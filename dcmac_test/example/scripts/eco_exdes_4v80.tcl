open_project dcmac_0_ex/dcmac_0_ex.xpr
update_compile_order -fileset sources_1
open_bd_design [get_files {*/dcmac_0_exdes_support.bd}]
delete_bd_objs [get_bd_nets dcmac_0_gt_wrapper/util_ds_buf_1_IBUFDS_GTME5_O]
delete_bd_objs [get_bd_intf_nets dcmac_0_gt_wrapper/CLK_IN_D_1_1] [get_bd_cells dcmac_0_gt_wrapper/util_ds_buf_1]
delete_bd_objs [get_bd_intf_pins dcmac_0_gt_wrapper/CLK_IN_D_1]
delete_bd_objs [get_bd_intf_ports CLK_IN_D_1]
delete_bd_objs [get_bd_intf_nets CLK_IN_D_1_1]

connect_bd_net [get_bd_pins dcmac_0_gt_wrapper/gt_quad_base_1/GT_REFCLK0] [get_bd_pins dcmac_0_gt_wrapper/util_ds_buf_0/IBUFDS_GTME5_O]
save_bd_design
validate_bd_design
make_wrapper -files [get_files dcmac_0_exdes_support.bd] -top

write_bd_tcl -force -no_ip_version ./output/dcmac_0_exdes_support.tcl

exit
