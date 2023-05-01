*** Settings ***
Documentation     v.1.0.0
# Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime

*** Keywords ***
Company Login
    [Arguments]   ${url}   ${username}    #${password}

    ${urlDev}   Set Variable   #
    ${urlUat}   Set Variable   $(url_uat)/setdd/
    
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors    
    Create Webdriver    Chrome    chrome    chrome_options=${chrome_options}    
    Run Keyword If   '${url}' == 'Dev'    Go To    ${urlDev}
    Run Keyword If   '${url}' == 'Uat'    Go To    ${urlUat}
    Maximize Browser Window
    #input form
    Wait Until Page Contains Element   //input[contains(@name,'loginName')]   30s
    Input Text   //input[contains(@name,'loginName')]   ${username}
    Click Button   //input[contains(@type,'submit')]
    #Check user
    ${checkUrl}   Get Location
    Run Keyword If   '${checkUrl}' == '$(url_uat)/setdd/authenticate.do'   
    ...   Click Element   //a[@href='/setdd/confirmLogin.do?method=confirm&uri=']
    Wait Until Page Contains Element   //h4[contains(.,'SET Dashboard')]   30s
    Click Element   //h4[contains(.,'SET Dashboard')]
    Wait Until Page Contains Element   //input[@type='submit']   30s
    Click Button   //input[@type='submit']
    # Wait Until Page Contains Element    DASHBOARD   45s


Wait Loading screen
    Wait Until Element Is Visible   //div[contains(@class,'ngx-foreground-spinner center-center')]
    # Wait Until Element Is Not Visible    //div[contains(@class,'ngx-foreground-spinner center-center')] 
    Wait Until Element Is Hidden   //div[contains(@class,'ngx-foreground-spinner center-center')] 

Wait Loading screen Not Visible
    Wait Until Element Is Not Visible    //div[contains(@class,'ngx-foreground-spinner center-center')]   30s

Wait Loading screen Is Visible
    Wait Until Element Is Visible    //div[contains(@class,'ngx-foreground-spinner center-center')]    30s


Create Group
    [Arguments]   ${inputDate}
    Wait for page load
    Click Element   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
    Wait for page load
    #Click Add Group
    Wait Until Element Is Enabled     //button[contains(@class,'btn btn-outline-primary btn-circle')]   30s
    ${ele}    Get WebElement   //button[contains(@class,'btn btn-outline-primary btn-circle')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Wait for page load
    #INTERNAL
    Run Keyword If   '${inputDate}' == 'INTERNAL_1'   Input Data INTERNAL_1
    Run Keyword If   '${inputDate}' == 'INTERNAL_2'   Input Data INTERNAL_2
    #EXTERNAL
    Run Keyword If   '${inputDate}' == 'EXTERNAL_1'   Input Data EXTERNAL_1
    Run Keyword If   '${inputDate}' == 'EXTERNAL_2'   Input Data EXTERNAL_2
    # Run Keyword If   '${inputDate}' == 'EXTERNAL_3'   Input Data EXTERNAL_3

Input Data INTERNAL_1
    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     6   6   Group
    ${GroupType}   Read Excel Cell     7   6   Group
    ${member1}     Read Excel Cell     8   6   Group
    ${member2}     Read Excel Cell     9   6   Group
    ${member3}     Read Excel Cell    10   6   Group
    Set Test Variable   ${GroupName}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    Click Element    //label[contains(.,'${GroupType}')]
    
    ${no}    Set Variable   1
    FOR   ${i}    IN RANGE    3
        Input Text     //input[contains(@aria-autocomplete,'list')]     ${member${no}}
        Wait for page load
        Mouse over     //div[@class='ng-select-container'][contains(.,'Please select user')]
        Mouse Down      //span[@class='ng-option-label ng-star-inserted'][contains(.,'${member${no}}')]
        Click Element   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${member${no}}')]
        Wait for page load
        ${no}   Evaluate   ${no} + 1
        Click Element   //button[contains(.,'Add Member')]
    END

    #count total member
    # [Arguments]   ${countMember}
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 3' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load

Input Data INTERNAL_2
    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     17   6   Group
    ${GroupType}   Read Excel Cell     18   6   Group
    ${member1}     Read Excel Cell     19   6   Group
    ${member2}     Read Excel Cell     20   6   Group
    ${member3}     Read Excel Cell     21   6   Group
    ${member4}     Read Excel Cell     22   6   Group     #---> member duplicate

    Set Test Variable   ${GroupName}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    Click Element    //label[contains(.,'${GroupType}')]

    ${no}    Set Variable   1
    FOR   ${i}    IN RANGE    4
        Input Text     //input[contains(@aria-autocomplete,'list')]     ${member${no}}
        Wait for page load
        Mouse over     //div[@class='ng-select-container'][contains(.,'Please select user')]
        Mouse Down      //span[@class='ng-option-label ng-star-inserted'][contains(.,'${member${no}}')]
        Click Element   //span[@class='ng-option-label ng-star-inserted'][contains(.,'${member${no}}')]
        Wait for page load
        ${no}   Evaluate   ${no} + 1
        Click Element   //button[contains(.,'Add Member')]
    END

    #count total member
    # [Arguments]   ${countMember}
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 4' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load

