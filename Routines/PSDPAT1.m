PSDPAT1 ;B'ham ISC/JPW,BJW - Prt activity report (Patient/Drug) ; 17 Apr 98
 ;;3.0; CONTROLLED SUBSTANCES ;**7,62,68**;13 Feb 97;Build 12
 ;modified for nois:det-0198-42285;displays drugs for destruction,returns,waste,transfers
START ;entry for compile and print
 K ^TMP("PSDPAT",$J),^TMP("PSDPAT1",$J),^TMP("PSDPATB",$J),^TMP("PSDPATL",$J) S (PSDAQTY,PSDCNT)=0,PSDNAOU=NAOU
 I $D(ALL) F PSDR=0:0 S PSDR=$O(^PSD(58.8,+PSDNAOU,1,PSDR)) Q:'PSDR  I $D(^PSD(58.8,+PSDNAOU,1,+PSDR,0)) S PSDRG(+PSDR)=+$P(^(0),U,4)
 F PSDR=0:0 S PSDR=$O(PSDRG(PSDR)) Q:'PSDR  D
 .F PSD=PSDSD:0 S PSD=$O(^PSD(58.81,"ACT",PSD)) Q:'PSD  D
 ..S PSD58=0  F  S PSD58=$O(^PSD(58.81,"ACT",PSD,PSD58)) Q:'PSD58  D
 ...F PSDTYP=0:0 S PSDTYP=$O(^PSD(58.81,"ACT",PSD,PSD58,PSDR,PSDTYP)) Q:'PSDTYP  D
 ....F PSDA=0:0 S PSDA=$O(^PSD(58.81,"ACT",PSD,PSD58,PSDR,PSDTYP,PSDA)) Q:'PSDA  I $P(^PSD(58.81,PSDA,0),U,18)=PSDNAOU!($P(^PSD(58.81,PSDA,0),U,3)=PSDNAOU) D
 .....D CHK2
 .....Q:$G(PSDSTOP)
 .....S PSDEND=0 I PSD>PSDED S PSDEND=1
 .....S ^TMP("PSDPAT1",$J,PSDR,PSDA)=PSDEND
 F PSDR=0:0 S PSDR=$O(PSDRG(PSDR)) Q:'PSDR  F PSDA=0:0 S PSDA=$O(^PSD(58.8,+PSDNAOU,1,PSDR,3,PSDA)) Q:'PSDA  D
 .Q:'$D(^PSD(58.8,PSDNAOU,1,PSDR,3,PSDA,0))  S PSD0=^(0),PSD=$P(PSD0,U,15)
 .I (PSD>PSDSD) D
 ..S PSDEND=0 I PSD>PSDED S PSDEND=1
 ..S PSDTR=+$P($G(PSD0),U,17),PSDTYP=$P(^PSD(58.81,PSDTR,0),U,2),PSDSTOP=0 I PSDTYP'=23 D CHK2
 ..Q:$G(PSDSTOP)
 ..S ^TMP("PSDPAT1",$J,PSDR,PSDTR)=PSDEND
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.81,"ATRN",PSD)) Q:'PSD!(PSD>PSDED)  D
 .F PSDA=0:0 S PSDA=$O(^PSD(58.81,"ATRN",PSD,PSDA)) Q:'PSDA  D
 ..S PSD0=^PSD(58.81,PSDA,0) Q:$P(PSD0,U,18)'=NAOU!('$D(PSDRG($P(PSD0,U,5))))  D
 ...S PSDEND=0 I PSD>PSDED S PSDEND=1
 ...S:PSDRG($P(PSD0,U,5)) ^TMP("PSDPAT1",$J,$P(PSD0,U,5),PSDA)=PSDEND
 S PSDRUG=0 F  S PSDRUG=$O(^TMP("PSDPAT1",$J,PSDRUG)) Q:'PSDRUG  D
 .S (PSDNBAL,PSDA)=0 F  S PSDA=$O(^TMP("PSDPAT1",$J,PSDRUG,PSDA)) Q:'PSDA  D  D PSDPATB^PSDPAT2
 ..;S PSD0=$G(^PSD(58.81,PSDA,0)),PSDTYP=$P(PSD0,U,2),PSD=$P(PSD0,U,4),PSDRQ="" Q:$P(PSD0,U,11)=3!($P(PSD0,U,2)=12)
  ..S PSD0=$G(^PSD(58.81,PSDA,0)),PSDTYP=$P(PSD0,U,2),PSD=$P(PSD0,U,4),PSDRQ=""
 ..S PSDRN=$S($P($G(^PSDRUG(+PSDRUG,0)),U)]"":$P(^(0),U),1:"ZZ/"_PSDRUG_" NAME MISSING")
 ..Q:$P(PSD0,U,11)=3!($P(PSD0,U,2)=12)
 ..S PSDSTOP=0 I PSDTYP'=23 D CHK2
 ..Q:$G(PSDSTOP)
 ..S PSDEND=$G(^TMP("PSDPAT1",$J,PSDRUG,PSDA))
 ..I PSDTYP'=17 S PSDRQ=$P(^PSD(58.81,PSDA,0),U,20) S:$G(PSDRQ) PSD0=$G(^PSD(58.8,PSDNAOU,1,PSDRUG,3,PSDRQ,0))
 ..I '$G(PSDRQ) D  Q
 ...S PSDBAL=$P(PSD0,U,10)
 ...D SET^PSDPAT2 Q
 ..I $G(PSDRQ) D  Q
 ...S PSD=$P(PSD0,U,15)
 ...Q:'$G(PSD)
 ...S PSDNR1=+$P(PSD0,U,4),PSDNR2="",PSDQTY=+$P(PSD0,U,20),PSDBAL=$P(PSD0,U,22),PSDPAT="PHARMACY DISP #"_$P(PSD0,U,16)
 ...S PSDRN=$S($P($G(^PSDRUG(+PSDRUG,0)),U)]"":$P(^(0),U),1:"ZZ/"_PSDRUG_" NAME MISSING") S PSDTR=+$P($G(PSD0),U,17)
 ...I (PSDTYP=18)!(PSDTYP=17) S $P(PSDRG(+PSDRUG),U,2)=+$P(PSDRG(+PSDRUG),U,2)+PSDQTY
 ...S PSDNR1=$S($P($G(^VA(200,PSDNR1,0)),U)]"":$P(^(0),U),1:"UNKNOWN")
 ...S (PSDWQT,PSDWRE,PSDRQT,PSDRRE,PSDDRG1,PSDSOQT,PSDDQT,PSDDRE,PSDRET,PSDDT)="",PSD9="",$P(PSD0,U,16)="",PSDTYP=0
 ...S PSD3=$G(^PSD(58.81,PSDA,3)) S PSDRET=+$P(PSD3,U),PSDRQT=+$P(PSD3,U,2),PSDRRE=$P(PSD3,U,3),PSDDQT=+$P(PSD3,U,5),PSDDRE=$P(PSD3,U,6),PSDDT=+$P(PSD3,U,4)
 ...I $P(^PSD(58.81,PSDA,0),U,2)=9 S PSDTYP=9
 ...I $P(^PSD(58.81,PSDA,0),U,2)=5 S PSDTYP=5 D SET2^PSDPAT2 Q
 ...S $P(PSD0,U,10)=$P(PSD0,U,22) D SET1^PSDPAT2
 F  S PSDR=$O(PSDRG(PSDR)) Q:'PSDR  I $G(PSDRG(PSDR))  S PSDRN=$S($P($G(^PSDRUG(+PSDR,0)),U)]"":$P(^(0),U),1:"ZZ/"_PSDR_" NAME MISSING") D:'$D(^TMP("PSDPAT",$J,PSDRN))
 .S ^TMP("PSDPAT",$J,PSDRN,DT,"NO ACTIVITY",1)=0,^TMP("PSDPATL",$J,PSDRN)=U_PSDRG(PSDR)
