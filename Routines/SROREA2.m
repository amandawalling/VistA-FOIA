SROREA2 ;B'HAM ISC/MAM - DELAY REASONS, ALL SPECIALTIES ; [ 04/04/00  11:54 AM ]
 ;;3.0; Surgery ;**94**;24 Jun 93
 S (PAGE,SRSOUT,SRHDR)=0 K ^TMP("SR",$J),^TMP("SRT",$J) S (^TMP("SR",$J),^TMP("SRT",$J))=0 I 'SROTOT D HDR Q:SRSOUT
 S SRSDATE=SRSD-.0001,SREDT=SRED+.9999
 F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>SREDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D UTIL
 I ^TMP("SR",$J)=0 D:SROTOT HDR W !!,"No data for selected date range." Q
 I SROTOT D ^SROREA Q
 S SRSS=0 F  S SRSS=$O(^TMP("SRT",$J,SRSS)) Q:SRSS=""!(SRSOUT)  D SPEC
 Q:SRSOUT  D ^SROREA
 Q
UTIL I '$D(^SRF(SRTN,.2)) Q
 I '$P(^SRF(SRTN,.2),"^",12) Q
 I '$O(^SRF(SRTN,17,0)) Q
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSS=$S('SRSS:"ZZ",1:$P(^SRO(137.45,SRSS,0),"^"))
 S SRDC=0 F  S SRDC=$O(^SRF(SRTN,17,SRDC)) Q:'SRDC  S CAUSE=$P(^SRF(SRTN,17,SRDC,0),"^"),SRDEL=$P(^(0),"^",2) D SETUT
 Q
SETUT I '$D(^TMP("SRT",$J,SRSS)) S ^TMP("SRT",$J,SRSS)=0
 I '$D(^TMP("SRT",$J,SRSS,CAUSE)) S ^TMP("SRT",$J,SRSS,CAUSE)=0
 I '$D(^TMP("SR",$J,CAUSE)) S ^TMP("SR",$J,CAUSE)=0
 S ^TMP("SR",$J)=^TMP("SR",$J)+1,^TMP("SR",$J,CAUSE)=^TMP("SR",$J,CAUSE)+1
 S ^TMP("SRT",$J,SRSS)=^TMP("SRT",$J,SRSS)+1,^TMP("SRT",$J,SRSS,CAUSE)=^TMP("SRT",$J,SRSS,CAUSE)+1
 Q
SPEC I $Y+6>IOSL D PAGE Q:SRSOUT
 S SRSSNM=$S(SRSS'="ZZ":SRSS,1:"SURGICAL SPECIALTY NOT ENTERED")
 S SRCOL=80-$L(SRSSNM)\2,SRSS1="" F UL=1:1:$L(SRSSNM) S SRSS1=SRSS1_"-"
 W !!,?SRCOL,SRSSNM,!,?SRCOL,SRSS1,!
 S CAUSE=0 F  S CAUSE=$O(^TMP("SRT",$J,SRSS,CAUSE)) Q:'CAUSE!(SRSOUT)  D CAUSE
 Q:SRSOUT  W !!,?3,"TOTAL DELAYS FOR "_SRSSNM,?65,$J($P(^TMP("SRT",$J,SRSS),"^"),5),!
 Q
CAUSE I $Y+4>IOSL D PAGE I SRSOUT Q
 S SRCAUS=$P(^SRO(132.4,CAUSE,0),"^") W !,SRCAUS,?65,$J($P(^TMP("SRT",$J,SRSS,CAUSE),"^"),5)
 Q
PAGE S X="" I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter RETURN to continue printing this report, or '^' to exit from this option." G PAGE
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S X=$E(SRSD,4,5)_"/"_$E(SRSD,6,7)_"/"_$E(SRSD,2,3),Y=$E(SRED,4,5)_"/"_$E(SRED,6,7)_"/"_$E(SRED,2,3),PAGE=PAGE+1 I $Y W @IOF
 I $E(IOST)="P" W !,?(80-$L(SRINST)\2),SRINST,?70,"PAGE: "_PAGE,!,?32,"SURGICAL SERVICE"
 W !,?28,"REPORT OF DELAY REASONS",!,?27,"FROM "_X_"  TO "_Y
 I $E(IOST)="P" W !!,?21,"REVIEWED BY:",?45,"DATE REVIEWED:",!! F LINE=1:1:80 W "="
 I SRHDR,CAUSE W !!,?SRCOL,SRSSNM,!,?SRCOL,SRSS1,!
 S SRHDR=1
 Q
