
use Final_Datasets.dta 

* Labeling Cancer sites* 

label define cance 2 "Larynx" 3 "Eso" 4 "Oral" 5 "Stomach" 6 "CRC" 7 "Liver" /// 
 8 "Pancreas" 9 "Leukemia" 10 "Bladder" 11 "Kidney" 12 "Cervix" 13 "Pharynx" 1 "Lung", replace 
 
* Generating Relative Risk minus 1*  
 

gen RR1men= MenRR-1

gen RR1women=WomenRR-1

* Generating Polciy gap for men* 
 
gen mpowergap= 34-mpower

gen educationgap= 100-menliteracy   

gen educationgapF= 100-womenliteracy 



* Potentian reduction in prevalence of tobacco smoknig under each scenario for men* 

gen MpoweReduction= (mpowergap*-0.26)

gen AfoordReduction= (10*-0.1227)


gen EducationReduction= ( educationgap *-0.27) 


gen overallreduction= (educationgap*-0.216)+(10*-0.0798)+(mpowergap*-0.16)  

gen intreduction1 = (menliteracy *-0.533)+(-0.066*afford)+(-1.255*mpower)+(0.013*(menliteracy*mpower))

gen intreduction2 = (100*-0.533)+(-0.066*(afford+10))+(-1.255*34)+(0.013*(100*34)) 

gen intreduction= intreduction2-intreduction1 


* Potentian reduction in prevalence of tobacco smoknig under each scenario for Women* 

gen MpoweReductionF=(mpowergap*-0.125)

gen AfoordReductionF=(10*-0.06) 

gen overallreductionF=(mpowergap*-0.110)+(10*-0.0467)  
 
gen intreduction1F = (womenliteracy *-0.08)+(-0.038*afford)+(-0.33*mpower)+(0.003*(menliteracy*mpower))

gen intreduction2F = (100 *-0.08)+(-0.038*(afford+10))+(-0.33*34)+(0.003*(100*34))

gen intreductionF= intreduction2F-intreduction1F 


* Estimating new prevalence of tobacco smokwomenliteracying for men under each scenario* 

gen CurrentPrevM=male 

gen prev1M= male+MpoweReduction 

gen prev2M= male+AfoordReduction 

gen prev3M= male+EducationReduction  

gen prev4M=male+overallreduction 

gen prev5M= male+intreduction

* Estimating new prevalence of tobacco smoking for women under each scenario* 

gen CurrentPrevF=female 

gen prev1F= female+MpoweReductionF 

gen prev2F= female+AfoordReductionF 
 
gen prev4F=female+overallreductionF 

gen prev5F=  female+intreductionF

replace prev2F=0 if prev2F<0

replace prev4F=0 if prev4F<0

replace prev1F=0 if prev1F<0  

replace prev5F=0 if prev5F<0  


* Converting the prevalence of tobacco smoknig in men to a percent* 

gen curentM100=CurrentPrevM/100 

gen prev1M100=prev1M/100 

gen prev2M100=prev2M/100 

gen prev3M100=prev3M/100 

gen prev4M100=prev4M/100  

gen prev5M100= prev5M/100

*Calculation of Population attributable fraction for men under each scnario inclduing current prevalence and all of alternatives* 

gen currentPAFM=((curentM100* RR1men )/(1+( curentM100*RR1men)))*100 

gen PAFM1= ((prev1M100* RR1men )/(1+(prev1M100*RR1men)))*100 

gen PAFM2= ((prev2M100* RR1men )/(1+(prev2M100*RR1men)))*100  

gen PAFM3= ((prev3M100* RR1men )/(1+(prev3M100*RR1men)))*100  

gen PAFM4= ((prev4M100* RR1men )/(1+(prev4M100*RR1men)))*100  

gen PAFM5= ((prev5M100* RR1men )/(1+(prev5M100*RR1men)))*100  


* Calculation of reduction in attributable fraction of tobacco smoking due to each policy in men* 

gen scenario1M= currentPAFM- PAFM1

gen scenario2M= currentPAFM- PAFM2

gen scenario3M= currentPAFM- PAFM3

gen scenario4M= currentPAFM- PAFM4 

gen scenario5M= currentPAFM-PAFM5 


* Converting the prevalence of tobacco smoknig in Women to a percent* 

gen curentF100=CurrentPrevF/100 

gen prev1F100=prev1F/100 

gen prev2F100=prev2F/100 

gen prev4F100=prev4F/100  

gen prev5F100= prev5F/100

*Calculation of Population attributable fraction for women under each scnario inclduing current prevalence and all of alternatives* 

gen currentPAFF=((curentF100* RR1women )/(1+( curentF100*RR1women)))*100 

gen PAFF1= ((prev1F100* RR1women )/(1+(prev1F100*RR1women)))*100 

