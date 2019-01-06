*** Settings ***
Documentation  This is some basic info about the whole suite
# notice we're no longer referencing the Selenium2Library in our script!
#Resource  ../Resources/ManageHospitalAPP.robot  # necessary for Setup & Teardown
#Library     DatabaseLibrary
Library     Collections
Library     OperatingSystem

#Resource  ../Resources/PO/MainMenu.robot  # necessary for lower level keywords in test cases
Resource  ../Resources/PO/Login.robot
Resource  ../Resources/PO/Registration.robot
Resource  ../Resources/PO/Navigators.robot

Resource  ../Data/InputData.robot

Resource  ../Resources/Common/CommonWeb.robot

#Suite Setup     Begin Web Test
#Suite Teardown  End Web Test

Test Setup  CommonWeb.Begin Web Test
Test Teardown  CommonWeb.End Web Test

# Copy/paste the below line to Terminal window to execute
#  pybot -d results -i mytest ./Tests/EndToEnd.robot
#  pybot -d results -i mytempalte ./Tests/EndToEnd.robot
#  pybot -i mytests  EndToEnd.robot


*** Variables ***


*** Test Cases ***
Verify User Registration
    [Tags]  137783  TEST001
    [Documentation]
    ...  Covered Test Case : User Registration
    Registration.Register User  ${MOJAZ_Register_USER}

Verify User Login
    [Tags]  137784  TEST002
    [Documentation]
    ...  Covered Test Case : User Registration
    Login With User  ${Walem_User}

Valid Login
    Given login page is open
    When valid username and password are inserted
    and credentials are submitted
    Then welcome page should be open


*** Keywords ***
Get Browser Version
	[Arguments]		${bname}
	${agentHeader}=    Execute Javascript    return navigator.userAgent;
	LOG		USER AGENT HEADER=${agentHeader}
	${browserVer}=		Fetch From Right	${agentHeader}		${bname}/
	LOG		BROWSER VERSION=${browserVer}
	[Return]	${browserVer}

