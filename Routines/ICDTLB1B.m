ICDTLB1B ;ALB/EG - GROUPER UTILITY FUNCTIONS FY 2006; 8/19/04 3:19pm ; 6/28/05 4:01pm
 ;;18.0;DRG Grouper;**20**;Oct 20, 2000
DRG1 D DRG528 D:ICDRG'=528 DRG543^ICDTLB6B D:ICDRG'=543 DRG529
 S ICDRG=$S(AGE<18:3,ICDRG=528:528,ICDRG=543:543,ICDRG=529:529,ICDRG=530:530,ICDCC:1,1:2) I AGE="" S ICDRTC=3,ICDRG=470
 Q
DRG2 D DRG1
 Q
DRG3 D DRG1
 Q
DRG7 S ICDRG=$S(ICDCC:7,1:8) Q
DRG8 S ICDRG=$S(ICDCC:7,1:8) Q
DRG10 S ICDRG=$S(ICDCC:10,1:11) Q
DRG11 S ICDRG=$S(ICDCC:10,1:11) Q
DRG16 S ICDRG=$S(ICDCC:16,1:17) Q
DRG17 S ICDRG=$S(ICDCC:16,1:17) Q
DRG18 S ICDRG=$S(ICDCC:18,1:19) Q
DRG19 S ICDRG=$S(ICDCC:18,1:19) Q
DRG24 S ICDRG=$S(AGE<18:26,ICDCC:24,1:25) I AGE="" S ICDRTC=3,ICDRG=470
 Q
DRG25 S ICDRG=$S(AGE<18:26,ICDCC:24,1:25) I AGE="" S ICDRTC=3,ICDRG=470
 Q
DRG26 S ICDRG=$S(AGE<18:26,ICDCC:24,1:25) I AGE="" S ICDRTC=3,ICDRG=470
 Q
DRG27 S ICDRG=$S(ICDPD[1!(ICDSD[1):27,AGE="":470,AGE<18:30,ICDCC:28,1:29),ICDRTC=$S(ICDRG=470:3,1:ICDRTC) Q
DRG28 D DRG27 Q
DRG29 D DRG27 Q
DRG30 D DRG27 Q
DRG31 S ICDRG=$S(AGE<18:33,ICDCC:31,1:32) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG32 S ICDRG=$S(AGE<18:33,ICDCC:31,1:32) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG33 S ICDRG=$S(AGE<18:33,ICDCC:31,1:32) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG34 S ICDRG=$S(ICDCC:34,1:35) Q
DRG35 S ICDRG=$S(ICDCC:34,1:35) Q
DRG39 D VER^ICDDRG2 Q
DRG40 S ICDRG=$S(AGE>17:40,1:41) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG41 S ICDRG=$S(AGE>17:40,1:41) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG46 S ICDRG=$S(AGE<18:48,ICDCC:46,1:47) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG47 S ICDRG=$S(AGE<18:48,ICDCC:46,1:47) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG48 S ICDRG=$S(AGE<18:48,ICDCC:46,1:47) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG53 S ICDRG=$S(AGE>17:53,1:54) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG54 S ICDRG=$S(AGE>17:53,1:54) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG57 S ICDRG=$S((ICDOPCT>0)&($P(ICDY(0),U,1)="28.3"):$S(AGE>17:59,1:60),ICDOPCT>0:$S(AGE>17:57,1:58),AGE>17:59,1:60) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG58 S ICDRG=$S(ICDOPCT>1:$S(AGE>17:57,1:58),AGE>17:59,1:60) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG59 D EN1^ICDDRG3 I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG60 D EN1^ICDDRG3 I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG61 S ICDRG=$S(AGE>17:61,1:62) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG62 S ICDRG=$S(AGE>17:61,1:62) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG68 S ICDRG=$S(AGE<18:70,ICDCC:68,1:69) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG69 S ICDRG=$S(AGE<18:70,ICDCC:68,1:69) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG70 S ICDRG=$S(AGE<18:70,ICDCC:68,1:69) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG73 S ICDRG=$S(AGE>17:73,1:74) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG74 S ICDRG=$S(AGE>17:73,1:74) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG75 S ICDRG=$S($D(ICDODRG(474)):474,1:ICDRG) Q
DRG76 S ICDRG=$S($D(ICDODRG(474)):474,ICDCC:76,1:77) Q
DRG77 S ICDRG=$S($D(ICDODRG(474)):474,ICDCC:76,1:77) Q
DRG78 S ICDRG=$S(ICDPD["X"&(ICDOR["H"):124,ICDSD["X"&(ICDOR["H"):124,1:78) Q
DRG79 S ICDRG=$S(AGE<18:81,ICDCC:79,1:80) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG80 S ICDRG=$S(AGE<18:81,ICDCC:79,1:80) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG81 S ICDRG=$S(AGE<18:81,ICDCC:79,1:80) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG83 S ICDRG=$S(ICDCC:83,1:84) Q
DRG84 S ICDRG=$S(ICDCC:83,1:84) Q
DRG85 S ICDRG=$S(ICDCC:85,1:86) Q
DRG86 S ICDRG=$S(ICDCC:85,1:86) Q
DRG89 S ICDRG=$S(AGE<18:91,ICDCC:89,1:90) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG90 S ICDRG=$S(AGE<18:91,ICDCC:89,1:90) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG91 S ICDRG=$S(AGE<18:91,ICDCC:89,1:90) I AGE="" S ICDRG=470,ICDRTC=3
 Q
DRG92 S ICDRG=$S(ICDCC!($D(ICDSDRG(92))):92,1:93) Q
DRG93 S ICDRG=$S(ICDCC:92,1:93) Q
DRG94 S ICDRG=$S(ICDCC:94,1:95) Q
DRG528 S ICDRG=$S((ICDPD["K")&(ICDOR["K"):528,1:ICDRG) Q
DRG529 S ICDRG=$S((ICDOR["S")&(ICDCC):529,(ICDOR["S")&('ICDCC):530,1:ICDRG) Q
DRG530 D DRG529 Q
