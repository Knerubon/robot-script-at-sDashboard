*** Settings ***
Documentation     v.1.0.0
Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
# Resource                  variables.robot


*** Keywords ***
Create Event
    # Wait for page load
    Element Should Be Visible   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    # Wait Until Page Contains Element   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]   30s
    Click Element    //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Wait for page load
    # Capture Page Screenshot
    Wait Until Page Contains Element   //button[contains(@class,'btn btn-outline-primary btn-circle')]   30s
    ${ele}    Get WebElement   //button[contains(@class,'btn btn-outline-primary btn-circle')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Wait for page load
    # Capture Page Screenshot
    
    #input date
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${eventName}     Read Excel Cell     6   6   EVENT
    ${statusEvent}   Read Excel Cell     7   6   EVENT
    #External
    ${ex_actionBY}        Read Excel Cell     10   6   EVENT
    ${ex_startMonth}      Read Excel Cell     12   6   EVENT
    ${ex_startDate}       Read Excel Cell     13   6   EVENT
    ${ex_targetMonth}     Read Excel Cell     15   6   EVENT
    ${ex_targetDate}      Read Excel Cell     16   6   EVENT
    Set Test Variable     ${ex_actionBY}
    #Internal
    ${in_actionBY}        Read Excel Cell     19   6   EVENT
    ${in_startMonth}      Read Excel Cell     21   6   EVENT
    ${in_startDate}       Read Excel Cell     22   6   EVENT
    ${in_targetMonth}     Read Excel Cell     24   6   EVENT
    ${in_targetDate}      Read Excel Cell     25   6   EVENT
    Set Test Variable     ${in_actionBY}
    #Admin
    ${ad_actionBY}        Read Excel Cell     28   6   EVENT
    ${ad_startMonth}      Read Excel Cell     30   6   EVENT
    ${ad_startDate}       Read Excel Cell     31   6   EVENT
    ${ad_targetMonth}     Read Excel Cell     33   6   EVENT
    ${ad_targetDate}      Read Excel Cell     34   6   EVENT
    Set Test Variable     ${ad_actionBY} 

    Wait Until Page Contains Element   //input[contains(@formcontrolname,'eventName')]
    Input Text   //input[contains(@formcontrolname,'eventName')]   ${eventName}
    Click Element   //div[@class='ng-select-container ng-has-value'][contains(.,'Please Select×DRAFT')]
    Click Element   //div[@class='ng-option ng-star-inserted'][contains(.,'ACTIVE')]
    #External
    add group type member to event  ${ex_actionBY}   ${ex_startMonth}   ${ex_startDate}   ${ex_targetMonth}   ${ex_targetDate}
    add group type member to event  ${in_actionBY}   ${in_startMonth}   ${in_startDate}   ${in_targetMonth}   ${in_targetDate}
    add group type member to event  ${ad_actionBY}   ${ad_startMonth}   ${ad_startDate}   ${ad_targetMonth}   ${ad_targetDate}
    #check member
    ${totalMember}   Get Text   //div[contains(@class,'text-uppercase mt-2 mb-2 font-weight-bold')]
    Should Be True   '${totalMember}' == 'TOTAL MEMBER: 3' 
    Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png
    #click save
    Click Element   //button[@type='submit'][contains(.,'SAVE')]


