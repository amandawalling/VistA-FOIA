DVBACRRP ;ALB/GTS-557/THM-REPRINT 21-DAY CERT FOR MAS ;21 JUL 89
 ;;2.7;AMIE;;Apr 10, 1995
 D INIT
 I 'CONT G KIL
 S DVBSEL=$$SELECT^DVBAUTL5("Original Processing Date","21 Day Certificate")
 I DVBSEL="D" S SDATE=$$DATE() G:SDATE<0 KIL
 I DVBSEL="N" S XDA=$$PAT^DVBAUTL5("MAS") G:XDA<1 KIL
 I DVBSEL=0 G KIL
 D DEVICE
 I 'CONT G KIL
 D DATA
 ;
KIL D KILL
 Q
 ;
DATA ;
 I DVBSEL="D" DO
 .U IO
 .S NAME=""
 .F J=0:0 S NAME=$O(^DVB(396,"B",NAME)) Q:NAME=""  F XDA=0:0 S XDA=$O(^DVB(396,"B",NAME,XDA)) Q:XDA=""  I $P(^DVB(396,XDA,0),U,14)=SDATE S DFN=$P(^(0),U,1) D CREATE
 .Q
 I DVBSEL="N" DO
 .S DFN=$P(^DVB(396,XDA,0),U,1)
 .D CREATE
 .Q
 I NODTA=0 DO
 .S VAR(1,0)="0,0,0,2:2,0^No data found to reprint"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 Q
 ;
KILL K %DT(0),SDATE,DVBAON2,DVBSEL,VAR,CONT
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 D KILL^DVBAUTIL
 Q
 ;
CREATE ;CERTIFICATE CREATE
 Q:'$D(^DVB(396,XDA,4))
 I $D(^DVB(396,XDA,2)) Q:$P(^(2),U,10)="L"
 I '$D(^DPT(DFN,0)) W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 I '$D(^DPT(DFN,0)) W !!,"Patient record missing for DFN ",DFN,!!
 I '$D(^DPT(DFN,0)) S DVBAON2="" Q
 S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown")
 S WARD=$P(^DVB(396,XDA,4),U,6),BED=$P(^(4),U,7),DCHGDT=$P(^(4),U,5),ADMDT=$P(^(0),U,4)
 U IO W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !,FDT(0),?32,"REPORT OF CONTACT",!,?31,"21-DAY CERTIFICATE",?(80-11),"PAGE: 1",!,?(80-$L(HD1)\2),HD1,!!!!!!!,"Patient name: ",?16,PNAM,!,?9,"SSN: ",?16,SSN,?33,"Claim #: ",?43,CNUM,!!,?9,"Ward: ",?16,WARD,?30,"Bed: ",?36,BED,!!!
 W "     The patient above has been hospitalized for 21 consecutive days ",!,"from " S Y=ADMDT X ^DD("DD") W Y," to " S Y=DCHGDT X ^DD("DD") W Y,", and the major diagnosis for",!,"this period is:",!!!!!!!!!!!!!!!!!!!!
 W "Physician signature: " F LINE=$X:1:80 W "_"
 W !!!,"        Approved by: " F LINE=$X:1:65 W "_"
 W !!?5,"R0C  119",!
 S NODTA=1
 S DVBAON2=""
 Q
 ;
INIT ;
 K ^TMP($J)
 S CONT=1,NODTA=0,HD="21-DAY CERTIFICATE REPRINTING"
 D HOME^%ZIS
 D NOPARM^DVBAUTL2
 I $D(DVBAQUIT) S CONT=0 Q
 S HD1=$$SITE^DVBCUTL4()
 I '$D(DT) S X="T" D ^%DT S DT=Y
 S Y=DT X ^DD("DD") S FDT(0)=Y
 S VAR(1,0)="0,0,(IOM-$L(HD)\2),1:3,1:0^"_HD
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
 ;
DATE() ;THis function returns a date of the original request from the user.
 S %DT(0)=-DT
 S %DT("A")="Enter ORIGINAL PROCESSING DATE: ",%DT="AEQ"
 D ^%DT
 K %DT
 Q Y
 ;
DEVICE ;
 S VAR(1,0)="0,0,0,2:0,0^"
 D WR^DVBAUTL4("VAR")
 K VAR
 S %ZIS="AEQ"
 D ^%ZIS K %ZIS
 I POP S CONT=0 Q
 I $D(IO("Q")) DO
 .S CONT=0
 .S ZTIO=ION,ZTDESC="21-day Cert reprint",ZTRTN="DATA^DVBACRRP"
 .F I="XDA","DVBSEL","FDT(0)","HD","HD1","SDATE","NODTA" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .D ^%ZISC
 .I $D(ZTSK) DO
 ..S VAR(1,0)="0,0,0,2:2,0^Request queued."
 ..D WR^DVBAUTL4("VAR")
 ..K VAR
 ..Q
 .Q
 Q
