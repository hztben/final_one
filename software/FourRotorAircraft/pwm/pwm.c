/*
 * pwm.c
 *
 *  Created on: 2017-9-8
 *      Author: Ben
 */

#include <stdio.h>
#include "system.h"
#include "unistd.h"
#include "altera_avalon_pio_regs.h"
#include "pwm.h"


/****************************************************************
void moto_setting
     this function is to change the PWM's duty cycle.
inputs
     moto_i = motor's number
     moto_F = PWM's period
     moto_D = duty cycle (from 0 to 1000000)
return
	 none

*****************************************************************/
void moto_setting(int moto_i,int moto_F,int moto_D)
{
	switch(moto_i)
	{
	case(1):
	{
		IOWR(WR_BASE,0,0);
		IOWR(ADDR_BASE,0,0);
		IOWR(PIO_1_BASE,0,(50000000/moto_F));//fa-250  C8-200  F4240-1000000
		IOWR(ADDR_BASE,0,1);
		IOWR(PIO_1_BASE,0,(1000000-moto_D));//7d-125  64-100
		IOWR(WR_BASE,0,1);
	}
	case(2):
	{
		IOWR(WR2_BASE,0,0);
		IOWR(ADDR2_BASE,0,0);
		IOWR(PIO_2_BASE,0,(50000000/moto_F));//fa
		IOWR(ADDR2_BASE,0,1);
		IOWR(PIO_2_BASE,0,(1000000-moto_D));//7d
		IOWR(WR2_BASE,0,1);
	}
	case(3):
		{
		IOWR(WR3_BASE,0,0);
	    IOWR(ADDR3_BASE,0,0);
	    IOWR(PIO_3_BASE,0,(50000000/moto_F));//fa
	    IOWR(ADDR3_BASE,0,1);
	    IOWR(PIO_3_BASE,0,(1000000-moto_D));//7d
	    IOWR(WR3_BASE,0,1);
		}

	case(4):
	{
	  	IOWR(WR4_BASE,0,0);
	    IOWR(ADDR4_BASE,0,0);
	    IOWR(PIO_4_BASE,0,(50000000/moto_F));//fa
	    IOWR(ADDR4_BASE,0,1);
	    IOWR(PIO_4_BASE,0,(1000000-moto_D));//7d
	    IOWR(WR4_BASE,0,1);
	}

	}
}


/****************************************************************
void moto_init
     this function is to unlock the accelerograph.
inputs
     none
return
	 none

*****************************************************************/
void moto_init()
{
	moto_setting(1,50,120000);//电机-周期-占空比
	moto_setting(2,50,120000);//电机-周期-占空比
	moto_setting(3,50,120000);//电机-周期-占空比
	moto_setting(4,50,120000);//电机-周期-占空比
	usleep(2000000);
	moto_setting(1,50,50000);
	moto_setting(2,50,50000);
	moto_setting(3,50,50000);
	moto_setting(4,50,50000);
	usleep(2000000);
}


