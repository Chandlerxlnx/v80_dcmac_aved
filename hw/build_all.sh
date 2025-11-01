#!/usr/bin/env bash
# (c) Copyright 2024, Advanced Micro Devices, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
############################################################
set -Eeuo pipefail

# Init
DESIGN="dcmac_0_ex_top"
#DESIGN="dcmac_0_ex_impl_top"
HW_DIR=$(realpath ./dcmac_ex)
FW_DIR=$(realpath ../AVED/fw/AMC)
DCMAC_TST_DIR=$(realpath ../dcmac_tst/build)
XSA=${XSA:-$(realpath ${HW_DIR})/${DESIGN}.xsa}

# Step HW
pushd ${HW_DIR}
  make
  mkdir -p ./build
  cp ${XSA} ./build
  #vivado -source src/create_design.tcl -source src/build_design.tcl -mode batch -nojournal -log ./build/vivado.log
popd

#step DCMAC_TST
pushd ${DCMAC_TST_DIR}
   ../scripts/comment_out_loop.sh ../../hw/dcmac_ex/dcmac_exdes_test_lib.h > ../src/dcmac_tst/dcmac_exdes_test_lib.h
   make cleanall && make all
   cp -a ${DCMAC_TST_DIR}/v80_work/dcmac_tst/build/dcmac_tst.elf ${HW_DIR}/build
popd

# Step FW
pushd ${FW_DIR}
  ./scripts/build.sh -os freertos10_xilinx -profile v80 -xsa $XSA
  cp -a ${FW_DIR}/build/amc.elf ${HW_DIR}/build
  # Takes in fpt.json and produces fpt.bin
popd

# Step FPT
pushd ${FW_DIR}/build
  ../scripts/gen_fpt.py -f ../scripts/fpt.json
  cp -a ${FW_DIR}/build/fpt.bin ${HW_DIR}/build
popd

# Step PDI combine
# Generate PDI w/ bootgen
pushd ${HW_DIR}
  bootgen -arch versal -image ${HW_DIR}/fpt/pdi_combine.bif -w -o ${HW_DIR}/build/${DESIGN}_nofpt.pdi
popd

# final pdi generation
${HW_DIR}/fpt/fpt_pdi_gen.py --fpt ${HW_DIR}/build/fpt.bin --pdi ${HW_DIR}/build/${DESIGN}_nofpt.pdi --output ${DESIGN}.pdi
