DCMAC_EX_PRJ=dcmac_0_ex/dcmac_0_ex.xpr

all: v80_eco

v80_eco:${DCMAC_EX_PRJ}
	sed -i '/gt_ref_clk1_/s/^/\/\//g' dcmac_0_ex/imports/*.sv
	sed -i '/gt_ref_clk1_/s/^/#/g' dcmac_0_ex/imports/*.xdc
${DCMAC_EX_PRJ}:
	vivado -mode tcl -source ./scripts/create_dcmac_ex.tcl
	vivado -mode tcl -source ./scripts/eco_exdes_4v80.tcl
proj: ${DCMAC_EX_PRJ}

clean:
	@rm -rf vivado*
cleanall:
	@rm -rf proj_dcmac
	@rm -rf dcmac_0_ex
