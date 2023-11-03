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
binvar namelist [, options]

Options           | Description
----------------- | -------------
saving(filename)  | Path/filename of the generated docx file.
inline            | Add table to a docx in memory rather than saving to standalone file.
title(string)     | Optional title for table.
colabels(string)  | Optional labels for columns. Supply list of column number # "label"... Default is to label models/columns using the names of the stored estimates used to form the table.
bfmt(%fmt)        | Stata format used for coefficients. Default is %9.2f
star(numlist)     | Numlist of significance levels. If option is omitted significance is reported numerically.
nopval            | Do not report significance levels.
ci(%fmt)          | Stata format used for 95% confidence intervals. If option is omitted no CIs are not reported.
stats(scalarlist) | Report scalarlist in table. Allowed is N aic bic
baselevels        | Include all baselevels.
keep(coflist)     | List of coefficient to include in table.
pagesize(psize)   | Set pagesize of Word document.
landscape         | Use landscape layout for word document.
eform             | Report parameters as exp(B).



Description
------------


Examples
--------

Setup
```stata
sysuse nlsw88, clear



Author
-------

Dr Glenn Sandström, Umeå Univerity, Sweden.
Email: glenn.sandstrom@umu.se
Web:http://www.umu.se/en/staff/glenn-sandstrom/

