


 clear all
 
 cd "/Users/dimabuhanevyc/Documents/University/Semester 4/thesis" 

 use "Panel_Data_2019.dta"
 
 
reg Turnout TB GDP Unemployment Corruption




 
eststo A

esttab A using 4.tex, label   replace                            ///
title(This is a regression table)       ///
nonumbers mtitles("Model A" "Model B")  ///
addnote("Source: auto.dta")



***
 
 drop if Year == 2011
 
 drop if Year == 2013

 
 reg Turnout TB GDP Unemployment Corruption


 
 
twoway lfitci Turnout TB || scatter Turnout TB, by(Year, cols(2))






 
***robust regression***

regress Turnout TB Unemployment GDP Corruption, vce(robust)


eststo B

esttab B using 5.tex, label                               ///
title(Regression Results)       ///
nonumbers mtitles("Turnout")  ///
addnote("Source: auto.dta")


***clustering all years***


regress Turnout TB Unemployment GDP Corruption, vce(cluster Region)

eststo C

esttab C using 6.tex, label                               ///
title(Clustering Results)       ///
nonumbers mtitles("Turnout")  



***without 2014***


drop if Year == 2014


regress Turnout TB Unemployment GDP Corruption, vce(cluster Region)

eststo D

esttab D using 7.tex, label                               ///
title(Clustering Results, excl "2014")       ///
nonumbers mtitles("Turnout")  


























***ANNEX***
***clustering***

loneway Turnout TB /// dinding interclass correlation

global rho = r(rho) 

 reg Turnout TB GDP Unemployment Corruption, cluster(TB)





***clustering***


cluster completelinkage Turnout TB GDP Unemployment Corruption, name(L2clnk)

cluster dendrogram L2clnk, xlabel(, angle(90) labsize(*.75))

cluster generate g2 = group(2), name(L2clnk)

codebook g2

by g2, sort: summarize Turnout TB GDP Unemployment Corruption






***SMD





regress Turnout TB GDP Unemployment Corruption

coefplot, drop(_cons) xline(0)



***

regress Turnout TB GDP Unemployment Corruption if Year==2019

estimates store D

eststo A


regress Turnout TB GDP Unemployment Corruption if Year==2010 | Year==2012 | Year==2014 

estimates store F

eststo B

esttab A B using 4.tex, label   replace                            ///
title(This is a regression table)       ///
nonumbers mtitles("Model A" "Model B")  ///
addnote("Source: auto.dta")


coefplot D F, drop(_cons) xline(0)



