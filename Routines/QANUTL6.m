QANUTL6 ;HISC/GJC-DATA INQUIRY FOR PATIENT/INCIDENT ;2/3/92
 ;;2.0;Incident Reporting;**12**;08/07/1992
 ;
 K DIC,DO,DINUM,DLAYGO,^UTILITY("DIQ1",$J)
 S QANTAB=$S(IOM=132:133,1:81),$P(QANLINE,"*",QANTAB)=""
 S DIC="^QA(742,",DIC(0)="QEAMZ",DIC("A")="Select Patient: ",D="B^BS5"
 S DIC("W")="D DICW^QANUTL6" D MIX^DIC1 K DIC,DO,DINUM,DLAYGO
 I +Y'>0 D KILL Q
 S QANDFN=+Y,QAN742=$G(^QA(742,QANDFN,0))
 S QANIEN=$P(QAN742,U,3),QAN7424=$G(^QA(742.4,QANIEN,0))
 S QANHEAD(0)="PATIENT/INCIDENT DATA INQUIRY REPORT"
 S Y=$P(QAN742,U),C=$P(^DD(742,.01,0),U,2) D:Y]"" Y^DIQ S QANPAT=Y
 S Y=$P(QAN7424,U,2),C=$P(^DD(742.4,.02,0),U,2) D:Y]"" Y^DIQ S QANINCD=Y
 S Y=$P(QAN7424,U,3) D D^DIQ S QANDATE=Y
 S QANHEAD(1)="For Patient: "_QANPAT
 S QANHEAD(2)="Incident: "_QANINCD_" On Date: "_QANDATE
 ;Patient data
 S DIC="^QA(742,",DR=".01:.11;.13;.14",DA=QANDFN,DIQ(0)="E" D EN^DIQ1
 I $D(^QA(742,QANDFN,1,0)) D RSERV
 I $D(^QA(742,QANDFN,2,0)) D IRDIAG
 ;Incident data
 S DIC="^QA(742.4,",DR=".02:.15;.17:.22",DA=QANIEN,DIQ(0)="E" D EN^DIQ1
 I $D(^QA(742.4,QANIEN,2,0)) D MEDCNTR
 K DIC,DA,DR,DIQ
TASK ;Call to %ZTLOAD.
 S Y=DT X ^DD("DD") S TODAY=Y,(PAGE,QANQUIT)=0
 K IOP,%ZIS S %ZIS("A")="Print on device: ",%ZIS="MQ" W ! D ^%ZIS W !!
 G:POP KILL
 I $D(IO("Q")) S ZTRTN="START^QANUTL6",ZTDESC="Patient/Incident Data Inquiry Report." D QLOOP,^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!"),! G EXIT
START ;IO requests
 U IO D HDR,EN1^QANUTL7
EXIT ;
 W ! D ^%ZISC,HOME^%ZIS
KILL ;Kill and quit.
 K %ZIS,C,D,DA,DIC,DIQ,DR,IW,PAGE,POP,QAN742,QAN7424,QANDATE,QANDFN
 K QANHEAD,QANIEN,QANINCD,QANLINE,QANPAT,QANTAB,TODAY,X,Y,ZTDESC,ZTRTN
 K QANX,QANY,QANZ,QANDD,QANQUIT,QANUTIL,ZTSK,%W,D0,DIQ2,QANCASE,QANW
 K QAHDNM,QAHDSSN,QAHOLD,^UTILITY("DIQ1",$J)
 Q
DICW ;Data display on lookups.
 S QANIEN=$P(^QA(742,+Y,0),U,3),QAN7424=$G(^QA(742.4,QANIEN,0))
 N Y S Y=$P(QAN7424,U,3) D D^DIQ S QANDATE=Y,Y=$P(QAN7424,U,2)
 S C=$P(^DD(742.4,.02,0),U,2) D:Y]"" Y^DIQ S QANINCD=Y
 S QANCASE=$P(QAN7424,U)
 W " "_QANINCD_" "_QANDATE_" "_QANCASE
 Q
HDR ;Header
 S PAGE=PAGE+1 W @IOF,!?69,TODAY,!?69,"Page: ",PAGE,!!
 W ?(IOM-$L(QANHEAD(0))\2),QANHEAD(0),!,?(IOM-$L(QANHEAD(1))\2),QANHEAD(1),!
 W !?(IOM-$L(QANHEAD(2))\2),QANHEAD(2),!!
 F IW=1:1:2 W QANLINE,!
 Q
IRDIAG ;Data for Incident Related Diagnosis
 F DA=0:0 S DIC="^QA(742,"_QANDFN_",2,",DR=.01,DA(1)=QANDFN,DIQ(0)="E",DA=$O(^QA(742,QANDFN,2,DA)) Q:DA'>0  D EN^DIQ1
 Q
MEDCNTR ;Data for Medical Center Action
 F DA=0:0 S DIC="^QA(742.4,"_QANIEN_",2,",DR=.01,DA(1)=QANIEN,DIQ(0)="E",DA=$O(^QA(742.4,QANIEN,2,DA)) Q:DA'>0  D EN^DIQ1
 Q
RSERV ;Data for Responsible Service
 F DA=0:0 S DIC="^QA(742,"_QANDFN_",1,",DR=.01,DA(1)=QANDFN,DIQ(0)="E",DA=$O(^QA(742,QANDFN,1,DA)) Q:DA'>0  D EN^DIQ1
 Q
QLOOP ;Save variables.
 F IW="^UTILITY(""DIQ1"",$J,","PAGE","TODAY","QAN*" S ZTSAVE(IW)=""
 Q
