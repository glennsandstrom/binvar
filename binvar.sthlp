{smcl}
{* *! version 1.0 20231023 }{...}
{right:version 1.0}
{title:Title}
{phang}
{bf:binvar} {hline 2} Command for creating a grouped/binned indicator variable from a continious numerical variable. 

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:binvar}
varlist
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}

{synopt:{opt generate(newname)}}Name of the gererated grouped/binned variable.{p_end}
{synopt:{opt interval(integer)}}Length of interval that makes up the groups/binns.{p_end}
{synopt:{opt lastbin(missing, expand)}}Optional methods to handle the last group if it is not possible to make the last binn equal to the specifyed interval.{p_end}
{synopt:{opt replace}}Replace newname if it already exists.{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

	
{marker description}{...}
{title:Description}
{pstd}

{pstd}
{cmd:binvar} 
Command for creating a grouped/binned indicator variable from a continious numerical variable. Command takes the numerical varaible and partitions it into binns/groups of the lenght specified in intervall.
{marker options}{...}
{title:Options}
{dlgtab:Main}

{phang}
{opt generate(newname)}Name of the gererated grouped/binned variable.

{phang}
{opt interval(integer)}Length of the groups/binns.

{phang}
{opt interval(integer)} Length of interval.

{phang}
{opt lastbin(missing, expand)} Optional, allowed is missing or expand. If this option is not provided and the range of the variable to be grouped/binned is not equally divisble by intervall the last group includes the values that are larger than the endvalue of the group prior to the last up to the maximum value.

{phang}
{opt replace} Replace newname if it exists.

{marker examples}{...}
{title:Examples}

{hline}
{pstd}Setup{p_end}

{phang2}{cmd:. sysuse uslifeexp.dta, clear}{p_end}

{pstd}Run command on the varible year in 5 year binns for the interval 1900-1980.{p_end}
{phang2}{cmd:. cut2 year, start(1900) end(1980) interval(5) gen(ygrp)}

{pstd}Tabulate the generated binned variable.{p_end}
{phang2}{cmd:. tab ygrp}


{hline}


{title:Author}
{p}

Dr Glenn Sandström, Umeå Univerity, Sweden.
Email: {browse "mailto:glenn.sandstrom@umu.se":glenn.sandstrom@umu.se}
Web:{browse "http://www.idesam.umu.se/english/about/staff/?uid=glsa0001"}


{title:See Also}
Related commands: egen cut()


