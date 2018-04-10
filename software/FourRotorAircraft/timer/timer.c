/*
 * timer.c
 *
 *  Created on: 2017-9-8
 *      Author: Ben
 */

#include <stdio.h>
#include "altera_avalon_timer_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include "string.h"


unsigned char timeFlag = 0;
extern unsigned char g_stopFlag;
extern unsigned char g_flag5ms;
extern unsigned char g_flag20ms;
int stop = 0;

/*��ʱ������*/
void isr_timer0()
{
	/*stop ++;
	if(stop > 12000){
		g_stopFlag = 0;
	}*/
	timeFlag++;
	g_flag5ms = 1;
	if(timeFlag > 3){
		timeFlag = 0;
		g_flag20ms = 1;
	}
    //IOWR_ALTERA_AVALON_UART_CONTROL(UART0_BASE,0);
    //IOWR_ALTERA_AVALON_UART_TXDATA(UART0_BASE, '\n');
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0x00);       //���timer0�жϱ�־�Ĵ���
    //IOWR_ALTERA_AVALON_UART_CONTROL(UART0_BASE,ALTERA_AVALON_UART_CONTROL_TRDY_MSK);
}


void TimerInit(void)
{
     IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0x00);       //���timer0�жϱ�־�Ĵ���
     IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE,250000);   //����timer0����	����(kHz)*����(ms)
     IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE,250000 >> 16);
     IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE, 0x07);      //����timer0�ж�
     alt_irq_register(TIMER_0_IRQ, (void *)0, isr_timer0);      //ע��timer0�ж�
}



