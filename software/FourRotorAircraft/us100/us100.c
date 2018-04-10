/*
 * us100.c
 *
 *  Created on: 2017-9-8
 *      Author: Ben
 */


#include <stdio.h>
#include "system.h"
#include "alt_types.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_uart_regs.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "us100.h"
#include "unistd.h"

//#include "altera_avalon_uart.h"
//#include "altera_avalon_uart_fd.h"

alt_u16 status;
int uartData[2];
float g_preLength=0;

void GetHeight(){
	Uart_232_send(0x55);
}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_set_baudrate
 *      Description:  ���ò����ʼĴ���
 * =========================================================
 */
void Uart_232_set_baudrate(alt_u64 baudrate)
{
	alt_u64 divisor;
	divisor=(alt_u64)(ALT_CPU_FREQ/baudrate+0.5);    //�÷�Ƶ��ʽ
	IOWR(US_100_UART_BASE, ALTERA_AVALON_UART_DIVISOR_REG, divisor);
}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_send
 *      Description:  ����һ���ַ�
 * =========================================================
 */
void Uart_232_send(unsigned char data)
{
    IOWR_ALTERA_AVALON_UART_TXDATA(US_100_UART_BASE,data);
    status=IORD_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE);
    while(!(status&0x0040))    //�ȴ��������
        status=IORD_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE);
    usleep(1000);
   // IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE,data);
}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_send_n
 *      Description:  ����һ���ַ�
 * =========================================================
 */
void Uart_232_send_n(unsigned char *ptr,unsigned char n)
{
    for( ;n>0;n--)
    {
    	Uart_232_send(*ptr);
        ptr++;
    }
}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_receive
 *      Description:  ���ճ���
 * =========================================================
 */
int Uart_232_receive(void)
{
	int temp;
    status=IORD_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE);
    while(!(status&0x0080))//�ȴ��������
    status=IORD_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE);
    temp=IORD_ALTERA_AVALON_UART_RXDATA(US_100_UART_BASE);
    IOWR_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE, 0x0);//��״̬��־
    return temp;
}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_ISR
 *      Description:  ���ڽ����жϷ������
 * =========================================================
 */
void Uart_232_ISR()
{

	unsigned char k;
	//static int lastLength = 0;
//	uartData[0]=Uart_232_receive();
	for(k=0;k<2;k++){
		uartData[k] = Uart_232_receive();
	}

//	while(IORD_ALTERA_AVALON_UART_RXDATA(UART_232_BASE)!=0x0a)  //��#Ϊ�ַ���������־
	g_preLength =uartData[0]* 256 +uartData[1];
	/*if(((lastLength - g_preLength)>50) || ((g_preLength - lastLength)>50)){
		g_preLength = lastLength;
	}
	lastLength = g_preLength;*/

	//printf("height : %d\n",g_preLength);

	IOWR_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE, 0x00);//��״̬��־
	IOWR_ALTERA_AVALON_UART_RXDATA(US_100_UART_BASE, 0x00);//����ռĴ���

}


/*
 * ===  FUNCTION    ========================================
 *         Name:  Uart_232_initial
 *      Description:  �����жϳ�ʼ������
 * =========================================================
 */
//unsigned int nirq_irq_context1;
void Uart_232_initial()
{
	//void *irq_context_ptr = (void*)&nirq_irq_context1;
	Uart_232_set_baudrate(9600);
    IOWR_ALTERA_AVALON_UART_CONTROL(US_100_UART_BASE, 0x80);//�����ж�ʹ��
    IOWR_ALTERA_AVALON_UART_STATUS(US_100_UART_BASE, 0x00);//��״̬��־
    IOWR_ALTERA_AVALON_UART_RXDATA(US_100_UART_BASE, 0x00);//����ռĴ���
  //  alt_irq_register(UART_0_IRQ,NULL,Uart_232_ISR);
    alt_ic_isr_register(US_100_UART_IRQ_INTERRUPT_CONTROLLER_ID,US_100_UART_IRQ,Uart_232_ISR,NULL,0x00);//ע���ж�
}


