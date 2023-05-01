*** Settings ***
Documentation     
...               *Create Date* : 01 Apr 2021
...               ${lastVersion}
Resource          Resource/variables.robot
Resource          Resource/configGroup.robot
Resource          Resource/eventlist.robot
Resource          Resource/company.robot
Resource          Resource/report.robot
suite teardown    Close All Browsers

*** Test Case ***

TestGroup_001    #Create new group type internal
    [Documentation]
        ...   Create new group type internal  ${\n}
    [Tags]    TestGroup
    Open Web dashbroad    ${user}   ${password}
    Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    Select Menu   ${MenuGroup} 
    Click Add : circle button
    Input data : name group   Group  6   6
    Input data : Type group   Group  7   6
    Add All Member in Group   Group  8   6     
    Count total : Member   Group   12   6
    Click Save
    Check status save :   Success

TestGroup_002    #Search group , edit name group and add member in group
    [Documentation]
        ...   Search group , edit name group and add member in group  ${\n}
    [Tags]    TestGroup
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuGroup} 
    #------------------------------------
    Search group list  Group  17  6
    Edit group : Group name   Group  18  6
    Click Save
    Check status save :   Update Success
    Search group list  Group  19  6
    Add All Member in Group   Group  21   6
    Count total : Member   Group   24   6
    # Add All Member in Group   Group  25   6     **ยังสามารถ Add ซ้ำได้ รอ Dev แก้
    Delete Member   Group  27  6
    Count total : Member   Group   28   6
    Click Save
    Check status save :   Update Success

TestGroup_003    #Check duplicate group
    [Documentation]
        ...   Check duplicate group  ${\n}
    [Tags]    TestGroup
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    # Step Test
    # Select Menu   ${MenuGroup} 
    #------------------------------------
    Click Add : circle button
    Input data : name group   Group  34   6
    Check Duplicate Group


TestGroup_004    #Delete Group
    [Documentation]
        ...   Delete Group  ${\n}
    [Tags]    TestGroup
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuGroup} 
    #------------------------------------
    Delete Group   Group  40  6

TestGroup_005    #Create new group type internal and external (data test report)
    [Documentation]
        ...   Create new group type internal and external (data test report)  ${\n}
    [Tags]    TestGroup
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuGroup} 
    #------------------------------------
    #Add Group : Internal 
    Click Add : circle button
    Input data : name group   Group  47   6
    Input data : Type group   Group  48   6
    Add All Member in Group   Group  49   6     
    Count total : Member   Group   55   6
    Click Save
    Check status save :   Success
    #Add Group : External #1
    Click Add : circle button
    Input data : name group   Group  60   6
    Input data : Type group   Group  61   6
    Add All Member in Group   Group  62   6     
    Count total : Member   Group   68   6
    Click Save
    # Check status save :   Success
    #Add Group : External #2
    Click Add : circle button
    Input data : name group   Group  72   6
    Input data : Type group   Group  73   6
    Add All Member in Group   Group  74   6     
    Count total : Member   Group   83   6
    Click Save
    # Check status save :   Success

TestEvent_001    #Create Event
    [Documentation]
        ...   Create Event  ${\n}
    [Tags]    TestEvent
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    Select Menu   ${MenuEventlist}
    Click Add : circle button
    Input data : name   EVENT  6  6
    Select Status  EVENT  7  6
    #External
    Action by role type  EVENT  10  6
    Add date : start date   EVENT  12  6
    Add date : target date   EVENT  15  6
    Click Add
    #Internal
    Action by role type  EVENT  19  6
    Add date : start date   EVENT  21  6
    Add date : target date   EVENT  24  6
    Click Add
    #Admin
    Action by role type  EVENT  28  6
    Add date : start date   EVENT  30  6
    Add date : target date   EVENT  33  6
    Click Add
    Count total : Member   EVENT  36  6
    # Config Colour
    Config Colour :  EVENT  41  6
    Click Save
    #Check status
    Check status save :   Success

TestSetting_001    #Setting Permissions Group
    [Documentation]
        ...   Setting Permissions Group  ${\n}
    [Tags]    TestSetting
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuEventlist}
    #------------------------------------
    Search and click Search  Setting  5  6
    Click Manage Permission
    Set Permissions Group   Setting  8  6
    Set Permissions Group   Setting  11  6
    Set Permissions Group   Setting  14  6
    Click Save Manage Permission
    Check status save :  Success


