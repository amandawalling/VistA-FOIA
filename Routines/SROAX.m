SROAX ;BIR/ADM - EXCLUSION UTILITY ;02/01/07
 ;;3.0; Surgery ;**160**;24 Jun 93;Build 7
 Q
XL(SRCASE) ; compare CPT codes with exclusion list, return cpt code ien not excluded
 N SRCODE,SRCPT,SRDATE,SROTH,SRQ,SRXCLD,Y
 S (SRQ,SRXCLD)=0,SRCODE="",SRDATE=$P($G(^SRF(SRCASE,0)),"^",9)
 I $G(^SRO(136,SRCASE,0)) S SRCPT=$P($G(^SRO(136,SRCASE,0)),"^",2) I SRCPT'="" D COMP I SRQ G END
 S SROTH=0 F  S SROTH=$O(^SRO(136,SRCASE,3,SROTH)) Q:'SROTH  D  Q:SRQ
 .S SRXCLD=0,SRCPT=$P($G(^SRO(136,SRCASE,3,SROTH,0)),"^") I SRCPT'="" D COMP
END Q SRCODE
COMP I $G(^SRO(137,SRCPT,0)) S SRXCLD=1 Q
 I 'SRXCLD S SRQ=1,Y=$$CPT^ICPTCOD(SRCPT,SRDATE),SRCODE=$P(Y,"^") ; SRCODE=ien in file 81
 Q
