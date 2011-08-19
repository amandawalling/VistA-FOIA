RMPRFFIX ;VMP/RB - FIX FIELD LENGTH PROBLEMS FOR FILES #660/664 ;01/13/06
 ;;3.0;Prosthetics;**124**;06/20/05;Build 17
 ;;
 ;1. Post install to correct fields with length error created during
 ;   cut & paste for function key input during GUI process and passed
 ;   to VISTA files 660 and 664 for fields:  Brief Description, Remarks,
 ;   Serial #, Manufacturer, Model and Lot #  
 ;
BEG ;search and correct length in errors for specified fields in files 664/660
RD1 S IEN4=0,FILE2="^RMPR(660,",END=0,TT=0,TFND=0,TFIX=0,RMPRCT1=0,RMPRCT2=0
RD1A S IEN4=$O(^RMPR(664,IEN4)),HIEN=0 G EXIT:IEN4=""!(IEN4]"A")
RD1AA S DIC="^RMPR(664,",DA=IEN4,DR="7.5;1;7.5;10;13;19;21.1",DIQ="D664",DIQ(0)="IE" D EN^DIQ1
 S IEN0=$G(D664(664,IEN4,13,"I")),IEN42=0,HDT="",DFN=$G(D664(664,IEN4,1,"E")),RMUSER=$G(D664(664,IEN4,10,"I")),RMIFCAP=$G(D664(664,IEN4,7.5,"I"))
 S IWD="*SHIPPING* LINK",PCN=$G(D664(664,IEN4,7.5,"I")),FLD19=$G(D664(664,IEN4,19,"I")),FLD211=$G(D664(664,IEN4,21.1,"I"))
 K DIC,DA,DR,DIQ,D664
 S IEN42=0,FILE1="^RMPR(664,"
 D:IEN0>0 FIX660 G EXIT:END=1
RD1B S IEN42=$O(^RMPR(664,IEN4,1,IEN42)),HSW=0,NUM=IEN4_"-"_IEN42 I IEN42=""!(IEN42="B") G RD1A:RMOPT=1,ENTR
 S DIC="^RMPR(664,",DA=IEN4,DA(664.02)=IEN42,DR=2,DR(664.02)="1;7;12;15;15.2;15.4;15.6",DIQ="D664",DIQ(0)="I" D EN^DIQ1
 S FLD1D=$G(D664(664.02,IEN42,1,"I")),FLD7=$G(D664(664.02,IEN42,7,"I")),FLD15=$G(D664(664.02,IEN42,15,"I")),IEN0=$G(D664(664.02,IEN42,12,"I")),IWD="ITEM "_IEN42_": "_$E(FLD1D,1,30)
 S FLD152=$G(D664(664.02,IEN42,15.2,"I")),FLD154=$G(D664(664.02,IEN42,15.4,"I")),FLD156=$G(D664(664.02,IEN42,15.6,"I"))
 K DIC,DA,DR,DIQ,D664
 I IEN42<2,$L(FLD19)>30 S WDA=NUM,WDB="664-19  (Deliver To)",WDC=FLD19 D  G ENTR:END=1
 . S FLD1=19,FLD2="",DA1=IEN4,DA1A="",DA2="",LMIN=3,LMAX=30,WDS="Deliver To"
 . D ASK Q:END=1  D FILE
 I IEN42<2,$L(FLD211)>45 S WDA=NUM,WDB="664-21.1  (Deliver To Attention)",WDC=FLD211 D  G ENTR:END=1
 . S FLD1=21.1,FLD2=25,DA1=IEN4,DA1A="",DA2=IEN0,LMIN=0,LMAX=45,WDS="Deliver To Attention"
 . D ASK Q:END=1  D FILE
 I IEN42>1,HDT'="" D
 . S FLD2=25,DA1="",DA1A="",DA2=IEN0,DATA=HDT
 . D FILE
 S FILE1="^RMPR(664,IEN4,1,"
 I $L(FLD1D)>60 S WDA=NUM,WDB="664-1  (Brief Description)",WDC=FLD1D D  G ENTR:END=1
 . S FLD1=1,FLD2=24,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=3,LMAX=60,WDS="Brief Description"
 . D ASK Q:END=1  D FILE
 I $L(FLD7)>30 S WDA=NUM,WDB="664-7  (Remarks)",WDC=FLD7 D  G ENTR:END=1
 . S FLD1=7,FLD2=16,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=0,LMAX=30,WDS="Remarks"
 . D ASK Q:END=1  D FILE
 I $L(FLD15)>15 S WDA=NUM,WDB="664-15  (Serial #)",WDC=FLD15 D  G ENTR:END=1
 . S FLD1=15,FLD2=9,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=3,LMAX=15,WDS="SERIAL #"
 . D ASK Q:END=1  D FILE
 I $L(FLD152)>30 S WDA=NUM,WDB="664-15.2  (Manufacturer)",WDC=FLD152 D  G ENTR:END=1
 . S FLD1=15.2,FLD2=9.1,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=0,LMAX=30,WDS="Manufacturer"
 . D ASK Q:END=1  D FILE
 I $L(FLD154)>30 S WDA=NUM,WDB="664-15.4  (Model)",WDC=FLD154 D  G ENTR:END=1
 . S FLD1=15.4,FLD2=9.2,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=0,LMAX=30,WDS="Model"
 . D ASK Q:END=1  D FILE
 I $L(FLD156)>30 S WDA=NUM,WDB="664-15.6  (Lot #)",WDC=FLD156 D  G ENTR:END=1
 . S FLD1=15.6,FLD2=21,DA1=IEN42,DA1A=IEN4,DA2=IEN0,LMIN=0,LMAX=30,WDS="Lot #"
 . D ASK Q:END=1  D FILE
 G RD1B
