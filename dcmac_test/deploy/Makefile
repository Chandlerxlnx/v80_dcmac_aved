PDI:=../hw/dcmac_0_ex_top.pdi
AVED_PDI:= ./flash_setup/fpt_v80_gen5x8.pdi
help:
	@echo "make prog : burning the cfg memory with PDI file in ./flash_setup"
	@echo "make boot : boot V80 from flash image"
	@echo "make all  : burn cfg memory and boot from flash"
	@echo "make prog PDI=<PATH TO PDI>  : burn cfg memory with PDI file <PATH TO PDI>"
	@echo "make prog_aved: burning cfg memory with standard AVED PDI file"
	@echo "make ami_prog: program fpt file via inbound ami_tool, no JTAG cable needed"
	@echo "make clean: clean the log files"
prog:
	vivado_lab -mode tcl -source ./flash_setup/prog_v80_flash.tcl -tclargs ${PDI}
boot:
	vivado_lab -mode tcl -source ./flash_setup/boot_fr_flash.tcl
prog_aved:
	vivado_lab -mode tcl -source ./flash_setup/prog_v80_flash.tcl -tclargs ${AVED_PDI}
	#vivado_lab -mode tcl -source ./flash_setup/prog_aved_flash.tcl
all: prog boot
ami_prog:
	sudo ami_tool cfgmem_fpt -d 09:00.0 -t primary -i ../hw/dcmac_0_exdes_imp_top.pdi

	
clean:
	@rm -rf vivado*.log vivado*.jou
	@rm -rf .Xil*
