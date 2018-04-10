/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu_0' in SOPC Builder design 'nios2'
 * SOPC Builder design path: C:/Users/Ben/Desktop/final_one/nios2.sopcinfo
 *
 * Generated: Sun Sep 10 11:31:48 CST 2017
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x4081020
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x0
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x2000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1b
#define ALT_CPU_NAME "cpu_0"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x4081800


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x4081020
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x0
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x2000020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1b
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x4081800


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_CFI_FLASH
#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_TIMER
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2
#define __OPENCORES_I2C


/*
 * HC_12 configuration
 *
 */

#define ALT_MODULE_CLASS_HC_12 altera_avalon_uart
#define HC_12_BASE 0x40
#define HC_12_BAUD 9600
#define HC_12_DATA_BITS 8
#define HC_12_FIXED_BAUD 1
#define HC_12_FREQ 50000000u
#define HC_12_IRQ 5
#define HC_12_IRQ_INTERRUPT_CONTROLLER_ID 0
#define HC_12_NAME "/dev/HC_12"
#define HC_12_PARITY 'N'
#define HC_12_SIM_CHAR_STREAM ""
#define HC_12_SIM_TRUE_BAUD 0
#define HC_12_SPAN 32
#define HC_12_STOP_BITS 1
#define HC_12_SYNC_REG_DEPTH 2
#define HC_12_TYPE "altera_avalon_uart"
#define HC_12_USE_CTS_RTS 0
#define HC_12_USE_EOP_REGISTER 0


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "CYCLONEIVE"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x40820f0
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x40820f0
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x40820f0
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios2"


/*
 * US_100_UART configuration
 *
 */

#define ALT_MODULE_CLASS_US_100_UART altera_avalon_uart
#define US_100_UART_BASE 0x0
#define US_100_UART_BAUD 9600
#define US_100_UART_DATA_BITS 8
#define US_100_UART_FIXED_BAUD 1
#define US_100_UART_FREQ 50000000u
#define US_100_UART_IRQ 4
#define US_100_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define US_100_UART_NAME "/dev/US_100_UART"
#define US_100_UART_PARITY 'N'
#define US_100_UART_SIM_CHAR_STREAM ""
#define US_100_UART_SIM_TRUE_BAUD 0
#define US_100_UART_SPAN 32
#define US_100_UART_STOP_BITS 1
#define US_100_UART_SYNC_REG_DEPTH 2
#define US_100_UART_TYPE "altera_avalon_uart"
#define US_100_UART_USE_CTS_RTS 0
#define US_100_UART_USE_EOP_REGISTER 0


/*
 * addr configuration
 *
 */

#define ADDR_BASE 0x4082050
#define ADDR_BIT_CLEARING_EDGE_REGISTER 0
#define ADDR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADDR_CAPTURE 0
#define ADDR_DATA_WIDTH 1
#define ADDR_DO_TEST_BENCH_WIRING 0
#define ADDR_DRIVEN_SIM_VALUE 0x0
#define ADDR_EDGE_TYPE "NONE"
#define ADDR_FREQ 50000000u
#define ADDR_HAS_IN 0
#define ADDR_HAS_OUT 1
#define ADDR_HAS_TRI 0
#define ADDR_IRQ -1
#define ADDR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADDR_IRQ_TYPE "NONE"
#define ADDR_NAME "/dev/addr"
#define ADDR_RESET_VALUE 0x0
#define ADDR_SPAN 16
#define ADDR_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_addr altera_avalon_pio


/*
 * addr2 configuration
 *
 */

#define ADDR2_BASE 0x4082090
#define ADDR2_BIT_CLEARING_EDGE_REGISTER 0
#define ADDR2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADDR2_CAPTURE 0
#define ADDR2_DATA_WIDTH 1
#define ADDR2_DO_TEST_BENCH_WIRING 0
#define ADDR2_DRIVEN_SIM_VALUE 0x0
#define ADDR2_EDGE_TYPE "NONE"
#define ADDR2_FREQ 50000000u
#define ADDR2_HAS_IN 0
#define ADDR2_HAS_OUT 1
#define ADDR2_HAS_TRI 0
#define ADDR2_IRQ -1
#define ADDR2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADDR2_IRQ_TYPE "NONE"
#define ADDR2_NAME "/dev/addr2"
#define ADDR2_RESET_VALUE 0x0
#define ADDR2_SPAN 16
#define ADDR2_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_addr2 altera_avalon_pio


