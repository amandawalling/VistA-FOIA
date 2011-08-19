FSCRPCA ;SLC/STAFF-NOIS RPC Add ;3/12/99  14:27
 ;;1.1;NOIS;**1**;Sep 06, 1998
 ;
ALERT(IN,OUT) ; from FSCRPX (RPCAlert)
 N DATA,NODE,TIME,XQAID,XQAKILL
 D GETTIME(.TIME) I 'TIME Q
 S NODE=$G(^XTV(8992,DUZ,"XQA",TIME,0)),DATA=$G(^(1))
 I '$L(NODE) Q
 S XQAID=$P(NODE,U,2)
 I XQAID["FSC-A" D USER^FSCRPCAP
 I XQAID["FSC-M" D ALERT^FSCRPCAP(DATA)
 S XQAKILL=1
 D DELETE^XQALERT
 Q
 ;
GETTIME(TIME) ;
 N NODEID,SUB
 S TIME=0
 S SUB=0 F  S SUB=$O(^XTV(8992,DUZ,"XQA",SUB)) Q:SUB<1  D  I TIME>0 Q
 .S NODEID=$P($G(^XTV(8992,DUZ,"XQA",SUB,0)),U,2)
 .I NODEID["FSC-A" S TIME=SUB Q
 .I NODEID["FSC-M" S TIME=SUB Q
 Q
 ;
LISTS(IN,OUT) ; from FSCRPX (RPCAddLists)
 N CALL,COUNT,INDX,INPUT,LCNT,LIMIT,LIMITNUM,LIMITDTO,LIMITDFM,LIST,LNAME,LNUM,MAX,OK,RLIST,TIME
 S COUNT=0,MAX=$$MAX^FSCRPCL
 S LNUM=0 F  S LNUM=$O(^TMP("FSCRPC",$J,"INPUT",LNUM)) Q:LNUM<1  S INPUT=^(LNUM) D  Q:COUNT'<MAX
 .S LIST=+INPUT,INDX=+$P(INPUT,U,2),LIMITNUM=$P(INPUT,U,3),LIMITDTO=$P(INPUT,U,4),LIMITDFM=$P(INPUT,U,5)
 .I 'LIST Q
 .D LIST(LIST,INDX,.RLIST,.OK) I 'OK Q
 .S LNAME=$P(^FSC("LIST",LIST,0),U)
 .I LNAME="MRE:" D
 ..S (LIMIT,LCNT)=0,TIME="" F  S TIME=$O(^FSCD("MRE","AUTC",INDX,TIME)) Q:TIME=""  D  Q:LIMIT  Q:COUNT'<MAX
 ...S CALL=0 F  S CALL=$O(^FSCD("MRE","AUTC",INDX,TIME,CALL)) Q:CALL<1  D  Q:LIMIT  Q:COUNT'<MAX
 ....I '$D(^TMP("FSC CURRENT LIST",$J,"C",CALL)) D CHECK(CALL,LIMITNUM,LIMITDTO,LIMITDFM,.LIMIT,.LCNT,.COUNT)
 .E  I LNAME="MRA:" D
 ..S (LIMIT,LCNT)=0,TIME="" F  S TIME=$O(^FSCD("MRA","AUTC",INDX,TIME)) Q:TIME=""  D  Q:LIMIT  Q:COUNT'<MAX
 ...S CALL=0 F  S CALL=$O(^FSCD("MRA","AUTC",INDX,TIME,CALL)) Q:CALL<1  D  Q:LIMIT  Q:COUNT'<MAX
 ....I '$D(^TMP("FSC CURRENT LIST",$J,"C",CALL)) D CHECK(CALL,LIMITNUM,LIMITDTO,LIMITDFM,.LIMIT,.LCNT,.COUNT)
 .E  D
 ..S (LIMIT,LCNT)=0,CALL="A" F  S CALL=$O(@RLIST@(CALL),-1) Q:CALL<1  D  Q:LIMIT  Q:COUNT'<MAX
 ...I '$D(^TMP("FSC CURRENT LIST",$J,"C",CALL)) D CHECK(CALL,LIMITNUM,LIMITDTO,LIMITDFM,.LIMIT,.LCNT,.COUNT)
 D OUTPUT
 Q
 ;
CHECK(CALL,LIMITNUM,LIMITDTO,LIMITDFM,LIMIT,LCNT,COUNT) ;
 N DATEO
 I LIMITNUM D
 .I LCNT'<LIMITNUM S LIMIT=1
 .E  D SETUP(CALL,.COUNT)
 E  I LIMITDTO!LIMITDFM D
 .S DATEO=$P(^FSCD("CALL",CALL,0),U,3)
 .I DATEO<LIMITDFM Q
 .I DATEO>LIMITDTO Q
 .D SETUP(CALL,.COUNT)
 E  D SETUP(CALL,.COUNT)
 S LCNT=LCNT+1
 Q
 ;
SETUP(CALL,COUNT) ; from FSCRPCQ, FSCRPCR, FSCRPCS
 N LNUM
 S COUNT=COUNT+1
 S LNUM=1+$O(^TMP("FSC CURRENT LIST",$J,"A"),-1)
 I LNUM<1000 S LNUM=LNUM+1000
 S ^TMP("FSC CURRENT LIST",$J,LNUM)=CALL_U_$$SHORT^FSCRPXUS(CALL,DUZ)
 S ^TMP("FSC CURRENT LIST",$J,"C",CALL)=LNUM
 Q
 ;
LIST(LIST,INDX,RLIST,OK) ; from FSCRPCR, FSCRPCS
 N L0,LNAME S OK=1
 S L0=$G(^FSC("LIST",LIST,0))
 I '$L(L0) S OK=0 Q
 S LNAME=$P(L0,U)
 I $L($P(L0,U,4)),'$P(L0,U,5) S RLIST="^FSCD(""CALL"","_$P(L0,U,4)_")"
 E  I $L($P(L0,U,4)),INDX S RLIST="^FSCD(""CALL"","_$P(L0,U,4)_","_INDX_")"
 E  I $P(L0,U,3)="M" D
 .S RLIST="^FSCD(""FSC MLC"","_$J_","_LIST_")"
 .D MANUAL^FSCLP(LIST)
 .K ^TMP("FSC LIST",$J)
 E  S RLIST="^FSCD(""LISTS"",""ALC"","_LIST_")"
 ;D MRU^FSCMR(DUZ,LIST,INDX)
 Q
 ;
CALLS(IN,OUT) ; from FSCRPX (RPCAddCalls)
 N CALL,NEWNUM,NUM
 S NEWNUM=+$O(^TMP("FSC CURRENT LIST",$J,"A"),-1)
 I NEWNUM<1000 S NEWNUM=NEWNUM+1000
 S NUM=0 F  S NUM=$O(^TMP("FSCRPC",$J,"INPUT",NUM)) Q:NUM<1  S CALL=+^(NUM) D
 .I '$D(^TMP("FSC CURRENT LIST",$J,"C",CALL)) D
 ..S NEWNUM=NEWNUM+1
 ..S ^TMP("FSC CURRENT LIST",$J,NEWNUM)=CALL_U_$$SHORT^FSCRPXUS(CALL,DUZ)
 ..S ^TMP("FSC CURRENT LIST",$J,"C",CALL)=NEWNUM
 D OUTPUT
 Q
 ;
OUTPUT ; from FSCRPCAP, FSCRPCD, FSCRPCQ, FSCRPCR, FSCRPCS
 N NUM
 S NUM=0 F  S NUM=$O(^TMP("FSC CURRENT LIST",$J,NUM)) Q:NUM<1  S ^TMP("FSCRPC",$J,"OUTPUT",NUM)=^(NUM)
 Q
 ;
INSERT(IN,OUT) ; from FSCRPCX (RPCInsertCall)
 N CALL,LNUM,NEWNUM
 S CALL=+^TMP("FSCRPC",$J,"INPUT",1)
 I 'CALL Q
 S LNUM=+$O(^TMP("FSC CURRENT LIST",$J,0))
 I LNUM<1 S NEWNUM=1000
 E  S NEWNUM=LNUM-1
 F  Q:'$D(^TMP("FSC CURRENT LIST",$J,NEWNUM))  S NEWNUM=NEWNUM-1
 I NEWNUM<1 Q
 S ^TMP("FSC CURRENT LIST",$J,NEWNUM)=CALL_U_$$SHORT^FSCRPXUS(CALL,DUZ)
 S ^TMP("FSC CURRENT LIST",$J,"C",CALL)=NEWNUM
 Q
