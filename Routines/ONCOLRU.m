ONCOLRU ;HInes OIFO/GWB - LAB UTILITY ;8/21/93
 ;;2.11;ONCOLOGY;**16,34**;Mar 07, 1995
 ;
D S %=$E(Y,4,5)*3
 S Y=$E("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",%-2,%)_" "_$S($E(Y,6,7):$J(+$E(Y,6,7),2)_", ",1:"")_($E(Y,1,3)+1700)_$S(Y[".":"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"")
 S:Y[1700 Y=""
 Q
 ;
SSN S SSN(2)=SSN
 I $L(DUZ("AG")),"NAFARMY"[DUZ("AG") S SSN=$S($L(SSN)<11:$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10),1:$E(SSN,10,11)_"/"_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)) S SSN(1)=$S($P(SSN,"-",3):$P(SSN,"-",3),1:$E(SSN,9,12)) Q
 S:$L(SSN)>8 SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,99)
 S SSN(1)=$S($P(SSN,"-",3):$P(SSN,"-",3),1:"????") S:'$L(SSN) SSN="?" Q
 ;
B ;Start Date/Go to Date
 S Y=$P(^ONCO(160.1,OSP,0),U,5)
 I Y="" S Y=DT
 S Y=$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_($E(Y,1,3)+1700)
 S %DT="AEX",%DT(0)="-"_DT,%DT("A")="Start Date: ",%DT("B")=Y
 D ^%DT K %DT
 Q:Y<1  S LRSDT=Y
 S %DT="AEX",%DT(0)="-"_DT,%DT("A")="Go to Date: ",%DT("B")="TODAY"
 D ^%DT K %DT
 Q:Y<1  S LRLDT=Y I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S $P(^ONCO(160.1,OSP,0),U,5)=LRLDT
 S Y=LRSDT D D S LRSTR=Y,Y=LRLDT D D S LRLST=Y Q
 ;
 ;
V K A,B,C,D,DEF,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,V,W,X,Y,Z
 K AGE,DOB,PNM,POP,SEX
 K DIC,DIE,DR,DFN,DIWF,D0,DQ,DA,DX,DE,DG
 K %Y,%X
 K ZTSK,ZTRTN,ZTSAVE,ZTDESC
 K LRWHO,LRSDT,LRLDT,LRSTR,LRLST,LRXR,LRXREF,LRADM,LRADX,LRABV,LRAWRD
 K LRAX,LRAD,LRDPAF,LRFNAM,LRMD,LRPF,LRPFN,LRSVC,LRID,LRAP,LRSAV,LREP
 K LRDTI,LRODT,LRSN,LRBL,LRCPT,LRFND,LRPPT,LRIDT,LRPMD,LRRMD,LR,LRA,LRB
 K LRC,LRD,LRE,LRF,LRG,LRH,LRI,LRJ,LRK,LRL,LRM,LRN,LRO,LRP,LRQ,LRR,LRS
 K LRT,LRU,LRV,LRW,LRX,LRY,LRZ,LRAU,LRFLN,LRLIDT,LRND,LRST,LRTK,LRWW
 K LRAC,DIWL,DIWR,DIWF,LROLLOC,LRCAPLOC,LRDFN,LRSF,LR,LRAN,LRAA,LRSOP
 K LROPT,LRRH,SSN,LRLLOC,LRDPF,LREND,LREXP,LRTOD,LRABO,LRPABO,LRPRH,LRSS
 K LRCS,LRRC,LRSIT,LRWHN,LRSA,LRIFN,LRBLT
 K ^TMP($J),^TMP("LRBL",$J)
 Q
