LAMSA ;SLC/DLG - MICROSCAN AND AUTOSCAN4 DATA ANALYZER  ;8/16/90  13:35 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY ID OR IDE
LA1 S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S LROVER=1,X="TRAP^"_LANM,@^%ZOSF("TRAP"),FD="|"
LA2 S TOUT=0,A=1 D IN G QUIT:TOUT,LA2:$E(IN)'="P" D QC
 K ORG,COMM,COMMO,LADGT,LABLI,LASPEC S (COMM,COMMO,LADRUG,LAISO,LAORG,LADNA,LAMIC,LMDR)=0,LRM=1
 S TOUT=0,BAD=0 F A=2:1 D IN,QC G LA3:TYPE="L",QUIT:TOUT
 Q
LA3 G LA2:'$D(ORG) X LAGEN G LA2:'ISQN ;Can be changed by the cross-link code
 S LRA=$P(^LAH(LWL,1,ISQN,0),U,3,5),LRAA=+LRA,LRAD=$P(LRA,U,2)
 F I=0:0 S I=$O(ORG(I)) Q:I'>0  S I1=I,X=ORG(I) S ^LAH(LWL,1,ISQN,3,I1,0)=ORG(I) D LA4 I COMMO F J=1:1:COMMO S:$D(COMM(I1,1,J))#2 ^LAH(LWL,1,ISQN,3,I1,1,J,0)=COMM(I1,1,J)
 I COMM F I=1:1:COMM S ^LAH(LWL,1,ISQN,4,I,0)=COMM("C",I)
 G LA2
LA4 F J=0:0 S J=$O(ORG(I,J)) Q:J'>0  S ^LAH(LWL,1,ISQN,3,I1,J)=ORG(I,J)
 Q
QC ;QC and data record processing here
 S TYPE=" " Q:"BC"[CTRL  S TYPE=$E(IN) Q:TYPE']""  I "PBRMLFC"'[TYPE Q  ;These are the record types we handle
 D @TYPE Q
P S V=$P(IN,FD,3) D NUM S LAPID=V Q
B S V=$P(IN,FD,3) D NUM S (CUP,IDE)=V,LRSP=$S($P(IN,FD,7):$P(IN,FD,7),1:"ANY"),LASPEC=$P(IN,FD,9) Q  ;Could change LRAA here
R S LAISO=+$P(IN,FD,3),LATPN=+$P(IN,FD,5),LANOS=$P(IN,FD,9),LAORG=$P(IN,FD,12),LANORG=$P(IN,FD,13),LANYD=$P(IN,FD,23)
 S X=$O(^LAB(62.4,TSK,7,LRM,1,"C",LAORG,0)),LAORG=0 Q:X'>0  S LAORG=+^LAB(62.4,TSK,7,LRM,1,X,0),ORG(LAISO)=LAORG
 Q
M Q:$D(ORG(LAISO))'>0  S LADNA=$P(IN,FD,3),LAMIC=$P(IN,FD,5),LANCCLS=$P(IN,FD,8)
 F I=1:1:25 S Y(I)=$P(IN,FD,I)
 D M^LAMSA1 Q
F S X=$P(IN,FD,4) I X]"" S:"PB"[$P(IN,FD,3) COMM=COMM+1,COMM("C",COMM)=X S:$P(IN,FD,3)="R" COMMO=COMMO+1,COMM(LAISO,1,COMMO)=X,X=""
 Q
C S COMM=COMM+1,COMM("C",COMM)=$P(IN,FD,5) Q
 Q
L S END=$P(IN,FD,3) Q
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN S CNT=^LA(TSK,"I",0)+1,CTRL="<" IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 5 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
OUT S CNT=^LA(TSK,"O")+1,^("O")=CNT,^("O",CNT)=OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=TSK LOCK
 Q
QUIT G LA2:^LA(TSK,"I")>^("I",0) LOCK ^LA(TSK) H 1 K ^LA(TSK,"I"),^LA("LOCK",TSK)
 I $D(^LA(TSK,"O")),^("O")=^("O",0) K ^LA(TSK,"O")
 LOCK  K ^TMP($J),^TMP("LA",$J)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM)
