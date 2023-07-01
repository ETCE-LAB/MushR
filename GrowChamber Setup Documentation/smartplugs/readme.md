# Adding Humdifier, Ventilator to mycodo 
We used TP-Link Tapo WLAN Smart Socket, Smart Home Wi-Fi Socket  for controlling the Humidifier, Fan for regulating the humidity inside the tents. Each tent is equipped with individual Humidifier, Fan both are connected to smart plug,  water tank with capacity of 60 Litres. Using  the output function in mycodo we can turn on, off the humidifiers, fan at required time.
Follow these steps for adding the smart socket as output to the mycodo 


Step 1.	Navigate to mycodo IP address in a browser 

Step 2.	 Click "Setup"	

![image](https://user-images.githubusercontent.com/121457303/213940131-8b2a0ff4-6775-4fc5-80bb-b88323da35d4.png)
<p align=”center”>Step 2 Screenshot </p>

Step 3. Click on "Output"

![image](https://user-images.githubusercontent.com/121457303/213940393-32324d61-992d-48c3-80dd-b583378bfbe3.png)
<p align=”center”>Step 3 Screenshot </p>

Step 4.	Click "Output: Select One" dropdown list

![image](https://user-images.githubusercontent.com/121457303/213940418-cf70b7cb-4c4a-446b-8d3a-5d37aa15635e.png)
<p align=”center”>Step 4 Screenshot </p>

Step 5.	Select "On/Off: Python Code [PYTHON]" in the dropdown list

![image](https://user-images.githubusercontent.com/121457303/213940450-96ef6c1a-ae70-41e2-a241-9ed410a81b6f.png)
<p align=”center”>Step 5 Screenshot </p>

Step 6.	Click Add button after selecting the "On/Off: Python Code [PYTHON]"

![image](https://user-images.githubusercontent.com/121457303/213940482-a6ebcc01-343d-4353-95c3-cddfbaa2f269.png)
<p align=”center”>Step 6 Screenshot </p>	

Step 7.	Click on the Gear icon in the newly added output device

![image](https://user-images.githubusercontent.com/121457303/213940515-20eb2caa-849e-4395-94e7-1062b4cf6958.png)

						<p align=”center”>Step 7 Screenshot </p>
            
Step 8. In the new screen Click on the "On Command" field  and delete all its content  

![image](https://user-images.githubusercontent.com/121457303/213940581-f7aa141b-0029-44fe-924d-b89bd457c3f6.png)

<p align=”center”>Step 8 Screenshot </p>

step 9.	Paste the following code snippet into the text box


                      sys.path.insert(1, '/usr/local/lib/python3.9/dist-packages')
                      from PyP100 import PyP100      #pip install PyP100 
                      log_string = "ID: {id}: ON".format(id=output_id)
                      self.logger.info(log_string)

                      p100 = PyP100.P100("smart plug ip address", "tplink user id", "password") #Creating a P100 plug object

                      p100.handshake() #Creates the cookies required for further methods
                      p100.login() #Sends credentials to the plug and creates AES Key and IV for further methods

                      p100.turnOn() #Sends the turn on request
#end code smart plug on 

step 10.	Then Click on the "Off Command" field and delete all its contents then paste the following code snippet


![image](https://user-images.githubusercontent.com/121457303/213940751-469b5a36-8012-4b3d-ba0c-4940eabd25c2.png)
<p align=”center”>Step 10 Screenshot </p>
         
#start of off code snippet

            sys.path.insert(1, '/usr/local/lib/python3.9/dist-packages')
            from PyP100 import PyP100
            log_string = "ID: {id}: OFF".format(id=output_id)
            self.logger.info(log_string)
            p100 = PyP100.P100("smart plug ip address", "tplink user id", "password") #Creating a P100 plug object ,replace ip address and userid , password.

            p100.handshake() #Creates the cookies required for further methods
            p100.login() #Sends credentials to the plug and creates AES Key and IV for further methods

            p100.turnOff() #Sends the turn off request
            p100.getDeviceInfo()

#end of off code snippet


Step 11.	Click on save button and wait for the mycodo then click on the close button  
          ![image](https://user-images.githubusercontent.com/121457303/213940877-c886ec60-db7a-465d-bf0c-3dee49c2a0ff.png)
          <p align=”center”>Step 11 Screenshot 1 </p>
          ![image](https://user-images.githubusercontent.com/121457303/213941096-f9b7d0e4-dd2b-49ac-8b01-da1cfb403302.png)
          <p align=”center”>Step 11 Screenshot 2 </p>

Step 12.	Then verify the output using on, off buttons in the newly added output device
![image](https://user-images.githubusercontent.com/121457303/213941118-ff03e8f7-9455-41e3-b437-36dabb18f130.png)
<p align=”center”>Step 12 on Screenshot </p>

![image](https://user-images.githubusercontent.com/121457303/213941137-eae96402-8565-4428-b69b-73b149f38e24.png)
<p align=”center”>Step 12 off Screenshot </p> 

You have successfully added smart plug as output.
