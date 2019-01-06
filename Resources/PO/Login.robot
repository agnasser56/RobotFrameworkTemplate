*** Settings ***
Library  Selenium2Library
Resource  ../Common/CommonWeb.robot

*** Variables ***
${txtUserName}      id=login-username
${txtPassword}      id=login-password
${btnLogin}         id=btn-login
${LogOut}           xpath=//a[@ng-click='logout()']
${btnnotification}  xpath=//a[@class[contains(.,"close")]]
${lnkLogin}         xpath=//a[@href='#login']
${lnkLogin1}         xpath=//a[@href='#login']
${lnkForgetUserName}         xpath=//a[@href='#forgetUserName']
${lnkForgetPassword}         xpath=//a[@href='#forgetPassword']
${btnSubmitDetails}     xpath=//a[contains(@ng-click,'forgetUserName')]
${btnSubmitDetails2}     xpath=//a[contains(@ng-click,'forgetPassword')]
${btnLoginFromPublicPage}     xpath=//a[@ng-click='login()']
${btnLoginFromTopMenu}     xpath=//a[@href='#login']
*** Keywords ***
Login With User
    [Arguments]  ${Credentials}
    Input text  ${txtUserName}     ${Credentials.UserName}
    Input text  ${txtPassword}     ${Credentials.Password}
    #Handle the captcha case
    ${captchaExist} =   CommonWeb.Element Exists  //input[@name='jcaptcha']
    RUN KEYWORD IF  ${captchaExist} == True  input text  ${txtcaptcha}  123456
    click link  ${btnLogin}

    Verify Login Success

Retrieve Credentials Forget UserName
    Navigate To Retrieve Credentials By Forget UserName Page
    Fill Retrieve Credentials Forget UserName Form  ${MOJAZ_RetrieveCredentials}
    Verify Retrieve Credentials Success
    Reset The Password To Default


Retrieve Credentials Forget Password
    Navigate To Retrieve Credentials By Forget Password Page
    Fill Retrieve Credentials Forget Password Form  ${MOJAZ_RetrieveCredentials}
    Verify Retrieve Credentials Success
    Reset The Password To Default

Fill Retrieve Credentials Forget UserName Form
  [Arguments]  ${Credentials}
    Input text  ${txtmobile}     ${Credentials.Mobile}
    Input text  ${txtcaptcha}     123456
    click link  ${btnSubmitDetails}

Fill Retrieve Credentials Forget Password Form
  [Arguments]  ${Credentials}
    Input text  ${txtUserName}     ${Credentials.UserName}
    Input text  ${txtmobile}     ${Credentials.Mobile}
    Input text  ${txtcaptcha}     123456
    click link  ${btnSubmitDetails2}

Navigate To Retrieve Credentials By Forget UserName Page
    click link  ${lnkForgetUserName}
    wait until page contains element   ${txtMobile}

Navigate To Retrieve Credentials By Forget Password Page
    click link  ${lnkForgetPassword}
    wait until page contains element   ${txtusername}

Navigate To Login Page From Public Page
    click element  ${btnLoginFromPublicPage}
    wait until element is visible   ${txtusername}

Navigate To Login Page From Top Menu
    click element  ${btnLoginFromTopMenu}
    wait until element is visible   ${txtusername}

Close Notification
   click link  ${btnnotification}


Verify Login Success
    wait until page contains element  ${LogOut}

Verify Retrieve Credentials Success
    wait until page contains element  ${lblSuccessMessage}


Logout
    click link                       ${LogOut}
    wait until element is visible  	 ${lnkLogin}


