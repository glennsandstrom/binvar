*! 1.0.0 G. Sandström 2023-10-22
capture program drop binvar
program define binvar
	version 18

	// varlist                       # name of variable to be recoded into a binned version)
    // generate                      # name of the gererated variable)
    // interval                      # length of interval)
    // lastinterval(missing, expand) # how to hadle the last interval if it is not evenly divisible by interval
	// replace                       # replace newvar if it exists)

	// varlist     (name of variable to be recoded into a binned version)
    // interval    (length of interval)
	// start       (lowest value starting first interval default is var minimum)
	// generate    (name of the gererated variable)
	// greedy      (include values higher than end in last bin)
	// replace     (replace newvar if it exists)
    // gapignore
	
	syntax varlist(min=1 max=1), ///
    GENerate(name) ///
	Interval(numlist) ///
    [, lastbin(string)] ///
    [Start(numlist)] ///
    [gapignore] ///
    [replace] ///
    [debug]
    
    /***************************************************************************/
	// Set internal names
    /***************************************************************************/
	local vartobin "`varlist'"
    /***************************************************************************/
	// Check that variable generate does not exist
    /***************************************************************************/

    capture confirm new variable `generate'
	if _rc!=0 {
	
		if "`replace'"!="" { //drop generate if it already exists (replace)
			capture label drop `generate'
			drop `generate'
			di as result "The variable `generate' is already defined. Option replace specified. Dropping and replacing variable"
		}
		else {
			di as error "The variable `generate' is already defined. Specify option replace or choose a new variable name"
			exit _rc
		}
		
	}

	/***************************************************************************/
	// Check that there are no gaps... variable is consequtive increments, issue varning if it is not
    /***************************************************************************/
	qui sum `vartobin'
	local max= r(max)
	local min= r(min)
	local range= r(max)-r(min) + 1 // add one to range to incude also first value in range
	local mod= mod(`range',`interval')
	
	qui levelsof `vartobin', local(vals)
	local missvals ""
	forvalues val= `min'(1)`max' {
		local found: list posof "`val'" in vals
		if (`found'==0) local missvals= "`missvals'" + " `val'"
	}
	
	if ("`missvals'"!="") di as error "Varning," as text " `vartobin' has gaps and no observations for: " as result "`missvals'"
	
	if (`mod'!=0) {
		di as error "Varning," ///
		as text " the range of `vartobin'" ///
		as result " `min'-`max'" ///
		as text " contains" ///
		as result " `range'" ///
		as text " distinct values (including gaps) which is not equaly divisible by" ///
		as result " `interval'"
        di as text "Decide how to handle the last interval which will not be equal to `interval'." 
        di as text "Default behaviour is to incude the values up to max in dataset in the last binn even if this is less than intervall."
        di as text "Different approches can be requested by specifying option lastbin(missing, expand ) "
	}
    
    /***************************************************************************/
	// Check that last lastbin option contains only allowed values if it is set
    /***************************************************************************/
      if ("`lastbin'"!="") {
          if(!strpos("`lastbin'", "missing") & !strpos("`lastbin'", "expand") ) {
              di as error "Invalid syntax for option lastbin; valid missing and expand with no abbreviations"
              error 197
          }
      }
    
    /***************************************************************************/
	// default values for options if none are provided
    /***************************************************************************/
    
    // no value for start of first binn is provided => set to minimum of vartobin
	if ("`start'"=="") {
		local start "`min'"
	} 
	
    /***************************************************************************/
	// loop over the binns and create variable
    /***************************************************************************/
		// span is one less than intervall to incude first value e.g. 5-year intervall 1900-1904
		local span= `interval'-1
		
        // create the first bin
		// create tovar and set it to 0 for all cases where fromvar is in the first intervall
		qui gen `generate' = . 
		
		
        // create indexvalue for assigning incremented levels of binvar in the loop
		local index=0
     
		// start loop to create the binns
		forvalues binstart=`start'(`interval')`max' {
			
			
			local binend= `binstart' + `span'
			
            /***************************************************************************/
            // Check if we are in last bin => if binend is more or equal to max we are in the last bin
            /***************************************************************************/
			if (`binend' >= `max') local inlbin = 1 
			else local inlbin = 0
            /***************************************************************************/
            //Handle the last bin based on options provided in lastbin
			/***************************************************************************/
			if (`inlbin') {
                /***************************************************************************/
                // if option lastbin is not set => make a lastbin with avaliable values up to max
                /***************************************************************************/
                if ("`lastbin'"=="") {
                    local binend= `max'
                    qui replace `generate' = `index' if inrange(`vartobin', `binstart', `binend')
                    
                    qui sum `vartobin' if `generate'==`index' // get the range of values in the last bin
                    if(`r(min)'==`r(max)') label define `generate' `index' "`r(max)'", add // check if last bin only contains one value
                    else label define `generate' `index' "`r(min)'-`r(max)'", add
                }
                /***************************************************************************/
                // if option lastbin is set to missing
                /***************************************************************************/
				else if ("`lastbin'"=="missing") { //set all values in last bin to missing
                    // do nothing and values in last incomplete bin will be left missing
                    
                }
                /***************************************************************************/
                // if option lastbin is set to missing
                /***************************************************************************/
                else if ("`lastbin'"=="expand") { // include the values from the last non complete bin in second to last bin
                    local binend= `max'
                    local binstart= `binstart'-`interval' // set binstart to startvalue of the bin that is second to last
                    local index= `index'-1      // decrement index to level of the bin that is second to last
                    qui replace `generate' = `index' if inrange(`vartobin', `binstart', `binend')
                    //change vlauelabel of the bin that is second to last which is now the last binend
                    di "`index'==`binstart'-`binend'"
                    label define `generate' `index' "`binstart'-`binend'", modify
                    
                }
			}
            /***************************************************************************/
            // for all bins that are not the last bin
            // for all bins where endvalue is less than max
			else { 
				qui replace `generate' = `index' if inrange(`vartobin', `binstart', `binend')
				label define `generate' `index' "`binstart'-`binend'", add
			}
			
			
		local ++index
		}
        
		label values `generate' `generate'

   // no alue for start of first binn is provided => set to minimum of vartobin
	if ("`debug'"!="") {
        numlabel `generate', add
		di "{input}--- DEBUG: --------------------------------------"
		di as text "start:"    as result " `start'"
		di as text "interval:" as result " `interval'"
        di as text "lastbin:" as result " `lastbin'"
		di as text "generate:" as result " `generate'"
		di as text "max:"      as result " `max'"
		di as text "min:"      as result " `min'"
		di as text "range:"    as result " `range'"
		di as text "mod:"      as result " `mod'"
		di as text "generate:" as result " `generate'"
		di as text "replace:"  as result " `replace'"
		di "{input}--- DEBUG: --------------------------------------"
	} 
		
	
end
/*#####################################################################################*/
