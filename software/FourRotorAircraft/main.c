#include <stdio.h>
#include "system.h"
#include "unistd.h"
#include "alt_types.h"
#include "timer.h"
#include "app.h"
#include "us100.h"
#include "jy901.h"
#include "pwm.h"
#include "controller.h"

unsigned char g_stopFlag = 1;
unsigned char g_protectFlag = 1;
unsigned char g_flag5ms = 0;
unsigned char g_flag20ms = 0;

//机头向上，Roll 增大
//左侧向上，Pitch 增大
//逆时针旋转，Yaw 增大

//g_stopFlag&&g_protectFlag


int main()
{

	bspInit();
  	printf("The aircraft will take off!\n");

  	while(1){
  		if(g_flag5ms == 1){
  			MotorControl();
  			g_flag5ms = 0;
  		}
  		if(g_flag20ms == 1){
  			GetHeight();
  			g_flag20ms = 0;
   		}
  	}

  	return 0;
}

