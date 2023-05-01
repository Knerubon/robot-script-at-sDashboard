*** Settings ***
Documentation      Last update date : 24 Apr 2021

Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
Resource           prepareData.robot

*** Keywords ***

Input data : name
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text       //input[contains(@formcontrolname,'eventName')]    ${value}
    ...   AND   Wait Loading screen Not Visible

Select Status   
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text       (//input[contains(@aria-autocomplete,'list')])[1]    ${value}
    ...   AND   Wait Loading screen Not Visible
    Click Execute Javascript   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]

Action by role type
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Input Text   (//input[contains(@aria-autocomplete,'list')])[2]    ${value}
    Click Execute Javascript  //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
                              
Add date : start date 
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    #START DATE 
    Click Element   (//button[contains(@class,'btn btn-outline-secondary calendar')])[1]
    Wait Until Page Contains Element   //select[contains(@aria-label,'Select month')]
    ${list}   Get all data excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Select From List By Label    //select[contains(@aria-label,'Select month')]   ${list[${0}]}
    Wait Until Page Contains Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]
    Click Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]
    
Add date : target date    
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}    
    #START DATE
    Click Element   (//button[contains(@class,'btn btn-outline-secondary calendar')])[2]
    Wait Until Page Contains Element   //select[contains(@aria-label,'Select month')]
    ${list}   Get all data excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Select From List By Label    //select[contains(@aria-label,'Select month')]   ${list[${0}]}
    Wait Until Page Contains Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]
    Click Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]

Click Add
    click Element   //button[contains(@class,'btn btn-outline-primary plus-button')]


