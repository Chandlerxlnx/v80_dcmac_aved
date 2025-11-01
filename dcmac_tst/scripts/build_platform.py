# 2025-03-24T21:49:51.433421
import vitis

client = vitis.create_client()
client.update_workspace(path="./v80_work")

#platform = client.create_platform_component(name = "V80_pltfm",hw_design = "$COMPONENT_LOCATION/../../dcmac_0_ex/dcmac_0_ex_top.xsa",os = "standalone",cpu = "psv_cortexa72_0",domain_name = "standalone_psv_cortexa72_0")

try:
    platform =client.get_component(name="v80_pfm")
except:
    platform = client.create_platform_component(name = "v80_pfm",hw_design = "$COMPONENT_LACATION/../../../hw/dcmac_ex/dcmac_0_ex_top.xsa",os= "standalone",cpu = "psv_cortexr5_1",domain_name ="standalone_psv_cortexr5_1")


domain = platform.get_domain(name="standalone_psv_cortexr5_1")
    
    #platform = client.create_platform_component(name = "v80_pfm",hw_design = "$COMPONENT_LOCATION/../../../hw/dcmac_ex/dcmac_0_ex_impl_top.xsa",os= "standalone",cpu = "psv_cortexa72_0",domain_name = "standalone_psv_cortexa72_0")
    #domain = platform.get_domain(name="standalone_psv_cortexa72_0")
    #platform = client.create_platform_component(name = "v80_pfm",hw_design = "$COMPONENT_LACATION/../../../hw/dcmac_ex/dcmac_0_ex_impl_top.xsa",os= "standalone",
    #        cpu = "psv_cortexr5_1",domain_name ="standalone_psv_cortexr5_1")
'''    
try:
    domain = platform.get_domain(name="standalone_psv_cortexa72_0")
except:
    #domain= platform.add_domain(cpu="psv_cortexa72_0",os="standalone",name = "standalone_psv_cortexa72_0")
    domain= platform.add_domain(cpu = "psv_cortexa72_0",os = "standalone",name = "standalone_psv_cortexa72_0",display_name = "standalone_psv_cortexa72_0")
    domain = platform.get_domain(name="standalone_psv_cortexa72_0")
    status= platform.build()
    
'''
status = domain.regenerate()

try:
    status = domain.set_lib(lib_name="xilfpga")
    status = domain.set_lib(lib_name="xilmailbox")
except Exception as e:
    print("Debug Me:",e)

status = domain.set_config(option = "os", param = "standalone_stdin", value = "cips_pspmc_0_psv_sbsauart_1")
status = domain.set_config(option = "os", param = "standalone_stdout", value = "cips_pspmc_0_psv_sbsauart_1")
# the message print out to coresight which is in JTAG cable.
#status = domain.set_config(option = "os", param = "standalone_stdout", value = "cips_pspmc_0_psv_coresight_0")
#status = domain.set_config(option = "os", param = "standalone_stdin", value = "cips_pspmc_0_psv_coresight_0")


status = platform.build()

print("Info: platform v80_pfm has been created!")

vitis.dispose()


