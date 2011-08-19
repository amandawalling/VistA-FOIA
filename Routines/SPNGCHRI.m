SPNGCHRI ;WDE/SD OUTCOME GRID FOR CHART 9/19/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
CALC ;
 S SPNGOAL=""
 S SPNXX=0 F  S SPNXX=$O(^TMP($J,SPNXX)) Q:SPNXX=""  S SPNYY=0 F  S SPNYY=$O(^TMP($J,SPNXX,SPNYY)) Q:SPNYY=""  S SPNZZ=0 F  S SPNZZ=$O(^TMP($J,SPNXX,SPNYY,SPNZZ)) Q:SPNZZ=""  D  Q:+SPNGOAL
 .I $P(^SPNL(154.1,SPNZZ,0),U,2)=4 I 27[$P(^SPNL(154.1,SPNZZ,2),U,17) S SPNGOAL=SPNZZ
 I SPNGOAL="" D ZAP^SPNOGRDA Q
 S XA=$S(SPNRSCO=4:"Finish",SPNRSCO=5:"F/U (END)",SPNRSCO=9:"Finish",SPNRSCO=10:"F/U (END)",1:"ERROR")
 ;Physical
 S SPNR1C1=$P($G(^SPNL(154.1,DA,"CHART")),U,1)
 I SPNR1C1="" S SPNR1C1=0
 S SPNR2C1=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,1)
 I SPNR2C1="" S SPNR2C1=0
 S SPNR3C1=SPNR1C1-SPNR2C1
 ;Mobility
 S SPNR1C2=$P($G(^SPNL(154.1,DA,"CHART")),U,2)
 I SPNR1C2="" S SPNR1C2=0
 S SPNR2C2=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,2)
 I SPNR2C2="" S SPNR2C2=0
 S SPNR3C2=SPNR1C2-SPNR2C2
 ;Occupation
 S SPNR1C3=$P($G(^SPNL(154.1,DA,"CHART")),U,3)
 I SPNR1C3="" S SPNR1C3=0
 S SPNR2C3=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,3)
 I SPNR2C3="" S SPNR2C3=0
 S SPNR3C3=SPNR1C3-SPNR2C3
 ;Social Int
 S SPNR1C4=$P($G(^SPNL(154.1,DA,"CHART")),U,4)
 I SPNR1C4="" S SPNR1C4=0
 S SPNR2C4=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,4)
 I SPNR2C4="" S SPNR2C4=0
 S SPNR3C4=SPNR1C4-SPNR2C4
 ;Economic
 S SPNR1C5=$P($G(^SPNL(154.1,DA,"CHART")),U,5)
 I SPNR1C5="" S SPNR1C5=0
 S SPNR2C5=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,5)
 I SPNR2C5="" S SPNR2C5=0
 S SPNR3C5=SPNR1C5-SPNR2C5
 ;Cognitive
 S SPNR1C6=$P($G(^SPNL(154.1,DA,"CHART")),U,6)
 I SPNR1C6="" S SPNR1C6=0
 S SPNR2C6=$P($G(^SPNL(154.1,SPNGOAL,"CHART")),U,6)
 I SPNR2C6="" S SPNR2C6=0
 S SPNR3C6=SPNR1C6-SPNR2C6
 ;TOTAL
 S SPNR1C7=$$GET1^DIQ(154.1,DA_",",999.06)
 S SPNR2C7=$$GET1^DIQ(154.1,SPNGOAL_",",999.06)
 S SPNR3C7=SPNR1C7-SPNR2C7
 Q
