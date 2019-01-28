var robot = require('robotjs');

var SerialPort = require('serialport');
var portName = "/dev/cu.usbserial-A70062G7";
var myPort = new SerialPort(portName, 9600);

var Readline = SerialPort.parsers.Readline; // make instance of Readline parser
var parser = new Readline(); // make a new parser to read ASCII lines
myPort.pipe(parser); // pipe the serial stream to the parser

parser.on('data', printData);

function printData(data){
	console.log(data);
	
	if (data.includes("Step Forward")){
		robot.keyTap('left');
	}

	if (data.includes("Step Backward")){
		robot.keyTap('right');
	}
	
	if (data.includes("Slice End")){
		robot.keyTap(']');
	}

	if (data.includes("Slice Beginning")){
		robot.keyTap('[');
	}

}

myPort.on('open',openPort);

function openPort(){
	console.log("Serial Port Connected Successfully!");
}

//function isString (value) {
//	return typeof value === 'string' || value instanceof String;
//}