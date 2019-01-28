Editing Assistant

This repository will be used to contain the code related to an Arduino project for a hardware assistant device to use with Final Cut Pro X.

As the Arduino I have is quite old there is no keyboard emulation capability.  To overcome this issue I employ a bit NodeJS and the output from Arduino's serial port via USB.

Arduino IDE (web version available) required to view/edit the 'editing-assistant.ino' file.
	Download the Arduino IDE at https://www.arduino.cc/en/Main/Software

NodeJS requirements:
	RobotJS for virtual keystrokes.
		Install using npm install robotjs
		
	SerialPort for one way communication with the hardware.
		Install using npm install serialport
	
Optional:
If you would like to see the hardware schematic you can open the 'editing assistant.fzz' using the Fritzing application.
	Download Fritzing at http://fritzing.org/download/
	

To Do:
	Hardware:
		Aquire SAMD/32u4 compatible Arduino
		Aquire continuous potentiometer
		Aquire static on/off switch.

	Software:
		Fix RobotJS keyboard code to use keys with modifiers
		Add in the code for the continuous potentiometer
		Add in the code for the static on/off switch
		Add in LED code dependent on the static on/off switch
		
		Dependent on SAMD 32u4 Arduino
			Strip serialport messaging and convert it to keyboard inputs using the keyboard.h available.
			
I wouldn't say it's anywhere near the final state, but a few details/tweaks and it can be played with in a production environment sans scrubbing the timeline with a potentiometer. 