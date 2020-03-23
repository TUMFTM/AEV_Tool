########## AEV TOOL ##########

#Requirements for AEV_Tool :

- MATLAB R2017b with all toolboxes and JDBC Driver for SQL Databases
	Installation information: https://www.mathworks.com/help/database/ug/mysql-jdbc-windows.html

- CATIA V5-6R2016 [Education Version]

- DB Browser for SQLite (Default Programm for .db)
	Installation information: http://sqlitebrowser.org/

#Initial Set-Up 

1. Make sure all the folders are in the same location. 
2. Create a text file  called 'javaclasspath.txt' in the directory that contains preferences for MATLAB and related products. 
	- The txt file should contain "C:\DB_Drivers\sqlite-jdbc-3.23.1.jar" [installation directory of the JDBC Driver]
	- Use 'prefdir' to find the default MATLAB preferences directory.
3. "AEV_Tool\09_Macros" Folder contains the script file for CATIA operations such as Opening, Closing, Updating the model. 
	- The script file contains the location information of the parametric CAD models.
	- The file location in the script file is "C:\Ganesh_TUM\AEV-Tool\Git\AEV_Tool\07_CAD\SRT_2030.CATProduct". Please change it to the corresponding installation directory of your computer.
	- All the Macro CATscript files should be changed and updated accordingly.
4. Set up the CAD Model by following the instructions in  '\AEV-Tool\Git\AEV_Tool\06_Exchange\Setting Up the Parametric CAD Model.pdf'
	
#Steps of running the tool

1. Open the script called 'TUMCREATE.m' 
2. The tool asks the user to select between two display size. Use Laptop for normal screens
3. The user can choose between 3 modes, 1. Manual Mode, 2. Automated mode, 3. DART (Parameters Demo)
#Manual Mode

4. In the Manual mode, the user manually input all the parameters. The user must follow the process as shown in the left side of the tool.
	- The tool shows the progress of the user at the bottom by changing the color from green to blue as the user progresses.
	- The 'check' button should pressed after every step to check if all the values are entered. The tool highlights the wrong input with 'red color'.
	- The 'default' button provides all the parmaeter to size the vehicle concept. This helps the user to understand certain parameters. 
5. Following the input of all the parameters, The tool allows the user to visualise the vehicle concept, provides the specifications and 3D concpet. 
#Automated Mode

6. In the automated mode, the user inputs basics input parameters such as the number of passenger, the vehicle type and the tool automatically sizes the rest of the components
7. The user should sequentially select the components from the left side of the tool. The tool provides a quick overview of the concept being developed on the right side. 
8. Similar to the manual mode, the tool shows the progress of the user at the bottom by changing the color from green to blue as the user progresses.
10. After the component selection, the user can perform a powertrain simulation, get cost estimation and compare vehicle properties with spider plot and visualise in 3D. 
11. The Automated mode can create two vehicle concepts simultaneously. 
12. https://www.youtube.com/watch?v=2OABzJDcWN4 - The link shows the demo of the tool. 

#Trouble Shooting

1. If the CAD visulaisation has problems - Please follow the steps in '\AEV-Tool\Git\AEV_Tool\06_Exchange\Design Table and Exporting_TXT.pdf' available in the main folder.
2. Please check if the 'catia_inertia.txt' and 'catia_trigger.txt' files in "\AEV-Tool\Git\AEV_Tool\06_Exchange" are empty with out any text.

#Authors
Ganesh Sethuraman [Corresponding Author: ganesh.sethuraman@tum-create.edu.sg; ganesh.sethuraman@tum.de]
Manfred Schwarz
Stefan maxl
Phi Tran

#License
This project is licensed under the LGPL 3.0 License - see the LICENSE.md file for details
-----------------------------------------------------------------------------------------------------



