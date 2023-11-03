/******************************************************************************/
/** Script start                                                             **/
/******************************************************************************/
/* Clear datasets from memory if any are loaded */
	clear all
	set more off, permanently
    set varabbrev off, permanently
	discard
	/**************************************************************************/
	/*** Change working directory depending on OS so that all automatic   *****/
	/*** saves are located in this path                                   *****/
	/**************************************************************************/
	if c(hostname) == "1630-sandstrom" {
		cd "C:\Users\glsa0001\OneDrive - Umeå universitet\Stata programs\binvar"
		sysdir set PERSONAL  "C:\Users\glsa0001\OneDrive - Umeå universitet\Stata programs\ado\personal"
		global  wordpath "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"
		global  excelpath "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
	
	}
	else if c(hostname) == "Kontoret-i5" {
		cd "C:\Users\glenn\OneDrive - Umeå universitet\Stata programs\binvar"
		sysdir set PERSONAL  "C:\Users\glenn\OneDrive - Umeå universitet\Stata programs\ado\personal"
		global  wordpath "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"
		sysdir set PERSONAL  "F:\OneDrive - Umeå universitet\Stata programs\ado\personal"
	}
    
    /*** LOAD ADO PROGRAM **********************/
do binvar.ado

	sysuse bplong,clear
    /**************************************************************************/

    /**************************************************************************/

	// check that bpgrp have corect values
	binvar bp, interval(5) lastbin(missing) gen(bpgrp) debug replace
	assert inrange(bp, 125, 129) if bpgrp==0
	assert inrange(bp, 180, 184) if bpgrp==11
    assert mi(bpgrp) if inrange(bp, 185, 185)
	tab bpgrp, mi
	
	
	binvar bp, interval(5) gen(bpgrp) debug replace
	assert inrange(bp, 125, 129) if bpgrp==0
	assert inrange(bp, 180, 185) if bpgrp==11
    assert !mi(bpgrp)
	tab bpgrp, mi
    
    exit

	sysuse  nlsw88, clear
    binvar age, interval(5) gen(agegrp) debug replace
    tab agegrp, mi
    
    sysuse uslifeexp.dta, clear
    
    binvar year, interval(3) lastbin(expand) gen(ygrp) replace
    tab ygrp, missing
    
	assert inrange(year, 1900, 1904) if ygrp==0
	//assert inrange(bp, 125, 129) if bpgrp==0
	//assert inrange(bp, 185, 189) if bpgrp==12
	tab bpgrp, mi
	
	
	
    exit
	tab bpgrp
	
	assert inrange(year, 1900, 1904) if ygrp==1
	assert inrange(year, 1980, 1984) if ygrp== 17
	
	binvar year, start(1900) end(1980) interval(5) gen(ygrp) replace
	
	assert inrange(year, 1900, 1904) if ygrp==1
	assert inrange(year, 1980, 1984) if ygrp== 17
	
	drop if year== 1999
	
	binvar year, start(1900) end(2000) interval(5) gen(ygrp) replace
	
	assert inrange(year, 1900, 1904) if ygrp==1
	assert inrange(year, 1980, 1999) if ygrp== 17
	
	assert inrange(year, 1995, 1998) if ygrp== 20
