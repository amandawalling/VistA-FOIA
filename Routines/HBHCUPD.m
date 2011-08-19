HBHCUPD ; LR VAMC(IRMS)/MJT-HBHC update missing data in ^HBHC(631) using ^HBHC(634.1) & ^HBHC(634.3) as input for which records/fields to update, HBHC(634.2 errors must be corrected using PCE software, 634.2 data killed @ end of processing;9804
 ;;1.0;HOSPITAL BASED HOME CARE;**2,6,8,10,24**;NOV 01, 1993;Build 201
 ; HBHC(634.7 MFH errors must be corrected using MFH option, 634.7 killed here so validity processing can occur again
 I $P($G(^HBHC(631.9,1,0)),U,9)]"" K ^HBHC(634.7) S ^HBHC(634.7,0)="HBHC MEDICAL FOSTER HOME ERROR(S)^634.7P"
 I ('$D(^HBHC(634.1,"B")))&($D(^HBHC(634.2,"B")))&('$D(^HBHC(634.3,"B")))&('$D(^HBHC(634.5,"B"))) D PCEMSG^HBHCUTL3 S HBHCFLAG=1 G PSEUDO
PROMPT ; Prompt user for patient name
 W ! K DIC S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC
 G:Y=-1 PSEUDO
 S HBHCDPT=+Y
 I ('$D(^HBHC(634.1,"B",HBHCDPT)))&('$D(^HBHC(634.2,"B",HBHCDPT)))&('$D(^HBHC(634.3,"B",HBHCDPT)))&('$D(^HBHC(634.5,"B",HBHCDPT))) W $C(7),!!,"This patient has no records containing errors on file.",! H 3 G PROMPT
 F HBHCFILE=634.1,634.3 I $D(^HBHC(HBHCFILE,"B",HBHCDPT)) K DR S HBHCFORM=$S(HBHCFILE=634.1:3,1:5) S:HBHCFORM=5 HBHCCNT=1 S HBHCIEN="" F  S HBHCIEN=$O(^HBHC(HBHCFILE,"B",HBHCDPT,HBHCIEN)) Q:HBHCIEN=""  D PROCESS
 G PROMPT
PSEUDO ; Process pseudo SSN message
 I '$D(HBHCFLAG) D:$D(^HBHC(634.2,"B")) PCEMSG^HBHCUTL3
 I $D(^HBHC(634.5,"B")) D PSEUDO^HBHCUTL3 K ^HBHC(634.5) S ^HBHC(634.5,0)="HBHC PSEUDO SSN ERROR(S)^634.5P^"
EXIT ; Exit module
 ; HBHC(634.2 visit errors must be corrected using PCE software, 634.2 killed here so validity processing can occur again
 K ^HBHC(634.2) S ^HBHC(634.2,0)="HBHC VISIT ERROR(S)^634.2P^"
 K DA,DIC,DIE,DIK,DR,HBHC,HBHC12,HBHC359,HBHCAFLG,HBHCCNT,HBHCCOLM,HBHCDATE,HBHCDFLG,HBHCDFN,HBHCDIED,HBHCDPT,HBHCDR,HBHCDT,HBHCFILE,HBHCFLAG,HBHCFLG,HBHCFORM,HBHCI,HBHCIEN,HBHCJ,HBHCKEEP,HBHCL,HBHCM,HBHCMSG,HBHCNOD1,HBHCPC,HBHCQ
 K HBHCQ1,HBHCRFLG,HBHCSUB,HBHCTFLG,HBHCTXT,HBHCUPD,HBHCWRD1,HBHCWRD2,HBHCWRD3,HBHCY0,Y
 Q
PROCESS ; Process errors via DIE
 S DA=$P(^HBHC(HBHCFILE,HBHCIEN,0),U,2),HBHCTXT=$S(HBHCFORM=3:"Evaluation/Admission",1:"Discharge")
 L +^HBHC(631,DA):0 I '$T W $C(7),!!,"Another user is editing this "_HBHCTXT_" entry.",! H 3 Q
 S:HBHCFORM=3 (DR,HBHCDR)=^HBHC(HBHCFILE,HBHCIEN,1)
 I HBHCFORM=5 S HBHCSUB=0 F  S HBHCSUB=$O(^HBHC(HBHCFILE,HBHCIEN,HBHCSUB)) Q:HBHCSUB'>0  D SET
 K DIE S DIE="^HBHC(631,",DIE("NO^")="OUTOK"
 S HBHC=HBHCIEN,HBHCPC=$S(HBHCFORM=5:40,1:18),HBHCCOLM=$S(HBHCFORM=3:14,1:19)
 S HBHCDT=$P($G(^HBHC(631,DA,0)),U,HBHCPC) S:HBHCDT="" HBHCDT=$P($G(^HBHC(631,DA,0)),U,2) S HBHCDATE=$S(HBHCDT]"":$E(HBHCDT,4,5)_"-"_$E(HBHCDT,6,7)_"-"_$E(HBHCDT,2,3),1:"")
 W !!!?HBHCCOLM,"===  Editing "_$S(HBHCDATE]"":HBHCDATE_" "_HBHCTXT,1:HBHCTXT)_" data  ===",!
 D ^DIE K DR
 ; Admit/Reject Action branch
 S:HBHCDR["14;" DR="K HBHCQ;S X=$P(^HBHC(631,DA,0),U,15);D ACTION^HBHCUTL;15;16;I $D(HBHCQ) K HBHCQ S Y=0;17:36"
 ; Discharge Status branch
 S:HBHCDR["43;" DR="[HBHC UPDATE DISCHARGE]"
 I $D(DR) I '$D(Y) I (DR["D ACTION")!(DR["[HBHC UPDATE") S HBHCDFN=DA,HBHCUPD=1 D ^DIE K HBHCUPD
 L -^HBHC(631,DA) I '$D(HBHCKEEP) I '$D(Y) K DIK S DIK="^HBHC(HBHCFILE,",DA=HBHC D ^DIK K HBHCKEEP
 Q
SET ; Set DR string(s) for Discharge data
 S:$D(DR) DR(1,631,HBHCCNT)=^HBHC(HBHCFILE,HBHCIEN,HBHCSUB),HBHCCNT=HBHCCNT+1
 S:'$D(DR) (DR,HBHCDR)=^HBHC(HBHCFILE,HBHCIEN,HBHCSUB)
 Q
