RMPRE22 ;PHX/RFM-CONTINUATION OF RMPRE21 ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
 ;AMIS,660
 S R2=^RMPR(664,RMPRA,1,R1,0),RMPRBD=$P(R2,U,2)
 L +^RMPR(660,RMPRAR,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" Q
 S R2=^RMPR(664,RMPRA,1,R1,0)
 S RMPRTO=$P(R2,U,7) S:RMPRTO=""!(RMPRTO<0) RMPRTO=$P(R2,U,3)
 S $P(^RMPR(660,RMPRAR,0),U,16)=RMPRTO*$P(R2,U,4)
 S $P(^RMPR(660,RMPRAR,0),U,4)=$P(^RMPR(664,RMPRA,1,R1,0),U,9),$P(^RMPR(660,RMPRAR,"AM"),U,3)=$P(^RMPR(664,RMPRA,1,R1,0),U,10),$P(^RMPR(660,RMPRAR,"AM"),U,4)=$P(^RMPR(664,RMPRA,1,R1,0),U,11)
 S $P(^RMPR(660,RMPRAR,0),U,7)=$P(^RMPR(664,RMPRA,1,R1,0),U,4)
 S $P(^RMPR(660,RMPRAR,1),U,2)=RMPRBD K RMPRBD
 S $P(^RMPR(660,RMPRAR,0),U,12)=RMPR("DDT"),$P(^(0),U,11)=RMPRSER
 ;item remarks
 S RMPRCC=$P(^RMPR(664,RMPRA,1,R1,0),U,8)
 ;close remarks added to item remarks
 S RMPRCC=$S(RMPRCC'="":RMPRCC_" "_$P($G(^RMPR(664,RMPRA,2)),U,3),1:$P($G(^RMPR(664,RMPRA,2)),U,3))
 S $P(^RMPR(660,RMPRAR,0),U,18)=RMPRCC
 S $P(^RMPR(660,RMPRAR,0),U,15)=$S($P(^RMPR(664,RMPRA,1,R1,0),U,6)="N":"*",1:"")
 L -^RMPR(660,RMPRAR,0)
 S DA=RMPRAR,DIK="^RMPR(660," D IX1^DIK W !,"Updated "_$P(R1,U,1)_" 10-2319 record for this Veteran"
 I $D(RMPRWO),$D(^RMPR(664.2,+RMPRWO,0)) S DIC="^RMPR(664.2,"_RMPRWO_",1,",DA(1)=RMPRWO,DIC(0)="LZ",R660=^RMPR(660,RMPRAR,0),RMPRTRN=$P(^(1),U,1),X=$P(R660,U,6) D FILE^DICN I +Y>0 D
 .S $P(^RMPR(664.2,RMPRWO,1,+Y,0),U,2)=$P(R660,U,7),$P(^(0),U,3)=$J($P(R660,U,16)/$P(R660,U,7),0,2),$P(^(0),U,6)=$P(R660,U,9),$P(^(0),U,7)=$P(R660,U,8),$P(^(0),U,8)=RMPRSER
 .S $P(^RMPR(664.2,RMPRWO,1,+Y,0),U,10)=RMPRTRN,$P(^(0),U,4)=$P(R660,U,14),$P(^(0),U,11)=RMPRA,$P(^(0),U,12)=RMPRAR S DIK=DIC,DA(1)=RMPRWO,DA=+Y D IX1^DIK
 .S ^RMPR(664.2,RMPRWO,1,"AC",RMPRA,DA)=""
 Q
