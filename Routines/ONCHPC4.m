ONCHPC4 ;Hines OIFO/GWB - 2000 Hepatocellular Cancers PCE Study ;01/10/00
 ;;2.11;ONCOLOGY;**26**;Mar 07, 1995
 ;First Course of Treatment 
 K TABLE,HTABLE
 S TABLE("29. DATE OF FIRST COURSE OF TREATMENT")="DFCT^ONCHPC4"
 S TABLE("30. DATE OF INPATIENT ADMISSION")="DIA^ONCHPC4"
 S TABLE("31. DATE OF INPATIENT DISCHARGE")="DID^ONCHPC4"
 S TABLE("SURGERY")="S^ONCHPC4"
 S TABLE("32. DATE OF NON CANCER-DIRECTED SURGERY")="DNCDS^ONCHPC4"
 S TABLE("33. NON CANCER-DIRECTED SURGERY")="NCDS^ONCHPC4"
 S TABLE("34. DATE OF CANCER-DIRECTED SURGERY")="DCDS^ONCHPC4"
 S TABLE("35. SURGICAL APPROACH")="SA^ONCHPC4"
 S TABLE("36. SURGERY OF PRIMARY SITE")="SPS^ONCHPC4"
 S TABLE("37. RADIO-FREQUENCY DESTRUCTION OF TUMOR")="RFDT^ONCHPC4"
 S TABLE("38. ABLATION & RESECTION")="AR^ONCHPC4"
 S TABLE("39. SURGICAL MARGINS")="SM^ONCHPC4"
 S TABLE("40. DISTANCE OF TUMOR TO CLOSEST MARGIN")="DTCM^ONCHPC4"
 S TABLE("41. SURGERY OF REGIONAL SITE(S), DISTANT SITE(S), OR DISTANT LYMPH NODE(S)")="SORS^ONCHPC4"
 S TABLE("42. SURGICAL TREATMENT OF RESIDUAL PRIMARY TUMOR")="STRPT^ONCHPC4"
 S TABLE("43. RECONSTRUCTION/RESTORATION-FIRST COURSE")="RR^ONCHPC4"
 S TABLE("RADIATION THERAPY")="R^ONCHPC4A"
 S TABLE("44. DATE RADIATION STARTED")="DRS^ONCHPC4A"
 S TABLE("45. RADIATION THERAPY")="RT^ONCHPC4A"
 S TABLE("CHEMOTHERAPY")="C^ONCHPC4A"
 S TABLE("46. DATE CHEMOTHERAPY STARTED")="DCS^ONCHPC4A"
 S TABLE("47. CHEMOTHERAPY")="CT^ONCHPC4A"
 S TABLE("48. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED")="TCAA^ONCHPC4A"
 S TABLE("49. ROUTE CHEMOTHERAPY ADMINISTERED")="RCA^ONCHPC4A"
 S TABLE("50. CHEMOTHERAPY/SURGERY SEQUENCE")="CSS^ONCHPC4A"
 S TABLE("OTHER THERAPY")="O^ONCHPC4A"
 S TABLE("51. DATE OTHER TREATMENT STARTED")="DOTS^ONCHPC4A"
 S TABLE("52. OTHER TREATMENT")="OT^ONCHPC4A"
 S TABLE("53. ARTERIAL EMBOLIZATION")="AE^ONCHPC4A"
 S TABLE("54. DEATH WITHIN30 DAYS OF START OF INTIIAL COURSE OF THERAPY")="DWTD^ONCHPC4A"
 S HTABLE(1)="29. DATE OF FIRST COURSE OF TREATMENT"
 S HTABLE(2)="30. DATE OF INPATIENT ADMISSION"
 S HTABLE(3)="31. DATE OF INPATIENT DISCHARGE"
 S HTABLE(4)=""
 S HTABLE(5)="SURGERY"
 S HTABLE(6)=""
 S HTABLE(7)="32. DATE OF NON CANCER-DIRECTED SURGERY"
 S HTABLE(8)="33. NON CANCER-DIRECTED SURGERY"
 S HTABLE(9)="34. DATE OF CANCER-DIRECTED SURGERY"
 S HTABLE(10)="35. SURGICAL APPROACH"
 S HTABLE(11)="36. SURGERY OF PRIMARY SITE"
 S HTABLE(12)="37. RADIO-FREQUENCY DESTRUCTION OF TUMOR"
 S HTABLE(13)="38. ABLATION & RESECTION"
 S HTABLE(14)="39. SURGICAL MARGINS"
 S HTABLE(15)="40. DISTANCE OF TUMOR TO CLOSEST MARGIN"
 S HTABLE(16)="41. SURGERY OF REGIONAL SITE(S), DISTANT SITE(S), OR DISTANT LYMPH NODE(S)"
 S HTABLE(17)="42. SURGICAL TREATMENT OF RESIDUAL PRIMARY TUMOR"
 S HTABLE(18)="43. RECONSTRUCTION/RESTORATION-FIRST COURSE"
 S HTABLE(19)=""
 S HTABLE(20)="RADIATION THERAPY"
 S HTABLE(21)=""
 S HTABLE(22)="44. DATE RADIATION STARTED"
 S HTABLE(23)="45. RADIATION THERAPY"
 S HTABLE(24)=""
 S HTABLE(25)="CHEMOTHERAPY"
 S HTABLE(26)=""
 S HTABLE(27)="46. DATE CHEMOTHERAPY STARTED"
 S HTABLE(28)="47. CHEMOTHERAPY"
 S HTABLE(29)="48. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED"
 S HTABLE(30)="49. ROUTE CHEMOTHERAPY ADMINISTERED"
 S HTABLE(31)="50. CHEMOTHERAPY/SURGERY SEQUENCE"
 S HTABLE(32)=""
 S HTABLE(33)="OTHER THERAPY"
 S HTABLE(34)=""
 S HTABLE(35)="51. DATE OTHER TREATMENT STARTED"
 S HTABLE(36)="52. OTHER TREATMENT"
 S HTABLE(37)="53. ARTERIAL EMBOLIZATION"
 S HTABLE(38)="54. DEATH WITHIN30 DAYS OF START OF INTIIAL COURSE OF THERAPY"
 S CHOICES=38
 S IE=ONCONUM
 W @IOF D HEAD^ONCHPC0
 W !," FIRST COURSE OF TREATMENT"
 W !," -------------------------"
 S DIE="^ONCO(165.5,",DA=ONCONUM
 S CDS=$$GET1^DIQ(165.5,IE,58.2)
 S RAD=$$GET1^DIQ(165.5,IE,51.2,"I")
 S CHE=$$GET1^DIQ(165.5,IE,53.2,"I")
