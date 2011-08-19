PSXRACT ;BIR/HW-ACTIVITY REPORT [ 05/10/97  2:28 PM ] ; 31 Oct 2000  2:28 PM
 ;;2.0;CMOP;**1,31**;11 Apr 97
 ; External reference to ^PSRX( supported by DBIA #1221
 ; External reference to ^PS(59 supported by DBIA #1976
 ;
BEGDATE S DIR(0)="DO",DIR("A")="ENTER BEGINNING TRANSMISSION DATE " D ^DIR K DIR
 G:$D(DIRUT)!(X']"") END
 S PSXB=Y K Y,X
 I PSXB>DT W !!,"Future dates are not allowed.",! G BEGDATE
ENDDATE S Y=DT X ^DD("DD") S ZZTODAY=Y K Y
 K X,Y
 S DIR(0)="DO",DIR("A")="ENTER ENDING TRANSMISSION DATE ",DIR("B")=ZZTODAY
 D ^DIR K DIR
 G:$D(DIRUT) END
 S PSXE=Y K Y
 I PSXE<PSXB W !,"Ending date must follow beginning date!" G ENDDATE
 K ZZTODAY
 D SEL Q:'$D(DIVNM)
DEVICE W !! S %ZIS="MQ",%ZIS("A")="Select Printer: ",%ZIS("B")=""
 D ^%ZIS G:POP END S PSXLAP=ION
 I $E(IOST,1,2)["C-" G START
 I '$D(IO("Q")) G ST0
 D ^%ZISC K J,C
QUE S ZTSAVE("PSXB")="",ZTSAVE("PSXE")="",ZTSAVE("DIVNM(")="",ZTSAVE("DIVDA(")="",ZTIO=PSXLAP
 S ZTRTN="START^PSXRACT"
 S ZTDESC="CMOP Activity Report"
 D ^%ZTLOAD
Q1 W:$D(ZTSK) !!,"Report Queued to Print!!"
 K DIR,PSXB,PSXE,Y
 Q
ST0 U IO
 ;Called by taskman to print the CMOP Activity Report
START S:$D(ZTQUEUED) ZTREQ="@"
 S LINE="W ! F I=1:1:80 W ""="""
DIVISION ;
 S DIVDA=0 F  S DIVDA=$O(DIVDA(DIVDA)) Q:DIVDA'>0  D ONEDIV
 D GRNDSUM
 G EXIT
 ;
 Q
ONEDIV ;
 S LINE="W ! F I=1:1:80 W ""=""",CT=0
 S Y=PSXB X ^DD("DD") S PSXBE=Y
 S Y=PSXE X ^DD("DD") S PSXEE=Y
 S PSXE1=PSXE+.99999,PSXD=PSXB-.00001
 D TITLE
BATCH F  S PSXD=$O(^PSX(550.2,"D",PSXD)) Q:(+PSXD'>0)!(+PSXD>PSXE1)  D  Q:$G(PSXFLAG)=1
 .F P5502=0:0 S P5502=$O(^PSX(550.2,"D",PSXD,P5502)) Q:'P5502  D  Q:$G(PSXFLAG)=1
 ..S BATCH=+$P($G(^PSX(550.2,P5502,0)),"^") Q:$G(BATCH)']""
 ..S DIV=$P($G(^PSX(550.2,P5502,0)),"^",3),DIV=$P($G(^PS(59,DIV,0)),"^")
 ..I '$D(DIVNM(DIV)) Q
 ..I DIV'=DIVDA(DIVDA) Q
 ..S NODE=$G(^PSX(550.2,P5502,1)) Q:$G(NODE)']""
 ..S ORDS=$P($G(NODE),"^",7),TORDS=$G(TORDS)+ORDS,RTRN=$P(NODE,"^",2)
 ..S TORDS(DIV)=$G(TORDS(DIV))+ORDS
 ..S RXS=$P($G(NODE),"^",8),TRXS=$G(TRXS)+RXS
 ..S TRXS(DIV)=$G(TRXS(DIV))+RXS
 ..F PSXR=0:0 S PSXR=$O(^PSRX("AS",PSXD,PSXR)) Q:'PSXR  D
 ...S PSXF="" F  S PSXF=$O(^PSRX("AS",PSXD,PSXR,PSXF)) Q:($G(PSXF)']"")  D RX
 ..D PRINT Q:$G(PSXFLAG)=1
 X LINE
 S DIV=DIVDA(DIVDA)
 W !,?9,DIV,?35,$J($G(TORDS(DIV)),7),?43,$J($G(TRXS(DIV)),6),?53,$J($G(PSXCRT(DIV)),7),?63,$J($G(PSXNDT(DIV)),7),?73,$J($G(PSXCUT(DIV)),5)
 Q
GRNDSUM ;
 S DIVDA(0)="                              Grand Total Summary",DIVDA=0
 D TITLE
 S DIV=0 F  S DIV=$O(TORDS(DIV)) Q:DIV=""  D
 .W !,?9,DIV,?35,$J($G(TORDS(DIV)),7),?43,$J($G(TRXS(DIV)),6),?53,$J($G(PSXCRT(DIV)),7),?63,$J($G(PSXNDT(DIV)),7),?73,$J($G(PSXCUT(DIV)),5)
 X LINE
 W !!,"TOTAL",?35,$J($G(TORDS),7),?43,$J($G(TRXS),6),?53,$J($G(PSXCRT),7),?63,$J($G(PSXNDT),7),?73,$J($G(PSXCUT),5)
END K DIR,DIRUT,PSXB,PSXE,ZZTODAY,PSXLAP,PSXE1,PSXOT,PSXD,P5502,BATCH
 K DIV,NODE,TORDS,TRXS,PSXR,PSXF,GT,PSXFLAG,ZNODE,ZFILL,PSXSTAT,PSXCR
 K PSX,PSXCRT,PSXCUT,PSXLINE,PSXNDT,PSXNOW,X,Y,%,RTRN
 Q
EXIT ;
 D END
 K DIVDA,DIVNM,PSXB,PSXE,LINE,CT,I,PSXBE,PSXEE,ZZTOT,ZTSK
 D ^%ZISC
 Q
RX ; COUNT RX DATA
 I $D(^PSRX(PSXR,4,0)) F PSX=0:0 S PSX=$O(^PSRX(PSXR,4,PSX)) Q:'PSX  D
 .S ZNODE=$G(^PSRX(PSXR,4,PSX,0)),ZFILL=$P($G(ZNODE),"^",3)
 .I $G(ZFILL)'=PSXF K ZFILL Q
 .I +$G(ZNODE)'=BATCH Q
 .S PSXSTAT=$P($G(ZNODE),"^",4),PSX(ZFILL)=PSXSTAT
 .K ZNODE,ZFILL,PSXSTAT
 I $G(PSX(PSXF))=1 S PSXCR=$G(PSXCR)+1,PSXCRT=$G(PSXCRT)+1 D  Q
 .S PSXCRT(DIV)=$G(PSXCRT(DIV))+1
 I $G(PSX(PSXF))=3 S PSXND=$G(PSXND)+1,PSXNDT=$G(PSXNDT)+1 D  Q
 .S PSXNDT(DIV)=$G(PSXNDT(DIV))+1
 I $G(PSX(PSXF))=2 S PSXRT=$G(PSXRT)+1 S:(RTRN)>0 COM="FILLED IN "_$G(RTRN)
 S PSXCU=$G(PSXCU)+1,PSXCUT=$G(PSXCUT)+1
 S PSXCUT(DIV)=$G(PSXCUT(DIV))+1
 S:$G(COM)'="" PSXCU=""
 Q
TITLE I IOST["C-" W @IOF
 S Y=PSXB X ^DD("DD") S PSXBP=Y
 S Y=PSXE X ^DD("DD") S PSXEP=Y
 D NOW^%DTC S Y=% X ^DD("DD") S PSXNOW=Y
 W !,?30,"CMOP ACTIVITY REPORT"_$S($G(ZZTOT)=1:" SUMMARY",1:"")
 W !,DIVDA(DIVDA)
 W !,"For ",PSXBP,"  thru  ",$P(PSXEP,"@"),?40,"Printed: ",PSXNOW
 S PSXLINE=6
 K PSXBP,PSXEP
 X LINE
AHEAD W !,"TRANS #",?9,"DIVISION",?37,"ORDERS",?45,"RXS",?53,"RELEASED",?63,"NOT DISP",?73,"UNREL"
 X LINE
 Q
PRINT I IOST["C-",($G(PSXLINE)>20) D  Q:$G(PSXFLAG)=1
 .S DIR(0)="E" D ^DIR K DIR I $G(Y)'=1 S PSXFLAG=1 K Y Q
 .D TITLE
 I IOST'["C-",($G(PSXLINE)>60) W @IOF D TITLE
 ;S:$G(COM)="" PSXCU=""
 W !,$J($G(BATCH),6),?9,$S($G(COM)'="":$E($G(DIV),1,10)_" "_$G(COM),1:$G(DIV)),?35,$J($G(ORDS),7),?43,$J($G(RXS),6),?53,$J($G(PSXCR),7),?63,$J($G(PSXND),7),?73,$J($G(PSXCU),5)
 S PSXLINE=$G(PSXLINE)+1
 K BATCH,DIV,ORDS,RXS,PSXCR,PSXND,PSXCU,PSXRT,COM,COM1
 Q
SEL ;Select divisions
 ; returns arrays
 ; DIVNM("names of divisions")=selection number
 ; DIVDA("iens of divisions")=name of division
 ; for testing
 W !!,"SELECTION OF DIVISION(S)",!
 S DIV="" K DIVNM,DIVDA,DIVX
 F I=1:1 S DIV=$O(^PS(59,"B",DIV)) Q:DIV=""  S DIVNM(I)=DIV,DIVNM(DIV)=I,DIVDA=$O(^PS(59,"B",DIV,0)),DIVNM(I,"I")=DIVDA
 S I=I-1
 K DIR S DIR(0)="S^A:ALL DIVISIONS;S:SELECT DIVISIONS"
 D ^DIR K DIR         G:Y="A" ALL
 G:Y="S" SELECT
 Q
SELECT ;
 F C=1:1:I S DIR("A",C)=C_"    "_DIVNM(C)
 S DIR(0)="LO^1:"_I,DIR("A")="Select Division(s) "
 D ^DIR
 I '+Y K DIVNM Q
 M DIVX=DIVNM K DIVNM
 F I=1:1 S X=$P(Y,",",I) Q:'X  M DIVNM(X)=DIVX(X) S DIVNM=DIVX(X),DIVNM(DIVNM)=X
 K DIVX,DIR
ALL W !!,"You have selected:",! S DIV=0 F  S DIV=$O(DIVNM(DIV)) Q:'DIV  W !,DIV,?5,DIVNM(DIV)
 S DIR(0)="Y",DIR("A")="Is this corrrect ? ",DIR("B")="YES" D ^DIR
 K DIR
 I Y D  Q
 .K DIVDA
 .S DIV=0 F  S DIV=$O(DIVNM(DIV)) Q:'DIV  S DA=DIVNM(DIV,"I"),DIVDA(DA)=DIVNM(DIV) K DIVNM(DIV)
 G SEL
 ;
