*** Variables ***
#==================================== Config ===================================#

${url}       Uat            ### Dev | Uat
${urlDev}    #
${urlUat}    #

${user}          #
${password}      #

${pathCapture}    ${OUTPUTDIR}/Result052021
${lastVersion}   Last update date : 16 May 2021
${excelPath}    ${CURDIR}\\TestCaseAutomate.xlsx
${ExcelName}    TestCaseAutomate.xlsx
${MenuGroup}   //div[@class='mat-list-item-content'][contains(.,'GROUP')]
${MenuEventlist}   //div[@class='mat-list-item-content'][contains(.,'EVENT LIST')]
${MenuReportSummary}   //div[@class='mat-list-item-content'][contains(.,'SUMMARY STATUS')]
${MenuReportCustomize}   (//div[@class='mat-list-item-content'][contains(.,'CUSTOMIZE')])[1]