/*
 * addr3 configuration
 *
 */

#define ADDR3_BASE 0x40820a0
#define ADDR3_BIT_CLEARING_EDGE_REGISTER 0
#define ADDR3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADDR3_CAPTURE 0
#define ADDR3_DATA_WIDTH 1
#define ADDR3_DO_TEST_BENCH_WIRING 0
#define ADDR3_DRIVEN_SIM_VALUE 0x0
#define ADDR3_EDGE_TYPE "NONE"
#define ADDR3_FREQ 50000000u
#define ADDR3_HAS_IN 0
#define ADDR3_HAS_OUT 1
#define ADDR3_HAS_TRI 0
#define ADDR3_IRQ -1
#define ADDR3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADDR3_IRQ_TYPE "NONE"
#define ADDR3_NAME "/dev/addr3"
#define ADDR3_RESET_VALUE 0x0
#define ADDR3_SPAN 16
#define ADDR3_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_addr3 altera_avalon_pio


/*
 * addr4 configuration
 *
 */

#define ADDR4_BASE 0x40820b0
#define ADDR4_BIT_CLEARING_EDGE_REGISTER 0
#define ADDR4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADDR4_CAPTURE 0
#define ADDR4_DATA_WIDTH 1
#define ADDR4_DO_TEST_BENCH_WIRING 0
#define ADDR4_DRIVEN_SIM_VALUE 0x0
#define ADDR4_EDGE_TYPE "NONE"
#define ADDR4_FREQ 50000000u
#define ADDR4_HAS_IN 0
#define ADDR4_HAS_OUT 1
#define ADDR4_HAS_TRI 0
#define ADDR4_IRQ -1
#define ADDR4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADDR4_IRQ_TYPE "NONE"
#define ADDR4_NAME "/dev/addr4"
#define ADDR4_RESET_VALUE 0x0
#define ADDR4_SPAN 16
#define ADDR4_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_addr4 altera_avalon_pio


/*
 * cfi_flash_0 configuration
 *
 */

#define ALT_MODULE_CLASS_cfi_flash_0 altera_avalon_cfi_flash
#define CFI_FLASH_0_BASE 0x4040000
#define CFI_FLASH_0_HOLD_VALUE 40
#define CFI_FLASH_0_IRQ -1
#define CFI_FLASH_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CFI_FLASH_0_NAME "/dev/cfi_flash_0"
#define CFI_FLASH_0_SETUP_VALUE 40
#define CFI_FLASH_0_SIZE 262144u
#define CFI_FLASH_0_SPAN 262144
#define CFI_FLASH_0_TIMING_UNITS "ns"
#define CFI_FLASH_0_TYPE "altera_avalon_cfi_flash"
#define CFI_FLASH_0_WAIT_VALUE 160


/*
 * epcs_flash_controller_0 configuration
 *
 */

#define ALT_MODULE_CLASS_epcs_flash_controller_0 altera_avalon_epcs_flash_controller
#define EPCS_FLASH_CONTROLLER_0_BASE 0x4081800
#define EPCS_FLASH_CONTROLLER_0_IRQ 2
#define EPCS_FLASH_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_FLASH_CONTROLLER_0_NAME "/dev/epcs_flash_controller_0"
#define EPCS_FLASH_CONTROLLER_0_REGISTER_OFFSET 1024
#define EPCS_FLASH_CONTROLLER_0_SPAN 2048
#define EPCS_FLASH_CONTROLLER_0_TYPE "altera_avalon_epcs_flash_controller"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER_0
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x40820f0
#define JTAG_UART_0_IRQ 1
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * opencores_i2c_fbm320 configuration
 *
 */

