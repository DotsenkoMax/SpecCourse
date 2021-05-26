: fac ( n -- n! ) 1 swap 1+ 2 max 2 ?do i * loop ;
 
: main  ." 10! = " [ 10 fac ] literal . ;
 

 
: lol ." abracadabra" [ 1 2 + ] literal . 10 fac ;
see main cr
see lol



 : MY-+ ( Compilation: -- ; Run-time of compiled code: n1 n2 -- n )
      POSTPONE + ; immediate
     : foo ( n1 n2 -- n )
      MY-+ ;
1 2 foo .
see foo


: My+ POSTPONE + ; immediate
: plus My+ ;
: My- POSTPONE - ; immediate
: minus My- ;
: My* POSTPONE * ; immediate
: division My* ;
: My/ POSTPONE / ; immediate
: division My/ ;


: function 1 2 plus 3 minus ; immediate

cr
function .
cr
see function 


: kek [ + ] literal . ;

1 2 kek
