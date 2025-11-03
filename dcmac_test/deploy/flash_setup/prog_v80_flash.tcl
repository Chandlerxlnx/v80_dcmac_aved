#-----------------------------------------------------------
# Vivado v2024.2 (64-bit)
# SW Build 5239630 on Fri Nov 08 22:34:34 MST 2024
# IP Build 5239520 on Sun Nov 10 16:12:51 MST 2024
# SharedData Build 5239561 on Fri Nov 08 14:39:27 MST 2024
# Start of session at: Mon Apr 28 10:53:10 2025
# Process ID         : 3802
# Current directory  : /home/fintech/github/V80/v80_ethernet/aved_pfm_dcmac/hw
# Command line       : vivado
# Log file           : /home/fintech/github/V80/v80_ethernet/aved_pfm_dcmac/hw/vivado.log
# Journal file       : /home/fintech/github/V80/v80_ethernet/aved_pfm_dcmac/hw/vivado.jou
# Running On         : fintech-u
# Platform           : Ubuntu
# Operating System   : Ubuntu 20.04.6 LTS
# Processor Detail   : AMD Ryzen 7 3700X 8-Core Processor
# CPU Frequency      : 2200.000 MHz
# CPU Physical cores : 8
# CPU Logical cores  : 16
# Host memory        : 67358 MB
# Swap memory        : 2147 MB
# Total Virtual      : 69506 MB
# Available Virtual  : 68315 MB
#-----------------------------------------------------------
set alveo_dev xcv80_1
set flash_img [lindex $argv 0]
puts "====burning ${flash_img} into flash===="

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices $alveo_dev]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices $alveo_dev] 0]
create_hw_cfgmem -hw_device [lindex [get_hw_devices $alveo_dev] 0] [lindex [get_cfgmem_parts {cfgmem-2048-ospi-x8-single}] 0]
set_property PROGRAM.BLANK_CHECK  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.ERASE  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.CFG_PROGRAM  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.VERIFY  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.CHECKSUM  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
after 10000
refresh_hw_device [lindex [get_hw_devices $alveo_dev] 0]
set_property PROGRAM.ADDRESS_RANGE  {use_file} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
#set_property PROGRAM.FILES [list "../hw/dcmac_0_exdes_imp_top.pdi" ] [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.FILES [list $flash_img ] [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.FILE {./flash_setup/v80_initialization.pdi} [get_hw_devices $alveo_dev]
set_property PROGRAM.BLANK_CHECK  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.ERASE  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.CFG_PROGRAM  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.VERIFY  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
set_property PROGRAM.CHECKSUM  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
startgroup 
 program_hw_devices [lindex [get_hw_devices $alveo_dev] 0]; 
 refresh_hw_device [lindex [get_hw_devices $alveo_dev] 0];
 after 10000;# wait 10s
 refresh_hw_device [lindex [get_hw_devices $alveo_dev] 0]
 program_hw_cfgmem -hw_cfgmem [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices $alveo_dev] 0]]
endgroup

#after 10000; # wait 10s
#boot_hw_device  [lindex [get_hw_devices xcv80_1] 0]
#refresh_hw_device [lindex [get_hw_devices xcv80_1] 0]

exit
