* Created: 9/4/2020 3:30:48 PM                             
* Modify the path below to point to your data file.		
* The specified subdirectory was not created on			
* your computer. You will need to do this.				
*														
* This read program must be ran against the specified	
* data file. This file is specified in the program		
* and must be saved separately.							
*														
* This program does not provide tab or summaries for all	
* variables.                                             
*														
* There may be missing data for some institutions due    
* to the merge used to create this file.					
*														
* This program does not include reserved values in its   
* calculations for missing values.			            
*														
* You may need to adjust your memory settings depending  
* upon the number of variables and records.				
*														
* The save command may need to be modified per user		
* requirements.											
*														
* For long lists of value labels, the titles may be		
* shortened per program requirements.                    
*	
label drop _all
insheet using "STATA_RV_942020-614.csv", clear
label data STATA_RV_942020_614
label variable unitid "UNITID"
label variable instnm "Institution Name"
label variable year "Survey year 2018"
label variable enrtot "Total  enrollment"
label variable fte "Full-time equivalent fall enrollment"
label variable efug "Undergraduate enrollment"
label variable efgrad "Graduate enrollment"
label variable pctenran "Percent of total enrollment that are American Indian or Alaska Native"
label variable pctenras "Percent of total enrollment that are Asian"
label variable pctenrbk "Percent of total enrollment that are Black or African American"
label variable pctenrhs "Percent of total enrollment that are Hispanic/Latino"
label variable pctenrnh "Percent of total enrollment that are Native Hawaiian or Other Pacific Islander"
label variable pctenrwh "Percent of total enrollment that are White"
label variable pctenr2m "Percent of total enrollment that are two or more races"
label variable pctenrun "Percent of total enrollment that are Race/ethnicity unknown"
label variable pctenrnr "Percent of total enrollment that are Nonresident Alien"
label variable pctenrap "Percent of total enrollment that are Asian/Native Hawaiian/Pacific Islander"
label variable pctenrw "Percent of total enrollment that are women"
label variable dvef13 "Percent of undergraduate enrollment under 18"
label variable dvef14 "Percent of undergraduate enrollment 18-24"
label variable dvef15 "Percent of undergraduate enrollment, 25-64"
label variable dvef16 "Percent of undergraduate enrollment over 65"
label variable pctdeexc "Percent of students enrolled exclusively in distance education courses"
label variable pctdesom "Percent of students enrolled in some but not all distance education courses"
label variable pctdenon "Percent of students not enrolled in any distance education courses"
label variable rminsttp "Percent of first-time undergraduates - in-state"
label variable rmousttp "Percent of first-time undergraduates - out-of-state"
label variable rmfrgncp "Percent of first-time undergraduates - foreign countries"
label variable f1tufeft "Revenues from tuition and fees per FTE (GASB)"
label variable f1stapft "Revenues from state appropriations per FTE (GASB)"
label variable f1lcapft "Revenues from local appropriations per FTE (GASB)"
label variable f1gvgcft "Revenues from government grants and contracts per FTE (GASB)"
label variable f1pggcft "Revenues from private gifts, grants, and contracts per FTE (GASB)"
label variable f1invrft "Revenues from investment return per FTE (GASB)"
label variable f1otrvft "Other core revenues per FTE (GASB)"
label variable f1endmft "Endowment assets (year end) per FTE enrollment (GASB)"
label variable f2endmft "Endowment assets (year end) per FTE enrollment (FASB)"
label variable npist2 "Average net price-students awarded grant or scholarship aid, 2017-18"
label variable npgrn2 "Average net price-students awarded grant or scholarship aid, 2017-18"



summarize enrtot
summarize fte
summarize efug
summarize efgrad
summarize pctenran
summarize pctenras
summarize pctenrbk
summarize pctenrhs
summarize pctenrnh
summarize pctenrwh
summarize pctenr2m
summarize pctenrun
summarize pctenrnr
summarize pctenrap
summarize pctenrw
summarize dvef13
summarize dvef14
summarize dvef15
summarize dvef16
summarize pctdeexc
summarize pctdesom
summarize pctdenon
summarize rminsttp
summarize rmousttp
summarize rmfrgncp
summarize f1tufeft
summarize f1stapft
summarize f1lcapft
summarize f1gvgcft
summarize f1pggcft
summarize f1invrft
summarize f1otrvft
summarize f1endmft
summarize f2endmft
summarize npist2
summarize npgrn2


save cdsfile_all_STATA_RV_942020-614.dta