TIUAUDIT ;SLC/JER - Display audit trail ;4/4/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
 ;;Text Integration Utility;;
EN ; Option entry
 K ^TMP("TIUAUDIT",$J) N TIU
 D EN^VALM("TIU DISPLAY AUDIT TRAIL")
 K ^TMP("TIUAUDIT",$J)
 Q
MAIN ; Control branching
 N TIUVIEW S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 I +TIUVIEW'>0 D  Q
 . W !!,$C(7),$P(TIUVIEW,U,2),!
 . I $$READ^TIUU("EA","RETURN to continue...")
 D GET^TIUSRV(TIUDA)
 Q
HDR ; Build Header
 N TIUDTYP,DFN
 ; I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 D:$D(TIU)'>9 GETTIU^TIULD(.TIU,+TIUDA)
 S VALMHDR(1)=$$CENTER^TIULS($P($G(TIU("DOCTYP")),U,2))
 S VALMHDR(2)=$$SETREC("HDR")
 Q
SETREC(LINE) ; Calls $$SETSTR^VALM1 for each line of ^TMP("TIUAUDIT",$J,
 N Y
 I LINE="HDR" D
 . S Y=$$SETSTR^VALM1($$NAME^TIULS(TIU("PNM"),"LAST,FI MI"),$G(Y),1,15)
 . S Y=$$SETSTR^VALM1(TIU("SSN"),$G(Y),16,12)
 . S Y=$$SETSTR^VALM1($P($G(TIU("WARD")),U,2),$G(Y),30,20)
 . I +TIU("DOCTYP")=1 D
 . . S Y=$$SETSTR^VALM1("Adm: "_$$DATE^TIULS(+TIU("EDT"),"MM/DD/YY"),$G(Y),51,13)
 . . S Y=$$SETSTR^VALM1("Dis: "_$$DATE^TIULS(+TIU("LDT"),"MM/DD/YY"),$G(Y),66,13)
 . I +TIU("DOCTYP")'=1 D
 . . S Y=$$SETSTR^VALM1("Visit Date: "_$$DATE^TIULS(+TIU("EDT"),"MM/DD/YY@HR:MIN"),$G(Y),53,26)
 Q Y
 ;
CLEAN ; Die, filthy spawn!!!
 D CLEAN^VALM10 K VALMHDR,TIU,TIUPRM0,TIUPRM1
 Q
