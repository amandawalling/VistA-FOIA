DGJTVW ;ALB/MAF - DISPLAY SCREENS FOR INCOMPLETE RECORDS TRACKING (LIST PROCESSOR) ; JAN 31,1989@900
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
EN2 D HDR^DGJTEE S DGJTVIEW=1 K DIC D EN^DGJTVW1 Q
 ;Display coded by and date coded on screens.
CODDT S DGJVAL="        "_$S('$D(DGJTVIEW):"*",1:"")_"Date Coded: "
 S X=""
 S X=$$SETSTR^VALM1(DGJVAL,X,42,21)
 S DGJT1=2 D 1 S Y=DGJVAL I DGJVAL]"" X ^DD("DD") S DGJVAL=Y
 S X=$$SETSTR^VALM1(DGJVAL,X,63,18) D TMP^DGJTVW2
 Q
CODBY S DGJVAL="           "_$S('$D(DGJTVIEW):"*",1:"")_"Coded By: "
 S X=""
 S X=$$SETSTR^VALM1(DGJVAL,X,42,21)
 S DGJT1=3 D 1 S DGJVAL=$S($D(^VA(200,+DGJVAL,0)):$P(^(0),"^"),1:"")
 S X=$$SETSTR^VALM1(DGJVAL,X,63,18) D TMP^DGJTVW2
 Q
1 S DGJVAL=$P(DGJTNO,"^",4) S DGJVAL=$S($D(^DGPM(+DGJVAL,0)):$P(^(0),"^",16),1:"") I DGJVAL]"" S DGJVAL=$S($D(^DGPT(DGJVAL,0)):$P(^DGPT(DGJVAL,0),"^",9),1:"") I DGJVAL]"" S DGJVAL=$S($D(^DGP(45.84,+DGJVAL,0)):$P(^(0),"^",DGJT1),1:"")
 Q
COM ;Code to print the comments lines on screens.
 S X=""
 S X=$$SETSTR^VALM1("4)",X,1,2) D TMP^DGJTVW2
 S X=""
 S X=$$SETSTR^VALM1("Comments:",X,1,9)
 S DGJVAL=$P(^VAS(393,$P(DGJTEDT,"^",2),"MSG"),"^",1)
 S X=$$SETSTR^VALM1($E(DGJVAL,1,64),X,11,64) D TMP^DGJTVW2
 S X=""
 S X=$$SETSTR^VALM1($E(DGJVAL,65,129),X,11,64) D TMP^DGJTVW2
 S X=""
 S X=$$SETSTR^VALM1($E(DGJVAL,130,194),X,11,64) D TMP^DGJTVW2
 S X=""
 S X=$$SETSTR^VALM1($E(DGJVAL,195,232),X,11,64) D TMP^DGJTVW2
 Q
STAT1 ;check on the status of the report after a change has been made.
 I $D(DGJTSF),$P(DGJTNDT,"^",1)']"",$P(DGJTNDT,"^",5)']"" S DGJTST="INCOMPLETE" G STAT
 I $D(DGJTSF),$P(DGJTNDT,"^",1)']"",$P(DGJTNDT,"^",7)]"" S DGJTST="REVIEWED" G STAT
 I $D(DGJTSF),$P(DGJTNDT,"^",1)']"",$P(DGJTNDT,"^",5)]"",$P(DGJTDEL,"^",3)=0 S DGJTST="SIGNED NO REVIEW" G STAT
 I $D(DGJTSF),$P(DGJTNDT,"^",1)']"",$P(DGJTNDT,"^",5)]"",$P(DGJTDEL,"^",3)=1 S DGJTST="SIGNED" G STAT
 I $P(DGJTNDT,"^",1)']"" S DGJTST="INCOMPLETE" G STAT
 I $P(DGJTNDT,"^",3)']"" S DGJTST="DICTATED" G STAT
 I $P(DGJTNDT,"^",5)']"" S DGJTST="TRANSCRIBED" G STAT
 I $P(DGJTDEL,"^",3)=0 S DGJTST="SIGNED NO REVIEW" G STAT
 I $P(DGJTNDT,"^",7)']"" S DGJTST="SIGNED" G STAT
 I $P(DGJTDEL,"^",3)=1 S DGJTST="REVIEWED"
STAT S DGJTNSTA=$O(^DG(393.2,"B",DGJTST,0)) S DIE="^VAS(393,",DA=$P(DGJTEDT,"^",2),DR=".11////^S X=DGJTNSTA" D ^DIE K DR,DIE S $P(DGJTNO,"^",11)=DGJTNSTA K DGJTNSTA
 Q
