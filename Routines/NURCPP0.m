NURCPP0 ;HIRMFO/RM-NURSING CARE PLAN PATIENT EDIT ;8/29/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; ENTRY FROM OPTION NURCPE-CARE
 Q:$P($G(^DIC(213.9,1,"OFF")),"^")=1
 S NURSPK="NURSC"
 S NURSROOT=$O(^GMRD(124.2,"AA",NURSPK,2,"Nursing Care Plan",1,0)) I NURSROOT'>0 W !,$C(7),"CANNOT FIND THE 'Nursing Care Plan' ENTRY IN THE AGGREGATE TERM FILE" G Q1
 S GMRGRT=NURSROOT_"^"_$S($D(^GMRD(124.2,NURSROOT,0)):$P(^(0),"^"),1:"")
 S DIC(0)="EMQ",NASK=1,NACT=0 D EN7^NURSCUTL G:DFN'>0 Q1
PLAN S GMRGXPRT="0^1^1" D EN1^GMRGRUT3 G Q1:GMRGOUT!(+GMRGPDA'>0) I $P(GMRGPDA,"^",2)="@" G PLAN
GMRG S NURSCPE=$O(^NURSC(216.8,"B",GMRGPDA,0)) D:NURSCPE'>0 NEWPL G:NURSCPE'>0 Q1 D EN3^GMRGED0 G:'GMRGOUT EN1
Q1 D ^NURCKILL
 Q
NEWPL ;
 S X=GMRGPDA,DIC="^NURSC(216.8,",DIC(0)="Q" K DD D FILE^DICN S NURSCPE=+Y
 Q
