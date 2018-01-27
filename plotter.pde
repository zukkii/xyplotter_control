import processing.serial.*;

Serial myPort;  

void setup()
{
  size(200, 200, P3D);
  for (int i = 0; i < Serial.list ().length; i++) {
    println(i+":"+Serial.list()[i]);
  }
  String portName = Serial.list()[11];
  myPort = new Serial(this, portName, 115200);
  myPort.write("M10\r\n");
  myPort.write("G90\r\n");
  myPort.write("G21\r\n");
  myPort.write("G1 Y0.0 F2500.0\r\n");
  int m = millis();
  while ( (m-millis ())>-1000) {
  }
  myPort.write("G28\r\n");
  timeStamp = year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+"_";
  textFont(createFont("Arial", 12));
  initialize();
}

void draw()
{
  background(0); 
  stroke(255);

  //please input your code here---------------------------------------------------
  //Enter coordinate values like: position_set(X_value, Y_value)
  
  
  
  //==============================================================================

  exit();
}






void position_set(int x, int y) {
  myPort.write("G1 X"+str(x) + " Y" + str(y) +"F2500.0\r\n");
  println("waiting");
  delay(500);
  int inByte = myPort.read();
  while (inByte != 13) {
    inByte = myPort.read();
    println(myPort.read());
    delay(100);
  }
  println("finish");
}

void keyReleased()
{  

  if ( key == 'p' ) 
  {
    flag = !flag;
  }

  if ( key == 'h' ) 
  {
    myPort.write("G28\r\n");
    println("homing");
    currx = 0;
    curry = 0;
  }

  if ( key == 'd' ) 
  {
    myPort.write("G1 X"+str(currx + centX)+"F2500.0\r\n");
    int m = millis();
    currx += centX;
    while ( (m-millis ())>-12000) {
    }
  }
  if ( key == 'w' ) 
  {
    myPort.write("G1 Y"+str(curry + centY)+"F2500.0\r\n");
    int m = millis();
    curry += centY;
    while ( (m-millis ())>-12000) {
    }
  }

  if ( key == 's' )
  {
    myPort.write("G1 Y-"+str(curry + centY)+"F2500.0\r\n");
    int m = millis();
    curry -= centY;
    while ( (m-millis ())>-12000) {
    }
  }

  if ( key == 'a' )
  {
    myPort.write("G1 X-"+str(currx + centY)+"F2500.0\r\n");
    int m = millis();
    currx -= centX;
    while ( (m-millis ())>-12000) {
    }
  }
}

void initialize() {
  myPort.write("G28\r\n");
  println("homing");

  int inByte = myPort.read();
  while (inByte != 13) {
    inByte = myPort.read();
    println(myPort.read());
    delay(100);
  }
}

void _init() {
  myPort.write("G1 X"+str((centX-(rep*step)/2))+"F2500.0\r\n");
  int m = millis();
  while ( (m-millis ())>-12000) {
  }
  myPort.write("G1 Y"+str((centY+(rep*step)/2))+"F2500.0\r\n");
  m = millis();
  while ( (m-millis ())>-12000) {
  }
}


//void serialEvent(Serial myPort) {
//  //// read a byte from the serial port:
//  int inByte = myPort.read();
//  println(inByte);
//  flag2 = true;
//  println("flag is available");
//}