#define ALT_MODULE_CLASS_opencores_i2c_fbm320 opencores_i2c
#define OPENCORES_I2C_FBM320_BASE 0x60
#define OPENCORES_I2C_FBM320_IRQ 6
#define OPENCORES_I2C_FBM320_IRQ_INTERRUPT_CONTROLLER_ID 0
#define OPENCORES_I2C_FBM320_NAME "/dev/opencores_i2c_fbm320"
#define OPENCORES_I2C_FBM320_SPAN 32
#define OPENCORES_I2C_FBM320_TYPE "opencores_i2c"


/*
 * opencores_i2c_jy901 configuration
 *
 */

#define ALT_MODULE_CLASS_opencores_i2c_jy901 opencores_i2c
#define OPENCORES_I2C_JY901_BASE 0x20
#define OPENCORES_I2C_JY901_IRQ 3
#define OPENCORES_I2C_JY901_IRQ_INTERRUPT_CONTROLLER_ID 0
#define OPENCORES_I2C_JY901_NAME "/dev/opencores_i2c_jy901"
#define OPENCORES_I2C_JY901_SPAN 32
#define OPENCORES_I2C_JY901_TYPE "opencores_i2c"


/*
 * pio_0 configuration
 *
 */

#define ALT_MODULE_CLASS_pio_0 altera_avalon_pio
#define PIO_0_BASE 0x4082020
#define PIO_0_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_0_CAPTURE 0
#define PIO_0_DATA_WIDTH 4
#define PIO_0_DO_TEST_BENCH_WIRING 0
#define PIO_0_DRIVEN_SIM_VALUE 0x0
#define PIO_0_EDGE_TYPE "NONE"
#define PIO_0_FREQ 50000000u
#define PIO_0_HAS_IN 1
#define PIO_0_HAS_OUT 0
#define PIO_0_HAS_TRI 0
#define PIO_0_IRQ -1
#define PIO_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_0_IRQ_TYPE "NONE"
#define PIO_0_NAME "/dev/pio_0"
#define PIO_0_RESET_VALUE 0x0
#define PIO_0_SPAN 16
#define PIO_0_TYPE "altera_avalon_pio"


/*
 * pio_1 configuration
 *
 */

#define ALT_MODULE_CLASS_pio_1 altera_avalon_pio
#define PIO_1_BASE 0x4082030
#define PIO_1_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_1_CAPTURE 0
#define PIO_1_DATA_WIDTH 20
#define PIO_1_DO_TEST_BENCH_WIRING 0
#define PIO_1_DRIVEN_SIM_VALUE 0x0
#define PIO_1_EDGE_TYPE "NONE"
#define PIO_1_FREQ 50000000u
#define PIO_1_HAS_IN 0
#define PIO_1_HAS_OUT 1
#define PIO_1_HAS_TRI 0
#define PIO_1_IRQ -1
#define PIO_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_1_IRQ_TYPE "NONE"
#define PIO_1_NAME "/dev/pio_1"
#define PIO_1_RESET_VALUE 0x0
#define PIO_1_SPAN 16
#define PIO_1_TYPE "altera_avalon_pio"


/*
 * pio_2 configuration
 *
 */

#define ALT_MODULE_CLASS_pio_2 altera_avalon_pio
#define PIO_2_BASE 0x4082060
#define PIO_2_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_2_CAPTURE 0
#define PIO_2_DATA_WIDTH 20
#define PIO_2_DO_TEST_BENCH_WIRING 0
#define PIO_2_DRIVEN_SIM_VALUE 0x0
#define PIO_2_EDGE_TYPE "NONE"
#define PIO_2_FREQ 50000000u
#define PIO_2_HAS_IN 0
#define PIO_2_HAS_OUT 1
#define PIO_2_HAS_TRI 0
#define PIO_2_IRQ -1
#define PIO_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_2_IRQ_TYPE "NONE"
#define PIO_2_NAME "/dev/pio_2"
#define PIO_2_RESET_VALUE 0x0
#define PIO_2_SPAN 16
#define PIO_2_TYPE "altera_avalon_pio"


/*
 * pio_3 configuration
 *
 */

