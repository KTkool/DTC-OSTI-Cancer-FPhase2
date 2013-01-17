
All content licenced under a CC-BY-3.0 licence - Kathryn Atwell, Adam Berrington, Lucy Hutchinson, Ronja Woloszczuk, Islom Nazarov.

-------------------------------------------------------------------------------------------------------------------------------
Content notation

All content is in the form of .png or .fig (matlab) files. 

The files contain graphs of the total cell count for different values of Alpha

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

	Alpha5 = Comparison of without drug and with drug (alpha = 0.2). Graph of total cell counts for 500 iterations. 

	Alpha1 = Single diagram of cell count for alpha = 1, i.e control

	Alpha10wDiff = Comparison of with/without drugs now with diffusion gradient on d_d = params.dd = 4.5*10^-4;

	AlphaOptimisation = Total glycolytic cell count at 500 iterations, for different alpha values. Averaged over 5 runs. 

	AlphaReport = Comparison with diffusion, for params.dd = 4.5*10^-4, for alpha = 0.2.


	
