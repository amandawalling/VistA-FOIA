DGPT101P ;ALB/MTC - Parse 101 record ; 12 NOV 92
 ;;5.3;Registration;**164,678,664**;Aug 13, 1993;Build 15
 ;;
SET ; Parse 101 record
 ;
 S DGPTDTS=$$FMDT^DGPT101($E(DGPTSTR,15,20))_"."_$E(DGPTSTR,21,24)
 S DGPTPS=$E(DGPTSTR,5),DGPTSSN=$E(DGPTSTR,6,14),DGPTDTA=$E(DGPTSTR,15,24),DGPTFAC=$E(DGPTSTR,25,30),DGPTLN=$E(DGPTSTR,31,42),DGPTFI=$E(DGPTSTR,43),DGPTMI=$E(DGPTSTR,44)
 S DGPTSRA=$E(DGPTSTR,45,46),DGPTTF=$E(DGPTSTR,47,52),DGPTSRP=$E(DGPTSTR,53),DGPTPOW=$E(DGPTSTR,54),DGPTMRS=$E(DGPTSTR,55),DGPTGEN=$E(DGPTSTR,56),DGPTDOB=$E(DGPTSTR,57,64),DGPTPOS1=$E(DGPTSTR,65),DGPTPOS2=$E(DGPTSTR,66),DGPTEXA=$E(DGPTSTR,67)
 S DGPTEXI=$E(DGPTSTR,68),DGPTSTE=$E(DGPTSTR,69,70),DGPTCTY=$E(DGPTSTR,71,73),DGPTZIP=$E(DGPTSTR,74,78),DGPTMTC=$E(DGPTSTR,79,80),DGPTBY=$E(DGPTSTR,61,64)
 S DGPTINC=$E(DGPTSTR,81,86),DGPTERI=$E(DGPTSTR,96),DGPTCTRY=$E(DGPTSTR,97,99)
 Q
