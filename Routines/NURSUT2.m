NURSUT2 ;HIRMFO/MD,RM,FT-UTILITIES FOR FILES 210 AND 211.8 ;01/06/97
 ;;4.0;NURSING SERVICE;**3,33**;Apr 25, 1997
 ;
 ; Reference to ^SC is supported by IA #1416
 ;
EN1 ;GET THE TOTAL EMPLOYEE FTEE
 ; INPUT VARIABLES:  NUR("DA")=ENTRY IN FILE 210 FOR NURSING EMPLOYEE
 ;                   NUR("DT")=DATE AT WHICH TOTAL FTEE TO BE CALCULATED
 ;                     (OPTIONAL VARIABLE DT IS USED IF NOT SUPPLIED)
 ; OUTPUT VARIABLE:  NURTFTEE=TOTAL ASSIGNMENT FTEE
 S:'$D(NUR("DT")) NUR("DT")=DT S NUR=$S($D(^NURSF(210,NUR("DA"),0)):$P(^(0),U),1:"")
 S NURTFTEE=0 F NUR(0)=0:0 S NUR(0)=$O(^NURSF(211.8,"C",+NUR,NUR(0))) Q:NUR(0)'>0  D TOTX
 K NUR
 Q
TOTX F NUR(1)=0:0 S NUR(1)=$O(^NURSF(211.8,"C",+NUR,NUR(0),NUR(1))) Q:NUR(1)'>0  I $D(^NURSF(211.8,NUR(0),1,NUR(1),0)) S NUR(2)=^(0) I +NUR(2)'>NUR("DT"),('+$P(NUR(2),U,6)!(+$P(NUR(2),U,6)'<NUR("DT"))) S NURTFTEE=NURTFTEE+$P(NUR(2),U,4)
 Q
EN2 ;VARIABLE D0=NURS EMPLOYEE IEN IS PASSED IN TO COMPUTE PRIMARY LOCATION
 S NUR="",NUR(3)=$S($D(^NURSF(210,D0,0)):$P(^(0),U),1:"")
 F NUR(0)=0:0 S NUR(0)=$O(^NURSF(211.8,"AE",+NUR(3),1,NUR(0))) Q:NUR(0)'>0  D S2
 S X=NUR K NUR
 Q
S2 ;
 F NUR(1)=0:0 S NUR(1)=$O(^NURSF(211.8,"AE",+NUR(3),1,NUR(0),NUR(1))) Q:NUR(1)'>0  I $D(^NURSF(211.8,NUR(0),1,NUR(1),0)) S NUR(2)=^(0) D:+NUR(2) SETLOC
 Q
SETLOC I DT'<+$P(NUR(2),U),(DT<+$P(NUR(2),U,6)!'+$P(NUR(2),U,6)) S NUR=$S($D(^SC(+$S($D(^NURSF(211.8,NUR(0),0)):$P(^(0),U),1:""),0)):$P(^(0),U),1:""),NUR=$S(NUR?1"NUR ".E:$P(NUR,"NUR ",2),1:"")
 Q
EN3 ; ENTRY TO DETERMINE IF A POSITION CHANGE WILL CREATE DUPLICATE
 ; PRIMARY ASSIGNMENTS, MAKE TOTAL FTEE>1, MAKE THE START DATE
 ; AFTER THE VACANCY DATE OF THE ASSIGNMENT, OR CREATE DUPLICATE
 ; SERVICE POSITIONS ON THE SAME LOCATION
 ; INPUT VARIABLES:  DA(1) AND DA = DEFINE THE POSITION ENTRY
 ;                   NUR(0)=DATA TO BE FILED IN ZEROTH NODE; AND OF THE 
 ;                          SAME STRUCTURE AS THE ZEROTH NODE.
 ; OUTPUT VARIABLES: NURSBAD=$S(0:NO PROB,1:PROB)^$S(1:FTEE>1,2:DUP PRI,
 ;4:DUP SP,7:DUP TOUR)
 S NURZ=NUR(0) K NUR S NUR(0)=NURZ
 S NUR("CNTR")=1
 F NUR=0:0 S NUR=$O(^NURSF(211.8,"ASDT",+$P(NUR(0),U,4),NUR)) Q:$S(NUR'>0:1,'$P(NUR(0),U,8):0,NUR>$P(NUR(0),U,8):1,1:0)  F NUR(1)=0:0 S NUR(1)=$O(^NURSF(211.8,"ASDT",+$P(NUR(0),U,4),NUR,NUR(1))) Q:NUR(1)'>0  D STPOAR
 S (NUR("SDT",+$P(NUR(0),U,3),DA(1),DA),NUR("VDT",$S(+$P(NUR(0),U,8):$P(NUR(0),U,8),1:9999999),DA(1),DA))=NUR(0)
