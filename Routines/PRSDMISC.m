PRSDMISC ;HISC/MGD-PAID MISCELLANEOUS SUB-ROUTINES ;09/13/2003
 ;;4.0;PAID;**82**;Sep 21, 1995
SEPIND ;Separation Ind
 S SEPNAME=$P(^PRSPC(IEN,0),U,1),TL=$P(^PRSPC(IEN,0),U,8)
 S CCORG=$P(^PRSPC(IEN,0),U,49)
 S SEPIND="" S:$D(^PRSPC(IEN,1)) SEPIND=$P(^PRSPC(IEN,1),U,33)
 I DATA="Y" D
 .I TL'="",TYPE'="E" S $P(^PRSPC(IEN,0),U,8)="" K ^PRSPC("ATL"_TL,SEPNAME,IEN)
 .I CCORG'="" K ^PRSPC("ACC",CCORG,IEN)
 I DATA="N" D
 .I CCORG'="" S ^PRSPC("ACC",CCORG,IEN)=""
 .I TYPE="E",SEPIND="Y" D
 ..I $D(^PRSPC(IEN,"ANNUAL")) F P=2,3,4,5,6,7,9,10,11,12,13,14 S $P(^PRSPC(IEN,"ANNUAL"),U,P)=""
 ..I $D(^PRSPC(IEN,"LWOP")) F P=2,3,5,6,7,8,9,11 S $P(^PRSPC(IEN,"LWOP"),U,P)=""
 ..K ^PRSPC(IEN,"BAYLOR"),^PRSPC(IEN,"COMP")
 ..K ^PRSPC(IEN,"MILITARY"),^PRSPC(IEN,"SICK")
 ..S ^TMP($J,"PRS",SEPNAME,SSN)=""
 K SEPNAME,TL,CCORG,SEPIND,P Q
ACCSEP ;Accession/Separation fields
 I TYPE="I",DATA="" S NODE="" Q
 I TYPE="E",DATA="" S NODE="" Q
 I TYPE="T",DBNAME="MBSACODE",DATA="" S DATA="A" Q
 I TYPE="T",DBNAME="MBSADATE",DATA="" S DATA=$P(^PRSPC(IEN,0),"^",3) Q
 I TYPE="T",DBNAME="MBSANOAC",DATA="" S DATA="ACC" Q
