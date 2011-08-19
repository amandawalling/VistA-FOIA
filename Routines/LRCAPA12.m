LRCAPA12 ;SLC/RJS/FHS - LAB WORKLOAD  DIVISION REPORT;8/23/91 1039;
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
EN ;
 ;
 K ^TMP($J),ZTSK
ASK1 ;
 S %DT="E" W !!,"Beginning Date: " R X:$S($D(DTIME):DTIME,1:999) E  G EXIT
 G:(X["^") EXIT D ^%DT G:(Y<0) ASK1 S LRDT1=+Y
ASK2 ;
 S %DT="E" W !!,"Ending Date: " R X:$S($D(DTIME):DTIME,1:999) E  G EXIT
 G:(X["^") EXIT D ^%DT G:(Y<0) ASK2 S LRDT2=+Y I LRDT1>LRDT2 S Y=LRDT1,LRDT1=LRDT2,LRDT2=Y
 W !! S %ZIS="NQ" D ^%ZIS G:'$L(IO) EXIT
 G:IO'=IO(0)!($D(IO("Q"))) QUEUE
DQ ;
 I $D(ZTQUEUED) S ZTREQ="@"
 U IO S LRPG=0 D LOOP W:TOT !!,?35,"Total for the Report: ",$J(TOT,10,2)
 I '$D(^TMP($J)) W !!?10,"No Data for " S X=LRDT1P D DD W " - " S X=LRDT2P D DD W !!
 W:IOST["P-" @IOF
EXIT ;
 D ^%ZISC
 K LRPG,TOT,LRDT,LRDT1,LRDT2,LRDV1,LRDV2,LRLN,^TMP($J),LRTXT,ZTSK,%DT,%ZIS,ZTRTN,ZTDESC,ZTIO,ZTSAVE,LRDT1P,LRDT2P,IO("Q")
 Q
QUEUE ;
 S ZTRTN="DQ^LRCAPA12",ZTSAVE("LRDT*")="",ZTDESC="Lab Workload Division Report",ZTIO=ION
 K ZTDTH,ZTCPU,ZTUCI
 D ^%ZTLOAD
 G EXIT
 Q
LOOP ;
 S (LRLN,LRDV1,LRDV2,TOT)=0,LRDT1P=LRDT1,LRDT2P=LRDT2,LRDT1=LRDT1-.0001,LRDT2=LRDT2+.00001 D DT^LRX
 W !! D WAIT^DICD W:IOST["P-" @IOF
 F  S LRLN=$O(^TMP("WL",LRLN)) Q:'LRLN  S LRTXT=^(LRLN) D LOOP1
 D HEADER
 S LRDV1=0 F  S LRDV1=$O(^TMP($J,LRDV1)) Q:'LRDV1  D LOOP2
 Q
LOOP1 ;
 I ($E(LRTXT,1,2)="$$") S LRDV2=+$E(LRTXT,3,99),LRDT=$E(LRTXT,10,16) Q
 I ($E(LRTXT,1)="$") S LRDV1=+$E(LRTXT,2,99) Q
 Q:'LRDV1!('LRDV2)
 I LRDT>LRDT1,LRDT<LRDT2 D DATES S ^TMP($J,LRDV1,LRDV2,"TOT WRK")=^TMP($J,LRDV1,LRDV2,"TOT WRK")+(+$E(LRTXT,28,99)*(+$E(LRTXT,34,99)))
 Q
LOOP2 ;
 S LRDV2=0 F  S LRDV2=$O(^TMP($J,LRDV1,LRDV2)) Q:'LRDV2  D LOOP3
 Q
LOOP3 ;
 I IOST["P-"&($Y>(IOSL-6)) D HEADER
 W !,"Division: ",LRDV2
 S X=^TMP($J,LRDV1,LRDV2,"LO DT") W ?20,"From: " D DD S X=^("HI DT") W ?35,"To: " D DD
 W ?50,"Total: ",$J(^("TOT WRK"),10,2) S TOT=TOT+^("TOT WRK")
 Q
DATES ;
 D:'$D(^TMP($J,LRDV1,LRDV2,"HI DT"))#2 NEW
 S:'(LRDT<^TMP($J,LRDV1,LRDV2,"HI DT")) ^TMP($J,LRDV1,LRDV2,"HI DT")=LRDT
 S:'(LRDT>^TMP($J,LRDV1,LRDV2,"LO DT")) ^TMP($J,LRDV1,LRDV2,"LO DT")=LRDT
 Q
NEW ;
 S ^TMP($J,LRDV1,LRDV2,"HI DT")=0
 S ^TMP($J,LRDV1,LRDV2,"LO DT")=9999999
 S ^TMP($J,LRDV1,LRDV2,"TOT WRK")=0
 Q
HEADER ;
 S LRPG=LRPG+1 W:IOST["P-"&($Y>(IOSL-6)) @IOF W !!,"   Lab Workload Division Report for Site: ",LRDV1,"    Printed: ",LRDT0,!!,?60,"Pg: ",LRPG,!
 Q
DD ;
 W $$FMTE^XLFDT(X,"1D") Q
