XPDIN00L ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,0,0,"N")
 ;;=9,52^1,52^1,52^9,52^1,52
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52)
 ;;=1^0^9.62^^e^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,1,"D")
 ;;=2^11^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,1,"N")
 ;;=0^2^2^0^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,2,"D")
 ;;=4^11^65^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,2,"N")
 ;;=1^3^3^1^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,3,"D")
 ;;=6^11^65^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,3,"N")
 ;;=2^4^4^2^4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,4,"D")
 ;;=7^11^1^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,4,"N")
 ;;=3^5^5^3^5^^^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,5,"D")
 ;;=9^11^65^4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,5,"N")
 ;;=4^6^6^4^6
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,6,"D")
 ;;=11^11^65^5
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,6,"N")
 ;;=5^7^7^5^7
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,7,"D")
 ;;=12^11^1^6
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,7,"N")
 ;;=6^8^8^6^8^^^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,8,"D")
 ;;=13^11^64^7
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,8,"N")
 ;;=7^9^9^7^9
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,9,"D")
 ;;=15^11^65^10
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,52,9,"N")
 ;;=8^0^0^8^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",15,"FIRST")
 ;;=1,52
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","ASUB",2,57,1)
 ;;=3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","ASUB",8,51,2)
 ;;=5
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","ASUB",9,55,5)
 ;;=10
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","ADDRESS FOR USAGE REPORTING",9,9,55,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","AFFECTS RECORD MERGE","8^1^2",8,51,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","ALPHA/BETA TESTING...","8^1^2",8,54,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DATA COMES WITH FILE...",7,7,49,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DATA LIST",13,13,64,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DATE DISTRIBUTED","1^4^2",1,46,13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DESCRIPTION","1^4^2",1,46,11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(0)",6,6,52,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(0)",15,15,52,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(?)",6,6,52,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(?)",15,15,52,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(?,#)",6,6,52,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(?,#)",15,15,52,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(??)",6,6,52,8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(??)",15,15,52,8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(A)",6,6,52,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(A)",15,15,52,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(A,#)",6,6,52,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(A,#)",15,15,52,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(B)",6,6,52,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","DIR(B)",15,15,52,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","ENVIRONMENT CHECK ROUTINE","1^4^2",1,46,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","FILE",7,7,49,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","FILE AFFECTED",5,5,50,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","INSTALLATION MESSAGE",9,9,55,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","M CODE",6,6,52,9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","M CODE",15,15,52,9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","MAY USER OVERRIDE DATA UPDATE",13,13,64,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","NAME",6,6,52,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","NAME",15,15,52,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","NAME","1^4^2",1,46,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","NAME OF MERGE ROUTINE",5,5,50,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","PACKAGE FILE LINK...","2^14^4",14,65,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","POST-INSTALL ROUTINE","1^4^2",1,46,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","PRE-INSTALL ROUTINE","1^4^2",1,46,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","PRIMARY HELP FRAME","8^1^2",8,51,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","RECORD HAS PACKAGE DATA",5,5,50,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","RESOLVE POINTERS",13,13,64,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","CAP","SCREEN TO DETERMINE DD UPDATE",7,7,49,13)
 ;;=
