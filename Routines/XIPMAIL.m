XIPMAIL ;OOIFO/SO- SEND E-MAIL OF COUNTY CODE & STATE FILE EXCEPTIONS;5:36 AM  4 Feb 2006
 ;;8.0;KERNEL;**378**;Jul 10, 1995;Build 59
 N XIPM
 S XIPM=""
 ;SCAN COUNTY CODE(#5.13) FILE FOR EXCEPTIONS
 D ^XIPMAILA
 ;SCAN STATE(#5) FILE FOR EXCEPTIONS
 D ^XIPMAILB
 ;
 N TMP,LN,FACILITY
 S TMP="",LN=0
 S FACILITY=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 S TMP(LN)="Scanning COUNTY CODE(#5.13) & STATE(#5) files for:",LN=LN+1
 S TMP(LN)="         "_$P(FACILITY,U)_"(#"_$P(FACILITY,U,2)_")",LN=LN+1
 S TMP(LN)=" ",LN=LN+1
 N I
 S I=0
 F  S I=$O(XIPM("A",I)) Q:'I  S TMP(LN)=XIPM("A",I),LN=LN+1
 S TMP(LN)=" ",LN=LN+1
 S I=0
 F  S I=$O(XIPM("B",I)) Q:'I  S TMP(LN)=XIPM("B",I),LN=LN+1
 ;
 ; Mail back message
 N MSGSBJ,WHO
 S WHO(DUZ)=""
 S WHO("hecdqsupport@med.va.gov")="" ;GAL group=VHA HEC DQ SUPPORT
 S WHO("ORMSBY.SKIP@FORUM.VA.GOV")="" ;
 S WHO("G.XIP SERVER RESPONSE")=""
 I '$$GOTLOCAL^XMXAPIG("XIP SERVER RESPONSE") K WHO("G.XIP SERVER RESPONSE")
 S MSGSBJ="POSTAL CODE(#5.13) & STATE(#5) File Scan Results"
 ;
SEND D SENDMSG^XMXAPI(DUZ,MSGSBJ,"TMP",.WHO)
 D CLEAN^DILF
 Q
