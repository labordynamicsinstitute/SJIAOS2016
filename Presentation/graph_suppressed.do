clear
insheet using ../programs/bds_e_suppressions_multi.csv
global graph graphregion(color(white)) plotregion(lcolor(black) lwidth(medthin)) ylabel(, angle(0)) 
graph bar (asis) percentsup jcbirths jcconts, over(type, sort(cells) label(angle(forty_five))) ytitle(Percent suppressed cells) $graph legend(order(1 "Any suppression" 2 "JC by entrants" 3 "JC by continuers"))
graph export "suppressions_estabs.png", width(1600) replace