TestSetting_002    #Setting event add column
    [Documentation]
        ...   Setting event add column  ${\n}
    [Tags]    TestSetting
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuEventlist}
    #------------------------------------
    # Search and click Search  Setting  20  6
    # ----Add Column Data Type : All  sheetExcel  colStart  rowStart  columnNo  listNo  (listNo+3)
    Add Column Data Type : All  Setting  23  6  1   1
    Click Add Column
    Add Column Data Type : All  Setting  29  6  2   4
    # # ---Add Column Data Type : List   sheetExcel  colStart  rowStart  columnNo  listNo  valuelistNo   (listNo+3)
    Click Add Column
    Add Column Data Type : List   Setting  35  6  3  7  1
    Click Add Column
    Add Column Data Type : List   Setting  42  6  4  10  2
    # ---Add Column Data Type : Customize   sheetExcel  colStart  rowStart  columnNo  listNo  (listNo+4)
    Click Add Column
    Add Column Data Type : Customize   Setting  49  6  5  13 
    Click Add Column
    Add Column Data Type : All  Setting  56  6  6   17

TestSetting_003    #Setting event add row
    [Documentation]
        ...   Setting event add row  ${\n}
    [Tags]    TestSetting
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    # Select Menu   ${MenuEventlist}
    # Search and click Search  Setting  5  6
    #------------------------------------
    Add Rows : Tasks  Setting  67  6
    Click Add Rows
    Add Rows : Tasks  Setting  69  6
    Click Add Rows
    Add Rows : Tasks  Setting  71  6

TestCompany_001    #Company Submit
    [Documentation]
        ...   Company Submit  ${\n}
    [Tags]    TestCompany
    #Step Test
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #------------------------------------
    Company Login  Uat   Company   6   6
    Select Menu   ${MenuEventlist}
    Search Event   Company   8   6

    Click Edit Form td :  1
    Submit Data Type : Date    Company   12   6
    Click Submit Form

    Click Edit Form td :  2
    Submit Data Type : List  Company  15  6
    Click Submit Form

    Click Edit Form td :  3
    Submit Data Type : List  Company  17  6
    Click Submit Form

    Click Edit Form td :  4
    Submit Data Type : List  Company  18  6
    Click Submit Form

    Click Edit Form td :  5
    Submit Data Type : Input Text  Company  19  6
    Click Submit Form  
    
    #--------------------------------------------------------

    Click Edit Form td :  6
    Submit Data Type : Date    Company   22   6
    Click Submit Form

    Click Edit Form td :  7
    Submit Data Type : List  Company  25  6
    Click Submit Form

    Click Edit Form td :  8
    Submit Data Type : List  Company  27  6
    Click Submit Form

    Click Edit Form td :  9
    Submit Data Type : List  Company  28  6
    Click Submit Form

    Click Edit Form td :  10
    Submit Data Type : Input Text  Company  29  6
    Click Submit Form  

    #--------------------------------------------------------

    # Click Edit Form td :  11
    # Submit Data Type : Date    Company   32   6
    # Click Submit Form

    # Click Edit Form td :  12
    # Submit Data Type : List  Company  35  6
    # Click Submit Form

    # Click Edit Form td :  13
    # Submit Data Type : List  Company  37  6
    # Click Submit Form

    # Click Edit Form td :  14
    # Submit Data Type : List  Company  38  6
    # Click Submit Form

    # Click Edit Form td :  15
    # Submit Data Type : Input Text  Company  39  6
    # Click Submit Form  

    Click Save Form

TestReportSummary_001    #Test Report Summary
    [Documentation]
        ...   Test Report Summary  ${\n}
    [Tags]    TestReport
    Open Web dashbroad    ${user}   ${password}
    #--------------------------------------------------------
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    Select Menu   ${MenuReportSummary}
    Search and click object search :  Report  5  6
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Filter Group :  Report  8  6
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Filter Member :  Report  11  6
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

TestReportCustomize_001    #Test Report Customize
    [Documentation]
        ...   Test Report Customize  ${\n}
    [Tags]    TestReport
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    Select Menu   ${MenuReportCustomize}
    Create Customize Report  Report  17  6

TestSetting_004    #dalete colume and row
    [Documentation]
        ...   Dalete colume and row  ${\n}
    [Tags]    TestSetting
    # Open Web dashbroad    ${user}   ${password}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    #Step Test
    Select Menu   ${MenuEventlist}
    #------------------------------------
    Search and click Search  Setting  5  6
    Delete colume and row :  Setting  79  6
    Check Eventlist Form
    Check Event Report Summary
    Check Event Report Costomize

