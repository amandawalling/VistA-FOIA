LBRYX34 ; COMPILED XREF FOR FILE #682.04 ; 10/15/04
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^LBRY(682,DA(1),4,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^LBRY(682,DA(1),4,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^LBRY(682,DA(1),4,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" I "12"[X,'$P(^LBRY(682,DA(1),4,DA,0),U,6) S ^LBRY(682,"A2",DA(1),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" D NOCS^LBRYRTX
 S X=$P(DIKZ(0),U,6)
 I X'="" K ^LBRY(682,"A2",DA(1),DA)
 S X=$P(DIKZ(0),U,6)
 I X'="" S ^LBRY(682,"A3",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,7)
 I X'="" S:$P($G(^LBRY(682,DA(1),0)),U,2)'="" ^LBRY(682,"A4",X,$P(^LBRY(682,DA(1),0),U,2),DA(1),DA)=""
 S X=$P(DIKZ(0),U,7)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(1)=$S($D(^LBRY(682,D0,1)):^(1),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X=DIV S X=$P(^LBRY(682,DA(1),4,DA,0),U,7) X ^DD(682.04,5,1,2,1.4)
 G:'$D(DIKLM) A Q:$D(DISET)
END Q