PRINT ;prints data
 I SUM="S" D ^PSDPAT2 G DONE
 S (PG,PSDOUT,PSDAQTY)=0,PSDRN="",$P(LN,"-",132)="" D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S PSDRPDT=Y
 I '$D(^TMP("PSDPAT",$J)) D HDR W !!,?15,"**** NO DISPENSING ACTIVITY ****",!! G DONE
 D HDR S PSDRG="" F  S PSDRG=$O(^TMP("PSDPAT",$J,PSDRG)) Q:PSDRG=""!(PSDOUT)  W !,?5,"=> ",PSDRG,! D CHK F PSD=0:0 S PSD=$O(^TMP("PSDPAT",$J,PSDRG,PSD)) D:'PSD TOT Q:PSD=""!(PSDOUT)  D  Q:PSDOUT
 .S PSDPAT="" F  S PSDPAT=$O(^TMP("PSDPAT",$J,PSDRG,PSD,PSDPAT)) Q:PSDPAT=""!(PSDOUT)  F PSD1=0:0 S PSD1=$O(^TMP("PSDPAT",$J,PSDRG,PSD,PSDPAT,PSD1)) Q:'PSD1!(PSDOUT)  D  Q:PSDOUT
 ..S (PSDQTY,PSDSOQT,PSDRQT,PSDWQT,PSDDQT,PSDSTAT)=0,(PSDRRE,PSDWRE,PSDDRE)=""
 ..S PSD0=^TMP("PSDPAT",$J,PSDRG,PSD,PSDPAT,PSD1),PSDRGN=PSDRG
 ..Q:$P(PSD0,U,4)=3
 ..W ! I $Y+8>IOSL D HDR Q:PSDOUT  W !,?5,"=> ",PSDRG,!
 ..S Y=+$E(PSD,1,12) X ^DD("DD") S PSDT=Y
 ..I $G(PSD0)=0 S PSDQTY=0,PSDPQT=$P(^TMP("PSDPATL",$J,PSDRGN),U,2) W PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),! Q
 ..S PSDTYP=+$P(PSD0,U,4),PSDR=$P(PSD0,U,11),PSDSTAT=+$P(PSD0,U,24),PSDQTY=+$P(PSD0,U)
 ..I (PSDTYP)=9 S PSDPQT=+PSDNBAL+PSDQTY,PSDNBAL=PSDPQT W PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),!,?98,$P(PSD0,U,3),!,?25,$P(PSD0,U,6),!
 ..I PSDTYP=11 S PSDPQT=+PSDNBAL+PSDQTY,PSDNBAL=PSDPQT W PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),!,?98,$P(PSD0,U,3),!
 ..I (+$P(PSD0,U,9)) S PSDRQT=+$P(PSD0,U,9)
 ..I PSDTYP=17 S PSDSOQT=+$P(PSD0,U,12),PSDNBAL=+(PSDNBAL-PSDSOQT)+PSDRQT D
 ...W PSDT,?22,PSDPAT,?54 W:PSDTYP=17 "-" W $J(PSDSOQT,6)
 ...W ?75,$J(PSDNBAL,6),?98,$P(PSD0,U,2),! W:$P(PSD0,U,3)'="" ?98,$P(PSD0,U,3),!
 ...W PSDT,?22,PSDPAT,?45,"*GIVEN*" S PSDQTY=PSDSOQT-PSDRQT W ?55,$J(PSDQTY,6),!
 ...I PSDRQT S PSDPRT=1 D PRTRET
 ..I +$P(PSD0,U,5) S PSDWQT=+$P(PSD0,U,5),PSDWRE=$P(PSD0,U,6),PSDQTY=PSDQTY-PSDWQT D
 ...W PSDT,?22,PSDPAT,?45,"*WASTED*",?55,$J(PSDWQT,6)
 ...W ?98,$P(PSD0,U,2),!,?25,PSDWRE,?98,$P(PSD0,U,3),!
 ..I PSDTYP=23 S PSDPQT=+PSDNBAL+PSDQTY,PSDNBAL=PSDPQT W PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),!,?98,$P(PSD0,U,3),!
 ..I PSDTYP=0,'$G(PSDSTAT) D
 ...S PSDPQT=+PSDNBAL+PSDQTY,PSDNBAL=PSDPQT W PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),! I $P(PSD0,U,3)'="" W ?98,$P(PSD0,U,3),!
 ...S PSDRQT=+$P(PSD0,U,9),PSDPRT=0 I $G(PSDRQT) D PRTRET
 ..I PSDTYP=0,$G(PSDSTAT)=10 D
 ...S PSDPQT=+PSDNBAL+$P(PSD0,U),PSDNBAL=PSDPQT
 ...W:$P(PSD0,U)'=0 PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),!,?98,$P(PSD0,U,3),!  ; < *62 RJS
 ... S PSDTFDT=$P(PSD0,U,17),Y=PSDTFDT X ^DD("DD") S PSDTFDT=$E(Y,1,17),PSDTFN=$P(PSD0,U,18),PSDT2N=$P(PSD0,U,19),PSDTTDT=$P(PSD0,U,20)
 ...S PSDTTNR=$P(PSD0,U,21),PSDTRQT=+$P(PSD0,U,23),PSDNBAL=+PSDNBAL-PSDTRQT D PRTTRT
 ..I PSDTYP=5,'$G(PSDSTAT) S PSDPQT=+PSDNBAL+PSDQTY,PSDNBAL=PSDPQT D
 ...W PSDT,?22,PSDPAT,?45,"*TRFER*",?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),! I $P(PSD0,U,3)'="" W ?98,$P(PSD0,U,3),!
 ...W ?29,"*TRANSFERED FROM "_$P(PSD0,U,19),"*",?98,$P(PSD0,U,21),!
 ...S PSDRQT=+$P(PSD0,U,9) I $G(PSDRQT) D
 ....S PSDRRE=$P(PSD0,U,10),PSDNBAL=+PSDNBAL-PSDRQT,PSDRET=$P(PSD0,U,15),Y=PSDRET X ^DD("DD") S PSDRET=$E(Y,1,17)
 ....S:$G(PSDRET)=0 PSDRET="" W !,PSDRET,?22,PSDPAT,?45,"*RETURN* -",?55,$J(PSDRQT,6),?75,$J(PSDNBAL,6),?98,$P(PSD0,U,2),!,?25,PSDRRE,?98,!
 ..I +$P(PSD0,U,13) S PSDDQT=+$P(PSD0,U,13),PSDDRE=$P(PSD0,U,14),PSDDT=+$P(PSD0,U,16),PSDNBAL=PSDNBAL-PSDDQT D
 ...W PSDT,?22,PSDPAT,?44,"*DESTROY* -",?55,$J(PSDDQT,6),?75,$J(PSDNBAL,6),?98,$P(PSD0,U,2),!,?25,PSDDRE,?98,$P(PSD0,U,3),!
 ..I PSDTYP=5,$G(PSDSTAT)=10 D
 ...S PSDPQT=+PSDNBAL+$P(PSD0,U)-$P(PSD0,U,23),PSDNBAL=PSDPQT
 ...W:$P(PSD0,U)'="" PSDT,?22,PSDPAT,?55,$J(PSDQTY,6),?75,$J(PSDPQT,6),?98,$P(PSD0,U,2),!,?98,$P(PSD0,U,3),!  ; < *62 RJS
 ... S PSDTFDT=$P(PSD0,U,17),Y=PSDTFDT X ^DD("DD") S PSDTFDT=$E(Y,1,17),PSDTFN=$P(PSD0,U,18),PSDT2N=$P(PSD0,U,19),PSDTTDT=$P(PSD0,U,20)
 ...S PSDTTNR=$P(PSD0,U,21),PSDTRQT=+$P(PSD0,U,23) D PRTTRT
 ..I PSDTYP=99,+$P(PSD0,U,9)'=0 D
 ...S PSDRQT=+$P(PSD0,U,9),PSDNBAL=+PSDNBAL-PSDRQT D PRTRET
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 D KVAR^VADPT K VA,%,%DT,%H,%I,%ZIS,ALL,PSDAQTY,PSDBAL,PSDCNT,DA,PSDT,PSDDT,DFN,DIC,DIR,DIROUT,DIRUT,PSDDQT,DTOUT,PSDDRE,PSDDRG1,DUOUT,LN,LOOP,PSDNAOU,NAOU,NAOUN,PSDNBAL,PSD0,PSD3,PSD7,PSD9,PSDNR1,PSDSTOP
 K PSDNR2,PSDSTAT,PSDPAT,PG,POP,PSD,PSD1,PSDA,PSDATE,PSDED,PSDOUT,PSDPN,PSDPQT,PSDR,PSDRET,PSDRG,PSDRGN,PSDRN,PSDSD,PSDRQT,PSDRRE,PSDRPDT,PSDSOQT,PSD58,PSDRQ,PSDRUG,PSDTBAL,PSDTMP,PSDEND,PSDT2N,PSDTFDT,PSDPRT
 K PSDTFN,PSDTPRV,PSDTRQT,PSDTTDT,PSDTTNR,PSDTTON,PSDTQTY,PSDTYP,PSDQTY,SUM,PSDUQT,VADM,VAERR,PSDWQT,PSDWRE,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP("PSDPAT",$J),^TMP("PSDPAT1",$J),^TMP("PSDPATB",$J),^TMP("PSDPATL",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRTTRT ; PRINT TRANSFER TO INFORMATION
 W PSDTFDT,?22,PSDPAT,?45,"*TRFER* -",?55,$J(PSDTRQT,6),?75,$J(PSDNBAL,6),?98,$P(PSD0,U,18),!,?32,"*TRANSFER TO "_$P(PSD0,U,19),"*",?98,$P(PSD0,U,21),!
 Q
PRTRET ; PRINT RETURN INFORMATION
 S PSDRRE=$P(PSD0,U,10),PSDRET=$P(PSD0,U,15),Y=PSDRET X ^DD("DD") S PSDRET=$E(Y,1,17)
 S:$G(PSDRET)=0 PSDRET="",PSDNBAL=+PSDNBAL-PSDRQT
 W PSDRET,?22,PSDPAT,?45,"*RETURN*" W:'$G(PSDPRT) " -" W ?55,$J(PSDRQT,6) W:'$G(PSDPRT) ?75,$J(PSDNBAL,6)
 W ?98,$P(PSD0,U,2),!,?25,PSDRRE,?98,$P(PSD0,U,3),!
 K PSDPRT
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?20,"Activity Report for ",NAOUN,?55,PSDRPDT,?115,"Page: ",PG,!,?20,"Date: ",$P(PSDATE,U)," to ",$P(PSDATE,U,2),!!
 W ?5,"=>  DRUG",!,"DATE/TIME",?22,"PATIENT",?55,"QUANTITY",?75,"BALANCE",?98,"NURSE 1",!,?98,"NURSE2",!,LN,!!
 Q
CHK ;sets total qty used and balance
 S PSDTQTY=+$G(^TMP("PSDPATL",$J,PSDRG)),PSDBAL=+$P($G(^TMP("PSDPATL",$J,PSDRG)),U,2),PSDUQT=PSDBAL-PSDTQTY,PSDNBAL=$P($G(^TMP("PSDPATB",$J,PSDRG)),U,2)-$P($G(^TMP("PSDPATB",$J,PSDRG)),U,1)
 Q
CHK2 ;CHECK THE TTYPE
 S PSDSTOP=0 I PSDTYP'=23 D
 .I '$D(^PSD(58.81,PSDA,1)) D
 ..I PSDTYP'=17 S PSDSTOP=1
 ..I PSDTYP=9 S PSDSTOP=0
 Q
TOT ;prints total qty used and balance
 I $Y+4>IOSL D HDR Q:PSDOUT  W !,?5,"=> ",$S(PSDRG]"":PSDRG,1:PSDRGN),!
 ;W !,?55,"----------",?75,"----------",!,?5,"Total Quantity Used and Balance",?55,$J(PSDAQTY,6),?70,$J(PSDPQT,6),!
 W ! S PSDAQTY=0
 Q
