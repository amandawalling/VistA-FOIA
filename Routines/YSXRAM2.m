YSXRAM2 ; COMPILED XREF FOR FILE #615.6 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^YSR(615.6,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^YSR(615.6,"B",$E(X,1,30),DA)=""
END Q
