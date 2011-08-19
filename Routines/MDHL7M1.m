MDHL7M1 ; HOIFO/WAA - Muse EKG ; [02-06-2002 16:13]
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
OBX ; [Procedure] Process OBX
 N MDATT,PROC
 D ATT^MDHL7U(DEVIEN,.MDATT) Q:MDATT<1
 S PROC=0
 F  S PROC=$O(MDATT(PROC)) Q:PROC<1  D
 . N PROCESS
 . S PROCESS=$P(MDATT(PROC),";",5)
 . I PROCESS="UUEN^MDHL7U1" D ENCODE Q
 . D @PROCESS
 . Q
 Q:'MDIEN
 D REX^MDHL7U1(MDIEN)
 D GENACK^MDHL7X
 Q
 ;
ENCODE ; [Procedure] Process to the correct format
 N CNT,FTYPE,LINE,LINE2
 K ^TMP($J,"MDHL7M1")
 S CNT=0
 F  S CNT=$O(^TMP($J,"MDHL7A",CNT)) Q:CNT<1  D
 . N LCNT,CNT2
 . S LCNT=0
 . Q:$E(^TMP($J,"MDHL7A",CNT),1)'="Z"
 . S FTYPE=".PDF",LINE2=""
 . S LINE=$P(^TMP($J,"MDHL7A",CNT),"|",4)
 . S LINE=$E(LINE,$L($P(LINE,"\X0D\\X0A\"))+11,$L(LINE))
 . S CNT2=0
 . D TR(.LINE,.LINE2)
 . Q
 M ^TMP($J,"MDHL7","UUENCODE")=^TMP($J,"MDHL7M1")
 D @PROCESS
 K ^TMP($J,"MDHL7M1")
 Q
 ;
TR(LINE,LINE2) ; [Procedure] PARCE out the line and save the new file format
 N LLEN,I,X
 S I=0
TR2 D INC Q:LINE=""
 S X=$E(LINE,I)
 I X="\" D TRANS
 S LINE2=LINE2_X
 G TR2
 Q
INC ; INCREMENT I
 I (I+1)>$L(LINE) D
 . S I=0,CNT2=CNT2+1
 . S LINE=$G(^TMP($J,"MDHL7A",CNT,CNT2))
 . Q
 Q:LINE=""
 S I=I+1
 Q
TRANS ; TRANSLATE X TO THE CORRECT VALUE
 D INC Q:LINE=""
 S X=$E(LINE,I)
 I X="F" S X="|" D INC Q
 I X="S" S X="^" D INC Q
 I X="T" S X="&" D INC Q
 I X="E" S X="\" D INC Q
 I X="R" S X="~" D INC Q
 I X="X" D
 . D INC Q:LINE=""
 . D INC Q:LINE=""
 . S X=$E(LINE,I)
 . I X="D" D INC S LCNT=LCNT+1 D
 .. I LINE2'="end",LINE2'="" S ^TMP($J,"MDHL7M1",LCNT)=LINE2,X=""
 .. N Y
 .. F Y=1:1:5 D INC Q:LINE=""
 .. S LINE2=""
 .. Q
 . Q
 Q
