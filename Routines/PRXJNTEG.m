PRXJNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2951215.133603
 ;;5.0;IFCAP;**47**;
 ;;7.3;2951215.133603
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
PRCBCC ;;13827944
PRCFFMOM ;;12021110
PRCHAMXD ;;3133756
PRCHE ;;12972605
PRXJI001 ;;5659000
PRXJI002 ;;6259396
PRXJI003 ;;7191351
PRXJI004 ;;9335594
PRXJI005 ;;8145421
PRXJI006 ;;10307957
PRXJI007 ;;7889450
PRXJI008 ;;8321092
PRXJI009 ;;9600577
PRXJI00A ;;6012758
PRXJI00B ;;7561891
PRXJI00C ;;9061029
PRXJI00D ;;2771093
PRXJI00E ;;1792317
PRXJINI1 ;;4837823
PRXJINI2 ;;5232635
PRXJINI3 ;;16808312
PRXJINI4 ;;3357807
PRXJINI5 ;;433660
PRXJINIS ;;2217136
PRXJINIT ;;10189614
