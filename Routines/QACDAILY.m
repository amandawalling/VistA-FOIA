QACDAILY ;HISC/CEW - Daily Contact Tracking Report ;1/31/95  09:44
 ;;2.0;Patient Representative;**3,9,17**;07/25/1995
DATE ;
 S QAQPOP=0
 D DATE^QACUTL0 Q:QAQPOP
 K DIC,FLDS,L,BY,FR,TO
 N QACDIV
 ;S L=0,DIC="^QA(745.1,",DHD="[QAC DAILY HEADER]"
 S FLDS="[QAC DAILY]"
 D DIV^QACUTL0 Q:$G(QAQPOP)=1
 S BY="37;S2;C1,1;C30;S;"""""
 S FR(2)=QAQNBEG
 S TO(2)=QAQNEND
 I $G(QAC1DIV)]"" D
 . S (FR(1),TO(1))=$P($G(^DIC(4,QAC1DIV,0)),U)
 I $G(QAC1DIV)'>1 D
 . S FR(1)="@"
 . S TO(1)=""
 Q:$G(QAQPOP)=1
 S L=0,DIC="^QA(745.1,",DHD="[QAC DAILY HEADER]"
 D EN1^DIP
EXIT ;
 K DHD,BY,FLDS,FR,TO,DIP,DIC,L
 K QAC1DIV,QACDV
 K QAQNBEG,QAQNEND,QAQPOP
 D K^QAQDATE
 Q
