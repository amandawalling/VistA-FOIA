PSJXR515 ; COMPILED XREF FOR FILE #55.06 ; 10/28/97
 ; 
 I X'="" S ^PS(55,DA(1),5,"AUS",+X,DA)="" I $P($G(^PS(55,DA(1),5,DA,0)),"^",7)]"" S ^PS(55,DA(1),5,"AU",$P(^(0),"^",7),+X,DA)=""
 S X=$P(DIKZ(2),U,4)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(53))#2 KILL^PSGAL5:PSGAL(53)=X K PSGAL
 S X=$P(DIKZ(2),U,4)
 I X'="" S ^PS(55,"AUD",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(5),U,4)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(61))#2 KILL^PSGAL5:PSGAL(61)=X K PSGAL
 S X=$P(DIKZ(5),U,3)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(54))#2 KILL^PSGAL5:PSGAL(54)=X K PSGAL
 S X=$P(DIKZ(5),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I X S DIU=$S($D(^PS(55,DA(1),5,DA,5)):$P(^(5),"^",4),1:""),$P(^(5),"^",4)=DIU+X I $O(^DD(55.06,35,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV=DIU+X,DIH=55.06,DIG=35 D ^DICR
 S X=$P(DIKZ(5),U,5)
 I X'="" ; I X S PSGAMSF=2 D ^PSGAMSA
 S X=$P(DIKZ(2),U,5)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(56))#2 KILL^PSGAL5:PSGAL(56)=X K PSGAL
 S X=$P(DIKZ(2),U,5)
 I X'="" I $P($G(^PS(55,DA(1),5,DA,2)),"^")["@" S $P(^(2),"^")=$P($P(^(2),"^"),"@")_"@"_X
 S X=$P(DIKZ(2),U,6)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(57))#2 KILL^PSGAL5:PSGAL(57)=X K PSGAL
 S X=$P(DIKZ(4),U,15)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(58)) KILL^PSGAL5:PSGAL(58)=X K PSGAL
 S X=$P(DIKZ(4),U,16)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(59))#2 KILL^PSGAL5:PSGAL(59)=X K PSGAL
 S X=$P(DIKZ(4),U,17)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(60))#2 KILL^PSGAL5:PSGAL(60)=X K PSGAL
 S X=$P(DIKZ(4),U,12)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(63)) KILL^PSGAL5:PSGAL(63)=X K PSGAL
 S X=$P(DIKZ(4),U,13)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(64)) KILL^PSGAL5:PSGAL(64)=X K PSGAL
 S X=$P(DIKZ(4),U,14)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(65)) KILL^PSGAL5:PSGAL(65)=X K PSGAL
 S X=$P(DIKZ(4),U,11)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(62))#2 KILL^PSGAL5:PSGAL(62)=X K PSGAL
 S X=$P(DIKZ(4),U,9)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(66)) KILL^PSGAL5:PSGAL(66)=X K PSGAL
 S X=$P(DIKZ(4),U,10)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(67)) KILL^PSGAL5:PSGAL(67)=X K PSGAL
 S DIKZ(7)=$G(^PS(55,DA(1),5,DA,7))
 S X=$P(DIKZ(7),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(68)) KILL^PSGAL5:PSGAL(68)=X K PSGAL
 S X=$P(DIKZ(7),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(69)) KILL^PSGAL5:PSGAL(69)=X K PSGAL
 S X=$P(DIKZ(5),U,7)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(70)) KILL^PSGAL5:PSGAL(70)=X K PSGAL
 S X=$P(DIKZ(5),U,8)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I X S DIU=$S($D(^PS(55,DA(1),5,DA,5)):$P(^(5),"^",7),1:""),$P(^(5),"^",7)=DIU+X I $O(^DD(55.06,54,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV=DIU+X,DIH=55.06,DIG=54 D ^DICR
 S X=$P(DIKZ(5),U,8)
 I X'="" ; I '$D(DIU(0)),X S PSGAMSF=0 D ^PSGAMSA
 S X=$P(DIKZ(4),U,18)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(71)) KILL^PSGAL5:PSGAL(71)=X K PSGAL
 S X=$P(DIKZ(4),U,19)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(72)) KILL^PSGAL5:PSGAL(72)=X K PSGAL
 S X=$P(DIKZ(4),U,20)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(73)) KILL^PSGAL5:PSGAL(73)=X K PSGAL
 S X=$P(DIKZ(4),U,21)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(74)) KILL^PSGAL5:PSGAL(74)=X K PSGAL
 S X=$P(DIKZ(4),U,22)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(75)) KILL^PSGAL5:PSGAL(75)=X K PSGAL
 S X=$P(DIKZ(4),U,23)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(76)) KILL^PSGAL5:PSGAL(76)=X K PSGAL
 S X=$P(DIKZ(4),U,24)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(77)) KILL^PSGAL5:PSGAL(77)=X K PSGAL
 S X=$P(DIKZ(0),U,20)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(79)) KILL^PSGAL5:PSGAL(79)=X K PSGAL
 S X=$P(DIKZ(0),U,20)
 I X'="" S ^PS(55,"AUDDD",$E(X,1,30),DA(1),DA)=""
 S DIKZ(6.5)=$G(^PS(55,DA(1),5,DA,6.5))
 S X=$P(DIKZ(6.5),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(78)) KILL^PSGAL5:PSGAL(78)=X K PSGAL
 S X=$P(DIKZ(0),U,21)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(80)) KILL^PSGAL5:PSGAL(80)=X K PSGAL
 S DIKZ(.1)=$G(^PS(55,DA(1),5,DA,.1))
 S X=$P(DIKZ(.1),U,1)
 I X'="" S ^PS(55,DA(1),5,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(.1),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(101)) KILL^PSGAL5:PSGAL(101)=X K PSGAL
 S X=$P(DIKZ(.1),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(102)) KILL^PSGAL5:PSGAL(102)=X K PSGAL
 S X=$P(DIKZ(0),U,24)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(103)) KILL^PSGAL5:PSGAL(103)=X K PSGAL
 S X=$P(DIKZ(0),U,25)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(104)) KILL^PSGAL5:PSGAL(104)=X K PSGAL
 S X=$P(DIKZ(0),U,26)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(105)) KILL^PSGAL5:PSGAL(105)=X K PSGAL
 S X=$P(DIKZ(.1),U,3)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(106)) KILL^PSGAL5:PSGAL(106)=X K PSGAL
 S X=$P(DIKZ(0),U,27)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(107)) KILL^PSGAL5:PSGAL(107)=X K PSGAL
 G:'$D(DIKLM) A^PSJXR514 Q:$D(DISET)
END G ^PSJXR516
