#include "dcmac_exdes_test_lib.h"
/*
 * Added by Chandler Zhao
 */

/*
 * #define DCMAC_0_GT_CTL_BASEADDR  XPAR_AXI_GPIO_GT_CTL_BASEADDR
 * #define DCMAC_0_TX_DATAPATH_BASEADDR  XPAR_AXI_GPIO_TX_DATAPATH_BASEADDR
 * #define DCMAC_0_RX_DATAPATH_BASEADDR  XPAR_AXI_GPIO_RX_DATAPATH_BASEADDR
 * #define DCMAC_0_DCMAC_RESETS   XPAR_AXI_RESETS_DYN_BASEADDR
 * #define DCMAC_0_GT_RESET_DONE  XPAR_AXI_RESET_DONE_DYN_BASEADDR
 */

int dump_gt_regs(){
	uint32_t gt_ctl, gt_tx_datapath, gt_rx_datapath, gt_rst, gt_rst_done_0,gt_rst_done_1;
	uint32_t pr_data=0;

	gt_ctl		= *(U32 *) (DCMAC_0_GT_CTL_BASEADDR);
	gt_tx_datapath	= *(U32 *) (DCMAC_0_TX_DATAPATH_BASEADDR);
	gt_rx_datapath	= *(U32 *) (DCMAC_0_RX_DATAPATH_BASEADDR);
	gt_rst		= *(U32 *) (DCMAC_0_DCMAC_RESETS);
	gt_rst_done_0	= *(U32 *) (DCMAC_0_GT_RESET_DONE);
	gt_rst_done_1	= *(U32 *) (DCMAC_0_GT_RESET_DONE + 0x0004);

	xil_printf(" ====================================================================\n\r"); 
	xil_printf("  Debug: dump the GT control registers !\n\r"); 
	xil_printf("  DCMAC_0_GT_CTL_BASEADDR          = %x,     \t Value           = %x\n\r", DCMAC_0_GT_CTL_BASEADDR,gt_ctl);
	xil_printf("  DCMAC_0_TX_DATAPATH_BASEADDR     = %x,     \t Value           = %x\n\r", DCMAC_0_TX_DATAPATH_BASEADDR,gt_tx_datapath);
	xil_printf("  DCMAC_0_RX_DATAPATH_BASEADDR     = %x,     \t Value           = %x\n\r", DCMAC_0_RX_DATAPATH_BASEADDR,gt_rx_datapath);
	xil_printf("  DCMAC_0_DCMAC_RESETS             = %x,     \t Value           = %x\n\r", DCMAC_0_DCMAC_RESETS,gt_rst);
	xil_printf("  DCMAC_0_GT_RESET_DONE[0]         = %x,     \t Value           = %x\n\r", DCMAC_0_GT_RESET_DONE,gt_rst_done_0);
	xil_printf("  DCMAC_0_GT_RESET_DONE[1]         = %x,     \t Value           = %x\n\r", DCMAC_0_GT_RESET_DONE+0x4,gt_rst_done_1);
	for (int i=0;i<2;i++) {
		pr_data = *(U32* )(C0_STAT_PORT_RX_PHY_STATUS_REG_REG + (i << 12));
		xil_printf("alignment status :: C%d_STAT_PORT_RX_PHY_STATUS 0x%dc00 %x \n\r", i, (i+1), pr_data);
		pr_data = *(U32* )(C0_STAT_PORT_RX_PHY_STATUS_REG_REG + (i << 12)+4);
		xil_printf("alignment status :: C%d_STAT_PORT_RX_PHY_STATUS 0x%dc04 %x \n\r", i, (i+1), pr_data);
		
	
	}
	xil_printf(" ===================================================================="); 

	return 0;

}

/*
 * end of code added by Chandler Zhao
 */

