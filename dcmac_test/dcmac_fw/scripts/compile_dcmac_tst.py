#-----------------------------------------------------------------

#!/usr/bin/env python3
import vitis
client=vitis.create_client()
client.update_workspace(path="./v80_work")
comp_list=client.list_components()
print("Debug: components list",comp_list)
print("==========Debug===========")
print("Debug: components list type:", type(comp_list))
try:
    print("Debug: components name:",comp_list[1]['name'])
except:
    print("Debug: error in get comp_list['name']")
platform=client.get_component(name="v80_pfm")
comp=client.get_component(name='dcmac_tst')
#status=comp.build()
#status=comp.import_files(files=['axi_si570.c'],from_loc= '../src/clock_ctr',dest_dir_in_cmp = "src")
#print("Debug: Import file status:",status)

status=comp.build()
print(comp,"build status",status)

