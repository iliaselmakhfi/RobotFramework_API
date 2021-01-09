*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot

*** Keywords ***
Check If User Exist In Database
    Connect To Database Using Custom params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is 0  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')

Subscribe User With Http Post
    Create Session  session1  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}
    ${headers} =  Create Dictionary  Content-type= application/x-www-form-urlencoded
    ${responses} =  Post Request  session1  signup.php  data=${data}  headers=${headers}
    ${json} =  Set Variable  ${responses.json}
    Log  ${json}
    Should Be Equal As Strings  ${responses.status_code}  200

Check If User Is Created
    Connect To Database Using Custom params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${username}' and password = md5('${password}')  1