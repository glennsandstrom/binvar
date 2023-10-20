*! 1.0.0 G. Sandström 2018-06-08

program define binvar
	version 15.1
	// varlist     (name of variable to be recoded into a binned version)
	// start       (lowest value starting first interval default is var minimum)
	// interval    (length of interval)
	// generate    (name of the gererated variable)
	// greedy      (include values higher than end in last bin)
	// replace     (replace newvar if it exists)
	
	syntax varlist(min=1 max=1), ///
	Interval(numlist) ///
	Start(numlist) ///
	GENerate(name) ///
	[replace]
	
	// Check if start and end values evenly covers the entire range of the variable to be binned
	qui sum `varlist'
	local max= r(max)
	local min= r(min)
	
	// test that there are no gaps... variable is consequtive increments, issue varning if it is not
	
		// default values for options if none are provided
	if ("`start'"=="") {
		local start "`min'"
	} 
	
	capture confirm new variable `generate'
	if _rc!=0 {
	
		if "`replace'"!="" { //drop generate if it already exists (replace)
			capture label drop `generate'
			drop `generate'
			di as result "The variable `generate' is already defined. Option replace specified. Dropping and replacing variable"
		}
		else {
			di as error "The variable `generate' is already defined. Specifie option replace or choose a new variable name"
			exit _rc
		}
		
	}
		//set span = interval-1
		local span= `interval'-1
	
		local reflabel "`start'-`span'"
		label define `generate' 0 "`reflabel'"
		
		// create tovar and set it to 0 for all cases where fromvar is in the 
		// first interval
		gen `generate' = 0 if inrange(`varlist', `start', `start' + `span')
		
		// create indexvalue for assigning values to generate in loop
		local index=1
		
		// start loop to create the binns
		forvalues age=`start'(`interval')`end' {
			
			local endage= `age' + `span'
			local yearsleft= `max'-`endage'
					
			if `yearsleft'< `span' { //if next intervall i
				local endage= `max'
				replace `generate' = `index' if inrange(`varlist', `age', `endage')
				label define `generate' `index' "`age'-`endage'", add
			}
			else {
				replace `generate' = `index' if inrange(`varlist', `age', `endage')
				label define `generate' `index' "`age'-`endage'", add
			}
				
			local ++index
		}
		
		label values `generate' `generate'
		
	
end
/*#####################################################################################*/