FIX660 ;search and correct length in errors for specified fields in files 660
 S HSW=0
 S DIC="^RMPR(660,",DA=IEN0,DR="9;16;21;24:25;9.1;9.2",DIQ="D660",DIQ(0)="I" D EN^DIQ1
 S FLD16=$G(D660(660,IEN0,16,"I")),FLD9=$G(D660(660,IEN0,9,"I")),FLD21=$G(D660(660,IEN0,21,"I"))
 S FLD24=$G(D660(660,IEN0,24,"I")),FLD91=$G(D660(660,IEN0,9.1,"I")),FLD92=$G(D660(660,IEN0,9.2,"I"))
 S FLD25=$G(D660(660,IEN0,25,"I"))
 K DIC,DA,DR,DIQ,D660
 I $L(FLD25)>30 S WDA=IEN0,WDB="660-25  (Deliver To)",WDC=FLD25 D  G ENTR:END=1
 . S FLD2=25,DA2=IEN0,LMIN=3,LMAX=30,WDS="(Pros/Appliance Repair) Deliver To"
 . D ASK Q:END=1  D FILE
 I $L(FLD24)>60 S WDA=IEN0,WDB="660-24  (Brief Description)",WDC=FLD24 D  G ENTR:END=1
 . S FLD2=24,DA2=IEN0,LMIN=3,LMAX=60,WDS="(Pros/Appliance Repair) Brief Description"
 . D ASK Q:END=1  D FILE
 I $L(FLD16)>61 S WDA=IEN0,WDB="660-16  (Remarks)",WDC=FLD16 D  G ENTR:END=1
 . S FLD2=16,DA2=IEN0,LMIN=0,LMAX=61,WDS="(Pros/Appliance Repair) Remarks"
 . D ASK Q:END=1  D FILE
 I $L(FLD9)>20 S WDA=IEN0,WDB="660-9  (Serial #)",WDC=FLD9 D  G ENTR:END=1
 . S FLD2=9,DA2=IEN0,LMIN=0,LMAX=20,WDS="(Pros/Appliance Repair) Serial #"
 . D ASK Q:END=1  D FILE
 I $L(FLD21)>20 S WDA=IEN0,WDB="660-21  (Lot #)",WDC=FLD21 D  G ENTR:END=1
 . S FLD2=21,DA2=IEN0,LMIN=0,LMAX=20,WDS="(Pros/Appliance Repair) Lot #"
 . D ASK Q:END=1  D FILE
 I $L(FLD91)>55 S WDA=IEN0,WDB="660-91  (Manufacturer)",WDC=FLD91 D  G ENTR:END=1
 . S FLD2=9.1,DA2=IEN0,LMIN=0,LMAX=55,WDS="(Pros/Appliance Repair) Manufacturer"
 . D ASK Q:END=1  D FILE
 I $L(FLD92)>55 S WDA=IEN0,WDB="660-92  (Model)",WDC=FLD92 D  G ENTR:END=1
 . S FLD2=9.2,DA2=IEN0,LMIN=0,LMAX=55,WDS="(Pros/Appliance Repair) Model"
 . D ASK Q:END=1  D FILE
 Q
ASK I RMOPT=1 D  Q
 . S ^XTMP("RMPRFIX","RMPR",RMUSER,IEN4,IEN42,$P(WDB," "))=LMIN_U_LMAX_U_WDB_U_DFN_U_$L(WDC)_U_RMIFCAP_U_IWD_U_IEN4_U_IEN42_U_IEN0_U_WDA_U_WDC
 . S ^XTMP("RMPRFIX","RMPR","A",IEN4)=""
 . S RMPRCT2=RMPRCT2+1
 . S:IEN4'=HIEN RMPRCT1=RMPRCT1+1,HIEN=IEN4
 I HSW=0 W !,IEN4," / ",IEN0,?20,"PCN: ",PCN,?42,"ITEM: ",IWD
 S HSW=1,TFND=TFND+1
 ;ASK NEW FIELD ENTRY WITH CORRECT LENGTH
 W !,WDA,?12,WDB,!,WDC,!
 S DIR("A")=WDS,DIR("?")=$S(LMIN=0:"Field length cannot exceed "_LMAX_" characters",1:"Field length must be "_LMIN_"-"_LMAX_" characters in length")
 S DIR(0)="F^"_LMIN_":"_LMAX
 W !,DIR("?"),!
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S END=1 Q
 S DATA=Y
 W !
 Q
FILE Q:RMOPT=1
 K DA,DR,DIE
 I IEN42'=0,DA1'="" S DIE=FILE1,DA=DA1,DR=FLD1_"////^S X=DATA" S:DA1A DA(1)=DA1A D ^DIE K DA,DIE,DR
 I $G(FLD1)=19 S HDT=DATA
 Q:DA2=""!(FLD2="")
 S DIE=FILE2,DA=DA2,DR=FLD2_"////^S X=DATA" D ^DIE K DA,DIE,DR
 S TFIX=TFIX+1
 Q
ENT ;ASK INT TO FIX
 S IEN4=0,FILE2="^RMPR(660,",END=0,TFND=0,TFIX=0
ENTR ;664 INTERNAL FROM BUILD REPORT
 S DIR("A")="RECORD IDENTIFIER",DIR("?")="Enter record identifier from build list to be corrected"
 S DIR(0)="F"
 W !,DIR("?"),!
 D ^DIR
 I $D(DUOUT)!$D(DIRUT) S END=1 Q
 Q:Y=""
 S IEN4=Y
 I '$D(^XTMP("RMPRFIX","RMPR","A",Y)) W "   ** NOT FOUND ON CORRECTION REPORT" G ENTR
 W !
 G RD1AA
EXIT Q
