DENT ;ISC2/SAW,HAG-DENTAL PACKAGE MAIN DRIVER  ; 12/22/88  3:03 PM ;
V ;;VERSION 1.2 
 S %OPT="OPT"
SE D:'$D(DT) DT^DICRW S U="^",S=";",%O=$T(@(%OPT))
 I $D(^DOPT($P(%O,S,5),"VERSION")),($P($T(V),S,3)=^DOPT($P(%O,S,5),"VERSION")) G IN
 K ^DOPT($P(%O,S,5))
 F I=1:1 Q:$P($T(@(%OPT)+I),S,3)=""  S %OP=I,^DOPT($P(%O,S,5),I,0)=$P($T(@(%OPT)+I),S,3),^DOPT($P(%O,S,5),"B",$P($P($T(@(%OPT)+I),S,3),"^",1),I)=""
 S K=I-1,^DOPT($P(%O,S,5),0)=$P(%O,S,4)_U_1_U_K_U_K K I,K,X S ^DOPT($P(%O,S,5),"VERSION")=$P($T(V),S,3)
IN I $P(%O,S,6)'="" D @($P(%O,S,6))
PR Q:'$D(%OPT)  S %O=$T(@(%OPT)),S=";",IOP=0 D ^%ZIS K IOP W:IOST'["PK-" @IOF
 I $P(%O,S,7)'="" D @($P(%O,S,7))
 I $P(%O,S,7)="" W !!,$P(%O,S,3),":",!,$P($T(V),S,3),$P(%O,S,5),!! I $P(%O,S,9)="" W $P(%O,S,4),"S:",!
 F J=1:1 Q:$P($T(@(%OPT)+J),S,3)=""  S %OP=J,K=$S(J<10:15,1:14) I $P(%O,S,9)="" W !,?K,J,". ",$P($T(@(%OPT)+J),S,3)
RE W ! S DIC="^DOPT("_""""_$P($T(@(%OPT)),S,5)_""""_",",DIC(0)="AEQMN" D ^DIC G:X=""!(X=U) EXIT G:Y<0 RE K DIC,J,%O X $P($T(@(%OPT)+Y),S,4) G PR
EXIT I $P($T(@(%OPT)+(%OP+1)),S,4)'="" X $P($T(@(%OPT)+(%OP+1)),S,4)
 K DIC,G,J,%OP I $P(%O,S,8)'="" S %OPT=$P(%O,S,8) G SE
OUT K DENTSTA,DIC,DR,I,J,K,O,S,X,Y,%O,%OPT Q
INIT D:'$D(DT) DT^DICRW S:'$D(DTIME) DTIME=60 I '$D(ION) S IOP=$I D ^%ZIS K IOP Q
OPT ;;DENTAL SERVICE MAIN MENU DRIVER;OPTION;DENT;INIT
 ;;DENTAL ACTIVITY;S %OPT="DENTE" G SE
 ;;DENTAL PATIENT INQUIRY;D ^DENTQ
 ;;ENTER/EDIT APPT. SCHEDULING AID (CPM);D ^DENTCPM
 ;;PRINT APPT. SCHEDULING AID (CPM);D PRINT^DENTCPM
 ;;PROGRAM MANAGEMENT;S %OPT="DENTPM" G SE
 ;;MAILMAN;D ^XM
 ;;;
DENTE ;;DENTAL ACTIVITY ENTER/EDIT;OPTION;DENTE;;;OPT
 ;;ENTER DATA THRU CARD READER;D ^DENTCRD
 ;;TREATMENT DATA ENTER/EDIT (FULL SCREEN);D TREAT0^DENTE1
 ;;TREATMENT DATA ENTER/EDIT (LINE BY LINE);D TREAT^DENTE1
 ;;CLASS I-VI (TYPE 3) ADMIN INFO;D ADMIN^DENTE1
 ;;PERSONNEL INFO (TYPE 4);D PERS^DENTE1
 ;;NON CLINICAL TIME;D NCLIN^DENTE0
 ;;APPLICATIONS AND DENTAL FEE (TYPE 5);D FEE^DENTE1
 ;;DENTAL REPORTS;S %OPT="DENTP" G SE
 ;;REVIEW/RELEASE SERVICE REPORTS;D ^DENTAR
 ;;;
DENTPM ;;PROGRAM MANAGEMENT;OPTION;DENTPM;;;OPT
 ;;PROVIDER EDIT;D PROV^DENTE3
 ;;SITE PARAMETERS EDIT;D SITE^DENTE0
 ;;TYPE OF SERVICE EDIT;D TSE^DENTE2
 ;;INITIALIZE CARD READER;D ^DENTCRDI
 ;;TREATMENT DATA ENTRY DELETE;D DELTR^DENTE1
 ;;DELETE NON CLINICAL TIME ENTRY;D DELNC^DENTE0
 ;;TREATMENT DATA ENTRY EDIT/RE-RELEASE (FULL SCREEN);D TSE1^DENTE2
 ;;TREATMENT DATA ENTRY EDIT/RE-RELEASE (LINE BY LINE);D TDRR^DENTE2
 ;;CLASS I-VI ENTRY (TYPE 3) EDIT/RE-RELEASE;D ARR^DENTE2
 ;;PERSONNEL ENTRY (TYPE 4) EDIT/RE-RELEASE;D PRR^DENTE2
 ;;APPLICATIONS AND FEE (TYPE 5) EDIT/RE-RELEASE;D FBRR^DENTE2
 ;;;
DENTP ;;OTHER DENTAL REPORTS;OPTION;DENTP;;;DENTE
 ;;SERVICE REPORTS;D ^DENTA
 ;;SITTINGS/VISITS REPORT;D ^DENTP1
 ;;INPATIENTS REQUIRING DENTAL EXAM;D ^DENTPEX
 ;;TYPE OF SERVICE REPORT;D TOS^DENTP1
 ;;COST DISTRIBUTION REPORT;D ^DENTPCD
 ;;;
