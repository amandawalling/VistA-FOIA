PSDRLOG3 ;BIR/JPW,LTL-Inspector's Log By Date (cont'd) ; 31 May 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;print inspector's log by naou, drug and green sheet #
 S (PG,PSDOUT,NAOU)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDRLOG",$J)) D HDR W !!,?45,"****  NO PENDING NARCOTIC ORDERS FOR INSPECTION  ****",! G DONE
 S NAOU="" F  S NAOU=$O(^TMP("PSDRLOG",$J,"B",NAOU)) Q:NAOU=""!(PSDOUT)  D HDR Q:PSDOUT  W !,?2,"=> NAOU: ",NAOU,! S LNUM=$Y D LOOP2 Q:PSDOUT  D PRT
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,ANS,ASK,ASKN,CNT,COMM,DA,DIC,DIE,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,EXP,EXPD,FLAG,JJ,KK,LN,LOOP,LNUM,LOT,MFG,NAOU,NODE,NODE1,NODE3,NODE7,NUM
 K OK,ORD,ORDN,PG,PSD,PSDA,PSDATE,PSDCNT,PSDDT,PSDG,PSDIO,PSDOK,PSDN,PSDNA,PSDOUT,PSDR,PSDRD,PSDRET,PSDRN,PSDSD,PSDST,PSDTR,PSDTYP,QTY,REQD,REQDT,RPDT,RQTY
 K SEL,STAT,STATN,TEXT,TYP,TYPN,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDRLOG",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?42,"Inspector's Log for Controlled Substances",?120,"Page: ",PG,!,?52,RPDT,!
 W !,?57,"DATE",?71,"QTY"
 W !,"DISP #",?13,"DRUG",?55,"RECEIVED",?68,"RECEIVED",?85,"EXP DATE"
 W:$G(PSDRET) ?100,"DATE RETURNED" W ?118,"NAME/DATE"
 W !,LN,!
 Q
LOOP2 ;print inv typ loop
 S NAOU(1)=$O(^TMP("PSDRLOG",$J,"B",NAOU,0))
 S TYPN="" F  S TYPN=$O(^TMP("PSDRLOG",$J,NAOU(1),"B",TYPN)) Q:TYPN=""!(PSDOUT)  W !,?4,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),! S LNUM=$Y D
 .S TYPN(1)=$O(^TMP("PSDRLOG",$J,NAOU(1),"B",TYPN,0))
 .I ASK="N" D  Q
 ..S NUM=0
 ..F  S NUM=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),NUM)) Q:NUM=""!(PSDOUT)  D  Q:PSDOUT
 ...I $Y+8>IOSL D PRT,HDR Q:PSDOUT  W !?2,"=> NAOU: ",NAOU,!!?4,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),! S LNUM=$Y
 ...S PSDR=0
 ...F  S PSDR=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),NUM,PSDR)) Q:'PSDR!(PSDOUT)  S PSDCNT=0 F  S PSDCNT=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),NUM,PSDR,PSDCNT)) Q:'PSDCNT!(PSDOUT)  D  Q:PSDOUT
 ....I $Y+8>IOSL D PRT,HDR Q:PSDOUT  W !?2,"=> NAOU: ",NAOU,!!?4,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),! S LNUM=$Y
 ....S NODE=$G(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),NUM,PSDR,PSDCNT))
 ....W !,$P(NODE,U,4),?2,NUM,?13,$P(NODE,U,6),?55,$P(NODE,U,2),?70,$J($P(NODE,U),6),?85,$P(NODE,U,3),?100,"____________",?118,"____________",!
 ....W:$P(NODE,U,5)]"" ?13,"(TRANSFERRED TO ",$P(NODE,U,5),")",! S LNUM=$Y
 .S PSDRN="" F  S PSDRN=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),"B",PSDRN)) Q:PSDRN=""!(PSDOUT)  D  Q:PSDOUT
 ..I $Y+8>IOSL D PRT,HDR Q:PSDOUT  W !,?2,"=> NAOU: ",NAOU,! W:ASKN !,?4,"=> INVENTORY TYPE: ",$S($E(TYPN,1,2)="ZZ":$E(TYPN,3,99),1:TYPN),! S LNUM=$Y
 ..S PSDRN(1)=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),"B",PSDRN,0))
 ..S NUM="" F  S NUM=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),PSDRN(1),NUM)) Q:NUM=""!(PSDOUT)  F PSDCNT=0:0 S PSDCNT=$O(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),PSDRN(1),NUM,PSDCNT)) Q:'PSDCNT!(PSDOUT)  D  Q:PSDOUT
 ...I $Y+8>IOSL D PRT,HDR Q:PSDOUT  W !,?2,"=> NAOU: ",NAOU,! W:ASKN !,?4,"=> INVENTORY TYPE: ",TYPN,! S LNUM=$Y
 ...S NODE=$G(^TMP("PSDRLOG",$J,NAOU(1),TYPN(1),PSDRN(1),NUM,PSDCNT))
 ...W !,$P(NODE,"^",4),?2,$S(ASK="N":PSDRN,1:NUM),?13,$S(ASK="D":PSDRN,1:NUM),?55,$P(NODE,"^",2),?70,$J($P(NODE,"^"),6),?85,$P(NODE,"^",3),?100,"____________",?118,"____________",!
 ...W:$P(NODE,"^",5)]"" ?13,"(TRANSFERRED TO "_$P(NODE,"^",5)_")",!
 ...S LNUM=$Y
 Q
PRT ;
 I LNUM<IOSL-7 F JJ=LNUM:1:IOSL-7 W !
 W LN,!,"*  - Transferred to another NAOU",!,"** - Received from another NAOU",!
 Q
