PSGWPSI1 ;BHAM/CML-Print Data for AR/WS Stock Items - CONTINUED ; 30 Aug 93 / 10:16 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
PRINT ;
 S $P(LN,"-",133)="",PG=0,OUT=0,%DT="",X="T" D ^%DT X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("PSGWPSI",$J)) W !?43,"***** NO DATA AVAILABLE FOR THIS REPORT *****" G QUIT
 S ITMNM="" F LL=0:0 S ITMNM=$O(^TMP("PSGWPSI",$J,ITMNM)) Q:ITMNM=""!(OUT)  D:$Y+5>IOSL HDR I 'OUT W !,"=> ",ITMNM F AOU=0:0 S AOU=$O(^TMP("PSGWPSI",$J,ITMNM,AOU)) Q:'AOU!(OUT)  D WRTDATA
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST)="C"&('OUT) W !!,"Press RETURN to continue: " R AUTO:DTIME
QUIT ;
 K %DT,AOU,AOUNM,DRGDA,HDT,ITMDA,ITMNM,LIMIT,LINE,LN,LOC,NODE,PG,PSGWDT,LL,STKLEV,TCNT,TPNM,TYPE,WARD,WCNT,WDNM,X,Y,PSGWIO,ZTSK,ZTIO,DA,IO("Q"),AUTO,OUT
 K ^TMP("PSGWPSI",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@" Q
WRTDATA ;DATA LINES
 S NODE=^TMP("PSGWPSI",$J,ITMNM,AOU) S AOUNM=$S($P(^PSI(58.1,AOU,0),"^")]"":$P(^(0),"^"),1:"AOU #"_AOU_"/NO NAME OR DELETED")
 I $P(^TMP("PSGWPSI",$J,ITMNM,AOU),"^")="I" S Y=$P(^(AOU),"^",2) X ^DD("DD") D:$Y+5>IOSL HDR W !?4,AOUNM," (AOU INACTIVE AS OF ",Y,")",! Q
 S LOC=$P(NODE,"^"),STKLEV=$P(NODE,"^",2),WARD=$P(NODE,"^",3),TYPE=$P(NODE,"^",4)
 S WCNT=$L(WARD,";;"),TCNT=$L(TYPE,";;"),LIMIT=$S(TCNT>WCNT!(TCNT=WCNT):TCNT,WCNT>TCNT:WCNT,1:2)
 D:$Y+5>IOSL HDR Q:OUT  W !?4,AOUNM,?48,LOC,?62,STKLEV,?68 S WDNM=$P(WARD,";;",2) D:WDNM WARD W WDNM,?99 S TPNM=$P(TYPE,";;",2) D:TPNM TYPE W TPNM,!
 I LIMIT>2 F LINE=3:1:LIMIT D:$Y+5>IOSL HDR Q:OUT  W ?68 S WDNM=$P(WARD,";;",LINE) D:WDNM WARD W WDNM,?99 S TPNM=$P(TYPE,";;",LINE) D:TPNM TYPE W TPNM,!
 Q
WARD ;CHECK FOR WARD NAME IN ^DIC(42
 I $D(^DIC(42,WDNM,0)),$P(^(0),"^")]"" S WDNM=$P(^(0),"^") Q
 S WDNM="WARD #"_WDNM_"/NO NAME OR DELETED" Q
TYPE ;CHECK FOR TYPE IN FILE #58.16
 I $D(^PSI(58.16,TPNM,0)),$P(^(0),"^")]"" S TPNM=$P(^(0),"^") Q
 S TPNM="TYPE #"_TPNM_"/NO NAME OR DELETED" Q
HDR ;HEADER
 I $E(IOST)="C"&(PG>0) S DIR(0)="E" D ^DIR K DIR I Y'=1 S OUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,HDT,?122,"PAGE: ",PG,!?53,"DATA FOR AR/WS STOCK ITEMS",!!,"=> ITEM",!?61,"STOCK",!?14,"AOU",?49,"LOCATION",?61,"LEVEL",?70,"WARD (FOR ITEM)",?104,"TYPE",!,LN,!
 Q
