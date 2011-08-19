PSJDOSE ;BIR/MV-POSSIBLE DOSES UTILITY ; 1/28/10 8:21am
 ;;5.0; INPATIENT MEDICATIONS ;**50,65,106,111,216**;16 DEC 97;Build 10
 ;
 ; Reference to ^PSSORPH is supported by DBIA #3234.
 ;
 ;PSJDSFLG: Set to 1 if Dose and DD are not compatible
 ;PSJDSSEL: The selected dose in format:
 ;          Dosage Order^DD IEN^DUPD/BCMA DUPD^1(if BCMA DUPD exist
 ;PSJDSUPD: Set to 1 if need to prompt for the Units Per Dose
 ;
EDITDOSE ;Editing Dosage Ordered for active order
 ;*Need to set PSJDSFLG to null when call EDITDOSE.
 NEW PSGOER1,PSJDD,PSJDSUPD,PSJDSSEL,PSJX,Y
 ;Offer the possible doses from the only one or 1st DD
 S PSJX=$O(^PS(53.45,PSJSYSP,2,0)) S PSJDD=+$G(^(+PSJX,0))
 D DOSE(PSJDD)
 D DOSECHK
 I +PSJDSFLG D
 . W !!,PSJDOSE("WARN"),!,PSJDOSE("WARN1"),!
 . D PAUSE^VALM1
 S PSGOEE=2
 Q
GETDOSE(PSJDD) ;Dosage Order
 NEW PSJDSSEL,PSJDSUPD
 D DOSE(PSJDD)
 Q:'$D(PSJDSSEL)
 D:+$G(PSJDSUPD) DUPD
 D:'+$G(PSJDSUPD) SETDUPD($P(PSJDSSEL,U,3))
 D DOSECHK
 I +$G(PSJDSFLG) D
 . W !!,PSJDOSE("WARN"),!,PSJDOSE("WARN1"),!
 Q
 ;
SETVAR ;
 S PSJDOSE("WARN")="WARNING: Dosage Ordered and Dispense Units do not match."
 S PSJDOSE("WARN1")="         Please verify Dosage."
 Q
 ;
DOSE(PSJDD) ;Prompt for Dosage Ordered
 ;PSJDD: Dispense drug IEN
 ;
 NEW DA,DR,DIR,DTOUT,DUOUT,DIRUT,PSJDL,PSJX,PSJPIECE,PSJCONT
 D SETVAR
 D DOSE^PSSORPH(.PSJDOX,+PSJDD,"U")
 I '$D(PSJDOX) S PSJDOX(1)=-1
 S PSJPIECE=$S($P(PSJDOX(1),U,11)]"":11,1:3)
 I PSJPIECE=3 S:$S($P(PSJDOX(1),U,3)="":1,1:$P(PSJDOX(1),U)=-1) $P(PSJDOX(1),U)=-1
