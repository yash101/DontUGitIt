#include "config.h"

#include <stdio.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "esp_system.h"
#include "driver/uart.h"
#include "freertos/queue.h"
#include "soc/uart_struct.h"


#define INTERRUPT_PINS ((1 << GPS_INTR_SSP) | (1 << IMU_DRDY))

static QueueHandle_t IMUQueue;
static QueueHandle_t GPSQueue;

void IRAM_ATTR imu_interrupt(void* arg)
{
	// We need to do IMU shit in here
}

void IRAM_ATTR gps_interrupt(void* arg)
{
	// We need to do GPS shit in here
}

// GPS: GPS_INTR_SSP, IMU: IMU_DRDY
void setup_interrupts()
{
	// Holds the GPIO settings (temp)
	gpio_config_t gpcfg;

	gpcfg.pin_bit_mask = GPIO_SEL_4 | GPIO_SEL_21; 
	gpcfg.mode = GPIO_MODE_INPUT;
	gpcfg.pull_down_en = GPIO_PULLDOWN_ENABLE;
	gpcfg.pull_up_en = GPIO_PULLUP_DISABLE;
	gpcfg.intr_type = GPIO_INTR_POSEDGE;

	gpio_config(&gpcfg);
	gpio_install_isr_service(0);
	gpio_isr_handler_add(21, imu_interrupt, NULL);
	gpio_isr_handler_add(4, gps_interrupt, NULL);
}

void app_main()
{
	uart_set_baudrate(UART_NUM_2, 9600);
	uart_set_pin(UART_NUM_2, UART_MOSI, UART_MISO, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
	uart_set_word_length(UART_NUM_2, UART_DATA_8_BITS);
	uart_set_parity(UART_NUM_2, UART_PARITY_DISABLE);
	uart_set_stop_bits(UART_NUM_2, UART_STOP_BITS_1);

	setup_interrupts();

	printf("Finished loading!\n");

	while(1)
	{
	}
}
