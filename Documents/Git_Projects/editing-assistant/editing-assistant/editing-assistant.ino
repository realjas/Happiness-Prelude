//#include <Keyboard.h>

int stepForward = 6;
int sfBol = false;

int stepBackward = 5;
int sbBol = false;

int sliceEnd = 4;
int sleBol = false;

int sliceBeginning = 3;
int slbBol = false;


void setup() {
  Serial.begin(9600);
  while(!Serial) {
    //
  }

  //Keyboard.begin();
  
  pinMode(stepForward,INPUT);
  pinMode(stepBackward,INPUT);
  pinMode(sliceEnd,INPUT);
  pinMode(sliceBeginning,INPUT);
}

void loop() {
  if((digitalRead(stepForward) == HIGH) && (sfBol == false)){
    sfBol = true;
    Serial.println("Step Forward");
  }
  if((digitalRead(stepForward) == LOW) && (sfBol == true)){
    sfBol = false;    
  }

  if((digitalRead(stepBackward) == HIGH) && (sbBol == false)){
    sbBol = true;
    Serial.println("Step Backward");
  }
  if((digitalRead(stepBackward) == LOW) && (sbBol == true)){
    sbBol = false;    
  }

  if((digitalRead(sliceEnd) == HIGH) && (sleBol == false)){
    sleBol = true;
    Serial.println("Slice End");
  }
  if((digitalRead(sliceEnd) == LOW) && (sleBol == true)){
    sleBol = false;    
  }

  if((digitalRead(sliceBeginning) == HIGH) && (slbBol == false)){
    slbBol = true;
    Serial.println("Slice Beginning");
  }
  if((digitalRead(sliceBeginning) == LOW) && (slbBol == true)){
    slbBol = false;    
  }

}
