LRACS2 ;SLC/DCM - LAB SUMMARY REPORT CONT. (MISC.) ; 2/22/87  3:08 PM ;
 ;;5.2;LAB SERVICE;**201,225**;Sep 27, 1994
LRUDT S LRTIM=$E(LRFDT,9,12) F I=0:0 Q:$L(LRTIM)=4  S LRTIM=LRTIM_0
 S LRUDT=$$Y2K^LRX($P(LRFDT,"."))_$J(LRTIM,5)
 Q
HEAD D BOT,TOP Q
BOT ;
Y I $Y'>(IOSL-6) W ! G Y
 S LRPG=LRPG+1 Q
TOP ;from LRACS1
TOPLN ;from LRACS1
 D DASH^LRX S Z=^LAC(LRXLR,LRDFN,0)
 W !,PNM,?20,SSN,?33,"AGE: ",AGE,?50,LRLLOC
 S LRAG=0
 Q
LRMISC S LRFDT=0,LRPG=1 D TOP
MHI S LRMHN=$P(^LAC(LRXLR,LRDFN,LRMH,1,0),U,1) D WR
MDT S LRFDT=$O(^LAC(LRXLR,LRDFN,"MISC",1,1,LRFDT)) G:LRFDT<1 END S LRVDT=$P(^(LRFDT,0),U,3) G:$P(LRVDT,".",1)'=LRDT MDT D LRUDT S LRMIT=0
LRMIT S LRMIT=$O(^LAC(LRXLR,LRDFN,"MISC",1,1,LRFDT,1,LRMIT)) G:'LRMIT TXT S Z=^(LRMIT,0)
 S LRLO="",LRHI="",LRVAL=$P(Z,U,1),LRSPE=$P(Z,U,2),LRTEST=$P(Z,U,3),LRSPEM=$P(^LAB(61,LRSPE,0),U,1)
 G:'LRTEST COMM S LRUNT="",LRNAME=$P(^LAB(60,LRTEST,.1),U,1) S:$D(^LAB(60,LRTEST,1,LRSPE,0)) @("LRLO="_$S($L($P(^(0),U,2)):$P(^(0),U,2),1:"""""")),@("LRHI="_$S($L($P(^(0),U,3)):$P(^(0),U,3),1:"""""")),LRUNT=$P(^(0),U,7)
WR1 D:$Y>(IOSL-12) WR W !!,LRUDT,?15,LRSPEM,?36,LRNAME,":",?50,LRVAL," ",LRUNT,?63 W:$L(LRLO) "NORMALS: ",LRLO,"-",LRHI
 G LRMIT
COMM W !,"COMMENT: ",LRVAL G LRMIT
WR D:$Y>(IOSL-12) HEAD S LRCL=21-$L(LRMHN)
 Q
TXT S I=0 F  S I=$O(^LAC(LRXLR,LRDFN,"MISC",1,1,LRFDT,"TX",0)) Q:'I  W !,^(I,0)
 G MDT
END D BOT S LRLO="" K LRSB,LRMISC Q
PRE Q:$O(^LAC(LRXLR,LRDFN,"MISC",1,0))'>0  S LRMISC=1,LRPG=$S($D(^LR(LRDFN,"PG",LRMH)):$P(^(LRMH),U,2),1:0),LRMH="MISC" G LRMISC
 Q
SORT ;from LRACS, LRACS3
 S LRNM=""
 F  S LRNM=$O(^TMP($J,LRNM)) Q:LRNM=""  S LRDFN=0 F  S LRDFN=$O(^TMP($J,LRNM,LRDFN)) Q:LRDFN<1  S LRLLOC=^(LRDFN) Q:$D(^LR(LRDFN,0))[0  S LRIL=0,LRNAME=0,LRPG=1,LRAG=0,LRYESCOM=0 D:$D(LRMIC) LRIDT^LRACS3 D:'$D(LRMIC) LRMH^LRACS1
 Q
