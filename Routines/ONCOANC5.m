ONCOANC5 ;Hines OIFO/GWB - BUILDS FREE TEXT PORTION OF STATE REPORTING ;11 MAR 96
 ;;2.11;ONCOLOGY;**1,25,26**;MAR 07, 1995
SHTXT Q:AASTYPNC'="A"  K AASTXB S $P(AASTXB," ",351)=""
 S (AAS("S",1),AAS("S",2))=40,AAS("S",3)=100,AAS("S",4)=50
 F CN=1:1:3 S AASY(CN)=$P($G(^ONCO(165.5,D0,8)),U,CN) D
 . S AASY(CN)=AASY(CN)_$E(AASTXB,1,AAS("S",CN)-$L(AASY(CN)))
 S AASY(4)=$P($G(^ONCO(165.5,D0,0)),U,17)
 S:AASY(4)>0 AASY(4)=$E($P($G(^ONCO(160.19,AASY(4),0)),U,2),1,50)
 S AASY(4)=AASY(4)_$E(AASTXB,1,AAS("S",4)-$L(AASY(4)))
WP F CN=9,11,12,13,22 S AAS("S",CN)=250
 S (AAS("S",10),AAS("S",17),AAS("S",18))=200
 S (AAS("S",14),AAS("S",15),AAS("S",16))=150
 S (AAS("S",20),AAS("S",21))=100,AAS("S",19)=350
 F CN=9:1:22 S CNT=0,AASY(CN)="" D
 .I '$D(^ONCO(165.5,D0,CN)) S AASY(CN)=$E(AASTXB,1,AAS("S",CN)) Q
 .S CNT=0 F  S CNT=$O(^ONCO(165.5,D0,CN,CNT)) Q:CNT'>0!($L(AASY(CN))'<AAS("S",CN))  D
 ..S AAS(CN,CNT)=$G(^ONCO(165.5,D0,CN,CNT,0))
 ..I $L(AASY(CN))+$L(AAS(CN,CNT))>AAS("S",CN) S AASY(CN)=AASY(CN)_$E(AAS(CN,CNT),1,AAS("S",CN)-$L(AASY(CN))) Q
 ..S AASY(CN)=AASY(CN)_AAS(CN,CNT)
 .S AASY(CN)=$E(AASY(CN)_$E(AASTXB,1,AAS("S",CN)-$L(AASY(CN))),1,AAS("S",CN))
 K AAS
SETTMP S ^TMP($J,D0,1075)=$E(AASTXB,1,75),^TMP($J,D0,1150)=$E(AASTXB,1,75)
 S ^TMP($J,D0,1225)=$E(AASY(10),1,75)
 S ^TMP($J,D0,1300)=$E(AASY(10),76,150)
 S ^TMP($J,D0,1375)=$E(AASY(10),151,200)_$E(AASY(11),1,25)
 S ^TMP($J,D0,1450)=$E(AASY(11),26,100)
 S ^TMP($J,D0,1525)=$E(AASY(11),101,175)
 S ^TMP($J,D0,1600)=$E(AASY(11),176,250)
 S ^TMP($J,D0,1675)=$E(AASY(12),1,75)
 S ^TMP($J,D0,1750)=$E(AASY(12),76,150)
 S ^TMP($J,D0,1825)=$E(AASY(12),151,225)
 S ^TMP($J,D0,1900)=$E(AASY(12),226,250)_$E(AASY(22),1,50)
 S ^TMP($J,D0,1975)=$E(AASY(22),51,125)
 S ^TMP($J,D0,2050)=$E(AASY(22),126,200)
 S ^TMP($J,D0,2125)=$E(AASY(22),201,250)_$E(AASY(9),1,25)
 S ^TMP($J,D0,2200)=$E(AASY(9),26,100)
 S ^TMP($J,D0,2275)=$E(AASY(9),101,175)
 S ^TMP($J,D0,2350)=$E(AASY(9),176,250)
 S ^TMP($J,D0,2425)=$E(AASY(13),1,75)
 S ^TMP($J,D0,2500)=$E(AASY(13),76,150)
 S ^TMP($J,D0,2575)=$E(AASY(13),151,225)
 S ^TMP($J,D0,2650)=$E(AASY(13),226,250)_$E(AASY(1),1,40)_$E(AASY(2),1,10)
 S ^TMP($J,D0,2725)=$E(AASY(2),11,40)_$E(AASTXB,1,45)
 S ^TMP($J,D0,2800)=$E(AASTXB,1,75)
 S ^TMP($J,D0,2875)=$E(AASTXB,1,75)
 S ^TMP($J,D0,2950)=$E(AASTXB,1,75)
 S ^TMP($J,D0,3025)=$E(AASTXB,1,30)_$E(AASY(14),1,45)
 S ^TMP($J,D0,3100)=$E(AASY(14),46,120)
 S ^TMP($J,D0,3175)=$E(AASY(14),121,150)_$E(AASY(15),1,45)
 S ^TMP($J,D0,3250)=$E(AASY(15),46,120)
 S ^TMP($J,D0,3325)=$E(AASY(15),121,150)_$E(AASY(16),1,45)
 S ^TMP($J,D0,3400)=$E(AASY(16),46,120)
 S ^TMP($J,D0,3475)=$E(AASY(16),121,150)_$E(AASY(17),1,45)
 S ^TMP($J,D0,3550)=$E(AASY(17),46,120)
 S ^TMP($J,D0,3625)=$E(AASY(17),121,195)
 S ^TMP($J,D0,3700)=$E(AASY(17),196,200)_$E(AASY(18),1,70)
 S ^TMP($J,D0,3775)=$E(AASY(18),71,145)
 S ^TMP($J,D0,3850)=$E(AASY(18),146,200)_$E(AASY(20),1,20)
 S ^TMP($J,D0,3925)=$E(AASY(20),21,95)
 S ^TMP($J,D0,4000)=$E(AASY(20),96,100)_$E(AASY(21),1,70)
 S ^TMP($J,D0,4075)=$E(AASY(21),71,100)_$E(AASY(19),1,45)
 S ^TMP($J,D0,4150)=$E(AASY(19),46,120)
 S ^TMP($J,D0,4225)=$E(AASY(19),121,195)
 S ^TMP($J,D0,4300)=$E(AASY(19),196,270)
 S ^TMP($J,D0,4375)=$E(AASY(19),271,345)
 S ^TMP($J,D0,4450)=$E(AASY(19),346,350)_$E(AASY(3),1,70)
 S ^TMP($J,D0,4525)=$E(AASY(3),71,100)_$E(AASY(4),1,45)
 S ^TMP($J,D0,4600)=$E(AASY(4),46,50)_$E(AASTXB,1,70)
 S ^TMP($J,D0,4675)=$E(AASTXB,1,75)
 K AAS,AASY,AASTXB,CN,CNT
