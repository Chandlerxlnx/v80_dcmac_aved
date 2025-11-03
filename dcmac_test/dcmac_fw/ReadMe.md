# Read Me

#start
 step to build dcmac test elf
```
  cd build
  make all
```
# change the loop back mode
 By default the sample code is NE loop back mode, need to comment the loopback setting. command to comment out the setting.
 ```
comment_out_loop.sh ../hw/dcmac_ex/dcmac_exdes_test_lib.h > src/dcmac_tst/dcmac_exdes_test_lib.h
```
