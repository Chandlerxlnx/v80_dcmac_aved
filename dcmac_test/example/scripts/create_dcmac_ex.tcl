create_project  proj_dcmac ./proj_dcmac -part xcv80-lsva4737-2MHP-e-S
create_ip -name dcmac -vendor xilinx.com -library ip -version 3.0 -module_name dcmac_0
set_property -dict [list \
  CONFIG.DCMAC_DATA_PATH_INTERFACE_C0 {195MHz Upto 3x100G Ports} \
  CONFIG.FEC_SLICE0_CFG_C0 {FEC Disabled} \
  CONFIG.FEC_SLICE1_CFG_C0 {FEC Disabled} \
  CONFIG.MAC_PORT2_ENABLE_C0 {0} \
  CONFIG.MAC_PORT3_ENABLE_C0 {0} \
  CONFIG.MAC_PORT4_ENABLE_C0 {0} \
  CONFIG.MAC_PORT5_ENABLE_C0 {0} \
] [get_ips dcmac_0]
set_property -dict [list \
  CONFIG.DCMAC_LOCATION_C0 {DCMAC_X1Y1} \
  CONFIG.GT_REF_CLK_FREQ_C0 {322.265625} \
] [get_ips dcmac_0]

generate_target {instantiation_template} [get_files dcmac_0.xci]
update_compile_order -fileset sources_1
set_property generate_synth_checkpoint false [get_files  dcmac_0.xci]
generate_target all [get_files  dcmac_0.xci]
export_ip_user_files -of_objects [get_files dcmac_0.xci] -no_script -sync -force -quiet

open_example_project -force -dir ./ [get_ips  dcmac_0]

exit
