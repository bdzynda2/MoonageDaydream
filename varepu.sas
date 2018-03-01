libname varepu "C:\Work\Working Papers\VARs EPU";run;

data adr;
	set varepu.crsp_adr;
		prc = abs(prc);
		size = prc*(shrout*1000);
		close_spread = (ask-bid)/((ask+bid)/2);
		volt = log(askhi)-log(bidlo);
		illiq = (abs(ret)/(prc*vol))*(10**6);
		weekday = weekday(date);
		month = month(date);
		year = year(date);
	proc sort;by permno year month;
run;

proc means data=adr mean median stddev min max;var prc size;run;

proc means data=adr noprint;
	by permno year month;
	var prc size close_spread volt illiq;
		output out = adr2 (drop = _type_)
	mean = prc size close_spread volt illiq;
run;

*	equal-weighted index	*;

proc sort data=adr2;by year month;run;

proc means data=adr2 noprint;
	by year month;
	var prc size close_spread volt illiq;
		output out = adr3 (drop = _type_)
	mean = prc size close_spread volt illiq;
run;



