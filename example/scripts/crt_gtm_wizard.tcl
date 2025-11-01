
create_project -force proj_gtm ./proj_gtm -part xcv80-lsva4737-2MHP-e-S
create_ip -name gtwiz_versal -vendor xilinx.com -library ip -version 1.0 -module_name gtwiz_versal_0
set_property -dict [list \
  CONFIG.GT_TYPE {GTM} \
  CONFIG.INTF0_GT_SETTINGS {LR0_SETTINGS {INS_LOSS_NYQ 16}} \
  CONFIG.INTF0_PRESET {GTM-NRZ_Ethernet_25G} \
  CONFIG.INTF1_NO_OF_LANES {4} \
  CONFIG.INTF1_PRESET {GTM-NRZ_Ethernet_25G} \
  CONFIG.NO_OF_INTERFACE {1} \
  CONFIG.NO_OF_QUADS {1} \
  CONFIG.QUAD0_CH0_ILORESET_EN {false} \
  CONFIG.QUAD0_CH0_LOOPBACK_EN {true} \
  CONFIG.QUAD0_CH1_ILORESET_EN {false} \
  CONFIG.QUAD0_CH1_LOOPBACK_EN {true} \
  CONFIG.QUAD0_CH2_LOOPBACK_EN {true} \
  CONFIG.QUAD0_CH3_LOOPBACK_EN {true} \
  CONFIG.QUAD0_GT_GPIO_EN {true} \
] [get_ips gtwiz_versal_0]
set_property -dict [list \
  CONFIG.INTF0_GT_SETTINGS {LR0_SETTINGS {INS_LOSS_NYQ 16 RXPROGDIV_FREQ_VAL 644.531 RX_REFCLK_FREQUENCY 322.265625 TXPROGDIV_FREQ_VAL 644.531 TX_REFCLK_FREQUENCY 322.265625}} \
  CONFIG.INTF0_OPTIONAL_PORTS {ch_txmaincursor true ch_txpostcursor true ch_txprbsforceerr false ch_txprecursor true ch_txprecursor2 true ch_txprecursor3 true} \
] [get_ips gtwiz_versal_0]

generate_target {instantiation_template} [get_files gtwiz_versal_0.xci]
update_compile_order -fileset sources_1
set_property generate_synth_checkpoint false [get_files  gtwiz_versal_0.xci]
generate_target all [get_files  gtwiz_versal_0.xci]
export_ip_user_files -of_objects [get_files gtwiz_versal_0.xci] -no_script -sync -force -quiet

open_example_project -force -dir ./ [get_ips  gtwiz_versal_0]
