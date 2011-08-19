PRCAREP ;SF-ISC/YJK-CREATE REPAYMENT DATE SCHEDULE ;10/15/93  9:47 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This sets up repayment schedule for A/R.
BEGIN K DIC
EN W !! D BILL^PRCAUTL G:('$D(PRCABN)) END I +PRCA("STATUS")>0,$P(^PRCA(430.3,PRCA("STATUS"),0),U,3)'=102 W !,*7,"NOT AN ACTIVE ACCOUNT !" G EN
 I $D(^PRCA(430,PRCABN,5)) W *7,!,"THIS ACCOUNT ALREADY HAS A REPAYMENT PLAN !",!
 S PRCAPB=$S($D(^PRCA(430,PRCABN,7)):$P(^(7),U,1)+$P(^(7),U,2)+$P(^(7),U,3)+$P(^(7),U,4)+$P(^(7),U,5),1:$P(^(0),U,3)),PRCAMT=0
 S PRCADT="" D DIE G:PRCA("LOCK")=1 EN I (+PRCADT>0)&(+PRCAMT>0) D SET G EN
 I '$D(^PRCA(430,PRCABN,4)) W !,"NO REPAYMENT PLAN!",*7 K ^PRCA(430,PRCABN,5) G EN
 I $P(^PRCA(430,PRCABN,4),U,1)="" W *7,!,"NO REPAYMENT PLAN !" K ^PRCA(430,PRCABN,5) G EN
 W !,"NOTHING CHANGED !",! G EN
 ;
DIE S DIC="^PRCA(430,",DIE=DIC,DA=PRCABN,DR="41;S PRCADT=X;42;S PRCADAY=X;43;S PRCAMT=X" S PRCA("LOCK")=0 D LOCKF^PRCAWO1 D:PRCA("LOCK")=0 ^DIE
 K DIE,DR L -^PRCA(430,+$G(PRCABN)) Q  ;end of DIE
SET S PRCANPAY=PRCAPB/PRCAMT,PRCANPAY=$S(PRCANPAY>(PRCAPB\PRCAMT):PRCAPB\PRCAMT+1,1:PRCAPB\PRCAMT)
 W !!,"NUMBER OF PAYMENTS WILL BE ",PRCANPAY,! I PRCANPAY>60 W !,*7,"THIS NUMBER SHOULD BE LESS THAN 60 !, CHECK THE INPUT AGAIN",! Q
 S %DT="AEFX",%DT("A")="DUE DATE OF 1ST PAYMENT: " D ^%DT K %DT
 I Y<0 W !,*7,"NOTHING CHANGED !" Q
 K ^PRCA(430,PRCABN,5) S PRCAYR=$E(Y,1,3),PRCAMON=$E(Y,4,5) S:$L(PRCADAY)=1 PRCADAY="0"_PRCADAY D HOLD^PRCAUT1
 F Z0=1:1:PRCANPAY S Z1=PRCAYR_$S((PRCAMON<10&($E(PRCAMON,1)'=0)):0_PRCAMON,1:PRCAMON)_PRCADAY,^PRCA(430,DA,5,Z0,0)=Z1_U_"0",PRCAMON=PRCAMON+1 S:PRCAMON=13 PRCAMON=1,PRCAYR=PRCAYR+1
 S ^PRCA(430,DA,5,0)="^430.051DA^"_PRCANPAY_"^"_PRCANPAY,$P(^PRCA(430,DA,4),U,4)=PRCANPAY
 S PRCAKTY=$O(^PRCA(430.3,"AC",16,"")) D TRAN,IXDIK S $P(^PRCA(433,PRCAEN,0),U,4)=2
 W !!,"THE REPAYMENT PLAN HAS BEEN ESTABLISHED.",!
EXIT K PRCAKTY,PRCAMON,PRCAYR,PRCANPAY,DA1,DIK,DA Q  ;end of SET
IXDIK S DIK="^PRCA(430,"_PRCABN_",5,",DA(1)=PRCABN D IXALL^DIK K DIK Q
TRAN S PRCAEN=-1 D SETTR^PRCAUTL Q:PRCAEN<0  S DA=PRCAEN
 S DIE="^PRCA(433,",DR=".03////"_PRCABN_";11///"_PRCADT_";12///"_PRCAKTY_";15///"_PRCAPB_"" D ^DIE
 K DIE,DR,PRCADT Q
END K PRCAS,PRCAMT,PRCA,PRCAKTY,PRCADT,DA,DIE,PRCAYR,PRCAMON,PRCANPAY,DR,PRCAEN,PRCABN,PRCAPB,Z0,PRCADAY,DIC,PRCAS,PRCATY D KVAR^VADPT Q  ;end of PRCAREP
PROFILE ;print the repayment plan profile.
 K %ZIS,DXS,IOP
 D BILL^PRCAUTL G:'$D(PRCABN) END
 S %ZIS="Q" D ^%ZIS Q:POP  S IOM=80,PRCAIO=IO,PRCAIO(0)=IO(0)
 I IO=IO(0) W:$D(IOF) @IOF D TR,CLOSE K PRCAIO,PRCATY G PROFILE
 I $D(IO("Q")) K IO("Q") S ZTRTN="TR^PRCAREP",ZTSAVE("PRCABN")=PRCABN,ZTSAVE("PRCAIO(0)")=PRCAIO(0),ZTSAVE("PRCAIO")=PRCAIO,ZTDESC="Repayment Plan Profile"
 I  D ^%ZTLOAD,CLOSE W:(IOM-$X)<20 ! W "   <REQUEST QUEUED>",*7,! K PRCA,PRCATY G PROFILE
 U IO D TR,CLOSE G PROFILE
TR S D0=PRCABN K DXS D ^PRCATR1 K DXS W !! K PRCABN,PRCAKTY,PRCA Q
CLOSE D ^%ZISC K IOP,%ZIS,PRCAIO Q
