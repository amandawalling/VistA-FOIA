ORRCLPT ; SLC/JER - Pt functions for CM ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
NAME(DFN) ; Pt Name
 Q $P($G(^DPT(DFN,0)),U)
SSNL4(DFN) ; SSN Last4
 N ORRCY
 S ORRCY=$$SSN^DPTLK1(DFN)
 Q $S(+ORRCY:$E(ORRCY,6,10),1:ORRCY)
SEX(DFN) ; Pt SEX
 Q $P($G(^DPT(DFN,0)),U,2)
AGE(DFN) ; Pt AGE
 Q $$AGE^ORWPT(DFN,$$DOB^DPTLK1(DFN,2))
