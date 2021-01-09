*** Settings ***
Resource  ../Resources/signupBack.robot
Resource  ../Resources/variables.robot

*** Test Case ***
Subscribe User In Db
    [Tags]  First
    signupBack.Check If User Exist In Database
    signupBack.Subscribe User With Http Post
    signupBack.Check If User Is Created