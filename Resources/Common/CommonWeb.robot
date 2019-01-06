*** Settings ***
Library     Selenium2Library
#Library     DatabaseLibrary
#Library     ../../Lib/datamgr.py
Library     Collections
Library     OperatingSystem
#Library     ArchiveLibrary
Library     String
Resource  ../PO/Login.robot
*** Variables ***
#Configuration
${EnvironmentSheet}
${LoginSheet}
${dicItems}

#these vars are for the common web pages elements
${txtRequestNumber}   name=requestNumber
${txtMobile}		  name=mobile
${txtSequenceNumber}  name=sequenceNumber
${txtExpiryDate}	  xpath=//input[@ng-model='dpHijri']
${lnkExpiryDate}	  xpath=//a[contains(@class,'calendars-trigger')]
${txtCaptcha}		  name=jcaptcha
${btnCreateRequest}		  xpath=//a[contains(@ng-click,'createRequest')]
${btnUserCreateRequest}		  xpath=//a[contains(@ng-click,'userCreateRequest')]

${btnConfirmRequest}  xpath=//a[contains(@ng-click,'afterUserCreateRequest()')]
${msgSuccess}         xpath=//div[@class='success-msg']/descendant::*[contains(text(),'بيانات التقرير جاهزة')]



${ddlReportStatus}	  id=selection
${btnSearch}		  xpath=//a[contains(@ng-click,'searchRequests()')]
${btnConfirmRequest}  xpath=//a[contains(@ng-click,'afterUserCreateRequest()')]
${tblSearchResults}   xpath=//table/descendant::td[contains(text(),'<SeqNo>')]

#Common Web Elements
${lblSuccessMessage}    xpath=//div[contains(@class,'alert-success')]
${LogOut}           xpath=//a[@ng-click='logout()']
${elemNotExist}         xpath=//butt[contains(text(),'بنجاح')]
#${MainConnectionString}      "Provider=pymssql    DataBase=mojaz_qa   UserName=admin   Password=123456789   ServerIP=192.168.46.226  Port="
${MainConnectionString}      pymssql  ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}

${DBHost}         192.168.46.226
${DBName}         mojaz_qa
${DBPass}         123456789
${DBPort}         1433
${DBUser}         admin


*** Keywords ***

Begin Web Test
    #Set Global Variables
    #Load Environment Sheet
    #Load Login Sheet
    #Set Environment Variable   webdriver.chrome.driver  E:\\InnoDev\\Automation\\chromedriver.exe
    Create Webdriver    Chrome    executable_path=E:/InnoDev/Automation/chromedriver.exe
    Go To  https://id.uatc.walem.io/id/login
    #Set Environment Variable   webdriver.chrome.driver  E:/InnoDev/Automation/chromedriver.exe
    #Open Browser  https://id.uatc.walem.io/id/login  chrome
    #Maximize Browser Window

End Web Test
    #Close Browser
    #sleep  5
    #Create Zip From Files In Directory  ${TESTS_FOLDER}${/}results       ${TESTS_FOLDER}${/}Log.zip

Element Exists
    [Documentation]  Determines if the desired element exists
    [Arguments]  ${xpath}
    ${imageCount} =  Get Matching Xpath Count  ${xpath}
    ${imageExists} =  Evaluate  ${imageCount} > 0
    log  ${imageExists}
    [Return]  ${imageExists}

Check Element Exists
    [Documentation]  Determines if the desired element exists
    [Arguments]  ${xpath}
    ${xpath} =  remove string  ${xpath}  xpath=
    log  ${xpath}
    ${imageCount} =  Get Matching Xpath Count  ${xpath}
    ${imageExists} =  Evaluate  ${imageCount} > 0
    [Return]  ${imageExists}

Read Excel sheets
    [Arguments]   ${SheetName}  ${Type}

    ${tuple} =     Read From Excel
                    ...  Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)
                    ...  ${DATA_FOLDER}EFADA_RF_ControlFile.xlsx
                    ...  Select * from [${SheetName}]
                    ...  ${Type}
    return from keyword       ${tuple}
    set selenium timeout

Load Environment Sheet
    #Create dictionary   ${Environment}
    ${tuple}=   Read Excel sheets   Environment$    dict
    Set global variable  ${EnvironmentSheet}  ${tuple}
    log  ${tuple['RunType']}


Load Login Sheet
    #Create dictionary   ${Environment}
    ${tuple}=   Read Excel sheets   LogIn$  list
    Set global variable  ${LoginSheet}  ${tuple}
    log  ${LoginSheet}


Execute DataBase Script
    [Arguments]   ${sqlStatement}
     log  ${sqlStatement}
     Connect To Database         pymssql  ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}
     execute sql string          ${sqlStatement}


Search Vehicle
    [Arguments]  ${dr}
    Fill Search Vehicle Form  ${dr}
    Verify Search Vehicle Success  ${dr}

Fill Search Vehicle Form
   [Arguments]  ${dr}
	Input Text 		${txtSequenceNumber}  ${dr.SequenceNumber}
	#remove the readonly attribute to be able to set the text
	Execute Javascript  document.getElementsByClassName('form-control ng-pristine ng-untouched ng-valid is-calendarsPicker')[0].removeAttribute('readonly');
	#Execute JavaScript  "document.getElementsByClassName('form-control ng-pristine ng-valid is-calendarsPicker ng-touched')[0].readOnly = false;"
	Input Text 		${txtExpiryDate}  ${dr.ExpiryDate}
	Input Text 		${txtCaptcha}	  ${dr.Captcha}
    ${lnkLoginExist} =   CommonWeb.Check Element Exists  ${lnkLogin}
    RUN KEYWORD IF  ${lnkLoginExist} > 0    click element  ${btnCreateRequest}
	...         ELSE  Click Element 	${btnUserCreateRequest}

Verify Search Vehicle Success
    [Arguments]  ${dr}
    wait until page contains element  ${msgSuccess}
    page should contain element   ${msgSuccess}

Fill Search Request Form
    [Arguments]  ${dr}
    Input Text 		${txtRequestNumber}				${dr.RequestNumber}
	Input Text 		${txtMobile}				    ${dr.Mobile}
	Input Text 		${txtSequenceNumber}			${dr.SequenceNumber}
	Select From List		${ddlReportStatus}		${dr.ReportStatus}
	wait until element is visible  ${btnSearch}
	Click Element 		${btnSearch}

Verify Search Request Success
    [Arguments]  ${dr}
    sleep  5
    #${tblSearchResults} =  Get WebElement  xpath=//table/descendant::td[contains(text(),'${dr.SequenceNumber}')]
    ${tblSearchResults} =  replace string  ${tblSearchResults}  <SeqNo>  ${dr.SequenceNumber}
    Element Text Should Be  ${tblSearchResults}  ${dr.SequenceNumber}

Get Element Text
    [Arguments]  ${elem}
    wait until page contains element   ${elem}
    ${elemInnerText} =  get text  ${elem}
    should be equal  ${elemInnerText}  English
    [Return]  ${elemInnerText}

