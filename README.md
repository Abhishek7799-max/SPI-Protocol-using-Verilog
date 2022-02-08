# SPI-Protocol-using-Verilog
This is a Verilog Implementation of SPI protocol for serial communication.

The details of the implementation are slightly different from than normal vocabulary. 

SPI is a full-duplex communication protocol that is faster than UART, I2C. SPI means (Serial Peripheral Interface). It is a Master-slave protocol. 

It contains one master and many slaves.

In our implementation, we have used two slaves; Slave = 2'b01 refers to first
                                                Slave = 2'b10 refers to second slave 

dtf signal refers to data transfer. There are, in total, four modes of communication. 
                                                dtf = 2'b00 means no communication 
						      2'b01 means data from slave to master 
						      2'b10 means data from master to slave 
						      2'b11 means full-duplex communication
                