#define ALT_MODULE_CLASS_pio_3 altera_avalon_pio
#define PIO_3_BASE 0x4082070
#define PIO_3_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_3_CAPTURE 0
#define PIO_3_DATA_WIDTH 20
#define PIO_3_DO_TEST_BENCH_WIRING 0
#define PIO_3_DRIVEN_SIM_VALUE 0x0
#define PIO_3_EDGE_TYPE "NONE"
#define PIO_3_FREQ 50000000u
#define PIO_3_HAS_IN 0
#define PIO_3_HAS_OUT 1
#define PIO_3_HAS_TRI 0
#define PIO_3_IRQ -1
#define PIO_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_3_IRQ_TYPE "NONE"
#define PIO_3_NAME "/dev/pio_3"
#define PIO_3_RESET_VALUE 0x0
#define PIO_3_SPAN 16
#define PIO_3_TYPE "altera_avalon_pio"


/*
 * pio_4 configuration
 *
 */

#define ALT_MODULE_CLASS_pio_4 altera_avalon_pio
#define PIO_4_BASE 0x4082080
#define PIO_4_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_4_CAPTURE 0
#define PIO_4_DATA_WIDTH 20
#define PIO_4_DO_TEST_BENCH_WIRING 0
#define PIO_4_DRIVEN_SIM_VALUE 0x0
#define PIO_4_EDGE_TYPE "NONE"
#define PIO_4_FREQ 50000000u
#define PIO_4_HAS_IN 0
#define PIO_4_HAS_OUT 1
#define PIO_4_HAS_TRI 0
#define PIO_4_IRQ -1
#define PIO_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIO_4_IRQ_TYPE "NONE"
#define PIO_4_NAME "/dev/pio_4"
#define PIO_4_RESET_VALUE 0x0
#define PIO_4_SPAN 16
#define PIO_4_TYPE "altera_avalon_pio"


/*
 * sdram_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_0 altera_avalon_new_sdram_controller
#define SDRAM_0_BASE 0x2000000
#define SDRAM_0_CAS_LATENCY 3
#define SDRAM_0_CONTENTS_INFO ""
#define SDRAM_0_INIT_NOP_DELAY 0.0
#define SDRAM_0_INIT_REFRESH_COMMANDS 2
#define SDRAM_0_IRQ -1
#define SDRAM_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_0_IS_INITIALIZED 1
#define SDRAM_0_NAME "/dev/sdram_0"
#define SDRAM_0_POWERUP_DELAY 100.0
#define SDRAM_0_REFRESH_PERIOD 15.625
#define SDRAM_0_REGISTER_DATA_IN 1
#define SDRAM_0_SDRAM_ADDR_WIDTH 0x18
#define SDRAM_0_SDRAM_BANK_WIDTH 2
#define SDRAM_0_SDRAM_COL_WIDTH 9
#define SDRAM_0_SDRAM_DATA_WIDTH 16
#define SDRAM_0_SDRAM_NUM_BANKS 4
#define SDRAM_0_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_0_SDRAM_ROW_WIDTH 13
#define SDRAM_0_SHARED_DATA 0
#define SDRAM_0_SIM_MODEL_BASE 0
#define SDRAM_0_SPAN 33554432
#define SDRAM_0_STARVATION_INDICATOR 0
#define SDRAM_0_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_0_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_0_T_AC 5.5
#define SDRAM_0_T_MRD 3
#define SDRAM_0_T_RCD 20.0
#define SDRAM_0_T_RFC 70.0
#define SDRAM_0_T_RP 20.0
#define SDRAM_0_T_WR 14.0


/*
 * sysid_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_0 altera_avalon_sysid
#define SYSID_0_BASE 0x40820f8
#define SYSID_0_ID 0u
#define SYSID_0_IRQ -1
#define SYSID_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_0_NAME "/dev/sysid_0"
#define SYSID_0_SPAN 8
#define SYSID_0_TIMESTAMP 1505013133u
#define SYSID_0_TYPE "altera_avalon_sysid"


/*
 * timer_0 configuration
 *
 */

