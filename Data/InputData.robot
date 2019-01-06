*** Settings ***

*** Variables ***
#Global vars
${ROOT_FOLDER}      ${CURDIR}${/}..${/}            #Move from Data folder to EFADA which is the root for all other folders
${TESTS_FOLDER}     ${ROOT_FOLDER}${/}Tests${/}
${DATA_FOLDER}      ${CURDIR}${/}
${LIB_FOLDER}       ${ROOT_FOLDER}${/}Lib${/}
${RESOURCE_FOLDER}  ${ROOT_FOLDER}${/}Resources${/}
${RESULT_FOLDER}    ${ROOT_FOLDER}${/}Results${/}
${PO_FOLDER}        ${ROOT_FOLDER}${/}Resources${/}PO${/}
${BIN_FOLDER}  ${CURDIR}${/}..${/}bin${/}

#Configurations

#Login
&{MOJAZ_USER}           UserName=walemuatadmin         Password=Aa123456
&{Walem_User}           UserName=automation         Password=Ww#123456
&{MOJAZ_USER2}          UserName=automation2         Password=Aa#123456
&{MOJAZ_ADMIN_USER}     UserName=admin1         Password=Ww1234567*

#Registration
&{MOJAZ_Register_USER}           FirstName=gemy  LastName=sedo  Phone=0533321211  Email=abd@dd.com  Address1=Riyadh  Address2=Laban  City=Riyadh  State=Riyadh  PostalCode=12345  Country=ANGUILLA   UserName=AUTOMATION  Password=Aa#123456

#Request Details
&{MOJAZ_Request_Details}         RequestNumber=         Mobile=  SequenceNumber=110000513  ReportStatus=

#System Settings
&{MOJAZ_SystemSettings}          FreePackage=true   BillExpiryDuration=3  ValidityOfReport=4
&{MOJAZ_SystemSettings1}          FreePackage=false   BillExpiryDuration=3  ValidityOfReport=4

#Create Report
&{MOJAZ_VehicleDetails}          SequenceNumber=110022608   ExpiryDate=1444/04/22  Captcha=445566

#Change Password
&{MOJAZ_ChangePasswordData}       OldPassword=Ww#123456   NewPassword=Aa#123456

#Retrieve Password
&{MOJAZ_RetrieveCredentials}           Mobile=0533321211   UserName=automation         Password=Ww#123456

&{MOH_USER}             UserName=MOH                Password=12345678
&{HOSPITAL_USER}        UserName=habib              Password=12345678