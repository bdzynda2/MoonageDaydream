adr = read.csv("ADR_97_17.csv", header = TRUE)
adr_c = read.csv("ADR_Compustat.csv", header = TRUE)

adr$CUSIP <- as.numeric(as.character(adr$CUSIP))
adr$SHRCLS <- NULL
adr$TSYMBOL <- NULL

for( i in 1:nrow(adr)){
  if(is.na(adr[i,'CUSIP'])){
    adr[i,] <- NULL
  }
}


adr_c$gvkey <- NULL
adr_c$iid <- NULL
adr_c$tpci <- NULL

for( i in 1:nrow(adr)){
  if(is.na(adr_c[i,'cusip'])){
    adr[i,] <- NULL
  }
}


na.omit(adr)