import serial
import sys
import datetime
import numpy as np


def main():
    device_name = sys.argv[1];
    port = sys.argv[2];

    with serial.Serial(device_name, port, timeout=1) as ser:
        while True:
            mode = int(ser.readline());
            length = int(ser.readline());
            dat = str(ser.readline());
            ser.readline();
            stamp = datetime.datetime.now()

            if mode == 1: 
                # handle wifi
                print 'wifi'
            elif mode == 2:
                # handle imu
                print 'imu'
            elif mode == 3:
                # handle gps
                print 'gps'
            else:
                print 'mode: ', mode, ' is not yet implemented'



def calculate_dist(rssi):
    return np.exp( (rssi + 41.05*8) / (-15.31) )

if __name__ == '__main__':
    main()

