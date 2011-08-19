SROCNR1 ;B'HAM ISC/MAM - CIRC NURSE REPORT (ALL) ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
SET ; set variables
 I $Y+7>IOSL D PAGE Q:SRSOUT
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRSDATE=$P(SR(0),"^",9),SRSDATE=$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)
 D DEM^VADPT S SRNM=VADM(1),SSN=VA("PID") I $L(SRNM)>24 S SRNM=$P(SRNM,",")_","_$E($P(SRNM,",",2))_"."
 K SCRUB S SCRUB(1)="",(SCRUB,CNT)=0 F I=0:0 S SCRUB=$O(^SRF(SRTN,23,SCRUB)) Q:'SCRUB  S CNT=CNT+1,X=$P(^SRF(SRTN,23,SCRUB,0),"^"),X=$P(^VA(200,X,0),"^") S:$L(X)>17 X=$P(X,",")_", "_$E($P(X,",",2)) S SCRUB(CNT)=X
 K CIRC S CIRC(1)="",(CIRC,CNT)=0 F I=0:0 S CIRC=$O(^SRF(SRTN,19,CIRC)) Q:'CIRC  S CNT=CNT+1,X=$P(^SRF(SRTN,19,CIRC,0),"^"),X=$P(^VA(200,X,0),"^") S:$L(X)>17 SX=$P(X,",")_", "_$E($P(X,",",2)) S CIRC(CNT)=X
OPS S SROPER=$P(^SRF(SRTN,"OP"),"^"),OP=0 F I=0:0 S OP=$O(^SRF(SRTN,13,OP)) Q:'OP  D OTHER
 K SROPS,MM,MMM S:$L(SROPER)<50 SROPS(1)=SROPER I $L(SROPER)>49 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SR(.2)=^SRF(SRTN,.2),SRTI=$P(SR(.2),"^",10),SRTO=$P(SR(.2),"^",12),X=SRTI,X1=SRTO D MINS^SRSUTL2 S SRET=X
 S Y=SRTI D D^DIQ S SRFIND=$F(Y,":"),SRTI=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S Y=SRTO D D^DIQ S SRFIND=$F(Y,":"),SRTO=$S(SRFIND:$E(Y,SRFIND-3,SRFIND+1),1:"")
 S:SRTI="" (SRTI,SRET)="-"
PRINT ; print information
 W !!,SRSDATE,?9,SRNM,?35,SROPS(1),?87,$E(SCRUB(1),1,18),?106,$E(CIRC(1),1,18),?125,SRTI
 W !,SRTN,?9,VA("PID") W:$D(SROPS(2)) ?35,SROPS(2) W:$D(SCRUB(2)) ?87,$E(SCRUB(2),1,18) W:$D(CIRC(2)) ?106,$E(CIRC(2),1,18) W ?125,SRTO
 W ! W:$D(SROPS(3)) ?35,SROPS(3) W:$D(SCRUB(3)) ?87,$E(SCRUB(3),1,18) W:$D(CIRC(3)) ?106,$E(CIRC(3),1,18) W ?126,SRET
 S MORE=4 I $D(SROPS(4)) S MORE=5 W !,?35,SROPS(4) W:$D(SCRUB(4)) ?87,$E(SCRUB(4),1,18) W:$D(CIRC(4)) ?106,$E(CIRC(4),1,18)
 F I=MORE:1:10 I $D(SCRUB(I))!$D(CIRC(I)) W ! W:$D(SCRUB(I)) ?87,$E(SCRUB(I),1,18) W:$D(CIRC(I)) ?106,$E(CIRC(I),1,18)
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?120,"PAGE: "_PAGE,!,?58,"SURGICAL SERVICE",?100,"REVIEWED BY:"
 W !,?49,"CIRCULATING NURSE STAFFING REPORT",?100,"DATE REVIEWED:"
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,SRPRINT
 W !!,"DATE",?11,"PATIENT",?40,"OPERATION(S)",?87,"SCRUB NURSE",?106,"CIRC. NURSE",?122,"TIME IN",!,"CASE #",?13,"ID#",?122,"TIME OUT",!,?118,"ELAPSED (MINS)",! F I=1:1:132 W "="
 S PAGE=PAGE+1 I $D(NURSE) S SRN=0 D NUR
 Q
BEG ; entry when queued
 U IO K ^TMP("SR",$J) S SRSOUT=0,PAGE=1,SRSDT=SRSD-.0001,SREDT=SRED+.9999,SRINST=SRSITE("SITE")
 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:(SRSDT>SREDT)!'SRSDT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$P($G(^SRF(SRTN,.2)),"^",12)'="",$$DIV^SROUTL0(SRTN) D
 .S NURSE=0 F  S NURSE=$O(^SRF(SRTN,19,NURSE)) Q:'NURSE  D UTL
 K NURSE D HDR S NURSE=0
 F  S NURSE=$O(^TMP("SR",$J,NURSE)) Q:NURSE=""!SRSOUT  S SRN=0 D NUR S SRSDT=0 F  S SRSDT=$O(^TMP("SR",$J,NURSE,SRSDT)) Q:'SRSDT!(SRSOUT)  D SRTN
 I '$D(^TMP("SR",$J)) W $$NODATA^SROUTL0()
 Q
NUR D:$Y+7>IOSL PAGE Q:SRSOUT  I 'SRN W !!,?(132-$L("** "_NURSE_" **")\2),"** "_NURSE_" **" S SRN=1
 Q
SRTN ; continue looping
 S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,NURSE,SRSDT,SRTN)) Q:'SRTN!(SRSOUT)  D SET
 Q
PAGE I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 D HDR
 Q
LOOP ; break procedure if greater than 50 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<50  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OP,0),"^"))>250 S SRLONG=0,OP=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OP,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
UTL ; set ^TMP(
 S SRNUR=$P(^SRF(SRTN,19,NURSE,0),"^"),SRNUR=$P(^VA(200,SRNUR,0),"^")
 S ^TMP("SR",$J,SRNUR,SRSDT,SRTN)=""
 Q
