LRCAPDL ;DALISC/FHS - FORMATE DATA FROM 64.03 FOR DOWN LOAD TO SPREAD SHEET
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ;
 D ^%ZISC I '$O(^LRO(64.03,0)) W !?5,"Sorry   No data to down load",!! G END
 W !!,?20,"THE CHARACTER '^' IS NOT ALLOWED ",!
 R !!?10,"WHAT CHARACTER SHOULD BE USED TO SEPARATE THE FIELDS ",LRCH:DTIME
 G:'$T!(LRCH="^") END
 I '$L(LRCH) W !!?5,$C(7),"YOU MUST SELECT SOME CHARACTER ",!! G EN
 W !,"OK",! D ^%ZIS G END:POP U IO(0)
PRT W !,"YOU MAY PRESS RETURN/ENTER KEY TO STOP TRANSMISSION OF DATA ",!
 R !!?5,"PRESS RETURN WHEN READY ",X:500 G:'$T END
 W ! S (CNT,I)=0 F  S I=$O(^LRO(64.03,I)) Q:I=""  I $D(^(I,0)) S X=$TR(^(0),"^",LRCH) U IO W X,! S CNT=CNT+1 U IO(0) R LRSTOP:.001 Q:$T
 U IO(0) W !,"DOWN LOADED ",CNT," LINES OF DATA ",!!
END ;
 D ^%ZISC
 W !!?30,"CELL DATA FORMAT ",!
 W !,"CELL 1=SEQ NUMBER",?25,"CELL 2=PROVIDER ",?52,"CELL 3=PATIENT"
 W !,"CELL 4=DATE COMPLETED",?25,"CELL 5=REPORTING SITE",?52,"CELL 6=LOCATION TYPE"
 W !,"CELL 7=ACCESSION AREA",?25,"CELL 8=LAB TEST NAME",?52,"CELL 9=URGENCY"
 W !,"CELL 10=TREATING SPEC",?25,"CELL 11=WKLD CODE",?52,"CELL 12=INVERSE DATE"
 W !,"CELL 13=DATE COLLECTED",?25,"CELL 14=DATE ORDERED",?52,"CELL 15=HOSPITAL LOCATION"
 W !,"CELL 16=ACCESSION FILE INDEX",!
 Q
