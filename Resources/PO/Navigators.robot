*** Settings ***
Library  Selenium2Library
Resource  ../Common/CommonWeb.robot
Resource  Login.robot


*** Variables ***
${lnkNewUser}      xpath=//a[@href='#register']
${lnkRequests}      xpath=//a[@href='#/adminReport']
${lnkSystemSettings}      xpath=//a[@href='#/systemSettings']
${lnkMojazHomePage}      xpath=//a[@class='mojazLogo']
${lnkProfile}           xpath=//a[@ng-click='closeMenu()']
${lnkCreateRequests}           xpath=//a[contains(@href,'userCreateRequest')]

${txtPassword}      name=password
${btnLogin}         xpath=//a[contains(@ng-click,'form.$valid && login()')]
${LogOut}           xpath=//a[@ng-click='logout()']
${btnnotification}  //a[@class[contains(.,"close")]]

*** Keywords ***
Navigate To Registration Page
    ${lnkLoginExist} =   CommonWeb.Check Element Exists  ${lnkLogin}
    RUN KEYWORD IF  ${lnkLoginExist} > 0    click element  ${lnkLogin}
    click link  ${lnkNewUser}
    sleep  5s
    wait until element is visible  	 ${txtUserName}

Navigate To Login Page
    ${lnkLoginExist} =   CommonWeb.Check Element Exists  ${lnkLogin}
    RUN KEYWORD IF  ${lnkLoginExist} > 0    click element  ${lnkLogin}
    sleep  5s
    wait until element is visible  	 ${txtUserName}

Navigate To Requests Page
    click link  ${lnkRequests}
    wait until element is visible  	 ${txtRequestNumber}

Navigate To Create Requests Page
    click element  ${lnkCreateRequests}
    wait until element is visible  	 ${txtsequencenumber}

Navigate To System Settings Page
    click link  ${lnkSystemSettings}
    wait until element is visible  	 ${txtBillExpiryDuration}

Navigate To Mojaz Home Page
    click link  ${lnkMojazHomePage}
    wait until element is visible  	 ${txtSequenceNumber}

Navigate To Profile Page
    click link  ${lnkProfile}
    wait until element is visible  	 ${txtMobile}




