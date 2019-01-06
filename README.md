# RobotFrameworkTemplate
This is a template project for Robot Framework that use POM design pattern, it supports Selenium as well as API
How to Install:
	1- Install python for windows from the link below:
	https://www.python.org/ftp/python/3.7.1/python-3.7.1.exe
	2- After installing python, add the following to the environement variables:
		C:\Users\{YOUUSERNAME}\AppData\Local\Programs\Python\Python{Version}\Scripts\
		C:\Users\{YOUUSERNAME}\AppData\Local\Programs\Python\Python{Version}\
	3- Start Command Prompt as admin and install the following libraries.
		1- pip install robotframework-seleniumlibrary
		2- pip install robotframework-selenium2library
		3- pip install robotframework-fakerlibrary
		4- pip install robotframework-extendedseleniumlibrary
		5- pip install RESTInstance

How to run the scenarios
	1- Open CMD from the solution directory and run the following command.
		robot -d results -i TEST001 ./Scenarios/E2E.robot
	Note: in the above command TEST001 refers to the test tag inside E2E.robot file, change it accordingly if you want to run other test cases.	
