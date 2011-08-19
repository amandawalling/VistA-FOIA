GMVGR5 ;HIOFO/RM,YH,FT-TMP TO EXTRACT DATA FROM IO PACKAGE ;11/6/01  16:21
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #1391 - FILE 126.95 references  (private)
 ; #1430 - ^GMRYRP1 calls          (private)
 ; #1432 - ^GMRYUT0 calls          (private)
 ; #1435 - ^GMRYRP2 calls          (private)
 ; #1436 - ^GMRYRP3 calls          (private)
 ;
IO ; INPUT VARS:  DFN=PATIENT IEN
 ;              GMRFIN=END DATE OF EXTRACT
 ;              GMRSTRT=START DATE OF EXTRACT
 ;              GMROUT=0 (WILL BE SET IF ABNORMAL RESULTS)
 ;              GRPT=TYPE OF REPORT DATA EXTRACTED FOR
 ; OUTPUT VARS: GMROUT=1 (IF ABNORMAL RESULTS), SSN=PT'S SSN
 ;              GMRAGE=AGE OF PATIENT, GMRBED=ROOM-BED FOR PATIENT
 ;              GMRSEX=PATIENT SEX, GMRVADM=PATIENT'S ADMISSION DATE
 ;              GMRWARD=PTR TO 42 OF PT LOCATION, GMRWARD(1)=FT PT. LOC
 ;              AND GMR( WHICH HAS PT IO DATA OVER D/T RANGE
 N GMRNAM S GQT=0,GNN=$O(^GMRD(126.95,0)),GNN=$G(^GMRD(126.95,+GNN,1)),GMRNIT=$S($P(GNN,"^"):$P(GNN,"^"),1:2300),GMRDAY=$S($P(GNN,"^",2):$P(GNN,"^",2),1:"0700"),GMREVE=$S($P(GNN,"^",3):$P(GNN,"^",3),1:1500)
 D STARTD^GMRYRP1,PT^GMRYUT0,^GMRYRP2,REPORT1^GMRYRP3
 K DA,GAMOUNT,GBLNK,GCSHFT,GCURDT,GDATE,GDAY,GDSHFT,GDTFIN,GDTSTRT,GESHFT,GHR,GIN,GINDT,GIO,GITEM,GIVSTRT,GIVTYP,GLASTDT,GLN,GMRBTH,GMRDAY,GMRDIAG,GMREVE,GMRINDT,GMRNAM,GMRNIT,GMRX,GGNSHFT,GNXNSF,GNXTDT,GOP,GOPT,GOUT,GQT,GSHIFT,GSITE,GSTRT,GTEXT
 K GTOTIN,GTOTLI,GTOTLO,GTOTOUT,GTYP,GTYPE,GTYPI,GTYPO,GX,GY,II,JJ,KK,N,GGNDATE,GNN,GNSH,VAROOT,^TMP($J,"GMRY")
 Q
QIO ; KILL OUTPUT VARIABLES FROM IO SUBR.
 K GMRAGE,GMRBED,GMRSEX,GMRVADM,GMR,SSN
 Q
