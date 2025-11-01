#
# Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: MIT
#
# Author: Stephen MacMahon

import vitis
import os


pwd = os.getcwd()
client = vitis.create_client()
client.set_workspace(path=pwd + "/vitis_ws")
try:
    platform =client.get_component(name="v80_pfm")
except:
    platform = client.create_platform_component(name = "v80_pfm",hw_design = "../../hw/dcmac_0_ex/dcmac_0_ex_impl_top.xsa",cpu="psv_cortexa72_0")
    #platform = client.create_platform_component(name = "v80_pfm",hw_design = "../../hw/dcmac_0_ex/dcmac_0_ex_impl_top.xsa")
    status= platform.build()

platform = client.get_component(name="v80_pfm")
status = platform.build()

