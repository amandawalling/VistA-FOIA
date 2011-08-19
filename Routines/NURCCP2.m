NURCCP2 ;HIRMFO/RM-STANDARD CARE PLAN, PRINT (selection driver) ;1/23/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
SELCHC ; PRINT CHOICES TO SELECT FROM
 K @ANS I 'CHC W !!,"THERE ARE NO ENTRIES TO PICK FROM" Q
SELC ;
 D HDR F X=1:1:CHC D:NURCEOPG<$Y EOPG Q:NURCOUT  W !,$J(X,3,0),".  ",$P(^TMP($J,"CPCH",X),"^",2) I $D(^TMP($J,"CPCH",X,1)) D DXPRT Q:NURCOUT
 I NURCOUT S NURCOUT=NURCOUT-1 Q
SEL ; SELECT PROMPT
 W !,"Enter action: " R X:DTIME S:'$T X="^^" I "^^"[X S NURCOUT=''$L(X) K:MULT&$L(X) @ANS Q
 S OK=1 I MULT S NURX=X D VALSEL I 'OK,X'="??" W !?4,"ENTER SELECTIONS USING HYPHENS AND COMMAS.  E.G.  1-3,6." K @ANS
 I 'MULT,X'=+X!(X<1)!(X>CHC) S OK=0 I X'="??" W !?4,$C(7),"PLEASE ENTER A NUMBER IN THE RANGE 1-",CHC
 I 'OK,X'="??" W !?4,"OR ENTER ^ TO EXIT, OR ?? TO RELIST THE SELECTIONS."
 G:'OK SELC:X="??",SEL
 I 'MULT S @ANS=^TMP($J,"CPCH",X)
 E  S NURX=X D SETSEL
 Q
DXPRT ; PRINT DX'S UNDER PROBLEMS
 F G=1:1 S H=$G(^TMP($J,"CPCH",X,G)) Q:'$L(H)  D:NURCEOPG<$Y EOPG Q:NURCOUT  W !?5,"- "_$P(H,"^",2)
 Q
EOPG ; END OF PAGE
 W !,"Enter action (<RET> to see more): " R Y:DTIME S:'$T Y="^^" I "^^"[Y S NURCOUT=$L(Y) D:'NURCOUT HDR Q
 I MULT S NURX=Y D VALSEL I OK S NURX=Y D SETSEL,HDR Q
 I Y="??" S X=1 D HDR Q
 W !?4,"TYPE <RET> TO CONTINUE LISTING, ?? TO RELIST THE SELECTIONS,",!?4,"^ TO STOP LISTING, ^^ TO EXIT PROGRAM" W:MULT ",",!?4,"OR MAKE SELECTIONS, CHOOSE FROM 1-",CHC W "."
 G EOPG
 ;
HDR ; PRINT HDR & FF
 W @IOF,TXT
 Q
VALSEL ; VALIDATE INPUT IN NURX IN FORM 1-3,4 WITH 1-CHC AS RANGE
 ; SETS OK=1 IF VALID, ELSE SETS OK=0
 S C=1 F A=1:1 S B=$P(NURX,",",A) Q:B=""  S D=+B,E=$S(B["-":$P(B,"-",2,$L(B,"-")),1:+B) I D'=+D!(E'=+E)!(D<1)!(D>CHC)!(E<1)!(E>CHC)!(D>E) S C=0 Q
 S OK=C
 Q
SETSEL ; SET SELECTION ARRAY
 F A=1:1 S B=$P(NURX,",",A) Q:B=""  S C=+B,D=$S(B["-":$P(B,"-",2),1:+B) F E=C:1:D S F=$G(^TMP($J,"CPCH",E)),@(ANS_"(+F)")=F F Y=1:1 S Z=$G(^TMP($J,"CPCH",E,Y)) Q:Z=""  S @(ANS_"(+F,+Z)")=""
 Q
