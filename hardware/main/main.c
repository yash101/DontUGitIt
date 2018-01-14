#include <stdio.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "esp_system.h"
#include "driver/uart.h"
#include "freertos/queue.h"
#include "soc/uart_struct.h"

static uart_config_t gps_config = {
	.baud_rate = 9600,
	.data_bits = UART_DATA_8_BITS,
	.parity = UART_PARITY_DISABLE,
	.stop_bits = UART_STOP_BITS_1,
	.rx_flow_ctrl_thresh = 122
};

void setup_interrupts()
{
	static gpio_config_t gps_ssp_pulse;
	static gpio_config_t imu_drdy_int;
}

void app_main()
{
	uart_param_config(UART_NUM_2, &gps_config);
	uart_set_pin(UART_NUM_2, GPS_MOSI, GPS_MISO);
	uart_driver_install(UART_NUM_2, BUF_SIZE * 2, 0, 0, NULL, 0);

	setup_interrupts();
}

