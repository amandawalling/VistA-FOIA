QAOSCNV2 ;HISC/DAD-RENUMBER SEVERITY LEVELS ;11/2/92  14:18
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAOSVR=+$G(^DD(741.8,0,"VR")) G:(QAOSVR'>0)!(QAOSVR'<3) EXIT
 W !!,"Converting severity level numbers from 1-4 to 0-3"
 W !,"-------------------------------------------------",!
 F QAOSSNUM=0:0 S QAOSSNUM=$O(^QA(741.8,"B",QAOSSNUM)) Q:QAOSSNUM'>0  F QAOSD0=0:0 S QAOSD0=$O(^QA(741.8,"B",QAOSSNUM,QAOSD0)) Q:QAOSD0'>0  D
 . S X=$G(^QA(741.8,QAOSD0,0)),QAOSEVER=$P(X,"^"),QAOSTEXT=$P(X,"^",2)
 . Q:(QAOSEVER<1)!(QAOSEVER>4)
 . S QAQADICT=741.8,QAQAFLD=.01,X=QAOSEVER,(DA,D0)=QAOSD0
 . D ENKILL^QAQAXREF
 . S QAOSEVER=QAOSEVER-1
 . S $P(^QA(741.8,QAOSD0,0),"^")=QAOSEVER
 . S QAQADICT=741.8,QAQAFLD=.01,X=QAOSEVER,(DA,D0)=QAOSD0
 . D ENSET^QAQAXREF
 . W !?5,QAOSEVER+1,"  =>  ",QAOSEVER," - ",QAOSTEXT
 . Q
EXIT K D0,DA,DIE,DR,QAOSD0,QAOSEVER,QAOSSNUM,QAOSTEXT,QAOSVR,QAQADICT,QAQAFLD,X
 Q
