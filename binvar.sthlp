{smcl}
{* *! version 0.9 20231027 }{...}
{right:version 0.9}
{title:Title}
{phang}
{bf:binvar} {hline 2} Command for creating a grouped/binned indicator variable from a continious numerical variable. 

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:binvar}
varname
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt generate(newname)}}Name of the gererated grouped/binned variable.{p_end}
{synopt:{opt interval(integer)}}Length of interval that makes up the groups/binns.{p_end}
{synopt:{opt lastbin(string)}}Optional methods to handle the last binn.{p_end}
{synopt:{opt replace}}Replace newname if it already exists.{p_end}
{synopt:{opt interval(integer)}}Length of interval.{p_end}
{synopt:{opt start(integer)}}Start of first intervall.{p_end}
{synopt:{opt generate(newname)}}Name of the gererated variable.{p_end}
{synopt:{opt replace}}Replace newname if it exists.{p_end}
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
{opt lastbin(missing, expand)} Optional, allowed is missing or expand. If this option is not provided and the range of the variable to be grouped/binned is not equally divisble by intervall the last group includes the values that are larger than the endvalue of the group prior to the last up to the maximum value.

{phang}
{opt gapignore} Ignore potential gaps/missing values in the continious varaible being binned.

{phang}
{opt replace} Replace newname if it exists.

{marker examples}{...}
{title:Examples}

{hline}
{pstd}Setup{p_end}

{phang2}{cmd:. sysuse bplong, clear}{p_end}

{pstd}Run command on the varible bp to binn bloodpressure values into intervals of five.{p_end}
{phang2}{cmd:. binvar bp, interval(5) lastbin(missing) gen(bpgrp) replace}

{pstd}Tabulate the generated binned variable.{p_end}
{phang2}{cmd:. tab bpgrp}


{hline}


{title:Author}
{p}

Dr Glenn Sandström, Umeå Univerity, Sweden.
Email: {browse "mailto:glenn.sandstrom@umu.se":glenn.sandstrom@umu.se}
Web:{browse "http://www.idesam.umu.se/english/about/staff/?uid=glsa0001"}


{title:See Also}

Related commands: egen cut(), recode

