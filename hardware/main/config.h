#ifndef _CONFIG_H
#define _CONFIG_H


// Accelerometer/Gyroscope (IIC)
#define IMU_SDA 18
#define IMU_SCK 19

#define IMU_DRDY 22


// GPS (NMEA) (UART/RS232_3v3)
#define UART_MOSI 16
#define UART_MISO 17

//    GPS - On-the-second interrupt pulse
#define GPS_INTR_SSP 4

// Status LED
#define STATUS_LED 5


#define BUF_SIZE 1024

#endif
