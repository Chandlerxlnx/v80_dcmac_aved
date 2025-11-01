#SHELL:=/bin/bash
#TODO: Chandler, the dependency of Makefile is not correct. now it will rerun all flow. need correct it later.


export BUILD=.

DCMAC_SCRIPT := ../scripts/build_dcmac_tst.py
XSA :=../../hw/dcmac_ex/dcmac_0_ex_top.xsa
PLATFORM:=./v80_work/v80_pfm/export/v80_pfm/v80_pfm.xpfm
all: dcmac_tst

platform: $(PLATFORM)
	
$(PLATFORM) : $(XSA)
	@echo "Stage create platform"
	vitis -s ../scripts/build_platform.py

dcmac_tst: $(DCMAC_SCRIPT) $(PLATFORM)
	echo Creating dcmac_tst_cofnig component. running DCMAC_SCRIPT:$(DCMAC_SCRIPT)
	vitis -s $(DCMAC_SCRIPT)
	
run: $(PLATFORM)
	vitis -s ../scripts/compile_dcmac_tst.py
.phony help:
	@echo "all: create dcmac_tst_config elf from draft";
	@echo "platform: create platform component platform with u200.xsa";
	@echo "dcmac_tst: create dcmac_tst_config elf";
	@echo "run: compile the dcmac_tst_config component ";
clean:
	@rm -rf *.rpt
	@rm -rf *.log
	@rm -rf *.py*
	@rm -rf _ide log

cleanall: clean
	@rm -rf vitis_ws
	@rm -rf v80_work
