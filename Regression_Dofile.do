
use Final_Data.dta 

keep male Country year mpower afford  maleedu female femaleedu 

* Preparing data for fixed-term effect regression analysis* 

xtset Country  year 

xtreg male mpower, fe  

xtreg male afford, fe 

xtreg male maleedu, fe 


xtreg male mpower afford  maleedu, fe 


xtreg male c.maleedu##c.mpower afford, fe




* Calculating Policy gap for men* 
gen mpowergap= 34-mpower
 
gen educationgap= 100-  maleedu 

gen interactiongap= 3400-(mpower*maleedu)

* Calculating the percentage of reduction in prevalence of tobacco smoking in each scenario for men* 
 
gen MpoweReduction= (mpowergap*-0.26)

gen AfoordReduction= (10*-0.1227)

gen EducationReduction= ( educationgap *-0.268)

gen overallreduction= (educationgap*-0.216)+(10*-0.0798)+(mpowergap*-0.155)

gen intreduction = -0.533*(educationgap)-0.066*(10)-1.255*(mpowergap)+0.013*(interactiongap) 

gen reduction= -0.533*(maleedu)-1.255*(mpower)+0.013*(maleedu*mpower)-.066*(afford) 

gen reduction1= -0.533*(100)-1.255*(34)+0.013*(100*34)-.066*(afford+10) 

* Fixed term regression in women* 

xtreg female mpower, fe

xtreg female afford, fe  

xtreg female femaleedu, fe

xtreg female mpower afford, fe 

xtreg female c.femaleedu##c.mpower afford, fe 


* Calculating the percentage of reduction in prevalence of tobacco smoking in each scenario for women* 

gen MpoweReductionF=(mpowergap*-0.12)

gen AfoordReductionF=(10*-0.06) 

gen overallreductionF=(mpowergap*-0.110)+(10*-0.0467)  

gen intreductionF = -0.08*(educationgap) ///
-0.040*10 ///
-0.33*(mpowergap) ///
+0.003*((100*34) - (femaleedu*mpower))