#define ALT_MODULE_CLASS_timer_0 altera_avalon_timer
#define TIMER_0_ALWAYS_RUN 0
#define TIMER_0_BASE 0x4082000
#define TIMER_0_COUNTER_SIZE 32
#define TIMER_0_FIXED_PERIOD 0
#define TIMER_0_FREQ 50000000u
#define TIMER_0_IRQ 0
#define TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_0_LOAD_VALUE 49999ull
#define TIMER_0_MULT 0.0010
#define TIMER_0_NAME "/dev/timer_0"
#define TIMER_0_PERIOD 1
#define TIMER_0_PERIOD_UNITS "ms"
#define TIMER_0_RESET_OUTPUT 0
#define TIMER_0_SNAPSHOT 1
#define TIMER_0_SPAN 32
#define TIMER_0_TICKS_PER_SEC 1000u
#define TIMER_0_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_0_TYPE "altera_avalon_timer"


/*
 * wr configuration
 *
 */

#define ALT_MODULE_CLASS_wr altera_avalon_pio
#define WR_BASE 0x4082040
#define WR_BIT_CLEARING_EDGE_REGISTER 0
#define WR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WR_CAPTURE 0
#define WR_DATA_WIDTH 1
#define WR_DO_TEST_BENCH_WIRING 0
#define WR_DRIVEN_SIM_VALUE 0x0
#define WR_EDGE_TYPE "NONE"
#define WR_FREQ 50000000u
#define WR_HAS_IN 0
#define WR_HAS_OUT 1
#define WR_HAS_TRI 0
#define WR_IRQ -1
#define WR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WR_IRQ_TYPE "NONE"
#define WR_NAME "/dev/wr"
#define WR_RESET_VALUE 0x0
#define WR_SPAN 16
#define WR_TYPE "altera_avalon_pio"


/*
 * wr2 configuration
 *
 */

#define ALT_MODULE_CLASS_wr2 altera_avalon_pio
#define WR2_BASE 0x40820c0
#define WR2_BIT_CLEARING_EDGE_REGISTER 0
#define WR2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WR2_CAPTURE 0
#define WR2_DATA_WIDTH 1
#define WR2_DO_TEST_BENCH_WIRING 0
#define WR2_DRIVEN_SIM_VALUE 0x0
#define WR2_EDGE_TYPE "NONE"
#define WR2_FREQ 50000000u
#define WR2_HAS_IN 0
#define WR2_HAS_OUT 1
#define WR2_HAS_TRI 0
#define WR2_IRQ -1
#define WR2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WR2_IRQ_TYPE "NONE"
#define WR2_NAME "/dev/wr2"
#define WR2_RESET_VALUE 0x0
#define WR2_SPAN 16
#define WR2_TYPE "altera_avalon_pio"


/*
 * wr3 configuration
 *
 */

#define ALT_MODULE_CLASS_wr3 altera_avalon_pio
#define WR3_BASE 0x40820d0
#define WR3_BIT_CLEARING_EDGE_REGISTER 0
#define WR3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WR3_CAPTURE 0
#define WR3_DATA_WIDTH 1
#define WR3_DO_TEST_BENCH_WIRING 0
#define WR3_DRIVEN_SIM_VALUE 0x0
#define WR3_EDGE_TYPE "NONE"
#define WR3_FREQ 50000000u
#define WR3_HAS_IN 0
#define WR3_HAS_OUT 1
#define WR3_HAS_TRI 0
#define WR3_IRQ -1
#define WR3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WR3_IRQ_TYPE "NONE"
#define WR3_NAME "/dev/wr3"
#define WR3_RESET_VALUE 0x0
#define WR3_SPAN 16
#define WR3_TYPE "altera_avalon_pio"


/*
 * wr4 configuration
 *
 */

#define ALT_MODULE_CLASS_wr4 altera_avalon_pio
#define WR4_BASE 0x40820e0
#define WR4_BIT_CLEARING_EDGE_REGISTER 0
#define WR4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WR4_CAPTURE 0
#define WR4_DATA_WIDTH 1
#define WR4_DO_TEST_BENCH_WIRING 0
#define WR4_DRIVEN_SIM_VALUE 0x0
#define WR4_EDGE_TYPE "NONE"
#define WR4_FREQ 50000000u
#define WR4_HAS_IN 0
#define WR4_HAS_OUT 1
#define WR4_HAS_TRI 0
#define WR4_IRQ -1
#define WR4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WR4_IRQ_TYPE "NONE"
#define WR4_NAME "/dev/wr4"
#define WR4_RESET_VALUE 0x0
#define WR4_SPAN 16
#define WR4_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