DFCT W !," 29. DATE OF FIRST COURSE OF"
 W !,"      TREATMENT....................: ",$$GET1^DIQ(165.5,IE,49)
DIA S DR="1 30. DATE OF INPATIENT ADMISSION..." D ^DIE G:$D(Y) JUMP
DID S DR="1.1 31. DATE OF INPATIENT DISCHARGE..." D ^DIE G:$D(Y) JUMP
S W @IOF D HEAD^ONCHPC0
 W !," SURGERY",!
 W " -------"
DNCDS W !," 32. DATE OF NON CANCER-DIRECTED"
 W !,"      SURGERY......................: ",$$GET1^DIQ(165.5,IE,58.3)
NCDS S NCDS=$$GET1^DIQ(165.5,IE,58.1)
 S (NCDS1,NCDS2)="",LOS=$L(NCDS) I LOS<43 S NCDS1=NCDS G NCDS1
 S NOP=$L($E(NCDS,1,43)," ")
 S NCDS1=$P(NCDS," ",1,NOP-1),NCDS2=$P(NCDS," ",NOP,999)
NCDS1 W !," 33. NON CANCER-DIRECTED SURGERY...: ",NCDS1 W:NCDS2'="" !,?37,NCDS2
DCDS W !," 34. DATE OF CANCER-DIRECTED"
 W !,"      SURGERY......................: ",$$GET1^DIQ(165.5,IE,50)
SA S SA=$$GET1^DIQ(165.5,IE,74)
 S (SA1,SA2)="",LOS=$L(SA) I LOS<43 S SA1=SA G SA1
 S NOP=$L($E(SA,1,43)," "),SA1=$P(SA," ",1,NOP-1),SA2=$P(SA," ",NOP,999)
SA1 W !," 35. SURGICAL APPROACH.............: ",SA1 W:SA2'="" !,?37,SA2
SPS S (CDS1,CDS2)="",LOS=$L(CDS) I LOS<43 S CDS1=CDS G SPS1
 S NOP=$L($E(CDS,1,43)," "),CDS1=$P(CDS," ",1,NOP-1),CDS2=$P(CDS," ",NOP,999)
SPS1 W !," 36. SURGERY OF PRIMARY SITE.......: ",CDS1 W:CDS2'="" !,?37,CDS2
RFDT I $E(CDS,1,2)=99 D  G AR
 .S $P(^ONCO(165.5,D0,"HEP1"),U,57)=9
 .W !," 37. RADIO-FREQUENCY DESTRUCTION OF"
 .W !,"      TUMOR........................: Unknown"
 I $E(CDS,1,2)'=17 D  G AR
 .S $P(^ONCO(165.5,D0,"HEP1"),U,57)=8
 .W !," 37. RADIO-FREQUENCY DESTRUCTION OF"
 .W !,"      TUMOR........................: NA"
 S DR="1056 37. RADIO-FREQUENCY DESTRUCTION OF                                                   TUMOR........................" D ^DIE G:$D(Y) JUMP
