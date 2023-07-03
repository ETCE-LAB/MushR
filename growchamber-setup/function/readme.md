# Creating Humidity Controller and Cheese Effect while capturing Photo


Humidity controller is designed to maintain 85% to 90% humidity inside the grow tent and while keeping the high humidity inside the tents we observed  photos captured for AI training are blurry and full of moisture which is resulted with noisy images. In conclusion AI was unable to train on noisy images with high humidity 
As  solution to this problem we decided to remove humidity during the photo capturing from the tent we named this solution as cheese effect as we say cheese before capturing a photo.
every hour at 00 minutes and 00 seconds our three cameras capture the images of mushrooms growing inside the tents.
 
Step 1.	Navigate to mycodo IP address in a browser. 

Step 2.	 Click "Setup"	  
 
 ![image](https://user-images.githubusercontent.com/121457303/213941306-334db9d8-e5f5-423a-85de-7e1dfe8e9d0a.png)
Screenshot step 2

Step 3.	click on function
 ![image](https://user-images.githubusercontent.com/121457303/213941338-bdd444fc-6a86-4eb5-a3e0-a0f94ade3c06.png)
Screenshot step 3

Step 4.	in the  newly loaded “Function” page click on the function: Select One dropdown box

![image](https://user-images.githubusercontent.com/121457303/213941373-7e5501ad-b01e-4829-b4b6-974431065734.png)
Screenshot step 4

Step 5.	select Conditional Controller as shown below. 

![image](https://user-images.githubusercontent.com/121457303/213941406-b7075e4a-2d66-4abd-8ca7-2b8971da3adc.png)
Screenshot step 5

Step 6.	Then Click on Add button 
![image](https://user-images.githubusercontent.com/121457303/213941433-7ebfbab3-53b1-419d-8954-0a98a2e2db64.png)
Screenshot step 6

Step 7.	Click on the new added conditional controller gear icon. 
![image](https://user-images.githubusercontent.com/121457303/213941452-dc9a5db2-db72-46cc-9f66-1977004bd5c4.png)
Screenshot step 7

Step 8.	Then paste the following code in the Run python code text box in the newly appeared screen. 
![image](https://user-images.githubusercontent.com/121457303/213941482-942b33b0-76ae-4ba2-bcaf-e7d174884373.png)
Screenshot step 8


Code for step 8

```python
   #  Copyright (C) 2022, 2023 Harish Gundelli
    
   #  This program is free software: you can redistribute it and/or modify
   #  it under the terms of the GNU Affero General Public License as
   #  published by the Free Software Foundation, either version 3 of the
   #  License, or (at your option) any later version.
    
   #  This program is distributed in the hope that it will be useful,
   #  but WITHOUT ANY WARRANTY; without even the implied warranty of
   #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   #  GNU Affero General Public License for more details.
    
   #  You should have received a copy of the GNU Affero General Public License
   #  along with this program.  If not, see <https://www.gnu.org/licenses/>.


	        
   now = datetime.now()
   min1 = now.strftime("%M")
   mini=int(min1)
   self.logger.info("This INFO log entry will appear in the Daemon Log")
   self.run_loop_count += 1  #Counts how many times the run code has been executed
   measurement = self.condition("a0792977")   # Replace ID with correct Conditional ID
   self.logger.info(f"Measurement value is {measurement}")
   if mini > 50:
   self.run_action("81dd30f8", message=self.message)
   if measurement is not None:  # If a measurement exists
   self.message += "This message appears in email alerts and notes.\n"
   if measurement < 82:  # If the measurement is less than 85
   if mini < 50:
   if mini > 2:
       self.message += f"Measurement is too Low! Measurement is {measurement} and outside photo period\n"
       self.run_action("d29201ec", message=self.message)  # Run all actions sequentially
   elif measurement > 87:  # Else If the measurement is greater than 90
   self.message += f"Measurement is too High! Measurement is {measurement}\n"
   #Replace "qwer5678" with an Action ID
   self.run_action("81dd30f8", message=self.message)
   ```