Input Data EXTERNAL_1
    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     29   6   Group
    ${GroupType}   Read Excel Cell     30   6   Group
    ${member1}     Read Excel Cell     31   6   Group
    ${member2}     Read Excel Cell     32   6   Group
    ${member3}     Read Excel Cell     33   6   Group
    ${member4}     Read Excel Cell     34   6   Group     
    ${member5}     Read Excel Cell     35   6   Group

    Set Test Variable   ${GroupName}
    Set Test Variable   ${GroupType}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'USER'
    Wait for page load
 
    execute javascript  document.getElementById('EXTERNAL').click()
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'COMPANY'

    ${no}    Set Variable   1
    FOR   ${i}    IN RANGE    5
        Input Text     //input[contains(@aria-autocomplete,'list')]     ${member${no}}
        Wait for page load
        Mouse over     //div[@class='ng-select-container'][contains(.,'Please select company')]
        Mouse Down      //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Click Element   //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Wait for page load
        ${no}   Evaluate   ${no} + 1
        Click Element   //button[contains(.,'Add Member')]
    END

    #count total member
    # [Arguments]   ${countMember}
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 5' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load

Input Data EXTERNAL_2
    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     40   6   Group
    ${GroupType}   Read Excel Cell     41   6   Group
    ${member1}     Read Excel Cell     42   6   Group
    ${member2}     Read Excel Cell     43   6   Group
    ${member3}     Read Excel Cell     44   6   Group
    ${member4}     Read Excel Cell     45   6   Group     #---> member duplicate
    ${member5}     Read Excel Cell     46   6   Group     #---> member duplicate

    Set Test Variable   ${GroupName}
    Set Test Variable   ${GroupType}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'USER'
    Wait for page load
 
    execute javascript  document.getElementById('EXTERNAL').click()
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'COMPANY'

    ${no}    Set Variable   1
    FOR   ${i}    IN RANGE    5
        Input Text     //input[contains(@aria-autocomplete,'list')]     ${member${no}}
        Wait for page load
        Mouse over     //div[@class='ng-select-container'][contains(.,'Please select company')]
        Mouse Down      //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Click Element   //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Wait for page load
        ${no}   Evaluate   ${no} + 1
        Click Element   //button[contains(.,'Add Member')]
    END

    #count total member
    # [Arguments]   ${countMember}
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 5' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load

