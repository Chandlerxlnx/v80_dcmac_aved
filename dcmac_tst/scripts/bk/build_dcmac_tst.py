#-----------------------------------------------------------------
# Vitis v2023.1 (64-bit)
# Start of session at: Wed May  8 07:29:51 2024
# Current directory: /home/chandler/github/fintech/HSIO_examples/LLGT/sw
# Command line: vitis -i
# Journal file: vitis_journal.py
# Batch mode: $XILINX_VITIS/bin/vitis -new -s /home/chandler/github/fintech/HSIO_examples/LLGT/sw/vitis_journal.py
#-----------------------------------------------------------------

#!/usr/bin/env python3
import vitis
import os
pwd =os.getcwd()
print(pwd)
client = vitis.create_client()
client.set_workspace(path=pwd+"/vitis_ws")

try:
    platform =client.get_component(name="v80_pfm")
except:
    platform = client.create_platform_component(name = "v80_pfm",hw_design = "../../hw/dcmac_0_ex/dcmac_0_ex_impl_top.xsa",cpu="psv_cortexa72_0")
    status= platform.build()

if( not platform):
    print("Error: can't find platform v80_pfm")
    exit()

client.list_platform_components()
try:
    comp = client.get_component(name='dcmac_tst')
    if comp :
        print("component dcmac_tst exist already")
    else:
        comp = client.create_app_component(name="dcmac_tst",platform = "vitis_ws/v80_pfm/export/v80_pfm/v80_pfm.xpfm",domain = "standalone_a72_0")

except:
    comp = client.create_app_component(name="dcmac_tst",platform = "vitis_ws/v80_pfm/export/v80_pfm/v80_pfm.xpfm",domain = "standalone_a72_0")

status = comp.import_files(from_loc="../src/dcmac_tst", files=["dcmac_exdes_test.c"], dest_dir_in_cmp = "src")


status=comp.build()

