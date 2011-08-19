LASMA2 ;SLC/RWF - SMA II/(GENERATION 2) SYSTEM ROUTINE ;7/20/90  10:08 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY ID (patient no.) or IDE (lab no.) /use with FORMAT OPTION 4B.
LA1 S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
LA2 K TV S TOUT=0,A=1 D IN G QUIT:TOUT,LA2:$E(IN,3)'="/" D QC
 S TOUT=0,BAD=0 F A=2:1:10 D IN,QC G QUIT:TOUT
 S V=$E(Y(3),6,15) D NUM S RMK=V,DIL=0 S:RMK["DIL" DIL=+RMK
 F A=4,6,8 F IX=2:11:67 S X=$E(Y(A),IX,IX+10),I=+X,V=$P(X,"=",2) D NUM I "B*+"'[$E(V,$L(V)) S:DIL V=V*DIL S @TC(I,1)=+V ;V check for error flags
 S V=$E(Y(2),1,9),TRAY=+$E(Y(1),16,17),CUP=+$E(Y(1),19,20) D NUM S ID=+V,V=$E(Y(3),1,5) D NUM S IDE=+V
LA3 X LAGEN
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 I $D(RMK),$L(RMK) D RMK^LASET
 G LA2
QC ;QC TESTING HERE; S BAD=1 IF DONT STORE
 I A=2,$L(Y(1))<21 S Y(1)=Y(1)_IN,A=1 Q  ;EXT sent at 21 for File search.
 I A<4,$E(IN,4)="=" S Y(A)="",A=A+1 G QC ;Controls don't sent pat. no.
 S Y(A)=IN Q
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 5 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
 Q
OUT S CNT=^LA(TSK,"O")+1,^("O")=CNT,^("O",CNT)=OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=TSK LOCK
 Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
