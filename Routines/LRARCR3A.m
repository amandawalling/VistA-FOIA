LRARCR3A ;DALISC/CKA - ARCHIVEDWKLD REP GENERATOR-PRINT 2 ;
 ;;5.2;LAB SERVICE;**59**;Aug 31, 1995
 ;clone of LRCAPR3A
COND ;
 D HDR1^LRARCR4
 D LOC Q:LREND
 D LRMAC Q:LREND
 D:LRCTL CONTROL Q:LREND
 D WKLD Q:LREND
 D STAT^LRARCR3B
 Q
LOC ;
 Q:'$D(^TMP("LRAR",$J,"TST/LOC"))
 S LRSUBH1="TOTAL TESTS BY LOCATION: % of GRAND TOTAL"_" ( "_LRSUM_" )"
 W !!!?15,LRSUBH1,!?15,$E(LRDSH,1,$L(LRSUBH1)),!
 S LRLOC=""
 F I=0:1 S LRLOC=$O(^TMP("LRAR",$J,"TST/LOC",LRLOC)) Q:(LRLOC="")!(LREND)  D
 . S X=I#2 W:'X ! W ?X*40
 . W $E(LRLOC_"                    ",1,20),"="
 . W $J(^TMP("LRAR",$J,"TST/LOC",LRLOC),4),"  "
 . W $J($FN($S(LRSUM:^(LRLOC)/LRSUM,1:0)*100,"",2),5),"%"
 . I X,$Y+6>IOSL D UP1^LRARCR4 Q:LREND
 Q
LRMAC ;
 Q:'$D(^TMP("LRAR",$J,"TST/LRM"))
 S LRSUBH1="TOTAL TESTS by INSTRUMENTS: % of GRAND TOTAL"_" ( "_LRSUM_" )"
 I $Y+9>IOSL D PAUSE^LRARCR4 Q:LREND  W @IOF D HDR1^LRARCR4
 W !!!?15,LRSUBH1,!?15,$E(LRDSH,1,$L(LRSUBH1))
 S LRMAC=""
 F  S LRMAC=$O(^TMP("LRAR",$J,"TST/LRM",LRMAC)) Q:(LRMAC="")!(LREND)  S LRLMAC=^(LRMAC) D
 . I $Y+6>IOSL D UP1^LRARCR4 Q:LREND
 . W !!,LRMAC,"   =",$J(LRLMAC,5),"    "
 . W $J($FN($S(LRSUM:LRLMAC/LRSUM,1:0)*100,"",2),5),"%"
 . S LRTEST=""
 . F I=0:1 S LRTEST=$O(^TMP("LRAR",$J,"TST/LRM",LRMAC,LRTEST)) Q:(LRTEST="")!(LREND)  D
 . . S X=I#2 W:'X ! W ?X*40+1
 . . W LRTEST," = ",$J(^TMP("LRAR",$J,"TST/LRM",LRMAC,LRTEST),5)
 . . W "    ",$J($FN($S(LRLMAC:^(LRTEST)/LRLMAC,1:0)*100,"",2),5),"%"
 . . I X,$Y+6>IOSL D UP1^LRARCR4 Q:LREND
 Q
CONTROL ;
 Q:'$D(^TMP("LRAR",$J,"TST/CTL"))
 S LRSUBH1="Total CONTROL TESTS by INSTRUMENTS: % of GRAND TOTAL"_" ( "_LRSUM_" )"
 I $Y+9>IOSL D PAUSE^LRARCR4 Q:LREND  W @IOF D HDR1^LRARCR4
 W !!!?15,LRSUBH1,!?15,$E(LRDSH,1,$L(LRSUBH1))
 S LRMAC=""
 F  S LRMAC=$O(^TMP("LRAR",$J,"TST/CTL",LRMAC)) Q:(LRMAC="")!(LREND)  S LRLMAC=^(LRMAC) D
 . I $Y+6>IOSL D UP1^LRARCR4 Q:LREND
 . W !!,LRMAC,"   =",$J(LRLMAC,5),"    "
 . W $J($FN($S(LRSUM:LRLMAC/LRSUM,1:0)*100,"",2),5),"%"
 . S LRTEST=""
 . F I=0:1 S LRTEST=$O(^TMP("LRAR",$J,"TST/CTL",LRMAC,LRTEST)) Q:(LRTEST="")!(LREND)  D
 . . S X=I#2 W:'X ! W ?X*40+1
 . . W LRTEST," = ",$J(^TMP("LRAR",$J,"TST/CTL",LRMAC,LRTEST),5)
 . . W "    ",$J($FN($S(LRLMAC:^(LRTEST)/LRLMAC,1:0)*100,"",2),5),"%"
 . . I X,$Y+6>IOSL D UP1^LRARCR4 Q:LREND
 Q
WKLD ;
 Q:'$D(^TMP("LRAR",$J,"TST"))
 S LRSUBH1="TOTAL WKLD by TESTS: % of GRAND TOTAL"_" ( "_LRSUM_" )"
 I $Y+9>IOSL D PAUSE^LRARCR4 Q:LREND  W @IOF D HDR1^LRARCR4
 W !!!,?15,LRSUBH1,!?15,$E(LRDSH,1,$L(LRSUBH1)),!
 S LRTEST=""
 F I=0:1 S LRTEST=$O(^TMP("LRAR",$J,"TST",LRTEST)) Q:(LRTEST="")!(LREND)  D
 . I 'I#2,$Y+6>IOSL D UP1^LRARCR4 Q:LREND
 . S X=I#2 W:'X ! W ?X*40+1
 . W $E(LRTEST_"      ",1,8)," = ",$J(^TMP("LRAR",$J,"TST",LRTEST),5)
 . W " ",$J($FN($S(LRSUM:^(LRTEST)/LRSUM,1:0)*100,"",2),5),"%  "
 Q