Search and click Search
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[contains(@type,'text')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //tr[contains(@class,'cdk-row table-row ng-star-inserted')]   30s
    Run Keywords
    ...   Click Execute Javascript  //a[@class='text-uppercase pl-2'][contains(.,'setting')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible


Get name
    [Arguments]   ${xPath}
    ${_Name}   Get Text   ${xPath}
    Should Be True   '${_Name}' == '${value}'


Click Add Column
    # ${no}    Set Variable   1
    # FOR   ${i}    IN RANGE    5
    Wait Until Page Contains Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[1]   30s
    Click Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[1]
    #     ${no}   Evaluate   ${no} + 1
    # END

Click Add Rows
    # ${no}    Set Variable   1
    # FOR   ${i}    IN RANGE    5
    Wait Until Page Contains Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[2]   30s
    Click Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[2]
    #     ${no}   Evaluate   ${no} + 1
    # END

Add Column Data Type : All     #no support data type list and customize

    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}   ${columnNo}    ${listNo}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    ${columnNo}    Set Variable   ${columnNo}
    ${listNo}    Set Variable   ${listNo}
    #inputText 1
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[${columnNo}]
    Input Text   (//input[contains(@formcontrolname,'name')])[${columnNo}]    ${list[${0}]}
    #list1
    Input Text   (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${1}]}
    Click Execute Javascript  //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'${list[${1}]}')]
    #list2
    ${listNo}   Evaluate   ${listNo} + 1
    Input Text     (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${2}]}
    Click Execute Javascript  //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'${list[${2}]}')]
    #inputNum 1
    Input Text   (//input[contains(@type,'number')])[${columnNo}]   ${list[${3}]}
    #list3
    # ${listNo}   Evaluate   ${listNo} + 1
    Click save setting


Add Column Data Type : List 
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}   ${columnNo}    ${listNo}   ${valuelistNo}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    ${columnNo}    Set Variable   ${columnNo}
    ${listNo}    Set Variable   ${listNo}
    ${valuelistNo}    Set Variable   ${valuelistNo}
    #inputText 1
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[${columnNo}]
    Input Text   (//input[contains(@formcontrolname,'name')])[${columnNo}]    ${list[${0}]}
    #list1
    Input Text   (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${1}]}
    Click Execute Javascript  //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'${list[${1}]}')]
    Input Text   (//textarea[contains(@formcontrolname,'propertyPossibleValues')])[${valuelistNo}]      ${list[${2}]}
    #list2
    ${listNo}   Evaluate   ${listNo} + 1
    Input Text     (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${3}]}
    Click Execute Javascript  //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${3}]}')]
    #inputNum 1
    Input Text   (//input[contains(@type,'number')])[${columnNo}]   ${list[${4}]}
    #list3
    # ${listNo}   Evaluate   ${listNo} + 1
    Click save setting

Add Column Data Type : Customize 
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}   ${columnNo}    ${listNo}  
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    ${columnNo}    Set Variable   ${columnNo}
    ${listNo}    Set Variable   ${listNo}
    # ${valuelistNo}    Set Variable   ${valuelistNo}
    #inputText 1
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[${columnNo}]
    Input Text   (//input[contains(@formcontrolname,'name')])[${columnNo}]    ${list[${0}]}
    #list1
    Input Text   (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${1}]}
    Click Execute Javascript  //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'${list[${1}]}')]
    #list2
    ${listNo}   Evaluate   ${listNo} + 1
    Input Text     (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${2}]}
    Click Execute Javascript  //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${2}]}')]
    #list3
    ${listNo}   Evaluate   ${listNo} + 1
    Input Text     (//input[contains(@aria-autocomplete,'list')])[${listNo}]   ${list[${3}]}
    Wait Until Element Is Visible   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${3}]}')]
    Click Execute Javascript  //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${3}]}')]
    #inputNum 1
    Input Text   (//input[contains(@type,'number')])[${columnNo}]   ${list[${4}]}
    #list4
    # ${listNo}   Evaluate   ${listNo} + 1
    Click save setting

Add Rows : Tasks
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Input Text   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   ${value}
    Click Save setting

Click save setting
    Run Keywords
    ...   Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    ${logStatus}   Get Text   //div[contains(@class,'toast-top-right toast-container')]
    log   ${logStatus}
    Log to console   ${logStatus}

Click Manage Permission
    Wait Until Element Is Visible   //button[@type='button'][contains(.,'MANAGE PERMISSIION')]
    Run Keywords
    ...   Click Button   //button[@type='button'][contains(.,'MANAGE PERMISSIION')]
    # ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Set Permissions Group
    [Arguments]    ${sheetExcel}   ${colStart}   ${rowStart}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Element Is Visible   //div[@class='ng-select-container'][contains(.,'All Group')]
    Click Element   //div[@class='ng-select-container'][contains(.,'All Group')]
    Wait Until Page Contains Element   //div[@class='ng-option ng-star-inserted'][contains(.,'${list[${0}]}')]
    Click Element   //div[@class='ng-option ng-star-inserted'][contains(.,'${list[${0}]}')]
    Wait Until Page Contains Element    //label[@class='my-auto'][contains(.,'${list[${1}]}')]
    Click Element   //label[@class='my-auto'][contains(.,'${list[${1}]}')]
    Click Button    //button[@type='button'][contains(.,'ADD GROUP')]
    Wait Until Page Contains Element   //td[contains(.,'${list[${0}]}')]

Click Save Manage Permission
    Run Keywords
    ...   Click Button    //button[@type='button'][contains(.,'SAVE')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Delete colume and row :
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    ${length_list}   Get Length   ${list}

    FOR  ${i}   IN RANGE    ${length_list}
        Click Execute Javascript  (//button[contains(@class,'btn btn-outline-danger btn-circle')])[${list[${i}]}]   
        Wait Loading screen Not Visible
    END

    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Check Eventlist Form
    Select Menu   ${MenuEventlist}
    Search and click event form
    Click Element   //span[@class='event-name'][contains(.,'Admin')]
    configGroup.Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Check Event Report Summary
    Select Menu   ${MenuReportSummary}
    Search and click object search :  Report  5  6
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Check Event Report Costomize
    Select Menu   ${MenuReportCustomize}
    Search Report Costomize
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png


Search Report Costomize
    # [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   EVENT   6   6
    Run Keywords
    ...   Input Text   //input[contains(@placeholder,'Search report')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //td[contains(@role,'gridcell')]
    Run Keywords
    ...   Click Element   (//td[@role='gridcell'][contains(.,'${value}')])[2]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    
Search and click event form 
    # [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   EVENT   6   6
    Run Keywords
    ...   Input Text   //input[contains(@type,'text')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //tr[contains(@class,'cdk-row table-row ng-star-inserted')]   30s
    Run Keywords
    ...   Click Execute Javascript  //span[@class='event-name'][contains(.,'${value}')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Config Colour :
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    ${Length}   Get Length   ${list}
    ${colour}   Set Variable   1

    FOR  ${i}   IN RANGE   ${Length}
        Click Element   (//button[@id='color-picker-btn'])[${colour}]
        Wait Until Element Is Visible    //div[contains(@title,'${list[${i}]}')]
        Click Execute Javascript  //div[contains(@title,'${list[${i}]}')]
        log  ${list[${i}]}
        Click Element   (//div[contains(@class,'col-auto font-weight-bold stakeholder-type-label my-auto')])[${colour}]
        Wait Until Element Is Not Visible    //div[contains(@title,'${list[${i}]}')]
        ${colour}   Evaluate   ${colour} + 1
    END

Select Page Edit 
    Click Element   //a[@class='font-weight-bold nav-link'][contains(.,'EDIT')]
    configGroup.Wait Loading screen Not Visible