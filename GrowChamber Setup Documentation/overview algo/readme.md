# Algorithmeic explanation of Humidity control, Cheese effect
#CHEESE EFFECT CODE
WHEN TIME IS >= 50 MINUTES
      
          T1  SMART PLUG OFF
          T2  SMART PLUG OFF 

WHEN TIME IS >= 03 MINUTES
      

          T1  SMART PLUG ON
          T2  SMART PLUG ON 

#HUMIDITY CONTROLLER

    
    WHEN HUMIDIOTY IS < 90
          T1  SMART PLUG ON
          T2  SMART PLUG ON 

    WHEN HUMIDITY IS > 90
          T1  SMART PLUG OFF
          T2  SMART PLUG OFF