AR I ($E(CDS,1,2)="00")!($E(CDS,1,2)=99) D  G SM
 .S $P(^ONCO(165.5,D0,"HEP1"),U,58)=88
 .W !," 38. ABLATION & RESECTION..........: NA"
 I $E(CDS,1,2)<18 D  G SM
 .S $P(^ONCO(165.5,D0,"HEP1"),U,58)="00"
 .W !," 38. ABLATION & RESECTION..........: Ablation & resection not administered"
 S DR="1057 38. ABLATION & RESECTION.........." D ^DIE G:$D(Y) JUMP
SM S SM=$$GET1^DIQ(165.5,IE,59)
 S (SM1,SM2)="",LOS=$L(SM) I LOS<43 S SM1=SM G SM1
 S NOP=$L($E(SM,1,43)," "),SM1=$P(SM," ",1,NOP-1),SM2=$P(SM," ",NOP,999)
SM1 W !," 39. SURGICAL MARGINS..............: ",SM1 W:SM2'="" !,?37,SM2
 I ($E(CDS,1,2)=99)!($E(CDS,1,2)<17) K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCHPC0
DTCM I ($E(CDS,1,2)<18) D  G SORS
 .S $P(^ONCO(165.5,D0,"HEP1"),U,59)=8
 .W !," 40. DISTANCE OF TUMOR TO CLOSEST"
 .W !,"      MARGIN.......................: NA"
 I $E(CDS,1,2)=99 D  G SORS
 .S $P(^ONCO(165.5,D0,"HEP1"),U,59)=9
 .W !," 40. DISTANCE OF TUMOR TO CLOSEST"
 .W !,"      MARGIN.......................: Unknown"
 S DR="1058 40. DISTANCE OF TUMOR TO CLOSEST                                                     MARGIN......................." D ^DIE G:$D(Y) JUMP
SORS S SORS=$$GET1^DIQ(165.5,IE,139)
 S (SORS1,SORS2)="",LOS=$L(SORS) I LOS<43 S SORS1=SORS G SORS1
 S NOP=$L($E(SORS,1,43)," ")
 S SORS1=$P(SORS," ",1,NOP-1),SORS2=$P(SORS," ",NOP,999)
SORS1 W !," 41. SURGERY OF OTHER REGIONAL"
 W !,"      SITE(S), DISTANT SITE(S),"
 W !,"      OR DISTANT LYMPH NODE(S).....: ",SORS1 W:SORS2'="" !,?37,SORS2
STRPT W !!," 42. SURGICAL TREATMENT OF RESIDUAL PRIMARY TUMOR:"
 I $E(CDS,1,2)="00" D  G RR
 .S $P(^ONCO(165.5,D0,"HEP1"),U,60)=8
 .S $P(^ONCO(165.5,D0,"HEP1"),U,61)=8
 .W !,"      ABLATION.....................: NA"
 .W !,"      RESECTION....................: NA"
 I $E(CDS,1,2)=99 D  G RR
 .S $P(^ONCO(165.5,D0,"HEP1"),U,60)=9
 .S $P(^ONCO(165.5,D0,"HEP1"),U,61)=9
 .W !,"      ABLATION.....................: Unknown"
 .W !,"      RESECTION....................: Unknown"
 S DR="1059      ABLATION....................." D ^DIE G:$D(Y) JUMP
 S DR="1060      RESECTION...................." D ^DIE G:$D(Y) JUMP
RR S RR=$$GET1^DIQ(165.5,IE,23)
 S (RR1,RR2)="",LOS=$L(RR) I LOS<43 S RR1=RR G RR1
 S NOP=$L($E(RR,1,43)," "),RR1=$P(RR," ",1,NOP-1),RR2=$P(RR," ",NOP,999)
RR1 W !!," 43. RECONSTRUCTION/RESTORATION-"
 W !,"      FIRST COURSE.................: ",RR1 W:RR2'="" !,?37,RR2
PRTC W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT
 G R^ONCHPC4A
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G:$D(DIRUT) EXIT G JUMP
 .W @IOF,!," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I) I I=18 W ! K DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF,!," CHOOSE FROM:"
 S X=TABLE(X)
 G @X
EXIT S:$D(DIRUT) OUT="Y"
 K CHOICES,PIECE,HTABLE,TABLE
 K CDS,CHE,IE,LOS,NCDS,NOP,RAD,SA,SA1,SA2,SM,SM1,SM2
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
