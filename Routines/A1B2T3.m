A1B2T3 ;ALB/EG EXTRACT FROM ODS FILES AND PUT IN MESSAGE 3 ; JAN 12 1991
 ;;Version 1.55 (local for MAS v5 sites);;
DIS ;use AX x-ref from 11500.3
 Q:'$D(^A1B2(11500.3,"AX",A1B2TR))  S A1B2DA="" F AI=1:1 S A1B2DA=$O(^A1B2(11500.3,"AX",A1B2TR,A1B2DA)) Q:A1B2DA=""  S A1B2PTR=$P(^A1B2(11500.3,A1B2DA,0),U,2) I (A1B2PTR'=""),($D(^A1B2(11500.1,A1B2PTR))>0) D DIS1
 Q
DIS1 ;use EN^DIQ1
 S FL=11500.3,DIC="^A1B2(11500.3,",DA=A1B2DA,DIQ="ODS(",DIQ(0)="I",DR=".01;.03;.07;.08;.09;.1;.11;.12;.14;.15" D EN^DIQ1 S A1B2FAC=+ODS(FL,DA,.07,"I")
 S ^UTILITY("TRN",$J,A1B2TR,4,KNT,0)="$DIS"_U_ODS(FL,DA,.01,"I")_U_ODS(FL,DA,.03,"I")_U_U_U_ODS(FL,DA,.07,"I")_U_ODS(FL,DA,.08,"I")_U_ODS(FL,DA,.09,"I")_U
 S ^UTILITY("TRN",$J,A1B2TR,4,KNT,0)=^(0)_ODS(FL,DA,.1,"I")_U_ODS(FL,DA,.11,"I")_U_ODS(FL,DA,.12,"I")_U_ODS(FL,DA,.14,"I")_U_ODS(FL,DA,.15,"I"),KNT=KNT+1,KNT4=KNT4+1
 S ^UTILITY("TRN2",$J,A1B2TR,FL,A1B2DA)="" K DIC,DA,DIQ,DIQ(0),DR,ODS D:'$D(^UTILITY("TRN",$J,A1B2TR,1,A1B2PTR)) PAT^A1B2T1
 Q
BIL ;billing record
 F AI1=5:1:8 S KNT(AI1)=0
 F FL1=11500.61,11500.62,11500.63,11500.64 S FLB=$S(FL1=11500.61:"$BIL",FL1=11500.62:"$PRO",FL1=11500.63:"$DIA",FL1=11500.64:"$ASC",1:0),FLC=(FL1*100)-1150056,KNT=0 D BIL1
 K A1B2BA,A1B2DA,A1B2FAC,A1B2PTR,AI,AI1,AI2,AI3,AJ,AJ9,FL,FLC,KNT,KNT4
 Q
BIL1 Q:'$D(^A1B2(FL1,"AX",A1B2TR))  S A1B2BA="" F AI2=1:1 S A1B2BA=$O(^A1B2(FL1,"AX",A1B2TR,A1B2BA)) Q:A1B2BA=""  S AJ9=$S($D(^A1B2(FL1,A1B2BA,0)):$P(^(0),U,2),1:0) D:(AJ9'=0)&(AJ9'="")&('$D(^UTILITY("TRN2",$J,A1B2TR,FL1,A1B2BA))) BIL2
 Q
BIL2 S DIC="^A1B2("_FL1_",",DA=A1B2BA,DIQ="ODS(",DIQ(0)="I",DR=".01;.02;.03;.04;.05;.07;.08;.09;.12;.14;.15;.16;.2;.21" D EN^DIQ1 S A1B2FAC=+ODS(FL1,DA,.07,"I"),DR=".01",DIQ(0)="E" D EN^DIQ1
 F AI3=.01,.02,.03,.04,.05,.07,.08,.09,.12,.14,.15,.16,.2,.21 S:'$D(ODS(FL1,DA,AI3,"I")) (ODS(FL1,DA,AI3,"I"),ODS(FL1,DA,AI3,"I"))=""
 S AJ=FLB_"^^^^^^^^^^^^^"
 S $P(AJ,U,2)=ODS(FL1,DA,.01,"E"),$P(AJ,U,3)=ODS(FL1,DA,.03,"I"),$P(AJ,U,6)=ODS(FL1,DA,.07,"I"),$P(AJ,U,7)=ODS(FL1,DA,.08,"I"),$P(AJ,U,8)=ODS(FL1,DA,.09,"I"),$P(AJ,U,11)=ODS(FL1,DA,.12,"I")
 S $P(AJ,U,12)=ODS(FL1,DA,.14,"I"),$P(AJ,U,13)=ODS(FL1,DA,.15,"I"),$P(AJ,U,14)=ODS(FL1,DA,.16,"I")
 I FLC=6 S $P(AJ,U,3)=ODS(FL1,DA,.03,"I")
 I FLC=8 S $P(AJ,U,2)=ODS(FL1,DA,.01,"I"),$P(AJ,U,4)=ODS(FL1,DA,.04,"I"),$P(AJ,U,5)=ODS(FL1,DA,.05,"I")
 S KNT=KNT+1,KNT(FLC)=KNT(FLC)+1,^UTILITY("TRN",$J,A1B2TR,FLC,KNT,0)=AJ
 S ^UTILITY("TRN2",$J,A1B2TR,FL1,A1B2BA)="" K DIC,DIQ,DR
 I '$D(^UTILITY("TRN2",$J,A1B2TR,11500.2,ODS(FL1,DA,.02,"I"))) S A1B2DA=ODS(FL1,DA,.02,"I"),A1B2PTR=ODS(FL1,DA,.12,"I"),FL=11500.2 K ODS D ADM1^A1B2T1
 K DA,ODS
 Q
