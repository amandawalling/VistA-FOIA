FSCRPCEN ;SLC/STAFF-NOIS RPC Edit Note ;6/1/98  16:37
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTE(IN,OUT) ; from FSCRPX (RPCMakeANote)
 N CALL,EDITED,FIELDS,STATUS K FIELDS
 K ^TMP("FSC WP",$J)
 D PROCESS^FSCRPCNC(.FIELDS)
 S CALL=+$G(FIELDS("CALL"))
 I 'CALL Q
 S STATUS=+$P($G(^FSCD("CALL",CALL,0)),U,2)
 Q:'STATUS  Q:STATUS=2  Q:STATUS=99
 I $O(^TMP("FSCRPC",$J,"INPUT",1)) D
 .D FIELDS^FSCRPCEC(CALL,.FIELDS,.EDITED)
 .I EDITED D MRE^FSCMR(DUZ,CALL),UPDATE^FSCAUDIT(CALL)
 K FIELDS,^TMP("FSC WP",$J)
 Q
