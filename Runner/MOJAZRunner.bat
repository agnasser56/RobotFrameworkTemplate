ECHO Automation_Report=C:\\AutomationProjs\\EFADA_RF\\Tests\\Log.zip >> %qm_AttachmentsFile%

cd "C:\AutomationProjs\EFADA_RF\Tests"

pybot -d results -i %qm_RQM_TESTCASE_WEBID% EndToEnd.robot
