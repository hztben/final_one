/*
 * us100.h
 *
 *  Created on: 2017-9-8
 *      Author: Ben
 */

#ifndef US100_H_
#define US100_H_

void GetHeight(void);
void Uart_232_set_baudrate(alt_u64 baudrate);
void Uart_232_send(unsigned char data);
void Uart_232_send_n(unsigned char *ptr,unsigned char n);
int Uart_232_receive(void);
void Uart_232_ISR(void);
void Uart_232_initial(void);

#endif /* US100_H_ */
