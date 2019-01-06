import pyodbc
import os

# Excel driver: Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)
# Excel driver: Microsoft Access Driver (*.mdb, *.accdb)
# SQL driver: SQL Server
#For Oracle you need to install odbc driver

def read_from_excel(driver,filename,query,returntype):
    #print filename
    #assert os.path.exists(filename)

    CNXNSTRING = (r'Driver={0}; DBQ={1};'.format(driver, filename))

    print ('CNXNSTRING is ', CNXNSTRING)
    cnxn = pyodbc.connect(CNXNSTRING, autocommit=True)
    #print cnxn
    crsr = cnxn.cursor()
    #query = (query)
    crsr.execute(query)
    rows = crsr.fetchall()
    cnxn.close()
    #for row in rows:
    #   return (row.__getattribute__(colname))
    if returntype == 'dict':
           return (dict(rows))
    elif returntype == 'list':
           return (list(rows))




#D:\RTC_SandBox\EFADA_RF\Data\EFADA_RF_ControlFile.xlsx
#result = read_from_excel('Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)','D:\RTC_SandBox\EFADA_RF\Data\EFADA_RF_ControlFile.xlsx','select * from [LogIn$]','dict')
#print result
