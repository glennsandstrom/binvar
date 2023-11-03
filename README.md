# binvar v. 0.9
'binvar': Lightwight program to automate recoding of a continious variable to binned ordinal version 

Installation
============
Either use net command in Stata:
```stata
net install binvar , from(https://github.com/glennsandstrom/binvar/raw/master/)
```
Usage
=====


Title
-----

binvar 

Lightwight program to automate recoding of a continious variable to binned ordinal version 

Syntax
------
binvar varname [, options]

Options           | Description
----------------- | -------------
generate(newname) | Name of the gererated grouped/binned variable.
interval(integer) | Length of interval that makes up the groups/binns.
lastbin(string)   | Optional, allowed is *missing* or *expand*. If this option is not provided and the range of the variable to be grouped/binned is not equally divisble by intervall
replace           | Replace newname if it already exists.
interval(integer) | Length of interval.
start(integer)    | Start of first intervall.
generate(newname) | Name of the gererated variable.
replace           | Replace newname if it exists.




Description
------------

    binvar Command for creating a grouped/binned indicator variable from a continious numerical variable. Command takes the numerical varaible and partitions it into binns/groups of the
    lenght specified in intervall.  


Examples
--------

Setup
```stata
sysuse bplong, clear
```

Run command on the varible bp to binn bloodpressure values into intervals of five.
```stata
binvar bp, interval(5) lastbin(missing) gen(bpgrp) replace
```

Tabulate the generated binned variable.
```stata
tab bpgrp
```

Author
-------

Dr Glenn Sandström, Umeå Univerity, Sweden.
Email: glenn.sandstrom@umu.se
Web:http://www.umu.se/en/staff/glenn-sandstrom/

