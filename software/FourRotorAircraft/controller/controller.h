/*
 * controller.h
 *
 *  Created on: 2017-9-15
 *      Author: Ben
 */

#ifndef CONTROLLER_H_
#define CONTROLLER_H_


#define MAX_ANGLE 35

struct pid{
	float kp;
	float ki;
	float kd;
}rollPID,pitchPID,yawPID,heightPID;

void PIDInit(void);
float RollCalc(float);
float PitchCalc(float);
float YawCalc(float);
float HeightCalc(float);


#endif /* CONTROLLER_H_ */
