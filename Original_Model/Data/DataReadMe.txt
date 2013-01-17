
All data licenced under a CC-BY-3.0 licence - Kathryn Atwell, Adam Berrington, Lucy Hutchinson, Ronja Woloszczuk, Islom Nazarov.

___________________________________________________________________________________________________

NOTE: OUR .MAT FILES ARE TOO BIG TO BE HAPPILY PUSHED TO GIT HUB. INSTEAD THEY CAN BE FOUND ON THE DATA HUB WEBSITE: URL = /dataset/mat-model-tumor-development2

-------------------------------------------------------------------------------------------------------------------------------
Data notation

All content is in the form of .mat (matlab) files. 

The files contain counts of the average total populations for different values of Alpha. (averaged over 5 runs)

	AlphaX corresponds to an alpha value of 1/X. 

Parameters set to default values:

params.k = 10;
params.ht = 8600;
params.hn = 930;
params.pa = 0.001;
params.width = 50;
params.height = 35;
params.na = 36;
params.a0 = 0.2;
params.dg = 1/130^2;
params.dc = 1/25;

d_d is zero unless specified;

-----------------------------------------------------------------------------

Format of the data 

8x501 double array

first column is zeros

so actually a 8x500 array

__1_2_3_4_5_6_7_8_9 . . ._498_499_500_
|1
|2
|3
|4
|5
|6
|7
|8

	
y axis represents each cell count of states (1 - 8) 

 Normal : 1                 
 Hyperplastic : 5 ; 7       
 Hyperplastic-Gly : 6       
 Hyperplastic-Gly-AR : 8    
 Anything else : 2 ; 3; 4   



x direction counts number of iterations
                