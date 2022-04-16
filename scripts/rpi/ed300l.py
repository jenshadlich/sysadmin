#!/usr/bin/python

import sys
import serial
import time


port = serial.Serial(
    #port='/dev/ttyAMA0',
    port='/dev/ttyUSB0',
    baudrate=9600,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
)

start = '1b1b1b1b01010101'
end = '1b1b1b1b1a'

data = ''

print port.name

while True:
    char = port.read()
    data = data + char.encode('HEX')
    #print data
    pos = data.find(start)
    if (pos <> -1):
        data = data[pos:len(data)]
    pos = data.find(end)
    if (pos <> -1):
        timestamp = (time.strftime("%Y-%m-%d ") + time.strftime("%H:%M:%S"))
        result = timestamp

        search = '070100010800ff'
        pos = data.find(search)
        if (pos <> -1):
            pos = pos + len(search) + 20
            value = data[pos:pos + 10]
            energy = int(value, 16)
            print 'kWh: ' + search + ' = ' + value + ' = ' + str(energy) + ' kWh'
            result = result + ';' +  str(energy)

        data = ''