gen PAFF2= ((prev2F100* RR1women )/(1+(prev2F100*RR1women)))*100  

gen PAFF4= ((prev4F100* RR1women )/(1+(prev4F100*RR1women)))*100  

gen PAFF5= ((prev5F100* RR1women )/(1+(prev5F100*RR1women)))*100 

* Calculation of reduction in attributable fraction of tobacco smoking due to each policy in women* 

gen scenario1F= currentPAFF- PAFF1

gen scenario2F= currentPAFF- PAFF2

gen scenario4F= currentPAFF- PAFF4 

gen scenario5F= currentPAFF- PAFF5 

*Estimation of PAF with Current prevalence for men and women by country and cancer site* 

mean currentPAFM if cancer==1, over(Country) 

mean currentPAFF if cancer==1, over(Country) 



mean currentPAFM if cancer==2, over(Country) 

mean currentPAFF if cancer==2, over(Country)


mean currentPAFM if cancer==3, over(Country) 

mean currentPAFF if cancer==3, over(Country)


mean currentPAFM if cancer==4, over(Country) 

mean currentPAFF if cancer==4, over(Country)


mean currentPAFM if cancer==5, over(Country) 

mean currentPAFF if cancer==5, over(Country)


mean currentPAFM if cancer==6, over(Country) 

mean currentPAFF if cancer==6, over(Country)


mean currentPAFM if cancer==7, over(Country) 

mean currentPAFF if cancer==7, over(Country)


mean currentPAFM if cancer==8, over(Country) 

mean currentPAFF if cancer==8, over(Country)


mean currentPAFM if cancer==9, over(Country) 

mean currentPAFF if cancer==9, over(Country)


mean currentPAFM if cancer==10, over(Country) 

mean currentPAFF if cancer==10, over(Country)


mean currentPAFM if cancer==11, over(Country) 

mean currentPAFF if cancer==11, over(Country)
 

mean currentPAFF if cancer==12, over(Country)


mean currentPAFM if cancer==13, over(Country) 

mean currentPAFF if cancer==13, over(Country)




*Estimation of CI* 

mean currentPAFM, over(cancer) vce(bootstrap, reps(1000) dots(1))

mean currentPAFF, over(cancer) vce(bootstrap, reps(1000) dots(1))



*Estimation of preventable PAF with highest MPOWER for men and women by cancer site and Country* 

mean scenario1M if cancer==1, over(Country) 

mean scenario1F if cancer==1, over(Country) 



mean scenario1M if cancer==2, over(Country) 

mean scenario1F if cancer==2, over(Country)


mean scenario1M if cancer==3, over(Country) 

mean scenario1F if cancer==3, over(Country)


mean scenario1M if cancer==4, over(Country) 

mean scenario1F if cancer==4, over(Country)


mean scenario1M if cancer==5, over(Country) 

mean scenario1F if cancer==5, over(Country)


mean scenario1M if cancer==6, over(Country) 

mean scenario1F if cancer==6, over(Country)


mean scenario1M if cancer==7, over(Country) 

mean scenario1F if cancer==7, over(Country)


mean scenario1M if cancer==8, over(Country) 

mean scenario1F if cancer==8, over(Country)


mean scenario1M if cancer==9, over(Country) 

mean scenario1F if cancer==9, over(Country)


mean scenario1M if cancer==10, over(Country) 

mean scenario1F if cancer==10, over(Country)


mean scenario1M if cancer==11, over(Country) 

mean scenario1F if cancer==11, over(Country)


mean scenario1F if cancer==12, over(Country)


mean scenario1M if cancer==13, over(Country) 

mean scenario1F if cancer==13, over(Country)

*Estimation of CI* 

mean scenario1M, over(cancer) vce(bootstrap, reps(1000) dots(1))

mean scenario1F, over(cancer) vce(bootstrap, reps(1000) dots(1))


*Estimation of preventable PAF with a 10% increase in Afoordability index for men and women by cancer site* 

mean scenario2M if cancer==1, over(Country) 

mean scenario2F if cancer==1, over(Country) 



mean scenario2M if cancer==2, over(Country) 

mean scenario2F if cancer==2, over(Country)


mean scenario2M if cancer==3, over(Country) 

mean scenario2F if cancer==3, over(Country)


mean scenario2M if cancer==4, over(Country) 

mean scenario2F if cancer==4, over(Country)


mean scenario2M if cancer==5, over(Country) 

mean scenario2F if cancer==5, over(Country)


mean scenario2M if cancer==6, over(Country) 

mean scenario2F if cancer==6, over(Country)


mean scenario2M if cancer==7, over(Country) 

mean scenario2F if cancer==7, over(Country)


