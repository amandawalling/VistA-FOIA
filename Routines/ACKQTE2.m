ACKQTE2 ; ;11/10/10
 D DE G BEGIN
DE S DIE="^ACK(509850.6,D0,1,",DIC=DIE,DP=509850.63,DL=2,DIEL=1,DU="" K DG,DE,DB Q:$O(^ACK(509850.6,D0,1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,1) S:%]"" DE(1)=% S %=$P(%Z,U,2) S:%]"" DE(5)=% S %=$P(%Z,U,3) S:%]"" DE(8)=% S %=$P(%Z,U,4) S:%]"" DE(11)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="ACKQTE2",DQ=1+D G B
1 S DW="0;1",DV="M*P509850.1'X",DU="",DLB="DIAGNOSTIC CODE",DIFLD=.01
 S DE(DW)="C1^ACKQTE2"
 S DU="ACK(509850.1,"
 G RE:'D S DQ=2 G 2
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 K ^ACK(509850.6,DA(1),1,"B",$E(X,1,30),DA)
 S X=DE(1),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^ACK(509850.6,DA(1),1,"B",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C1F1 Q
X1 S DIC("S")="I $D(ACKCSC),$$ICD^ACKQUT1(+Y,ACKVD,ACKCSC)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S ACKDC=X
 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 D DC^ACKQASU
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 I $$PRIMARY^ACKQASU5(ACKVIEN,DA) S Y="@45"
 Q
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW="0;2",DV="RSX",DU="",DLB="Is this the Primary Diagnosis ?",DIFLD=.12
 S DE(DW)="C5^ACKQTE2"
 S DU="1:YES;0:NO;"
 S X=""
 S Y=X
 G Y
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C5F1 Q
X5 I X=1,$$PRIMARY^ACKQASU5(DA(1),"") K X
 Q
 ;
6 S DQ=7 ;@45
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I '$$PROB^ACKQUTL4(ACKPCE,ACKDIV)!(+$$PLIST^ACKQUTL6(ACKPAT,ACKDC)=2) S Y="@49"
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;3",DV="RS",DU="",DLB="Update PCE Problem List with Diag. code ?",DIFLD=.13
 S DU="1:YES;0:NO;"
 S X=""
 S Y=X
 G Y
X8 Q
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I X=0 S Y="@49"
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I '$$PROB^ACKQUTL4(ACKPCE,ACKDIV)!(+$$PLIST^ACKQUTL6(ACKPAT,ACKDC)=2) S Y="@49"
 Q
11 S DW="0;4",DV="R*P509850.3'X",DU="",DLB="DIAGNOSIS PROVIDER",DIFLD=.14
 S DE(DW)="C11^ACKQTE2"
 S DU="ACK(509850.3,"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 X "D SEND^ACKQUTL5(DA(1))"
C11F1 Q
X11 S DIC("S")="I $D(ACKVD) S ACKVALSC=$$STACT^ACKQUTL(+Y,ACKVD) I ACKVALSC=""0""!(ACKVALSC=""-6"")" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
12 S DQ=13 ;@49
13 G 1^DIE17
