*** Settings ***
Documentation     v.1.0.0
Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
Library            ${CURDIR}/sortcell.py

*** Keywords ***

Get all member
    [Arguments]    ${sheetExcel}   ${colStart}   ${rowStart}
    @{list_member}     Create List
    ${colStartMember}      Set Variable    ${colStart}    
    FOR    ${i}    IN RANGE    999999   
        ${valueMember}    Read Excel Cell     ${colStartMember}     ${rowStart}      ${sheetExcel}     
        ${isNone}   Check None Value     ${valueMember}     
        Exit For Loop If    ${isNone}  
        ${colStartMember}  Evaluate      ${colStartMember} + 1
        Append To List   ${list_member}    ${valueMember}
    END
    [Return]        ${list_member}
    log  ${list_member}

Get Data Excel
    [Arguments]    ${sheetExcel}   ${colStart}   ${rowStart}
    ${value}    Read Excel Cell     ${colStart}     ${rowStart}      ${sheetExcel}
    Set Test Variable    ${value}


Get all data excel
    [Arguments]    ${sheetExcel}   ${colStart}   ${rowStart}
    @{list}     Create List
    ${colStart}      Set Variable    ${colStart}    
    FOR    ${i}    IN RANGE    999999   
        ${value}    Read Excel Cell     ${colStart}     ${rowStart}      ${sheetExcel}    
        ${isNone}   Check None Value     ${value}    
        Exit For Loop If    ${isNone}  
        ${colStart}  Evaluate      ${colStart} + 1
        Append To List   ${list}    ${value}
    END
    [Return]        ${list}
    log  ${list}