Input Data EXTERNAL_3
    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     65   6   Group
    ${GroupType}   Read Excel Cell     66   6   Group
    ${member1}     Read Excel Cell     67   6   Group
    ${member2}     Read Excel Cell     68   6   Group
    ${member3}     Read Excel Cell     69   6   Group
    ${member4}     Read Excel Cell     70   6   Group     
    ${member5}     Read Excel Cell     71   6   Group  
    ${member6}     Read Excel Cell     72   6   Group  
    ${member7}     Read Excel Cell     73   6   Group  
    ${member8}     Read Excel Cell     74   6   Group  
    ${member9}     Read Excel Cell     75   6   Group  
    ${member10}     Read Excel Cell     76   6   Group  
    ${member11}     Read Excel Cell     77   6   Group  
    ${member12}     Read Excel Cell     78   6   Group  
    ${member13}     Read Excel Cell     79   6   Group  
    ${member14}     Read Excel Cell     80   6   Group  
    ${member15}     Read Excel Cell     81   6   Group  
    ${member16}     Read Excel Cell     82   6   Group  
    ${member17}     Read Excel Cell     83   6   Group  
    ${member18}     Read Excel Cell     84   6   Group  
    ${member19}     Read Excel Cell     85   6   Group  
    ${member20}     Read Excel Cell     86   6   Group  

    Set Test Variable   ${GroupName}
    Set Test Variable   ${GroupType}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'USER'
    Wait for page load
 
    execute javascript  document.getElementById('EXTERNAL').click()
    ${checkRole}   Get Text    (//div[contains(@class,'col-sm-2 my-auto')])[3]
    Should Be True   '${checkRole}' == 'COMPANY'

    ${no}    Set Variable   1
    FOR   ${i}    IN RANGE    20
        Input Text     //input[contains(@aria-autocomplete,'list')]     ${member${no}}
        Wait for page load
        Mouse over     //div[@class='ng-select-container'][contains(.,'Please select company')]
        Mouse Down      //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Click Element   //div[contains(@class,'ng-option ng-star-inserted ng-option-marked')]
        Wait for page load
        ${no}   Evaluate   ${no} + 1
        Click Element   //button[contains(.,'Add Member')]
    END

    #count total member
    # [Arguments]   ${countMember}
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 20' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load


Delete Group
    # [Arguments]   ${groupName}
    #Delete
    Click Element   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
    Wait for page load
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     57   6   Group
    Set Test Variable   ${GroupName}
    #Search
    Wait Until Page Contains Element   //input[@placeholder='Search']   30s
    Input Text    //input[@placeholder='Search']   ${GroupName}
    Wait for page load

    Wait Until Page Contains    ${GroupName}    30s
    ${checkGroup}    Get Text    (//td[contains(@role,'gridcell')])[1]
    Should Be True   '${checkGroup}' == '${GroupName}'
    Click Element   //button[@class='btn btn-outline-danger btn-circle ng-star-inserted']
    Wait Until Page Contains Element    //button[@type='button'][contains(.,'DELETE')]    30s 
    ${confirmDel}   Get Text    //div[contains(@class,'modal-body')]
    ${__confirmDel}   Get Substring   ${confirmDel}   8   -8
    Should Be True  '${__confirmDel}' == '${GroupName}'
    Click Element   //button[@type='button'][contains(.,'DELETE')]
    Wait for page load
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

Edit Name Group
    Click Element   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
    Wait for page load
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}        Read Excel Cell     51   6   Group
    ${ChangGroupName}   Read Excel Cell     53   6   Group
    Set Test Variable   ${GroupName}
    Set Test Variable   ${ChangGroupName}
    #Search
    Wait Until Page Contains Element   //input[@placeholder='Search']   30s
    Input Text    //input[@placeholder='Search']   ${GroupName}
    Wait for page load
    Wait Until Page Contains    ${GroupName}    30s
    ${checkGroup}    Get Text    (//td[contains(@role,'gridcell')])[1]
    Should Be True   '${checkGroup}' == 'TEST GROUP INTERNAL - 2'
    Click Element   //span[@class='cursor hover'][contains(.,'${GroupName}')]
    Wait for page load
    Input Text   //input[contains(@formcontrolname,'groupName')]      ${ChangGroupName}
    Wait for page load
    ${ele}    Get WebElement   //button[@type='submit'][contains(.,'SAVE')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Wait Until Page Contains Element   //input[@placeholder='Search']   30s
    Input Text    //input[@placeholder='Search']   ${ChangGroupName}
    Wait for page load
    Wait Until Page Contains    ${ChangGroupName}    30s
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png


Delete Member
    # Click Element   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
    # Wait for page load
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     6   6   Group
    Set Test Variable   ${GroupName}
    #Search
    Wait Until Page Contains Element   //input[@placeholder='Search']   30s
    Input Text    //input[@placeholder='Search']   ${GroupName}
    Wait Until Page Contains Element   //td[@role='gridcell'][contains(.,'${GroupName}')]   30s
    ${checkGroup}    Get Text    //td[@role='gridcell'][contains(.,'${GroupName}')]
    Should Be True   '${checkGroup}' == '${GroupName}'
    Wait Until Page Contains Element   //span[@class='cursor hover'][contains(.,'${GroupName}')]   30s
    Click Element    //span[@class='cursor hover'][contains(.,'${GroupName}')]
    Wait for page load
    #Delete 1 Member 
    Click Element   (//button[contains(@class,'btn btn-outline-danger btn-circle')])[1]
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 2' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #Save
    Click Element   //button[contains(.,'SAVE')]
    Wait for page load

Group Err Duplicate
    # [Arguments]   ${inputDate}
    Wait for page load
    Click Element   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
    Wait for page load

    # Wait Until Page Contains Element   //button[contains(@class,'btn btn-outline-primary btn-circle')]   30s
    # Click Button   //button[contains(@class,'btn btn-outline-primary btn-circle')]

    ${ele}    Get WebElement   //button[contains(@class,'btn btn-outline-primary btn-circle')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 

    Wait for page load

    Wait Until Page Contains Element   //button[@type='submit'][contains(.,'SAVE')]
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}   Read Excel Cell     62   6   Group
    Set Test Variable   ${GroupName}
    Input Text       //input[contains(@formcontrolname,'groupName')]    ${GroupName}
    Wait for page load
    Click Button    //button[@type='submit'][contains(.,'SAVE')]
    Wait for page load

    ${errMsgDupGroup}   Get Text   //small[contains(@class,'text-danger ng-star-inserted')]
    Should Be True   '${errMsgDupGroup}' == 'This name is already exist.' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png

