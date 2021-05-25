variable readed_data 100 cells allot
variable array_length
variable depth_of_recursion 10 depth_of_recursion ! \ next it is 2 * logariphm
variable counter 0 counter !
: RTEST RP@ DUP >R RP@ RDROP SWAP - ;

RTEST CONSTANT RSTEP
RP@ CONSTANT RBIAS

: .RETURNSTACK \ --
  RP@ RBIAS 
  DO I @ U. RSTEP
  +LOOP CR ;
  
\ QUICK_SORT !!!
: cell- 1 cells - ;

( l r -- mid )
: mid drop ;

( addr1 addr2 -- )
: exch  dup @ >r over @ swap ! r> swap ! ;
 
( l r -- l r r2 l2 )
: partition 
  -1 depth_of_recursion +!
  2dup mid @ >r ( r: pivot )
  2dup begin
    swap begin dup @  r@ < while cell+ repeat
    swap begin r@ over @ < while cell- repeat
    2dup <= if 2dup exch >r cell+ r> cell- then
  2dup > until  r> drop ;
 
 ( l r -- )
: qsort 
  depth_of_recursion @ 0= if exit then
  partition  swap rot
  2dup < if recurse else 1 depth_of_recursion +! 2drop then
  2dup < if recurse else 2drop then ;
 
 ( array len -- flag)
: quick_sort 
  dup 2 < if 2drop exit then
  1- cells over + qsort 
  depth_of_recursion @ 0= if -1 ." Переключение на Heapsort." cr else 0 then 
 ;

\ HEAPSORT !!! 
: r'@ r> r> r@ swap >r swap >r ; ( copy 3rd element from the return stack)
 
( n1 n2 a -- f = a[n1] < a[n2])
: precedes >r cells r@ + @ swap cells r> + @ swap < ;   

( n1 n2 a --) ( swaping values in array at fields a[n1] and a[n2])                   
: exchange >r cells r@ + swap cells r> + over @ over @ swap rot ! swap ! ;                        
 
 ( n addr -- )
: print_array 
	swap 0 do
	 dup i cells + ? loop cr drop ;
 
 ( addr, n , ]n - 2[ / 2 -- )
: siftDown                 
  swap >r swap >r dup ( ]n - 2[ /2 , ]n - 2[ /2  on parametr stack)  ( head_here -> addr, n, addr ] on return stack)           
  begin                            
    dup 2* 1+ dup r'@ <                             
  while                                  
    dup 1+ dup r'@ <                                   
    if 2dup r@ precedes if swap then                 
    then drop                  
    2dup r@ precedes      
  while                                
    tuck r@ exchange                   
  repeat then                          
  drop drop r> swap r> swap            
;

 ( addr , n -- )
: heap_sort
  over >r            ( save addr in additional stack)                         
  dup 1- 1- 2/       ( addr, n , ]n - 2[ / 2)  
  begin                                
    dup 0< 0=         ( addr, n , ]n - 2[ / 2) ( while x >=0 )
  while                                
    siftDown 1-                        
  repeat drop                          
    ( addr n ) ( now heap is ready where root is maxima, let`s sort it)
  1- 0      ( addr n n-1 )             
  begin                                
    over 0>               ( while n > 0)             
  while                   ( addr n n-1)   
    2dup r@ exchange              
    siftDown          
    swap 1- swap              
  repeat                               
  drop drop drop r> drop
;
 
( sz -- ) ( we read all our input into array readed_data)
: fetch-input 
     0 do 
     	pad 40 accept   
     	pad swap s>number? drop
     	d>s readed_data i cells + ! loop ;


 ( addr , n -- )
 : intro_sort
 	2dup >r >r quick_sort 0= if ." Быстрая сортировка прошла! " cr else readed_data array_length @ heap_sort then r> r> 2drop
 ; 

( n -- )
: count_log2
	0 counter !
	begin 
		1 counter +!
		2/ dup 2 < until
	counter @ 1+
;

." Введите размер массива" cr
1 fetch-input 
readed_data @ array_length !
cr ." Размер массива присвоен: " array_length ? cr
array_length @ count_log2 depth_of_recursion !
." Введите массив" cr
array_length @ fetch-input cr
." Ввёденный массив" cr
array_length @ readed_data print_array
readed_data array_length @ intro_sort
cr ." Отсортированный массив" cr
array_length @ readed_data print_array
