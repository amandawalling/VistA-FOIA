RGHOUT ;CAIRO/DKM-HL7 message generation utilities ;14-Oct-1998
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;=================================================================
 ; Initialize
INIT(RGEP,HL,RGD,RGERR,RGSB) ;
 K HL,RGD
 D INIT^HLFNC2(RGEP,.HL)
 I $G(HL) S RGERR=$P(HL,U,2) Q +HL
 S RGD(1)=HL("FS"),HL("RGSB")=$G(RGSB,"HLS")
 F RGD=2:1:5 S RGD(RGD)=$E(HL("ECH"),RGD-1)
 K ^TMP("HLS",$J)
 Q 0
 ; Hand off completed message
SEND(RGEP,HL,RGERR) ;
 N RGZ
 D GENERATE^HLMA(RGEP,"GM",1,.RGZ,"",.HL)
 K ^TMP("HLS",$J)
 S:$P($G(RGZ),U,2) RGERR=$P(RGZ,U,3)
 Q
 ; Send acknowledgment
ACK(RGEP,RGCL,RGMSG,RGERR) ;
 N RGZ
 D GENACK^HLMA1($$PROIEN(RGEP),RGMSG,$$PROIEN(RGCL),"GM",1,.RGZ)
 K ^TMP("HLA",$J)
 S:$G(RGZ) RGERR=$P(RGZ,U,$L(RGZ,U))
 Q
 ; Build a segment from a local array and add to stream.
 ; This code makes heavy use of naked reference to output global.
SEG(RGTYPE,RGSEG,RGK) ;
 N RGPC,RGPC0,RGPC1,RGPC2,RGF,RGN,RGS
 S RGS=RGTYPE,RGF=1,RGN=+$O(^TMP($G(HL("RGSB"),"HLS"),$J,""),-1)
 F RGPC0=1:1:$O(RGSEG($C(1)),-1) D
 .S RGPC=RGPC0
 .F  D  Q:RGPC\1'=RGPC0
 ..D SEGA("RGSEG(RGPC)",$S(RGPC0=RGPC:1,1:3),0)
 ..D:$D(RGSEG(RGPC))>9 SEG1
 ..S RGPC=$O(RGSEG(RGPC))
 D:$L(RGS) SEGX("",0,1)
 K:$G(RGK) RGSEG
 Q
SEG1 F RGPC1=1:1:$O(RGSEG(RGPC,$C(1)),-1) D
 .D SEGA("RGSEG(RGPC,RGPC1)",2,RGPC1=1)
 .D:$D(RGSEG(RGPC,RGPC1))>9 SEG2
 Q
SEG2 F RGPC2=1:1:$O(RGSEG(RGPC,RGPC1,$C(1)),-1) D
 .D SEGA("RGSEG(RGPC,RGPC1,RGPC2)",5,RGPC2=1)
 Q
SEGA(RGG,RGP,RGT) ;
 D SEGX($G(@RGG),RGP,RGT)
 F RGP=0:0 S RGP=$O(@RGG@(0,RGP)) Q:'RGP  D SEGX(@RGG@(0,RGP),1,1)
 Q
SEGX(RGX,RGP,RGT) ;
 S:'RGT RGX=RGD(RGP)_RGX
 S RGT=200-$L(RGS),RGS=RGS_$E(RGX,1,RGT),RGX=$E(RGX,RGT+1,99999)
 I $L(RGX)!'RGP D
 .S RGN=RGN+1,^TMP($G(HL("RGSB"),"HLS"),$J,RGN)=RGS,RGS="" S:RGF RGF=0,RGN=+$O(^(RGN,0))
 .D:RGP SEGX(RGX,1,1)
 Q
 ; Build brief PID segment
PID(RGDFN) ;
 N RGPID,RGS,RGZ,RGZ1,RGZ2
 S RGZ=^DPT(RGDFN,0),RGZ2=$P(RGZ,U),RGZ1=$P(RGZ2,","),RGZ2=$P(RGZ2,",",2)
 S RGPID(5,1)=RGZ1,RGPID(5,2)=$P(RGZ2," "),RGPID(5,3)=$P(RGZ2," ",2,99)
 S RGPID(7)=$$DTFH^RGHLUT($P(RGZ,U,3))
 S RGPID(19)=$P(RGZ,U,9)
 S RGZ=$$GETICN^RGHLUT(RGDFN)
 S:RGZ'<0 RGPID(2,1)=+RGZ,RGPID(2,2)=$P(RGZ,"V",2)
 D SEG("PID",.RGPID)
 Q
 ; Build PV1 segment from visit IEN
