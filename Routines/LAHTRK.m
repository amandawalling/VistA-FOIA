LAHTRK ;SLC/RWF/CJS - HEMATRAK 590 DIFF COUNTER ;8/16/90  14:18 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
LA S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),TSK=$O(^LAB(62.4,"C","LAHTRK",0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 S U="^",SS="CH" D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
 S ZZ="3,9,9,6^6,1,1,1,2,4,4^14,3,3,3,3,3,3,3,3,3,3,3,3,3,4^35,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3^2,4,3^4,3,3,3,3^"
 S CNT=0,U="^"
LA2 S A=1,TOUT=0 D IN G QUIT:TOUT S Y(1)=IN,LOG=$E(IN,1,9) G LA2:LOG="" S LOG=+LOG
 F A=2:1:6 D IN G QUIT:TOUT S Y(A)=IN
SAVE F A=1:1:6 D PIEC
 S SPEC=$P(^LAB(69.9,1,1),U,1),METH="HTRAK"
LA3 X LAGEN G LA2:ISQN<1
 S Z3="",Z4="",Z5="",Z=LRVAL K LRVAL
 F I=12:1:17 S VAL=$P(Z,U,I)/10,Z3=Z3_$S(VAL=0:"",1:VAL)_U
 F I=20:1:24 S VAL=$P(Z,U,I)/10,Z4=Z4_$S(VAL=0:"",1:VAL)_U
 S VAL=+$P(Z,U,40),Z5=$S(VAL=1:"R",VAL=2:"A",VAL=3:"I",1:"")_U_U_U F I=28:1:33 S VAL=+$P(Z,U,I),Z5=Z5_$S(VAL=0:"",1:VAL-3)_U
 S Z5=Z5_$S(+$P(Z,U,35)=0:"",1:+$P(Z,U,35)-3) S Z14=$S(+$P(Z,U,18)=0:"",1:+$P(Z,U,18)\10)_U_$S(+$P(Z,U,19)=0:"",1:+$P(Z,U,19)\10)_U
 S Z14=Z14_$S(+$P(Z,U,34)=0:"",1:+$P(Z,U,34)-3)_U F I=36:1:39 S VAL=+$P(Z,U,I),Z14=Z14_$S(VAL=0:"",1:VAL-3)_U
 ;F I=66:1:69 S VAL=+$P(Z,U,I),Z14=Z14_$S(VAL=0:"",1:VAL)_U
 S NCYT=$S($P(Z5,U,4)=""&($P(Z5,U,5)="")&($P(Z5,U,6)="")&($P(Z5,U,7)="")&($P(Z5,U,10)="")&($P(Z14,U,3)=""):"Y",1:"N"),NCHR=$S($P(Z5,U,8)=""&($P(Z5,U,9)="")&($P(Z14,U,4)=""):"Y",1:"N")
 S Z5=$P(Z5,U,1)_U_NCYT_U_NCHR_U_$P(Z5,U,4,99)
 S X=$D(^LAH(LWL,1,ISQN,0)) ;INSURE NAKED IS SET FOR REST OF FOR LOOP SPEED CODE
 F I=1:1:6 S:$L($P(Z3,U,I)) ^(393+I)=$P(Z3,U,I)
 F I=1:1:5 S:$L($P(Z4,U,I)) ^(399+I)=$P(Z4,U,I)
 F I=1:1:22 S:$L($P(Z5,U,I)) ^(404+I)=$P(Z5,U,I)
 F I=1:1:11 S:$L($P(Z14,U,I)) ^(470+I)=$P(Z14,U,I)
 G LA2
PIEC S DES=$P(ZZ,U,A),FS=1+DES,L=0 F I=2:1:FS D PART
 Q
PART S F=L+1,L=$P(DES,",",I)+L,Z=Z_$E(Y(A),F,L)_U Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 9 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