AGAIN ;Prompt for dosage order again
 S PSJX=0
 NEW DIR
 W:($P(PSJDOX(1),U)'=-1) !!,"Available Dosage(s)"
 F PSJDL=0:0 S PSJDL=$O(PSJDOX(PSJDL)) Q:$S('PSJDL:1,$G(DUOUT):1,1:+PSJDOX(PSJDL)=-1)  D
 . S PSJX=PSJX+1
 . W !?4,$J(PSJX,3),".    ",$P(PSJDOX(PSJDL),U,PSJPIECE)
 . I '(PSJX#16) S DIR(0)="E" D ^DIR
 W !
 K DIR S DIR(0)="F^1:60"  ;*216 - No null dosage
 S DIR("A")=$S(+PSJX:"Select from list of Available Dosages or Enter Free Text Dose",1:"DOSAGE ORDERED")
 S:$G(PSGDO)]"" DIR("B")=PSGDO
 S DIR("?")="^D ENHLP^PSGOEM(53.1,109)" D ^DIR
 S PSJY=Y
 ;
 I $S($D(DTOUT):1,$D(DUOUT):1,$D(DIRUT):1,1:0) S PSGOROE1=1 Q
 ;
 ;* If select for the presented list (possible and local doses)
 I $D(PSJDOX(PSJY)) D  G:'PSJCONT AGAIN Q
 . NEW X S X=$P(PSJDOX(PSJY),U,PSJPIECE)
 . W "  ",X
 . S PSJCONT=$$CONT(X)
 . Q:'PSJCONT
 . D SELDOSE(PSJY,PSJDD)
 ;
 ;* Entered a numeric and choices are not local pos dose
 I PSJY?.N!(PSJY?.N1".".N),(PSJPIECE'=3) D  G:'PSJCONT AGAIN  Q
 . Q:$L(PSJY)>15
 . D DOSE^PSSORPH(.PSJDOX,+PSJDD,"U",,PSJY/+$P(PSJDOX(1),U,5))
 . S PSJCONT=$$CONT($P(PSJDOX(1),U,11))
 . I 'PSJCONT D DOSE^PSSORPH(.PSJDOX,+PSJDD,"U") Q
 . D SELDOSE(1,PSJDD)
 ;
 ;* Can't accept just a numeric value
 I PSJY?.N!(PSJY?.N1".".N) D ENHLP^PSGOEM(53.1,109) G AGAIN
 ;
 ;* Free text
 G:'$$CONT(PSJY) AGAIN
 K PSJDSSEL
 F X=0:0 S X=$O(PSJDOX(X)) Q:'X  S PSJXDOSE=$P(PSJDOX(X),U,PSJPIECE) I PSJY=PSJXDOSE D SELDOSE(X,PSJDD) Q
 I '$D(PSJDSSEL),($G(PSJY)]"") S PSJDSSEL=PSJY_U_+PSJDD_U_1,PSGDO=PSJY,PSJDSUPD=1
 Q
 ;
SELDOSE(X,PSJDD) ;
 S X=PSJDOX(X)
 S PSGDO=$P(X,U,PSJPIECE)
 S:$P(X,U)'=-1 PSJDOSE("DO")=$P(X,U,1,2)
 S PSJDSSEL=$P(X,U,PSJPIECE)_U_PSJDD
 I +$P(X,U,12) S $P(PSJDSSEL,U,3)=$P(X,U,12)_U_1 Q
 S $P(PSJDSSEL,U,3)=$S(PSJPIECE=11:$P(X,U,3),1:1)
 Q
CONT(X) ;Ask if user accepting the dose
 NEW DIR,DIRUT,Y
 W ! K DIR,DIRUT,DUOUT
 S DIR(0)="Y",DIR("A")="You entered "_X_" is this correct",DIR("B")="Yes"
 D ^DIR
 K DUOUT
 Q +Y
 ;
DUPD ;
 NEW PSJX,X
 S PSGUD=1
 W !,"UNITS PER DOSE: "_PSGUD_"// " R X:DTIME W "  ",X I X="^"!'$T S PSGOROE1=1 Q
 S:X="" X=1
 I X="@",'PSGUD W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.11,.02) G DUPD
 I X?1."?" D ENHLP^PSGOEM(53.11,.02) G DUPD
 I X?1.2N1"/"1.2N S X=+$J(+X/$P(X,"/",2),0,2) W "  ("_$E("0",X<1)_X_")"
 I $S($L(X)>12:1,X'=+X:1,X>50:1,X<0:1,1:X?.N1"."5.N) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.11,.02) G DUPD
 S $P(PSJDSSEL,U,3)=X
 D SETDUPD(X)
 Q
SETDUPD(X) ;
 S PSGUD=X,X=$S(PSJDSSEL]"":$P(PSJDSSEL,U,2),1:0)
 S PSJX=$O(^PS(53.45,PSJSYSP,2,"B",X,0))
 S PSGUD=+$FN(PSGUD,"",4) S:$E(PSGUD)="." PSGUD="0"_PSGUD
 S $P(^PS(53.45,PSJSYSP,2,+PSJX,0),U,2)=PSGUD
 Q
EDITDD ;Editing DDs
 NEW DA,DR,DIE
 S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(2,53.4502)=".02//1" D ^DIE
 I '$O(^PS(53.45,PSJSYSP,2,0)) W $C(7),!!,"WARNING:      This order must have at least one dispense drug before pharmacy can",!?9,"verify it!"
 Q
DOSECHK ;
 K PSJDSFLG S PSJDSFLG=0
 Q:'$P(PSJSYSU,";",4)
 Q:$G(PSGDO)=""
 NEW PSJX,PSJXDD,PSJCNT S PSJCNT=0
 ;*216 Be sure PSJDT is set
 I '$G(PSJDT) N X,% D NOW^%DTC S PSJDT=X
 F PSJX=0:0 S PSJX=$O(^PS(53.45,PSJSYSP,2,PSJX)) Q:'PSJX  D
 . S PSJXDD=$G(^PS(53.45,PSJSYSP,2,PSJX,0)) Q:PSJXDD=""
 . S:$P(PSJXDD,U,2)="" $P(^PS(53.45,PSJSYSP,2,PSJX,0),U,2)=1
 . ;*216 Don't count inactive Disp. Drug
 . I $P(PSJXDD,U,3)'="",$P(PSJXDD,U,3)'>PSJDT Q
 . S PSJCNT=PSJCNT+1
 D DOSECHK1
 Q
DOSECHK1 ;
 NEW PSJX,PSJXDD,PSJXUNIT,PSJUNIT,PSJXFLG,PSJTOT
 ;*216 Be sure PSJDT is set
 I '$G(PSJDT) N X,% D NOW^%DTC S PSJDT=X
 S PSJUNIT=$P(PSGDO,+PSGDO,2,$L(PSGDO,+PSGDO))
 S (PSJDSFLG,PSJXFLG,PSJTOT)=0
 S PSJX=0 F  S PSJX=$O(^PS(53.45,PSJSYSP,2,PSJX)) Q:'PSJX!PSJDSFLG!PSJXFLG  D
 . S PSJXDD=$G(^PS(53.45,PSJSYSP,2,PSJX,0))
 . S PSJXDUP=$S(+$P(PSJXDD,U,2):$P(PSJXDD,U,2),1:1)
 . ;*216 Don't count inactive Disp. Drug
 . I $P(PSJXDD,U,3)'="",$P(PSJXDD,U,3)'>PSJDT Q
 . D DOSE^PSSORPH(.PSJXDOX,+PSJXDD,"U")
 . I $S('$D(PSJXDOX):1,$P(PSJXDOX(1),U)="":1,1:+PSJXDOX(1)=-1) S PSJXFLG=1 Q
 . S PSJXUNIT=""
 . S:PSJUNIT["/" PSJXUNIT=PSJUNIT
 . I PSJUNIT'["/" F X=1:1:$L(PSJUNIT)  I $E(PSJUNIT,X)'?.N&($E(PSJUNIT,X)'?1" ") S PSJXUNIT=PSJXUNIT_$E(PSJUNIT,X)
 . I PSJCNT=1 D ONEDD Q:'PSJDSFLG
 . D BCMAUPD(PSJXDD),DOSE^PSSORPH(.PSJXDOX,+PSJXDD,"U",,PSJXDUP)
 . I PSJCNT=1 D ONEDD Q
 . S PSJTOT=+PSJXDOX(1)+$G(PSJTOT)
 I PSJCNT>1,(PSJTOT'=+PSGDO) S PSJDSFLG=1
 Q
ONEDD ;
 NEW X S PSJDSFLG=1
 F X=0:0 S X=$O(PSJXDOX(X)) Q:'X!'PSJDSFLG  D
 . I +PSJXDOX(X)'=+PSGDO,(PSJXUNIT=$P(PSJXDOX(X),U,2)),$S(PSJXDUP=$P(PSJXDOX(X),U,3):1,1:PSJXDUP=$P(PSJXDOX(X),U,12)) D  Q:PSJDSFLG
 .. N CHK S CHK=+PSGDO/$P(PSJXDOX(X),U,5) S CHK=+$FN(CHK,"",4) S:$E(CHK)="." CHK="0"_CHK I CHK=PSJXDUP S PSJDSFLG=0
 . I +PSJXDOX(X)=+PSGDO,$TR($P(PSJXDOX(X),U,11)," ")=$TR(PSGDO," "),$S(PSJXDUP=$P(PSJXDOX(X),U,3):1,1:PSJXDUP=$P(PSJXDOX(X),U,12)) S PSJDSFLG=0
 Q
BCMAUPD(PSJDD) ;
 NEW PSJCNT
 K PSJBCMA
 F X=0:0 S X=$O(PSJXDOX(X)) Q:'X  D
 . Q:'+$P(PSJXDOX(X),U,12)
 . S PSJCNT=+$G(PSJCNT)+1
 . S PSJBCMA(+PSJDD,$P(PSJXDOX(X),U,12),PSJCNT)=$P(PSJXDOX(X),U,1,2)
 Q
DSPWARN ;
 NEW PSJDOSE
 D SETVAR
 W !!,PSJDOSE("WARN"),!,PSJDOSE("WARN1"),!
 D PAUSE^VALM1
 Q
