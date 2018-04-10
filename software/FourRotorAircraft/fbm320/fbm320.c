/*
 * fbm320.c
 *
 *  Created on: 2017-9-10
 *      Author: Ben
 */

#include <stdio.h>
#include "system.h"
#include "alt_types.h"
#include "../i2c/i2c_opencores.h"

alt_u16 fbm320Standard = 0;

/****************************************************************
void Read_FBM320
     this function is to read the FBM320's registers.
inputs
      none
return
	  none
*****************************************************************/


alt_u32 Read_FBM320()
{
	alt_u32 FBM320_h=0;
	alt_u8 H_data[3]={0};
	I2C_start(OPENCORES_I2C_FBM320_BASE,0x60,0);/* 0x60 device address */
	I2C_write(OPENCORES_I2C_FBM320_BASE,0x33,0);/* 0x33 registers address */
	I2C_start(OPENCORES_I2C_FBM320_BASE,0x60,1);
	H_data[0]=I2C_read(OPENCORES_I2C_FBM320_BASE,0);
	H_data[1]=I2C_read(OPENCORES_I2C_FBM320_BASE,0);
	H_data[2]=I2C_read(OPENCORES_I2C_FBM320_BASE,1);
	FBM320_h=(( alt_u32 )H_data[0]<<16)|((alt_u16)H_data[1]<<8)|H_data[2];
	return (FBM320_h);

}



void fbm320Init(){
	I2C_init(OPENCORES_I2C_FBM320_BASE,ALT_CPU_FREQ,100000);
	fbm320Standard = Read_FBM320();
}

