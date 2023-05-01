*** Settings ***
Documentation     v.1.0.0
Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime



*** Keywords ***

Company Login
    [Arguments]   ${url}   ${sheetExcel}   ${colStart}   ${rowStart}

    ${urlDev}   Set Variable   #
    ${urlUat}   Set Variable   $(url_uat)/setdd/
    
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors    
    Create Webdriver    Chrome    chrome    chrome_options=${chrome_options}    
    Run Keyword If   '${url}' == 'Dev'    Go To    ${urlDev}
    Run Keyword If   '${url}' == 'Uat'    Go To    ${urlUat}
    Maximize Browser Window
    #input form
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Page Contains Element   //input[contains(@name,'loginName')]   30s
    Input Text   //input[contains(@name,'loginName')]   ${value}
    #click submit
    Click Button   //input[contains(@type,'submit')]
    #Check user
    ${checkUrl}   Get Location
    Run Keyword If   '${checkUrl}' == '$(url_uat)/setdd/authenticate.do'   
    # ...   Click Element   //a[@href='/setdd/confirmLogin.do?method=confirm&uri=']
    ...   Click Element   //a[contains(.,'Reject existing session and proceed login operation.')]

    Wait Until Element Is Visible     //h4[contains(.,'SET Dashboard')] 
    Wait Until Element Is Visible    //button[contains(@class,'btn btn-menu green-seagreen')]
    Click Execute Javascript   //button[contains(@class,'btn btn-menu green-seagreen')]
    Click Execute Javascript  //h4[contains(.,'SET Dashboard')]
    
    Wait Until Element Is Visible    //input[@type='submit']
    Click Button   //input[@type='submit']

    ${handle} =	Select Window	NEW
    Wait Until Element Is Visible     //div[@class='mat-list-item-content'][contains(.,'DASHBOARD')]   30s    


Search Event
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Run Keywords
    ...   Input Text   //input[contains(@type,'text')]   ${value}
    ...   AND   Wait Loading screen Is Visible
    ...   AND   Wait Loading screen Not Visible
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    Wait Until Element Is Visible   //tr[contains(@class,'cdk-row table-row ng-star-inserted')]
    ${ele}    Get WebElement   //span[@class='event-name'][contains(.,'${value}')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 

Click Edit Form td :
    [Arguments]    ${tdNo}
    Wait Until Page Contains Element   (//td[contains(@formarrayname,'properties')])[${tdNo}]
    Mouse Over   (//td[contains(@formarrayname,'properties')])[${tdNo}]
    Wait Until Element Is Visible   (//div[contains(@id,'icon-edit')])[${tdNo}]
    Click Element   (//div[contains(@id,'icon-edit')])[${tdNo}] 

Click Submit Form
    Wait Until Element Is Visible   //div[contains(@id,'icon-view')]   30s
    Click Element  //div[contains(@id,'icon-view')]

Click Save Form
    Wait Until Element Is Visible   //button[@type='button'][contains(.,'SAVE')]
    Click Button   //button[@type='button'][contains(.,'SAVE')]

Submit Data Type : Date
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    # Wait Until Page Contains Element   (//td[contains(@formarrayname,'properties')])[1]
    # Mouse Over   (//td[contains(@formarrayname,'properties')])[1]
    
    # Wait Until Element Is Visible   (//div[contains(@id,'icon-edit')])[1]
    # Click Element   (//div[contains(@id,'icon-edit')])[1] 
    Click Element   //button[contains(@class,'btn btn-outline-secondary calendar')]
    Wait Until Page Contains Element   //select[contains(@aria-label,'Select month')]
    ${list}   Get all data excel   ${sheetExcel}   ${colStart}   ${rowStart}
    Select From List By Label    //select[contains(@aria-label,'Select month')]   ${list[${0}]}
    Wait Until Page Contains Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]
    Click Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${list[${1}]}')]

Submit Data Type : List
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel  ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Page Contains Element   //input[contains(@aria-autocomplete,'list')]
    # Input Text   //input[contains(@aria-autocomplete,'list')]    ${value}
    # Click Execute Javascript  //div[@class='ng-option ng-option-selected ng-option-marked ng-star-inserted'][contains(.,'${value}')]

    Click Element   //div[@class='ng-select-container'][contains(.,'Please Select')]
    Wait Until Element Is Visible    //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]
    # Run Keywords
    Click Execute Javascript    //span[@class='ng-option-label ng-star-inserted'][contains(.,'${value}')]

Submit Data Type : Input Text
    [Arguments]   ${sheetExcel}   ${colStart}   ${rowStart}
    Get Data Excel  ${sheetExcel}   ${colStart}   ${rowStart}
    Wait Until Page Contains Element   //textarea[contains(@formcontrolname,'text')]
    Input Text   //textarea[contains(@formcontrolname,'text')]   ${value}
    

