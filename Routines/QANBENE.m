QANBENE ;HISC/GJC-Special incidents invol. a beneficiary ;3/3/92 [ 09/15/95  7:51 AM ]
 ;;2.0;Incident Reporting;**1,18,23,26,28**;08/07/1992
 ;
 D KILL^QANBENE0,^QAQDATE I QAQQUIT D K^QAQDATE W !!,$C(7),"Invalid date range, no report will be produced." Q
 S (PAGE,QANCONT,QANQUIT)=0
 S Y=QAQNBEG D DD^%DT S QANDATE(0)=Y
 S Y=QAQNEND D DD^%DT S QANDATE(1)=Y
 S QANLWLT=QAQNBEG-.0000001,QANUPLT=QAQNEND_".9999999"
 D DIV^QANRPT1
 S QANSITE(0)=$S($G(^QA(740,1,0))]"":$P(^(0),U),1:"")
 I QANSITE(0)']"" W !!,$C(7),"Site Parameters file incomplete, contact your site manager." D KILL^QANBENE0 Q
 S QANSITE=$$PRIM^VASITE(DT),QANSITE=$$SITE^VASITE(DT,QANSITE)
 S QANSITE(1)=$P(QANSITE,U,3)
 S QANSITE=$P(QANSITE,U,2)
 I $G(QANDVFLG)=1 S QANSITE=$$NAME^VASITE(DT)
 S QANHEAD(0)="Summary of Incidents Involving Patients (RCS 10-0073)"
 S QANHEAD(1)="For the period "_QANDATE(0)_" to "_QANDATE(1)
 S QANHEAD(2)="Site Name: "_QANSITE_"          FTS#:____________________"
 ;/*** SET UP TABS ***/
 S QANTAB(1)=$J(((5/80)*IOM),2,0),QANTAB(2)=$J(((10/80)*IOM),2,0),QANTAB(3)=$J(((25/80)*IOM),2,0),QANTAB(4)=$J(((27/80)*IOM),2,0),QANTAB(5)=$J(((45/80)*IOM),2,0),QANTAB(6)=$J(((55/80)*IOM),2,0)
 ;/*** SET UP TABS ***/
 ;D DIV^QANRPT1
 K DIR S DIR(0)="FAO^1:1^K:""BCO""'[X X",DIR("A")="Select Incident Status (B/C/O): ",DIR("?")="Enter ""O"" to select open cases, ""C"" for closed cases, or ""B"" for both open and closed cases" D ^DIR K DIR
 I $D(DIRUT) D KILL^QANBENE0 Q
 S QANFLG("IR STAT")=$S("B"[Y:"013","C"[Y:"0",1:"13") ;set IR Status flag
EN2 ;Call to ^QANBENE0
 D EN1^QANBENE0
 Q
VALID ;Validate as a reportable incident.
 S QANSWCH=0
 I $D(^QA(742.1,"BUPPER","PATIENT ABUSE",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","DEATH",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","INFORMED CONSENT-FAIL. TO OBTAIN",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","FALL",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","HOMICIDE",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","MEDICATION ERROR",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","MISSING PATIENT",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","ASSAULT-PATIENT TO PATIENT",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","INFORMED CONSENT, FAIL. TO OBTAIN",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","ASSAULT-PATIENT/STAFF",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","ASSAULT, PATIENT TO PATIENT",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","ASSAULT, PATIENT/STAFF",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","FIRE, PATIENT INVOLVED IN",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","INJURY NOT OTHERWISE LISTED",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","FIRE-PATIENT INVOLVED IN",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","SEXUAL ASSAULT",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","SUICIDE ATTEMPT",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","SUICIDE",QAN("INC"))) S QANSWCH=1 Q
 I $D(^QA(742.1,"BUPPER","TRANSFUSION ERROR",QAN("INC"))) S QANSWCH=1
 Q
