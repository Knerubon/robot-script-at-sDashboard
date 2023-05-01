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

Open Web dashbroad
    [Arguments]   ${user}    ${password}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors    
    Create Webdriver    Chrome    chrome    chrome_options=${chrome_options}    
    Run Keyword If   '${url}' == 'Dev'   Go To    ${urlDev}
    Run Keyword If   '${url}' == 'Uat'   Go To    ${urlUat}
    Maximize Browser Window
    Wait Until Element Is Visible    //input[contains(@type,'email')]   30s     
    Input text      //input[contains(@type,'email')]     ${user}
    Click Element   //input[contains(@value,'Next')]
    Wait Until Element Is Visible    //input[contains(@type,'password')]   30s    
    Input text      //input[contains(@type,'password')]     ${password}
    Click Element   //input[contains(@value,'Sign in')]
    Wait Until Element Is Visible    //input[contains(@value,'Yes')]   30s  
    Run Keywords
    ...   Click Element   //input[contains(@value,'Yes')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png  

Wait Loading screen Not Visible
    Wait Until Element Is Not Visible    //div[contains(@class,'ngx-foreground-spinner center-center')]   30s

Wait Loading screen Is Visible
    Wait Until Element Is Visible    //div[contains(@class,'ngx-foreground-spinner center-center')]    30s

Select Menu
    [Arguments]     ${xPathLocal}
    Run Keywords
    ...   Wait Until Page Contains Element   ${xPathLocal}   30s
    ...   AND   Wait Loading screen Not Visible
    Run Keywords
    ...   Click Element   ${xPathLocal}
    ...   AND   Wait Loading screen Is Visible
    Wait Loading screen Not Visible

Select Group Type : External
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'USER'
    ${ele}    Get WebElement   //label[@class='radio-inline mr-2 ng-star-inserted'][contains(.,'EXTERNAL')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'COMPANY'

Inser date : Member
    [Arguments]  ${memberName}
    Input Text   //input[contains(@aria-autocomplete,'list')]   ${memberName}

Addmember
    [Arguments]  ${memberName}
    Inser date : Member   ${memberName}
    Click Execute Javascript   //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
    Wait Until Element Is Not Visible   //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
    Wait Until Page Contains     ${memberName}   30s
    Click Button   //button[@type='button'][contains(.,'Add Member')]

Add All Member in Group
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    ${list_member}     Get all member      ${sheetExcel}   ${colStart}   ${rowStart}
    ${lenlist_member}    Get Length    ${list_member}  
    
    FOR    ${i}    IN RANGE    ${lenlist_member} 
        Addmember   ${list_member[${i}]}
    END

Count total : Member 
    [Arguments]    ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    ${getTotalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    ${totalMember} =    Split String     ${getTotalMember}      :${SPACE}
    log   ${totalMember}
    ${countMember}      Set Variable     ${totalMember[1]}
    Should Be True   '${value}' == '${countMember}' 
    log  ${countMember}

Click Execute Javascript
    [Arguments]   ${xPath}
    ${ele}    Get WebElement   ${xPath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    # execute javascript  document.getElementById('EXTERNAL').click()

Click Add : circle button
    Wait Until Element Is Enabled     //button[contains(@class,'btn btn-outline-primary btn-circle')]
    Run Keywords
    ...   Click Execute Javascript   //button[contains(@class,'btn btn-outline-primary btn-circle')]
    ...   AND   Wait Loading screen Not Visible

Input data : name group
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${value}
    # Run Keywords
    # ...   Input Text       //input[contains(@formcontrolname,'groupName')]    ${value}
    # ...   AND   Wait Loading screen Is Visible
    # ...   AND   Wait Loading screen Not Visible
    Run Keywords
    ...   Click Element   //div[@class='col-sm-2 my-auto'][contains(.,'GROUP')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible


Input data : Type group
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}      #input : sheet and Column, Row Excel
    Run Keyword If   '${value}' == 'EXTERNAL'   Select Group Type : External

Click Save
    Run Keywords
    ...   Click Element   //button[contains(.,'SAVE')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    

Check status save :
    [Arguments]   ${status}
    ${logStatus}   Get Text   //div[contains(@class,'toast-top-right toast-container')]
    log   ${logStatus}
    Should Be True   '${logStatus}' == '${status}'
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png


Search group list
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[@placeholder='Search']   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //span[@class='cursor hover'][contains(.,'${value}')]
    Run Keywords
    ...   Click Execute Javascript  //span[@class='cursor hover'][contains(.,'${value}')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Wait Until Page Contains Element   //input[contains(@formcontrolname,'groupName')]
    Get group name
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Get group name
    ${GroupName}   Get Value   //input[contains(@formcontrolname,'groupName')]
    Should Be True   '${GroupName}' == '${value}'

Get sarch group name 
    ${GroupName}   Get Text   //span[@class='cursor hover'][contains(.,'${value}')]
    Should Be True   '${GroupName}' == '${value}'


Edit group : Group name
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[contains(@formcontrolname,'groupName')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Run Keywords
    ...   Click Element   //th[@scope='col'][contains(.,'MEMBER')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Get group name
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Edit group : Member
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[contains(@formcontrolname,'groupName')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Run Keywords
    ...   Click Element   //th[@scope='col'][contains(.,'MEMBER')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Get group name
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png


Delete Member
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    ${delMember}   Get Text   (//tr[contains(@class,'ng-star-inserted')])[1]
    log   ${delMember}
    Should Be True   '${delMember}' == '${value}'
    Click Execute Javascript  (//button[contains(@class,'btn btn-outline-danger btn-circle')])[1]
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Delete Group
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[@placeholder='Search']   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //span[@class='cursor hover'][contains(.,'${value}')]
    Get sarch group name
    Click Execute Javascript  //button[contains(@class,'btn btn-outline-danger btn-circle ng-star-inserted')]  
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Page Contains Element   //div[contains(@class,'modal-body')]
    ${getConfirmDel}   Get Text   //div[contains(@class,'modal-body')]
    ${ConfirmDelGroup} =    Split String     ${getConfirmDel}      '
    log   ${ConfirmDelGroup}
    ${ConfirmGroup}      Set Variable     ${ConfirmDelGroup[1]}
    Should Be True   '${value}' == '${ConfirmGroup}' 
    log  ${ConfirmGroup}
    Run Keywords
    ...   Click Button   //button[@type='button'][contains(.,'DELETE')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Check Duplicate Group
    Run Keywords
    ...   Click Element   //label[@class='my-auto font-weight-bold'][contains(.,'GROUP')]
    # ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Wait Until Element Is Visible   //small[@class='text-danger ng-star-inserted'][contains(.,'This name is already exist.')]
    ${msgErrDupGroup}    Get Text   //small[@class='text-danger ng-star-inserted'][contains(.,'This name is already exist.')]
    Should Be True   '${msgErrDupGroup}' == 'This name is already exist.'
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Run Keywords
    ...   Click Element    //button[@type='button'][contains(.,'CANCEL')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
