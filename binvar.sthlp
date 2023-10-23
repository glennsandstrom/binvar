{smcl}
{* *! version 1.0 201902 }{...}
{right:version 1.0}
{title:Title}
{phang}
{bf:estimates_table_docx} {hline 2} Command for creating a binned indicator variable from a continious numerical variable. 

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:cut2}
varlist
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
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
{cmd:cut2} 
Command for creating a binned indicator variable from a continious numerical variable.
{marker options}{...}
{title:Options}
{dlgtab:Main}

{phang}
{opt start(integer)}Start of first intervall.

{phang}
{opt end(integer)} Start of last intervall.

{phang}
{opt interval(integer)} Length of interval.

{phang}
{opt generate(newvarname)} Name of the gererated variable.

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


