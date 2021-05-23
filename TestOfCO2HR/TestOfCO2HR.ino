#include <CCS811.h>
#include <SoftwareSerial.h>
#include <Arduino.h>


SoftwareSerial BTserial(10, 11); // RX | TX

int sensorPin = A0; 
int sensorPinCO = A4; 
int sensorPinNH2 = A1; 
int sensorPinNH3 = A2; 

int sensorValue = 0;
int sensorValueCO = 0;
int sensorValueNH2 = 0;
int sensorValueNH3 = 0;

const float max_volts = 5.0;
const float max_analog_steps = 1023.0;
int threshold = 550;


CCS811 sensor;

void setup(void)
{
    Serial.begin(9600);
    /*Wait for the chip to be initialized completely, and then exit*/
    BTserial.begin(9600);   

    while(sensor.begin() != 0){
        Serial.println("failed to init chip, please check if the chip connection is fine");
        delay(1000);
    }
   
    sensor.setMeasCycle(sensor.eCycle_250ms);
}


void loop() {
  delay(1000);
          //for mobile
        sensorValue = analogRead(sensorPin);
         //for mobile
        sensorValueCO = analogRead(sensorPinCO);
         //for mobile
        sensorValueNH2 = analogRead(sensorPinNH2);
         //for mobile
        sensorValueNH3 = analogRead(sensorPinNH3);
        
    if(sensor.checkDataReady() == true){
        Serial.print("CO2: ");
        Serial.print(sensor.getCO2PPM());
        Serial.print("ppm, TVOC: ");
        Serial.print(sensor.getTVOCPPB());
        Serial.println("ppb, CO:");
        Serial.print(sensorValueCO * (max_volts / max_analog_steps));
        Serial.print("ppm, NH2: ");
        Serial.print(sensorValueNH2 * (max_volts / max_analog_steps));
        Serial.print("ppm, NH3: ");
        Serial.print(sensorValueNH3 * (max_volts / max_analog_steps));
        Serial.println("ppb");



  //IMPORTANT: The complete String has to be of the Form: 1234,1234,1234,1234;
  //(every Value has to be seperated through a comma (',') and the message has to
  //end with a semikolon (';'))
                /*BTserial.println("CO2: ");
                BTserial.print("CO2: " + sensor.getCO2PPM());  
                BTserial.print("ppm, TVOC: ");  
                BTserial.print(sensor.getTVOCPPB());  
                BTserial.print("ppm, CO: ");  
                BTserial.print(sensorValueCO * (max_volts / max_analog_steps));  
                BTserial.print("ppm, NH2: ");  
                BTserial.print(sensorValueNH2 * (max_volts / max_analog_steps));  
                BTserial.print("ppm, NH3: "); 
                BTserial.print(sensorValueNH3 * (max_volts / max_analog_steps));*/
                
                if(sensorValue < threshold){
                 /*BTserial.print("ppm, HR: ");
                 BTserial.print(sensorValue/5);  
                 BTserial.print("BPM");*/
                 if(sensor.getCO2PPM() == '\0' && sensor.getTVOCPPB()== '\0'  &&  (sensorValueCO * (max_volts / max_analog_steps)) == '\0'  &&  (sensorValueNH2 * (max_volts / max_analog_steps)) == '\0'  &&  (sensorValueNH3 * (max_volts / max_analog_steps)) == '\0'  && (sensorValue/5) == '\0' ){
                  
                  //do nothing
                  
                 }else {
                  
                  /*String msg=(String)sensor.getCO2PPM()+ "," + sensor.getTVOCPPB() + "," +(sensorValueCO * (max_volts / max_analog_steps)) + "," + (sensorValueNH2 * (max_volts / max_analog_steps)) + "," + (sensorValueNH3 * (max_volts / max_analog_steps)) + "," + (sensorValue/5);
                  BTserial.print(msg); 
                  Serial.print(msg);*/
                /*BTserial.print(" *******Starts****** "); 
                BTserial.print(sensor.getCO2PPM());  
                BTserial.print(" "); 
                BTserial.print(sensor.getTVOCPPB()); 
                BTserial.print(" ");   
                BTserial.print(sensorValueCO * (max_volts / max_analog_steps)); 
                BTserial.print(" ");  
                BTserial.print(sensorValueNH2 * (max_volts / max_analog_steps));
                BTserial.print(" "); 
                BTserial.print(sensorValueNH3 * (max_volts / max_analog_steps));
                BTserial.print(" "); */
                if(sensorValue < threshold){
                    /*BTserial.print(sensorValue/5);
                    BTserial.print(" ******Ends******* "); */
                  String msg=(String)sensor.getCO2PPM()+ "," + sensor.getTVOCPPB() + "," +(sensorValueCO * (max_volts / max_analog_steps)) + "," + (sensorValueNH2 * (max_volts / max_analog_steps)) + "," + (sensorValueNH3 * (max_volts / max_analog_steps)) + "," + (sensorValue/5);
                  delay(5000);
                  BTserial.print(msg); 
                   
                  }

                  
                 }

                 } 
                  else{
                  BTserial.print(1); 
                 }
                 
                
        //message to the receiving device
           
        

        
    } else {
        Serial.println("Data is not ready!");
    }
 
    sensor.writeBaseLine(0x847B);








    
}
