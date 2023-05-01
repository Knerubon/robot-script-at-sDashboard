*** Settings ***
Documentation      ${lastVersion}

Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
Resource           prepareData.robot
Resource           configGroup.robot

*** Keywords ***

Search and click object search :
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[contains(@type,'text')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //td[contains(@role,'gridcell')]
    Run Keywords
    ...   Click Execute Javascript  //td[@role='gridcell'][contains(.,'${value}')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Filter Group :
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Page Contains Element   //div[@class='ng-select-container'][contains(.,'Filter Group')]
    Click Element   //div[@class='ng-select-container'][contains(.,'Filter Group')]
    Wait Until Page Contains Element    //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
    Run Keywords
    ...   Click Execute Javascript    //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Filter Member :
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Page Contains Element   (//input[contains(@aria-autocomplete,'list')])[2]
    Click Element   (//input[contains(@aria-autocomplete,'list')])[2]
    Wait Until Element Is Visible    //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
    # Run Keywords
    Click Execute Javascript   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
    # ...   AND   Wait Loading screen Is Visible
    # ...   AND   Wait Loading screen Not Visible
    Run Keywords
    ...   Click Element   //th[@scope='col'][contains(.,'MEMBER')]
    # ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

Create Customize Report
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    ${list}   Get all data excel  ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Element Is Visible   //button[contains(@data-testid,'add-event-button')]
    Click Execute Javascript  //button[contains(@data-testid,'add-event-button')]

    Wait Until Element Is Visible   //div[@class='ng-select-container'][contains(.,'Please Select Event')]
    Click Element   //div[@class='ng-select-container'][contains(.,'Please Select Event')]

    Wait Until Element Is Visible   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${0}]}')]
    Run Keywords
    ...   Click Execute Javascript  //span[@class='ng-option-label ng-star-inserted'][contains(.,'${list[${0}]}')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible

    Input Text   //input[contains(@formcontrolname,'name')]   ${list[${1}]}
    Run Keywords
    ...   Click Button   //button[@type='button'][contains(.,'SAVE')]
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

