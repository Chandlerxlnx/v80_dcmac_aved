# crt_dcmac_tst.py
import vitis

client = vitis.create_client()
client.update_workspace(path="v80_work")

platform = client.get_component(name="v80_pfm")
domain_list=platform.list_domains()
print("Domain list: {}".format(domain_list))

try:
    domain = platform.get_domain(name="standalone_psv_cortexr5_1")
except:
    #domain = platform.add_domain(cpu = "psv_cortexa72_0",os = "standalone",name = "standalone_psv_cortexa72_0",display_name = "standalone_psv_cortexa72_0")
    platform.add_domain(name="standalone_psv_cortexr5_1",os="standalone",cpu="psv_cortexr5_1")
    domain = platform.get_domain(name="standalone_psv_cortexr5_1")

'''
try:
    domain = platform.get_domain(name="standalone_psv_cortexa72_0")
except:
    #domain= platform.add_domain(cpu="psv_cortexa72_0",os="standalone",name = "standalone_psv_cortexa72_0")
    domain= platform.add_domain(cpu = "psv_cortexa72_0",os = "standalone",name = "standalone_psv_cortexa72_0",display_name = "standalone_psv_cortexa72_0")
    domain = platform.get_domain(name="standalone_psv_cortexa72_0")
'''

#status = domain.set_config(option = "os", param = "standalone_stdin", value = "cips_pspmc_0_psv_sbsauart_1")
#status = domain.set_config(option = "os", param = "standalone_stdout", value = "cips_pspmc_0_psv_sbsauart_1")

#status = domain.set_config(option = "os", param = "standalone_stdout", value = "cips_pspmc_0_psv_coresight_0")
#status = domain.set_config(option = "os", param = "standalone_stdin", value = "cips_pspmc_0_psv_coresight_0")

status = platform.build()


try:
    comp=client.get_component(name='dcmac_tst')
    #print("Warning: App dcmac_tst has existed, please check if it is what you want first")
    #vitis.dispose()
except:
    comp = client.create_app_component(name="dcmac_tst",platform = "$COMPONENT_LOCATION/../v80_pfm/export/v80_pfm/v80_pfm.xpfm",domain = "standalone_psv_cortexr5_1",template = "empty_application")
    comp = client.get_component(name="dcmac_tst")
    status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../../src/dcmac_tst", files=["dcmac_exdes_test_lib.h"], dest_dir_in_cmp = "src")
    status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../../src/dcmac_tst", files=["dcmac_exdes_test.c"], dest_dir_in_cmp = "src")
    status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../../src/dcmac_tst", files=["lscript.ld"], dest_dir_in_cmp = "src")

status = platform.build()
comp.build()

#status = client.export_projects(components = ["dcmac_tst", "hello_world", "platform"], system_projects = [], include_build_dir = False, dest = "/home/fintech/github/V80/v80_ethernet/dcmac_ex/dcmac_ex_0324/v80_work/v80_app_archive.zip")

vitis.dispose()


