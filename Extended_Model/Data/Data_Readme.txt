___________________________________________________________________________________________________

NOTE: OUR .MAT FILES ARE TOO BIG TO BE HAPPILY PUSHED TO GIT HUB. INSTEAD THEY CAN BE FOUND ON THE DATA HUB WEBSITE: URL = /dataset/mat-model-tumor-development

-------------------------------------------------------------------------------------------------------------------------------

Data notation

All data is in the form of .mat (matlab) files. 

The files contain storage matrices containing the state of each variable over the course of the simulation. At each iteration the state matrices are appended to the bottom of their corresponding storage matrices.

Parameters set to default values in all files:

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
                
DATA FILE NAMING CONVENTION

output_*type of mutant seeded at t=1**repeat number*.mat

types are: 	   ar = acid resistant
		   gly = glycolytic
		   hyp = hypoplastic
		   hyp_mut = hypoplastic with high mutation rate
		   
For further details see the report in the documentation folder.