PV1(RGV,RGDFN,RGF) ;
 N RGSEG,RGZ,RGZ1,RGZ2,RGSC
 Q:'RGV
 L +^AUPNVSIT(RGV):10 I '$T Q
 I '$$FIND1^DIC(9000010,,"X","`"_RGV) D UNLCK Q
 K RGZ
 S RGZ(1)=+$$GET1^DIQ(9000010,RGV,.01,"I")
 S RGZ(5)=$$GET1^DIQ(9000010,RGV,.05,"I")
 S RGZ(6)=$$GET1^DIQ(9000010,RGV,.06,"I")
 S RGZ(18)=$$GET1^DIQ(9000010,RGV,.18,"I")
 S RGZ(150,2)=$$GET1^DIQ(9000010,RGV,15002,"I")
 S RGZ(150,3)=$$GET1^DIQ(9000010,RGV,15003,"I")
 I $G(RGDFN),RGZ(5)'=RGDFN D UNLCK Q
 S RGZ=$$GET1^DIQ(9000010,RGV,.12,"I")
 I RGZ,RGZ'=RGV D PV1(RGZ,.RGDFN) D UNLCK Q
 Q:RGZ(150,3)'="P"
 S RGSEG(50)=$$GET1^DIQ(9000010,RGV,15001,"I")
 I $G(RGF) D SEG("PV1",.RGSEG) D UNLCK Q
 S RGSC=+$$GET1^DIQ(9000010,RGV,.22,"I")
 S RGSEG(2)=$S($G(RGZ(150,2)):"I",1:"O")
 S RGSEG(3,1)=$$GET1^DIQ(44,RGSC_",",.01)
 S RGSEG(3,4)=$$GET1^DIQ(4,RGZ(6)_",",99)
 S RGSEG(44)=$$DTFH^RGHLUT(RGZ(1),1)
 S RGSEG(45)=$$DTFH^RGHLUT(RGZ(18),1)
 S RGZ2=0
 F RGZ=0:0 S RGZ=$O(^AUPNVPRV("AD",RGV,RGZ)) Q:'RGZ  D
 .S RGZ1(1)=$$GET1^DIQ(9000010.06,RGZ,.01,"I")
 .S RGZ1(3)=$$GET1^DIQ(9000010.06,RGZ,.03,"I")
 .S RGZ1(4)=$$GET1^DIQ(9000010.06,RGZ,.04,"I")
 .Q:RGZ1(3)'=RGV
 .I RGZ1(4)="P",'$D(RGSEG(7)) S RGSEG(7)=$$PRV(+RGZ1(1))
 .E  S RGSEG(9+RGZ2)=$$PRV(+RGZ1(1)),RGZ2=RGZ2+.00001
 D SEG("PV1",.RGSEG,1)
 I RGSC D
 .I $T(CODE^RGHOMAP)]"" S RGSEG(2)=$TR($$CODE^RGHOMAP(44,RGSC),U,RGD(2))
 .D:$L(RGSEG(2)) SEG("PV2",.RGSEG)
UNLCK L -^AUPNVSIT(RGV)
 Q
 ; Build ORC segment
ORC(RGODAT,RGPRV,RGSTATUS,RGINST) ;
 N RGORC
 S RGORC(5)=$G(RGSTATUS)
 S RGORC(9)=$$DTFH^RGHLUT(RGODAT,1)
 S RGORC(12)=$$PRV(.RGPRV)
 S:$G(RGINST) RGORC(17)=$$INST(RGINST)
 D SEG("ORC",.RGORC)
 Q
 ; Build OBR segment
OBR(RGODAT,RGSRC,RGPRV,RGNS,RGFON,RGUDAT) ;
 N RGOBR
 S:$G(RGFON)'="" RGOBR(3,1)=RGFON
 S:$G(RGNS)'="" RGOBR(3,2)=RGNS
 S:$G(RGODAT) RGOBR(7)=$$DTFH^RGHLUT(RGODAT,1)
 S:$G(RGSRC) RGOBR(15)=$$SNM(RGSRC,61)
 S:$G(RGPRV) RGOBR(16)=$$PRV(.RGPRV)
 S:$G(RGUDAT) RGOBR(22)=$$DTFH^RGHLUT(RGUDAT,1)
 D SEG("OBR",.RGOBR)
 Q
 ; Build OBX segment
