RMPRPIYU ;HINCIO/ODJ - PIP Data Prompts;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ;DBIA #800
 Q
 ;
 ;***** QTY - Prompt for Quantity (Transfer Option RMPRPIYT)
QTY(RMPRQTY,RMPREXC,RMPR5,RMPR11) ;
 N RMPRERR,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT,DA,RMPRSTK
 S RMPRQTY=$G(RMPRQTY)
 S RMPREXC=""
 S RMPRERR=0
 S RMPRSTK("STATION IEN")=RMPR11("STATION IEN")
 S RMPRSTK("HCPCS")=RMPR11("HCPCS")
 S RMPRSTK("ITEM")=RMPR11("ITEM")
 S RMPRSTK("LOCATION IEN")=RMPR5("IEN")
 S RMPRSTK("VENDOR IEN")=""
 S RMPRERR=$$STOCK^RMPRPIUE(.RMPRSTK)
 I +RMPRSTK("QOH")<1 S RMPRERR=99 G QTYX
 S DIR(0)="NAO^1:"_+RMPRSTK("QOH")_":0"
 S DIR("A")="Enter Quantity to transfer: "
 S DIR("?")="^D QM^RMPRPIYU"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G QTYX
 I $D(DIROUT) S RMPREXC="P" G QTYX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G QTYX
 S RMPRQTY=Y
 S RMPREXC=""
QTYX Q RMPRERR
 ;
 ; On help get current stock and display
 ; only call from QTY^RMPRPIYU
QM N RMPRERR
 S RMPRERR=$$STOCK^RMPRPIUE(.RMPRSTK)
 W !,"Current balance is = "_RMPRSTK("QOH")
 W !,"Enter quantity 1 to "_RMPRSTK("QOH")_" or enter '^' to QUIT?"
 Q
 ;
 ;***** VEND - prompt for Vendor (Transfer option RMPRPIYT)
VEND(RMPRV,RMPRVNDR,RMPREXC) ;
 N DIC,X,Y,DA,DUOUT,DTOUT,DIROUT,DIRUT
 S RMPREXC=""
 S DIC(0)="AEQM"
 S DIC("A")="Vendor: "
 S DIC=440
 S DIC("S")="I $D(RMPRV(+Y))"
 D ^DIC
 I $D(DTOUT) S RMPREXC="T" G VENDX
 I $D(DIROUT) S RMPREXC="P" G VENDX
 I X=""!(X["^")!($D(DUOUT)) S RMPREXC="^" G VENDX
 S RMPRVNDR=+Y
VENDX Q
 ;
 ;***** LOCNM - Prompt for transfer 'To' location
 ;              must be in 661.5 and active
LOCNM(RMPRSTN,RMPR5,RMPREXC) ;
 N RMPRERR,DIR,X,Y,DA,DUOUT,DTOUT,DIROUT,RMPRYN,RMPRTDT
 S RMPREXC=""
 S RMPRERR=0
 S DIR(0)="FOA"
 S DIR("A")="Enter Receiving Location: "
 S DIR("?")="^D QM^RMPRPIYB"
 S DIR("??")="^D QM2^RMPRPIYB"
 S RMPR5("IEN")=""
LOCNM1 D ^DIR
 I $G(RMPR5("IEN"))'="" S RMPREXC="" G LOCNMX
 I $D(DTOUT) S RMPREXC="T" G LOCNMX
 I $D(DIROUT) S RMPREXC="P" G LOCNMX
 I X=""!(X["^") S RMPREXC="^" G LOCNMX
 K RMPR5
 S RMPR5("STATION")=RMPRSTN
 S RMPR5("STATION IEN")=RMPRSTN
 D LIKE^RMPRPIYB(RMPRSTN,X,.RMPREXC,.RMPR5)
 I RMPREXC'="" G LOCNM1
 I $G(RMPR5("IEN"))="" D  G LOCNM1
 . W !,"Please enter a valid Location"
 . Q
 ;
 ; exit
LOCNMX Q
 ;
 ;***** OK - Prompt for an OK
OK(RMPRYN,RMPREXC) ;
 N DIR,X,Y,DA,DUOUT,DTOUT,DIROUT,DIRUT
 S RMPREXC=""
 S RMPRYN="N"
 S DIR("A")="         ...OK"
 S DIR("B")="Yes"
 S DIR(0)="Y"
 D ^DIR
 I $D(DTOUT) S RMPREXC="T" G OKX
 I $D(DIROUT) S RMPREXC="P" G OKX
 I X=""!(X["^") S RMPREXC="^" G OKX
 S RMPRYN="N" S:Y RMPRYN="Y"
OKX Q
