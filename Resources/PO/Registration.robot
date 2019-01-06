*** Settings ***
Library  Selenium2Library
Library     Selenium2Library
#Library     DatabaseLibrary
Resource  ../Common/CommonWeb.robot

#Library     ExtendedSelenium2Library
*** Variables ***
${lnkRegisteration}         xpath=//a[text()='REGISTER']
${txtFirstName}     name=firstName
${txtLastName}      name=lastName
${txtPhone}         name=phone
${txtEmail}      name=userName
${txtAddress1}      name=address1
${txtAddress2}      name=address2
${txtCity}          name=city
${txtState}         name=state
${txtPostalCode}    name=postalCode
${txtcountry}       name=country
${txtUser_Name}     xpath=//input[@name='email']
${txtPassword}      name=password
${txtConfirmPassword}  name=confirmPassword
${btnSubmit}  name=register
${chkRegisteredSuccessfully}  xpath=//font[contains(text(),'Thank you for registering')]
*** Keywords ***
Register User
    [Arguments]  ${UserDetails}
    Registration.Navigate To Registration Page
    Fill Registration Form  ${UserDetails}
    Verify Register Success

Fill Registration Form
    [Arguments]  ${UserDetails}
    Input text   ${txtfirstname}        ${UserDetails.FirstName}
    Input text  ${txtlastname}          ${UserDetails.LastName}
    Input text  ${txtphone}          ${UserDetails.Phone}
    Input text  ${txtEmail}             ${UserDetails.Email}
    Input text  ${txtAddress1}   ${UserDetails.Address1}
    Input text  ${txtaddress2}            ${UserDetails.Address2}
    Input text  ${txtaddress2}            ${UserDetails.Address2}
    Input text  ${txtCity}            ${UserDetails.City}
    Input text  ${txtState}            ${UserDetails.State}
    Input text  ${txtPostalCode}            ${UserDetails.PostalCode}
    Select From List   ${txtcountry}    ${UserDetails.Country}
    #Input text  ${txtUser_Name}  ${UserDetails.UserName}
    Input text  ${txtpassword}   ${UserDetails.Password}
    Input text  ${txtconfirmpassword}  ${UserDetails.Password}
    click element   ${btnSubmit}

Navigate To Registration Page
   click element  ${lnkRegisteration}
   wait until page contains element  ${txtphone}

Verify Register Success
    wait until page contains element  ${chkRegisteredSuccessfully}