OBX(RGCODE,RGVAL,RGUNITS,RGSTAT,RGSEQ,RGSID,RGLO,RGHI,RGFLG) ;
 Q:RGVAL=""
 N RGOBX
 S RGOBX(1)=$G(RGSEQ)
 S RGOBX(2)=$S(RGVAL[RGD(2):"CE",RGVAL=+RGVAL:"NM",1:"ST")
 S RGOBX(3)=$TR(RGCODE,U,RGD(2)),RGOBX(4)=$G(RGSID),RGOBX(5)=RGVAL
 S:$G(RGUNITS)'="" RGOBX(6)=RGUNITS
 S:$G(RGFLG)'="" RGOBX(8)=RGFLG
 S:$G(RGSTAT)'="" RGOBX(11)=RGSTAT
 S:$G(RGLO)'="" RGOBX(7)=RGLO
 S:$G(RGHI)'="" $P(RGOBX(7),"-",2)=RGHI
 D SEG("OBX",.RGOBX)
 Q
 ; Convert imbedded reserved characters to escape format
ESCAPE(RGTXT) ;
 N RGZ,RGZ1,RGX,RGC,RGA,RGRTN
 S (RGX,RGRTN)=""
 F RGZ=1:1:5 S RGX=RGX_RGD(RGZ)
 F RGZ=1:1:$L(RGTXT) D
 .S RGC=$E(RGTXT,RGZ),RGA=$A(RGC),RGZ1=$F(RGX,RGC)-1
 .I RGZ1>0 S RGRTN=RGRTN_RGD(4)_$E("FSRET",RGZ1)_RGD(4)
 .E  I RGA>31,RGA<127 S RGRTN=RGRTN_RGC
 .E  S RGRTN=RGRTN_RGD(4)_"X"_$$BASE^RGRSUTL2(RGA,16,2)_RGD(4)
 Q RGRTN
 ; Get routing info for domain/institution
LINK(RGDI,RGCL,RGF) ;
 N RGZ,RGLL
 D LINK^HLUTIL3(RGDI,.RGLL,.RGF)
 S RGZ=$O(HLL("LINKS",$C(1)),-1)
 F RGLL=0:0 S RGLL=$O(RGLL(RGLL)) Q:'RGLL  S RGZ=RGZ+1,HLL("LINKS",RGZ)=RGCL_U_RGLL(RGLL)
 Q
 ; Get protocol IEN
PROIEN(RGPR) ;
 Q $S(RGPR="":0,RGPR=+RGPR:RGPR,1:$O(^ORD(101,"B",RGPR,0)))
 ; Universal provider ID
PRV(RGPRV) ;
 N RGID,RGZ,USR
 D GETS^DIQ(200,RGPRV,".01;9","I","USR")
 I $D(USR(200,RGPRV_",",.01,"I")) D
 .S RGZ=USR(200,RGPRV_",",.01,"I"),RGID=USR(200,RGPRV_",",9,"I")
 .S RGID=RGID_RGD(2)_$P(RGZ,",")_RGD(2)
 .S RGZ=$P(RGZ,",",2,99)
 .S RGID=RGID_$P(RGZ," ")_RGD(2)_$P(RGZ," ",2)_RGD(2)_$P(RGZ," ",3,99)
 Q $G(RGID)
 ; SNOMED pointer --> HL7 CE format
SNM(RGSNM,RGFN) ;
 S RGSNM=$G(^LAB(RGFN,+RGSNM,0))
 Q $S($P(RGSNM,U,2)="":"",1:$E("TMEFDPJ",RGFN-61*10+1)_"-"_$P(RGSNM,U,2)_RGD(2)_$P(RGSNM,U)_RGD(2)_"SNM")
 ; Return CPT4 coded element with optional subid attached
CPT(RGCPT,RGID) ;
 N RGZ
 S RGZ=$$CPT^ICPTCOD(+RGCPT)
 Q $S(+RGZ<1:"",1:$$SFX($P(RGZ,U)_RGD(2)_$P(RGZ,U,2)_RGD(2)_"C4",.RGID))
 ; Return institution in CE format
INST(RGINST) ;
 Q $S(RGINST:$$GET1^DIQ(4,+RGINST_",",99)_RGD(2)_$$GET1^DIQ(4,+RGINST_",",.01)_RGD(2)_99002,1:"")
 ; Add a suffix to a code
SFX(RGCODE,RGSFX) ;
 Q $S(RGCODE="":"",$G(RGSFX)="":RGCODE,1:$P(RGCODE,RGD(2))_RGD(5)_RGSFX_RGD(2)_$P(RGCODE,RGD(2),2,99))
 ; Format line from WP field
WP(RGTXT) ;
 F  Q:RGTXT'["|"  S RGTXT=$P(RGTXT,"|")_$P(RGTXT,"|",3,999)
 Q $$ESCAPE(RGTXT)
