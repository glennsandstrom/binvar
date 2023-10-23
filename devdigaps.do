	qui sum bp
	local max= r(max)
	local min= r(min)
	levelsof bp, local(vals)
	
	
	forvalues val= `min'(1)`max' {
		local found: list posof "`val'" in vals
		if (`found'==0) di "`val' has no observations"
	}


