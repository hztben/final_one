/*
 * app.c
 *
 *  Created on: 2017-9-8
 *      Author: Ben
 */

#include <stdio.h>
#include "system.h"
#include "alt_types.h"
#include "math.h"
#include "JY901.h"
#include "timer.h"
#include "pwm.h"
#include "../i2c/i2c_opencores.h"
#include "us100.h"
#include "fbm320.h"
#include "controller.h"
#include "app.h"
#include "unistd.h"


void bspInit(){
	moto_init();
	PIDInit();
	fbm320Init();
	JY901Init();
	Uart_232_initial();
	TimerInit();
}


void MotorControl(){
	float rollOut,pitchOut,yawOut;
	static int heightOut;
	int rotorOutFirst,rotorOutSecond,rotorOutThird,rotorOutFourth;
	float omega1,omega2,omega3,omega4;

	float J_x = 0.01444,J_y = 0.01444,J_z = 0.02770;
	float rollTau,pitchTau,yawTau,T;
	const float m = 80;
	const float g = 9.8;

	rollOut = RollCalc(0);
	pitchOut = PitchCalc(0);
	yawOut = YawCalc(0);
	heightOut = HeightCalc(1.06);

	heightOut = 0;					//test

	rollTau = J_x * rollOut;
	pitchTau = J_y * pitchOut;
	yawTau = 0;//J_z * yawOut;
	T = m*(heightOut + g);

	omega1 = sqrt(9972.078181 * T + 44320.34747 * rollTau + 44320.34747 * pitchTau + 367917.5865 * yawTau);
	omega2 = sqrt(9972.078181 * T + 44320.34747 * rollTau - 44320.34747 * pitchTau - 367917.5865 * yawTau);
	omega3 = sqrt(9972.078181 * T - 44320.34747 * rollTau - 44320.34747 * pitchTau + 367917.5865 * yawTau);
	omega4 = sqrt(9972.078181 * T - 44320.34747 * rollTau + 44320.34747 * pitchTau - 367917.5865 * yawTau);

	//printf("omega: %f\n",omega1);

	rotorOutFirst = (int)((omega1/980+5.30)*10000);
	rotorOutSecond = (int)((omega2/980+5.30)*10000);
	rotorOutThird = (int)((omega3/980+5.28)*10000);
	rotorOutFourth = (int)((omega4/980+5.30)*10000);


	printf("rotorOut: %d , %d , %d , %d \n",rotorOutFirst,rotorOutSecond,rotorOutThird,rotorOutFourth);

	/*rotorOutFirst = rollOut-pitchOut+yawOut+8;
	rotorOutSecond = rollOut+pitchOut-yawOut+8;
	rotorOutThird = -rollOut+pitchOut+yawOut+8;
	rotorOutFourth = -rollOut-pitchOut-yawOut+8;
	printf("Rotor 1 : %f\n",rotorOutFirst);*/


	if(rotorOutFirst < 60000){
		rotorOutFirst = 60000;
	}
	if(rotorOutFirst >90000){
		rotorOutFirst = 90000;
	}

	if(rotorOutSecond < 60000){
		rotorOutSecond = 60000;
	}
	if(rotorOutSecond > 90000){
		rotorOutSecond = 90000;
	}

	if(rotorOutThird < 60000){
		rotorOutThird = 60000;
	}
	if(rotorOutThird > 90000){
		rotorOutThird = 90000;
	}

	if(rotorOutFourth < 60000){
		rotorOutFourth = 60000;
	}
	if(rotorOutFourth > 90000){
		rotorOutFourth = 90000;
	}


	moto_setting(1,50,rotorOutFirst);//电机-周期-占空比
	moto_setting(2,50,rotorOutSecond); //电机-周期-占空比
	moto_setting(3,50,rotorOutThird); //电机-周期-占空比
	moto_setting(4,50,rotorOutFourth);//电机-周期-占空比

}