mean scenario2M if cancer==8, over(Country) 

mean scenario2F if cancer==8, over(Country)


mean scenario2M if cancer==9, over(Country) 

mean scenario2F if cancer==9, over(Country)


mean scenario2M if cancer==10, over(Country) 

mean scenario2F if cancer==10, over(Country)


mean scenario2M if cancer==11, over(Country) 

mean scenario2F if cancer==11, over(Country)


mean scenario2F if cancer==12, over(Country)


mean scenario2M if cancer==13, over(Country) 

mean scenario2F if cancer==13, over(Country)

*Estimation of CI* 

mean scenario2M, over(cancer) vce(bootstrap, reps(1000) dots(1))

mean scenario2F, over(cancer) vce(bootstrap, reps(1000) dots(1))


*Estimation of preventable PAF with maximizing literacy rate for men and women by cancer site* 

mean scenario3M if cancer==1, over(Country) 

mean scenario3M if cancer==2, over(Country) 

mean scenario3M if cancer==3, over(Country) 

mean scenario3M if cancer==4, over(Country) 

mean scenario3M if cancer==5, over(Country) 

mean scenario3M if cancer==6, over(Country) 

mean scenario3M if cancer==7, over(Country) 

mean scenario3M if cancer==8, over(Country) 

mean scenario3M if cancer==9, over(Country) 

mean scenario3M if cancer==10, over(Country) 

mean scenario3M if cancer==11, over(Country) 


mean scenario3M if cancer==13, over(Country) 


*Estimation of CI* 

mean scenario3M, over(cancer) vce(bootstrap, reps(1000) dots(1))



*Estimation of preventable PAF with all policies for men and women by cancer site* 

mean scenario4M if cancer==1, over(Country) 
mean scenario4F if cancer==1, over(Country) 



mean scenario4M if cancer==2, over(Country) 

mean scenario4F if cancer==2, over(Country)


mean scenario4M if cancer==3, over(Country) 

mean scenario4F if cancer==3, over(Country)


mean scenario4M if cancer==4, over(Country) 

mean scenario4F if cancer==4, over(Country)


mean scenario4M if cancer==5, over(Country) 

mean scenario4F if cancer==5, over(Country)


mean scenario4M if cancer==6, over(Country) 

mean scenario4F if cancer==6, over(Country)


mean scenario4M if cancer==7, over(Country) 

mean scenario4F if cancer==7, over(Country)


mean scenario4M if cancer==8, over(Country) 

mean scenario4F if cancer==8, over(Country)


mean scenario4M if cancer==9, over(Country) 

mean scenario4F if cancer==9, over(Country)


mean scenario4M if cancer==10, over(Country) 

mean scenario4F if cancer==10, over(Country)


mean scenario4M if cancer==11, over(Country) 

mean scenario4F if cancer==11, over(Country)


mean scenario4F if cancer==12, over(Country)


mean scenario4M if cancer==13, over(Country) 

mean scenario4F if cancer==13, over(Country)


*Estimation of CI* 

mean scenario4M, over(cancer) vce(bootstrap, reps(1000) dots(1))


mean scenario4F, over(cancer) vce(bootstrap, reps(1000) dots(1)) 



*Estimation of preventable PAF with all policies for men and women by cancer site* 

mean scenario5M if cancer==1, over(Country) 
mean scenario5F if cancer==1, over(Country) 



mean scenario5M if cancer==2, over(Country) 

mean scenario5F if cancer==2, over(Country)


mean scenario5M if cancer==3, over(Country) 

mean scenario5F if cancer==3, over(Country)


mean scenario5M if cancer==4, over(Country) 

mean scenario5F if cancer==4, over(Country)


mean scenario5M if cancer==5, over(Country) 

mean scenario5F if cancer==5, over(Country)


mean scenario5M if cancer==6, over(Country) 

mean scenario5F if cancer==6, over(Country)


mean scenario5M if cancer==7, over(Country) 

mean scenario5F if cancer==7, over(Country)


mean scenario5M if cancer==8, over(Country) 

mean scenario5F if cancer==8, over(Country)


mean scenario5M if cancer==9, over(Country) 

mean scenario5F if cancer==9, over(Country)


mean scenario5M if cancer==10, over(Country) 

mean scenario5F if cancer==10, over(Country)


mean scenario5M if cancer==11, over(Country) 

mean scenario5F if cancer==11, over(Country)


mean scenario5F if cancer==12, over(Country)


mean scenario5M if cancer==13, over(Country) 

mean scenario5F if cancer==13, over(Country)


*Estimation of CI* 

mean scenario5M, over(cancer) vce(bootstrap, reps(1000) dots(1))


mean scenario5F, over(cancer) vce(bootstrap, reps(1000) dots(1)) 