EN4 ; ENTRY FROM ASSIGNMENT EDIT TO VALIDATE POSITION ENTRY.
 Q:$G(NURLS)="P"  S (NURSBAD,NUR("TFTE"),NUR("PRI"),NUR("SP"),NUR("SP",1),NUR("TOUR"),NX)=0,NUR("VDT")=$O(NUR("VDT",0))
 F NUR("SDT")=0:0 S NUR("SDT")=$O(NUR("SDT",NUR("SDT"))) Q:NUR("SDT")'>0  D  Q:+NURSBAD
 . F NUR(1)=0:0 S NUR(1)=$O(NUR("SDT",NUR("SDT"),NUR(1))) Q:NUR(1)'>0  D  Q:+NURSBAD
 . . F NUR(2)=0:0 S NUR(2)=$O(NUR("SDT",NUR("SDT"),NUR(1),NUR(2))) Q:NUR(2)'>0  D DTPRC Q:+NURSBAD
 . . Q
 . Q
 S:'+NURSBAD&'NUR("PRI") NURSBAD=$S(NUR("CNTR")'>1:"1^5",1:"1^6")
 K NUR,NURZ,NX
 Q
STPOAR ;
 F NUR(2)=0:0 S NUR(2)=$O(^NURSF(211.8,"ASDT",+$P(NUR(0),U,4),NUR,NUR(1),NUR(2))) Q:NUR(2)'>0  S NUR(3)=$S($D(^NURSF(211.8,NUR(1),1,NUR(2),0)):^(0),1:"") I $P(NUR(3),U,6)'<$P(NUR(0),U,3)!'$P(NUR(3),U,6) D ST1
 Q
ST1 ;
 S:$S('(NUR(1)=DA(1)&(NUR(2)=DA)):1,1:0) (NUR("SDT",$P(NUR(3),U),NUR(1),NUR(2)),NUR("VDT",$S($P(NUR(3),U,6):$P(NUR(3),U,6),1:9999999),NUR(1),NUR(2)))=$P($G(^NURSF(211.8,NUR(1),0)),"^",1,2)_"^"_NUR(3),NUR("CNTR")=NUR("CNTR")+1
 Q
DTPRC ;
 I NUR("SDT")>NUR("VDT") D VACDT
 S NUR("TFTE")=NUR("TFTE")+$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U,6),NUR("PRI")=$S('$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U,11):NUR("PRI"),NUR("PRI"):2,1:1)
 S NX=NX+1 S NUR("SP",NX)=$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U)_U_$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U,5)_U_$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U,8)_U_$P(NUR("SDT",NUR("SDT"),NUR(1),NUR(2)),U,12)
 I NX>1 F NX(0)=1:1:NX I '+$P(NUR("SP",NX(0)),U,3)!((+$P(NUR("SP",NX(0)),U,3)'<DT)&(+$P(NUR("SP",NX(0)),U,3)'>DT)) D
 .  I $P(NUR("SP",NX(0)),U,1,2)=$P($G(NUR("SP",NX(0)+1)),U,1,2) S NUR("SP")=2
 .  I ($P(NUR("SP",NX(0)),U)_U_$P(NUR("SP",NX(0)),U,4))=($P($G(NUR("SP",NX(0)+1)),U)_U_$P($G(NUR("SP",NX(0)+1)),U,4)) S NUR("TOUR")=2
 .  Q
 S NURSBAD=$S(NUR("TFTE")>1:"1^1",NUR("PRI")>1:"1^2",NUR("SDT")>NUR("VDT"):"1^3",NUR("SP")=2:"1^4",NUR("TOUR")=2:"1^7",1:0)
 S:+NURSBAD&($P(NURSBAD,U,2)=5) $P(NURSNPOS,U,11)=1,NURSPOS(1)=NURSNPOS
 Q
VACDT ;
 F NUR("VDT")=NUR("VDT")-.1:0 S NUR("VDT")=$O(NUR("VDT",NUR("VDT"))) Q:NUR("VDT")'<NUR("SDT")!(NUR("VDT")'>0)  F NUR(4)=0:0 S NUR(4)=$O(NUR("VDT",NUR("VDT"),NUR(4))) Q:NUR(4)'>0  D VAC1
 Q
VAC1 ;
 F NUR(5)=0:0 S NUR(5)=$O(NUR("VDT",NUR("VDT"),NUR(4),NUR(5))) Q:NUR(5)'>0  S NUR("TFTE")=NUR("TFTE")-$P(NUR("VDT",NUR("VDT"),NUR(4),NUR(5)),U,6),NUR("PRI")=$S('$P(NUR("VDT",NUR("VDT"),NUR(4),NUR(5)),U,11):NUR("PRI"),1:0)
 Q
CAT(NURCAT) ; Input: Service Category code (i.e, R, L, N, A, S, C, O or
 ;                O_<space>_sub-category value)
 ; Ouput: Expanded value of Service Category.
 ;
 S NURCAT=$S(NURCAT="R":"RN",NURCAT="L":"LPN",NURCAT="C":"CK",NURCAT="N":"NA",NURCAT="S":"SE",NURCAT="A":"AO",NURCAT="O":"OT",1:NURCAT)
 I $P(NURCAT,"O ",2)'="" S NURCAT=$E(NURCAT,3,$L(NURCAT)),NURCAT=$E(NURCAT,1,6)
 Q NURCAT
CNTR(NURPARM) ; Center Printed String
 ;
 ;  Input: Item to be centered
 ;  Output: Value of print position to center string in report line
 N X,NURCNTR S X=$S(+$G(NURS132):132,1:80),NURCNTR=(X/2)-($L(NURPARM)/2)
 Q NURCNTR
PROD(NURPROG) ; Input: Nurs Product Line free text value
 ; Output: Expanded value of Service Category.
 ;
 S NURPPROD="",NURPPROD=$S(NURPROG="  BLANK":"NO PRODUCT LINE",$E(NURPROG)=" ":$E(NURPROG,2,99),1:NURPROG)
 Q NURPPROD
FACL(NURFAC) ; Input: Facility free text value.
 ; Output: Printable Facility value.
 S NURPFAC="",NURPFAC=$S(NURFAC="  BLANK":"NO FACILITY",1:NURFAC)
 Q NURPFAC
