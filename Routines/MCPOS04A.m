MCPOS04A ;HIRMFO/DAD-CONSULT CONVERSION 699 >>>===> 699.5 ;7/5/96  08:35
 ;;2.3;Medicine;;09/13/1996
 ;
 ; WORD PROCESSING FIELDS
 S %X="^MCAR(699,"_MC699D0_",20,",%Y="^MCAR(699.5,"_MC6995D0_",20,"
 D %XY^%RCR ; SUBJECTIVE WP
 S %X="^MCAR(699,"_MC699D0_",21,",%Y="^MCAR(699.5,"_MC6995D0_",21,"
 D %XY^%RCR ; OBJECTIVE WP
 S %X="^MCAR(699,"_MC699D0_",22,",%Y="^MCAR(699.5,"_MC6995D0_",22,"
 D %XY^%RCR ; ASSESSMENT WP
 S %X="^MCAR(699,"_MC699D0_",23,",%Y="^MCAR(699.5,"_MC6995D0_",35,"
 D %XY^%RCR ; PLANNED WP
 ;
 ; MEDICATIONS
 S MC699D1=0
 F  S MC699D1=$O(^MCAR(699,MC699D0,8,MC699D1)) Q:MC699D1'>0  D
 . S MCDATA=+$P($G(^MCAR(699,MC699D0,8,MC699D1,0)),U)
 . I $O(^MCAR(699.5,MC6995D0,4,"B",MCDATA,0)) Q
 . I $P($G(^PSDRUG(MCDATA,0)),U)="" Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(699.5,"_MC6995D0_",4,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(699.5,5,"","SPECIFIER"),DLAYGO=699.5
 . S (D0,DA(1))=MC6995D0,X=MCDATA D FILE^DICN
 . Q
 ;
 ; TECHNIQUE
 S MC699D1=0
 F  S MC699D1=$O(^MCAR(699,MC699D0,2,MC699D1)) Q:MC699D1'>0  D
 . S MCDATA=+$P($G(^MCAR(699,MC699D0,2,MC699D1,0)),U)
 . I $O(^MCAR(699.5,MC6995D0,2,"B",MCDATA,0)) Q
 . I $P($G(^MCAR(699.6,MCDATA,0)),U)="" Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(699.5,"_MC6995D0_",2,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(699.5,7,"","SPECIFIER"),DLAYGO=699.5
 . S (D0,DA(1))=MC6995D0,X=MCDATA D FILE^DICN
 . Q
 ;
 ; COMPLICATIONS
 S MC699D1=0
 F  S MC699D1=$O(^MCAR(699,MC699D0,17,MC699D1)) Q:MC699D1'>0  D
 . S MCDATA=+$P($G(^MCAR(699,MC699D0,17,MC699D1,0)),U)
 . I $O(^MCAR(699.5,MC6995D0,3,"B",MCDATA,0)) Q
 . I $P($G(^MCAR(696.9,MCDATA,0)),U)="" Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(699.5,"_MC6995D0_",3,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(699.5,3,"","SPECIFIER"),DLAYGO=699.5
 . S (D0,DA(1))=MC6995D0,X=MCDATA D FILE^DICN
 . Q
 ;
 ; ICD DIAGNOSIS
 S MC699D1=0
 F  S MC699D1=$O(^MCAR(699,MC699D0,"ICD",MC699D1)) Q:MC699D1'>0  D
 . S MCDATA=$G(^MCAR(699,MC699D0,"ICD",MC699D1,0))
 . S MCNARRDX=$P(MCDATA,U,2)
 . I $O(^MCAR(699.5,MC6995D0,"ICD","B",+$P(MCDATA,U),0)) Q
 . I $P($G(^ICD9(+$P(MCDATA,U),0)),U)="" Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(699.5,"_MC6995D0_",""ICD"",",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(699.5,700,"","SPECIFIER"),DLAYGO=699.5
 . I MCNARRDX]"" S DIC("DR")=".02///^S X=$E(MCNARRDX,1,80)"
 . S (D0,DA(1))=MC6995D0,X=+$P(MCDATA,U) D FILE^DICN K MCNARRDX
 . Q
 ;
 ; IMAGE
 S MC699D1=0
 F  S MC699D1=$O(^MCAR(699,MC699D0,2005,MC699D1)) Q:MC699D1'>0  D
 . S MCDATA=+$P($G(^MCAR(699,MC699D0,2005,MC699D1,0)),U)
 . I $O(^MCAR(699.5,MC6995D0,2005,"B",MCDATA,0)) Q
 . I $P($G(^MAG(2005,MCDATA,0)),U)="" Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(699.5,"_MC6995D0_",2005,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(699.5,2005,"","SPECIFIER"),DLAYGO=699.5
 . S (D0,DA(1))=MC6995D0,X=MCDATA D FILE^DICN
 . Q
 Q
