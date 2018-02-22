

proc import datafile = "ADR_97_17.csv" out = adrTemp replace;
	getnames = yes;
run;

data adrTemp;
	set adrTemp;
	where date ne .;
	where cusip ne .;
	where bidlo ne .;
	where askhi ne .;
	where prc ne .;
	where vol ne .;
	where ret ne .;
	where bid ne .;
	where ask ne .;
	where shrout ne .;
	where vwretd ne .;
run;

proc import datafile = "ADR_Compustat.csv" out = adrCmpstat(rename=tic=ticker) replace;
	getnames = yes;
run;

proc print data = adrCmpstat (obs = 10);
run;





proc sort data = adrTemp;
	by cusip ticker;
run;

proc sort data = adrCmpstat;
	by cusip ticker;
run;


data adr;
	merge adrTemp adrCmpstat;
	by cusip ticker;
run;

proc print data=adr (obs = 500);
run;

