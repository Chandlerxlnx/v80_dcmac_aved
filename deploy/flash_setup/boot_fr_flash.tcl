set alveo_dev xcv80_1

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices $alveo_dev]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices $alveo_dev] 0]
create_hw_cfgmem -hw_device [lindex [get_hw_devices $alveo_dev] 0] [lindex [get_cfgmem_parts {cfgmem-2048-ospi-x8-single}] 0]

after 10000; # wait 10s
boot_hw_device  [lindex [get_hw_devices xcv80_1] 0]
refresh_hw_device [lindex [get_hw_devices xcv80_1] 0]
exit