add group type member to event
    [Arguments]   ${actionBY}   ${startMonth}   ${startDate}   ${targetMonth}   ${targetDate}
    
    Run Keyword If   '${actionBY}' == 'EXTERNAL'   Select Option Type Group External  ${actionBY}
    ...   ELSE   Select Option Type Group  ${actionBY}

    #START DATE 
    Click Element   (//button[contains(@class,'btn btn-outline-secondary calendar')])[1]
    Wait Until Page Contains Element   //select[contains(@aria-label,'Select month')]
    Select From List By Label    //select[contains(@aria-label,'Select month')]   ${startMonth}
    Wait Until Page Contains Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${startDate}')]
    Click Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${startDate}')]
    #START DATE
    Click Element   (//button[contains(@class,'btn btn-outline-secondary calendar')])[2]
    Wait Until Page Contains Element   //select[contains(@aria-label,'Select month')]
    Select From List By Label    //select[contains(@aria-label,'Select month')]   ${targetMonth}
    Wait Until Page Contains Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${targetDate}')]
    Click Element   //div[@class='btn-light ng-star-inserted'][contains(.,'${targetDate}')]
    #Click Add
    Wait Until Page Contains Element   //button[contains(@class,'btn btn-outline-primary plus-button')]   30s
    Click Element   //button[contains(@class,'btn btn-outline-primary plus-button')]

config colour to group type
    
    Wait Until Page Contains Element   (//button[contains(@type,'button')])[4]
    Click Element   (//button[contains(@type,'button')])[4]
    Wait Until Page Contains Element   //div[contains(@title,'#FCB900')]   30s
    Click Element   //div[contains(@title,'#FCB900')]

    Wait Until Page Contains Element   (//button[contains(@type,'button')])[8]
    Click Element   (//button[contains(@type,'button')])[8]
    Wait Until Page Contains Element   //div[contains(@title,'#8ED1FC')]   30s
    Click Element   //div[contains(@title,'#8ED1FC')]

    Wait Until Page Contains Element   (//button[contains(@type,'button')])[12]
    Click Element   (//button[contains(@type,'button')])[12]
    Wait Until Page Contains Element   //div[contains(@title,'#FCB900')]   30s
    Click Element   //div[contains(@title,'#FCB900')]

Select Option Type Group External
    [Arguments]    ${actionBY}

    Wait Until Page Contains Element   //div[@class='ng-select-container'][contains(.,'Please Select')]    30s
    Click Element   //div[@class='ng-select-container'][contains(.,'Please Select')]
    
    Wait Until Page Contains Element   //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'${actionBY}')]   30s
    ${ele}    Get WebElement   //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'${actionBY}')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}

Select Option Type Group
    [Arguments]    ${actionBY}

    Wait Until Page Contains Element   //div[@class='ng-select-container'][contains(.,'Please Select')]    30s
    Click Element   //div[@class='ng-select-container'][contains(.,'Please Select')]
    
    Wait Until Page Contains Element   //div[@class='ng-option ng-star-inserted'][contains(.,'${actionBY}')]   30s
    ${ele}    Get WebElement   //div[@class='ng-option ng-star-inserted'][contains(.,'${actionBY}')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}

Setting Event
    #Event Page
    Wait Until Page Contains Element   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Element Should Be Visible   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Click Element    //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Wait for page load
    Search Event
    Manage Permission   8  9
    Manage Permission   11  12
    Manage Permission   14  15
    Manage Permission   17  18

Add Column To Event
    Element Should Be Visible   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Click Element    //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Wait for page load
    Search Event
    Add Column Data Type Date
    Add Column
    Add Column Data Type Status
    Add Column
    Add Column Data Type List Internal
    Add Column
    Add Column Data Type List External
    Add column
    Add Column Data Type Customize
    Add Column
    Add Column Data Type Freetext

Search Event
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${EventName}      Read Excel Cell     5   6   Setting
    Set Test Variable   ${EventName}
    Wait Until Page Contains Element   //input[@placeholder='Search event']   30s
    Input Text    //input[@placeholder='Search event']   ${EventName}
    Wait for page load
    Wait Until Page Contains Element   (//td[@role='gridcell'][contains(.,'${EventName} ACTIVE settingclone')])[1]   30s
    ${getEvent}   Get Text   (//td[@role='gridcell'][contains(.,'${EventName} ACTIVE settingclone')])[1]
    # Should Be True   '${getEvent}' == 'A-BOT TEST EVENT DASHBOARD 2021 -4 ACTIVE
    # ...   SETTINGCLONE' 
    ${ele}    Get WebElement   //a[@class='text-uppercase pl-2'][contains(.,'setting')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 

Manage Permission
    [Arguments]    ${dataGroupName}   ${dataSelectType}
    # Open Excel Document     ${ExcelName}        ${excelPath}
    ${GroupName}      Read Excel Cell     ${dataGroupName}   6   Setting
    ${selectType}     Read Excel Cell     ${dataSelectType}   6   Setting
    Set Test Variable       ${GroupName}
    Set Test Variable       ${selectType}
    Wait Until Page Contains Element   //button[@type='button'][contains(.,'MANAGE PERMISSIION')]   30s
    Click Element   //button[@type='button'][contains(.,'MANAGE PERMISSIION')]
    Wait for page load
    Wait Until Page Contains Element     (//input[contains(@aria-autocomplete,'list')])[5]   30s
    Wait Until Page Contains Element     //button[@type='button'][contains(.,'SAVE')]    30s
    Input Text     (//input[contains(@aria-autocomplete,'list')])[5]    ${GroupName}
    # CommomFunction.Wait for page load
    
    ${ele}    Get WebElement   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'${GroupName}')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Wait Until Page Contains Element   //button[@type='button'][contains(.,'SAVE')]   30s
    #Select READ ONLY | FULL CONTROL
    Run Keyword If   '${selectType}' == 'READ_ONLY'      Click Element   //label[@class='my-auto'][contains(.,'READ_ONLY')]
    Run Keyword If   '${selectType}' == 'FULL_CONTROL'   Click Element   //label[@class='my-auto'][contains(.,'FULL_CONTROL')]
    #Add Group
    Click Element   //button[@type='button'][contains(.,'ADD GROUP')]

    # ${totalMember}   Get Text   (//div[contains(@class,'mt-4')])[1]
    # Should Be True   '${totalMember}' == 'TOTAL GROUP: 1' 
    #Click Save
    Click Button   //button[@type='button'][contains(.,'SAVE')]
    CommomFunction.Wait for page load

Add Column
    # ${no}    Set Variable   1
    # FOR   ${i}    IN RANGE    5
        Wait Until Page Contains Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[1]   30s
        Click Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[1]
    #     ${no}   Evaluate   ${no} + 1
    # END

Add Column Data Type Date
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[1]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[1]    Start Date
    #Data Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[1]   DATE
    ${ele}    Get WebElement   //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'DATE')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[2]   ALL
    Mouse over     (//input[contains(@aria-autocomplete,'list')])[2]
    Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    #Oeder
    Input Text   //input[contains(@formcontrolname,'order')]   1
    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Column Data Type Status
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@type,'text')])[5]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[2]    ผลการทดสอบครั้งที่ 1
    #Data Type
    Input Text     (//input[contains(@aria-autocomplete,'list')])[4]   STATUS
    ${ele}    Get WebElement   (//span[@class='ng-option-label ng-star-inserted'][contains(.,'STATUS')])[1]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[5]   ALL
    Mouse over     (//input[contains(@aria-autocomplete,'list')])[5]
    Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    #Oeder
    Input Text   (//input[contains(@formcontrolname,'order')])[2]   2
    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Column Data Type List Internal
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[3]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[3]    Select List INTERNAL
    #Data Type
    Input Text     (//input[contains(@aria-autocomplete,'list')])[7]   LIST
    ${ele}    Get WebElement   //span[@class='ng-option-label ng-star-inserted'][contains(.,'LIST')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #input value
    Wait Until Page Contains Element   //textarea[contains(@formcontrolname,'propertyPossibleValues')]   30s
    Input Text   //textarea[contains(@formcontrolname,'propertyPossibleValues')]   A|B|C
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[8]   ALL
    Mouse over     (//input[contains(@aria-autocomplete,'list')])[8]
    Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    #Oeder
    Input Text   (//input[contains(@formcontrolname,'order')])[3]   3
    #Group

    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Column Data Type List External
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[4]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[4]    Select List EXTERNAL
    #Data Type
    Input Text     (//input[contains(@aria-autocomplete,'list')])[10]   LIST
    ${ele}    Get WebElement   //span[@class='ng-option-label ng-star-inserted'][contains(.,'LIST')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #input value
    Wait Until Page Contains Element   //textarea[contains(@formcontrolname,'propertyPossibleValues')]   30s
    Input Text   (//textarea[contains(@formcontrolname,'propertyPossibleValues')])[2]   Aa|Bb|Cc
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[11]   ALL
    Mouse over     (//input[contains(@aria-autocomplete,'list')])[11]
    Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    #Oeder
    Input Text   (//input[contains(@formcontrolname,'order')])[4]   4
    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Column Data Type Customize
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[5]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[5]    SURVEY STATUS
    #Data Type
    Input Text     (//input[contains(@aria-autocomplete,'list')])[13]   CUSTOMIZE_STATUS
    ${ele}    Get WebElement   //span[@class='ng-option-label ng-star-inserted'][contains(.,'CUSTOMIZE_STATUS')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #input value
    Wait Until Page Contains Element   (//input[contains(@aria-autocomplete,'list')])[14]   30s
    Input Text   (//input[contains(@aria-autocomplete,'list')])[14]   SURVEY STATUS
    ${ele}    Get WebElement   //span[@class='ng-option-label ng-star-inserted'][contains(.,'SURVEY STATUS')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[15]   ALL
    Mouse over     (//input[contains(@aria-autocomplete,'list')])[15]
    Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    #Oeder
    Input Text   (//input[contains(@formcontrolname,'order')])[5]   5
    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Column Data Type Freetext
    #Add Column Data Type Date
    Wait Until Page Contains Element   (//input[contains(@formcontrolname,'name')])[6]   30s
    Input Text   (//input[contains(@formcontrolname,'name')])[6]    หมายเหตุ
    #Data Type
    Input Text     (//input[contains(@aria-autocomplete,'list')])[17]   FREETEXT
    ${ele}    Get WebElement   //span[@class='ng-option-label ng-star-inserted'][contains(.,'FREETEXT')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #Type
    Input Text   (//input[contains(@aria-autocomplete,'list')])[18]   ALL
    # Mouse over     (//input[contains(@aria-autocomplete,'list')])[18]
    # Mouse Down      //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    # Click Element   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    ${ele}    Get WebElement   //div[@class='ng-option ng-star-inserted ng-option-marked'][contains(.,'ALL')]
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    #Oeder
    Input Text   (//input[contains(@formcontrolname,'order')])[6]   6
    #Save
    Click Button   (//button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')])[1]
    CommomFunction.Wait for page load

Add Row And SubRow
    Element Should Be Visible   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Click Element    //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
    Wait for page load
    Search Event
    #Tasks 1
    Wait Until Page Contains Element   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   30s
    Input Text   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   Tasks 1
    Click Element   //button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')]
    Wait Until Page Contains Element   //button[contains(@class,'btn btn-outline-success btn-circle mx-2 ng-star-inserted')]   30s
    Click Element   //button[contains(@class,'btn btn-outline-success btn-circle mx-2 ng-star-inserted')]
    Wait Until Page Contains Element   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   30s
    Input Text   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   Tasks 1.1
    Click Element   //button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')]
    CommomFunction.Wait for page load
    #Tasks 2
    Click Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[2]
    Wait Until Page Contains Element   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   30s
    Input Text   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   Tasks 2
    #Select Group INTERNAL

    Click Element   //button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')]
    CommomFunction.Wait for page load

    #Tasks 3
    Click Element   (//button[contains(@class,'btn btn-outline-success btn-circle mx-2')])[2]
    Wait Until Page Contains Element   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   30s
    Input Text   //input[contains(@class,'form-control form-control-sm w-75 ng-untouched ng-pristine ng-invalid')]   Tasks 3
    #Select Group EXTERNAL

    Click Element   //button[contains(@class,'btn btn-outline-success btn-circle ng-star-inserted')]
    CommomFunction.Wait for page load




