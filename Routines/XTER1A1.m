XTER1A1 ;ISC-SF.SEA/JLI - CONTINUTATION OF ERROR REPORTING ;12/7/93  14:16
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 Q
INTRACT ;
 K XTPRNT
 S %DT="AEQX",%DT("A")="Starting Date: " D ^%DT K %DT Q:Y'>0  S XTNDAT1=Y S XTNDAT2=Y I Y<DT S %DT="AEQX",%DT("A")="Ending Date:   " D ^%DT K %DT Q:Y'>0  S XTNDAT2=Y I Y<XTNDAT1 W !!,$C(7),"ENDING DATE can not be BEFORE start date" G INTRACT
 S DIR(0)="N^1:10",DIR("A")="List first N occurrences, where N = " D ^DIR K DIR S XTNUM=+Y Q:Y'>0
INT S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^XTER1A1",ZTIO=ION,ZTDESC="XTERTRP PRINT ERRS",ZTSAVE("XTNDAT1")="",ZTSAVE("XTNDAT2")="",ZTSAVE("XTNUM")="" D ^%ZTLOAD K XTNDAT1,XTNDAT2,XTNUM,ZTSK Q
DQ ;
 K ^TMP($J,"XTER1A") S XTNDAT1=+$$FMTH^XLFDT(XTNDAT1),XTNDAT2=+$$FMTH^XLFDT(XTNDAT2) F XTNDATE=XTNDAT1:1:XTNDAT2 D LISTN^XTER1A
 D LIST^XTER1A
 Q
