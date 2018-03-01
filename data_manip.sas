
title1 'Policy Uncertainty and Stocks';
proc import datafile = "ADR_97_17.csv" out = adrTemp replace;
	getnames = yes;
run;

data adrTemp;
	set adrTemp;
	if date = . then delete;
	if cusip = . then delete;
	if bidlo = . then delete;
	if askhi = . then delete;
	if prc = . then delete;
	if vol = . then delete;
	if ret = . then delete;
	if bid = . then delete;
	if ask = . then delete;
	if shrout = . then delete;
	if vwretd = . then delete;
	delete shcls;
run;

proc print data = adrTemp (obs=10);
run;

proc import datafile = "ADR_Compustat.csv" out = adrCmpstat(rename=cusip=CUSIP) replace;
	getnames = yes;
run;

data adrCmpstat;
	if CUSIP = . then delete;
	delete tsymbol tic;
run;

proc sort data = adrTemp;
	by cusip;
run;

proc sort data = adrCmpstat;
	by cusip;
run;

data adr;
	merge adrTemp adrCmpstat;
	by cusip;
	delete tsymbol
run;

proc print data=adr (obs = 10000);
run;





