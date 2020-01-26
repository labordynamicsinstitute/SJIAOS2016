%let seed=12345;
%let a=.1;
%let b=.25;

data test;
do i = 1 to 100000;
x=ranuni(&seed.);
     if 0   lt x le 0.5 then y=(1-&b) + (&b - &a)*(2*(.5-x))**.5;
else if 0.5 lt x le 1   then y=(1+&b) - (&b - &a)*(2*(x-.5))**.5;
output;
end;
run;

/* test the distribution */
/*
 * Turns on standard graphics;
 */
ods graphics on / imagename="SGPlot" width=3000px;
/*
 * Creates a (full-size page) PDF;
ods PDF  file="SGPlot.pdf" notoc dpi=600 ;
 * Creates a SVG file;
ods printer file="SGPlot.svg";
*/
options center nodate nonumber;

ods printer printer=png file="SGPlotHiDef.png" dpi=600;

proc sgplot data=test;
histogram y/ binstart=0.7 binwidth=0.001;
xaxis display=(nolabel) label='label'
   min=0.7 max=1&b. values=(0.75 0.9 1.1 1.25);
yaxis display=(nolabel) ;
run;
ods printer close;
