DVBA2768        ;DLS/DEK - PATCH DRIVER ; 6/9/04
 ;;2.7;AMIE;**68**;Apr 10, 1995
 ; DBIA#  External Reference(s)
 ;  2051  $$FIND1^DIC
 ;  2053  FILE^DIE
 ; 10141  BMES^XPDUTL, MES^XPDUTL
SET S (I,J)=0,K=396.18 Q
PRE D SET,DEACT,KILL Q
POST D SET,NODE0,ADJ,KILL Q
KILL K ^TMP("DIERR",$J),^TMP("DVBA",$J),I,J,K,NM,IEN,FD Q
B(X) S X=" "_$G(X)
 I '$D(XPDNM) W !!,X Q
 D BMES^XPDUTL(X)
 Q
DEACT ;Deactivate forms
 F I=1:1 S NM=$P($T(DATA+I),";;",2) Q:NM']""  D
 .S IEN=$$FIND1^DIC(K,,"O",NM)_","
 .D:IEN CD(3040615,3)
 ;F I=0:0 S I=$O(^DVB(K,I)) Q:'I  D
 ;.S IEN=I_","
 ;.I '$D(^DVB(K,I,2)) D CD(3040721,3) Q
 ;.D:'$P(^DVB(K,I,2),U,2) CD(3040915,3)
 D:J B(">>>   Review the following errors   <<<"),SHO
 Q
CD(D,F) ;Change data
 S FD(K,IEN,F)=D
 S FD(K,IEN,7)=$S(F=2:1,1:0)
 D FILE^DIE(,"FD")
 I $D(^TMP("DIERR",$J)) D
 .S J=J+1
 .M ^TMP("DVBA",$J,J)=^TMP("DIERR",$J)
 Q
NODE0 ;Adjust zero-node
 F  S I=$O(^DVB(K,I)) Q:'I  S J=J+1
 S I=$O(^DVB(K,"A"),-1),$P(^DVB(K,0),U,3,4)=I_U_J
 Q
ADJ ;Adjust forms
 F I=0:0 S I=$O(^DVB(K,I)) Q:'I  D
 .S NM=^(I,0),J=$P(NM,"~",2),IEN=I_","
 .I J=3 D  Q
 ..S $P(NM,"~",2)=4
 ..I $$FIND1^DIC(K,,"O",NM) D CD(3040915,3) Q
 ..D CD(3040721,2)
 .D:J=4 CD(3040915,2)
 Q
SHO I $D(XPDNM) D  Q
 .K J
 .M J=^TMP("DVBA",$J)
 .D MES^XPDUTL(.J)
 S J=$Q(^TMP("DVBA",$J))
 F  Q:J=""  D
 .W !?3,@(J)
 .S J=$Q(@J)
DATA Q
 ;;AID AND ATTENDANCE
 ;;ARTERIES AND VEINS
 ;;AUDIO
 ;;EAR DISEASE
 ;;ESOPHAGUS & HIATAL HERNIA
 ;;EYE EXAMINATION
 ;;GENITOURINARY
 ;;MISC RESPIRATORY DISEASES
 ;;MUSCLES
 ;;NEUROLOGICAL DISORDERS, MISC.
 ;;NOSE SINUS LARYNX PHARYNX
 ;;PTSD INITIAL EVALUATION
 ;;PTSD REVIEW
 ;;RECTUM AND ANUS
 ;;SCARS
 ;;SKIN DISEASES (OTHER THAN SCARS)
 ;;STOMACH DUODENUM
 ;;