int main_test()
{
	char test_key_in;
        uint8_t ch_en_str = 0;
        int gt_lanes = 8;
	int rst_cnt = 0;

	xil_printf("######################################### \n\r");
	xil_printf("# 2x100G  \n\r");
	xil_printf("######################################### \n\r");
        init_ch_en_client_rate_static ();

	//set TX cursors in this process.
        set_gt_pcs_loopback_and_reset_static();

        // Check/Wait for GT TX and RX resetdone
        wait_gt_txresetdone(gt_lanes);
        wait_gt_rxresetdone(gt_lanes);
	xil_printf("gt RX/TX reset done!  \n\r");

        // -----------------------------------------
        // DCMAC Configuration & Reset Section
        // -----------------------------------------

        assert_dcmac_global_port_channel_resets_static (); // Global & Port, Channel flush
	xil_printf("dcmac global port reset reset done!  \n\r");

        program_dcmac ();
	xil_printf("program dcmac done!  \n\r");

        release_dcmac_global_port_channel_resets_static ();
	xil_printf("release dcmac global port reset done!  \n\r");

        wait(2000);
        // -------------------------------------------------------
        // Perform a GT RX Datapathonly reset and DCMAC RX Reset
        // -------------------------------------------------------
	flag_alignment=0;
	rst_cnt=0;	
	do 
	{ 
        // GT RX Datapath only Reset
        gt_rx_datapathonly_reset();
	wait_gt_rxresetdone(gt_lanes);

        wait(2000);
        // DCMAC RX Port reset
        dcmac_rx_port_reset();
        wait(2000);
	

	flag_alignment=wait_for_alignment();
	rst_cnt = rst_cnt + 1;
	}
	while ((flag_alignment == 0) && (rst_cnt < 10));
	// re run test only, no GT config changed.
	while(1) {
        	usleep(20U);
		ch_en_str = get_chstr();
		sleep(5);
		test_fixe_sanity(ch_en_str);
		wait(100);

        	stats_test_check();
		xil_printf("\n\r*******Test Completed        \n\r");

		do {
			xil_printf(" rerun dcmac test without DCMAC/GT reset: press t/T \n\r");
			xil_printf(" reset dcmac : press r/R \n\r");
			xil_printf(" dump the GT registers: press g/G \n\r");
			xil_printf("quit dcmac test without DCMAC/GT reset, back to up level, testing with DCMAC/GT reset: press q/Q \n\r");
			scanf("%c",&test_key_in);
			if(test_key_in =='g' ||test_key_in =='G') {
				dump_gt_regs();
			}
			if(test_key_in =='r' ||test_key_in =='R') {
				flag_alignment=0;
				rst_cnt=0;	
				do 
				{ 
			        // GT RX Datapath only Reset
			        gt_rx_datapathonly_reset();
				wait_gt_rxresetdone(gt_lanes);
			
			        if(1) {
					wait(2000);
			        	// DCMAC RX Port reset
			        	dcmac_rx_port_reset();
			        	wait(2000);
				}
				flag_alignment=wait_for_alignment();
				rst_cnt = rst_cnt + 1;
				xil_printf("Debug aligment:%d, rst_cnt:%d\n\r",flag_alignment,rst_cnt);
				}
				while ((flag_alignment == 0) && (rst_cnt < 10));
			}
			if(test_key_in =='Q' ||test_key_in =='q') {
				break;
			}
		}while (test_key_in !='t' && test_key_in !='T');

	}
	return 1;
}


int main()
{
	char key_in;
	while(1) {
		main_test();
		dump_gt_regs();
		xil_printf(" rerun dcmac test with DCMAC/GT reset: press t/T \n\r");
		xil_printf(" dump the GT registers: press g/G \n\r");
		xil_printf("quit dcmac test with DCMAC/GT reset: press q/Q \n\r");

		do {
			scanf("%c",&key_in);
			if(key_in =='g' ||key_in =='G') {
				dump_gt_regs();
			}
			if(key_in =='Q' ||key_in =='q') {
				return 1;
			}
		}while (key_in !='t' && key_in !='T');
	} 

}

