MCARDBL ;WISC/TJK-UTILITY TO ASTERIK OUT ENTRIES ON SCREEN AND FUNCTIONS ;5/2/96  12:54
 ;;2.3;Medicine;;09/13/1996
START Q:'$D(DJBLO)  Q:DJBLO=""
 F DJBNO=1:1 S DJBITEM=$P(DJBLO,",",DJBNO) Q:DJBITEM=""  D
 .Q:'$D(DJJ(DJBITEM))  S DJDB=""
 .S $P(DJDB,"*",$P(DJJ(DJBITEM),U)+1)=""
 .S @($P(DJJ(DJBITEM),U,2))
 .K DJP1,DJP2,DJP8
 .X XY W DJDB S DJBHOLD=DJJ(DJBITEM),DJBITEM1=DJBITEM K DJJ(DJBITEM),V(DJBITEM)
 S DY=16,DX=15 X XY W DJHIN,"[Asterisks (*) indicate field n/a to this record]          "
 G EXIT:$D(DJJ(V))
 S DJNX=$O(DJJ(V)) I DJNX="" S DY=17,DX=0 X XY W "Press <RETURN> to Continue" S V=DJBITEM1,DJJ(V)=DJBHOLD,DJNX=DJBITEM1,$P(DJJ(V),U,1,2)="2^DY=17,DX=27"
 E  S V=DJNX
EXIT K DJBLO,DJBNO,DJDB,DJBITEM,DJBITEM1,DJBHOLD
 Q
FUNC ;Functions
 ;DCB-Function commands.
 I X="^T",$D(DJTOGGLE) W IOKPNM K DJTOGGLE D HELP G R^MCARDNJ
 I X="^T",'$D(DJTOGGLE) W IOKPAM S DJTOGGLE="" D HELP G R^MCARDNJ
 I X="^C" D HELP1 G R^MCARDNJ
 I X="^R" S DA=D0,DJNM=DJDPL,DJFLAG=V,MCMASS=1 K MCDID D ^MCARDPL D ^MCARD1 G EN^MCARDNJ
 ;I X="^K" S MCMASS=1 K MCDID D FUNCK^MCARDNQ2 G R^MCARDNJ
 I X="^O",'$D(MCHELPSW) S MCHELPSW=0 K MCDID S MCMASS=1 G TK^MCARDNJ
 I X="^O",$D(MCHELPSW) K MCHELPSW K MCDID S MCMASS=1 G TK^MCARDNJ
 I X="^H" S MCHELPS2=1 D START^MCARDHLP K MCDID,MCHELPS2 S MCMASS=1 G R^MCARDNJ
 G RETURN^MCARDNJ
HELP ;
 Q:'$D(MCHELPSW)
HELP1 ;
 I '$D(DJTOGGLE) D FUNCC^MCARDNQ2
 E  D FUNCK^MCARDNQ2
 Q
