variable readed_data 100 cells allot
variable array_length
variable depth_of_recursion 10 depth_of_recursion ! \ next it is 2 * logariphm

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
: quicksort 
  dup 2 < if 2drop exit then
  1- cells over + qsort 
  depth_of_recursion @ 0= if -1 ." Переключение на Heapsort." cr else 0 then 
 ;

\ HEAPSORT !!!
: r'@ r> r> r@ swap >r swap >r ; ( retrun stack: a, b, c -- a, b, c)  ( parameter stack: -- a)
 
( n1 n2 a -- f)
: precedes >r cells r@ + @ swap cells r> + @ swap < ;   

( n1 n2 a --)                    
: exchange >r cells r@ + swap cells r> + over @ over @ swap rot ! swap ! ;                        
 
 ( n addr -- n)
: print_array 
	swap 0 do
	 dup i cells + ? loop cr drop ;
 
 ( addr, n , ]n - 2[ / 2 -- )
: siftDown                             
  swap >r swap >r dup        ( ]n - 2[ /2 , ]n - 2[ /2  on parametr stack)  ( head_here -> addr, n, addr ] on return stack)           
  begin                                
    dup 2* 1+ dup r'@ <                
  while                                
    dup 1+ dup r'@ <                   
    if                                 
      over over r@ precedes if swap then
    then drop                          
    over over r@ precedes              
  while                                
    tuck r@ exchange                   
  repeat then                          
  drop drop r> swap r> swap            
;

 ( addr , n -- )
: heapsort                             
  over >r            ( save addr in additional stack)                            
  dup 1- 1- 2/       ( addr, n , ]n - 2[ / 2)  
  begin                                
    dup 0< 0=         ( addr, n , ]n - 2[ / 2) ( while x >=0 )                 
  while                                
    siftDown 1-                        
  repeat drop                          

  1- 0                                 
  begin                                
    over 0>                            
  while                                
    over over r@ exchange              
    siftDown swap 1- swap              
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
 	2dup >r >r quicksort 0= if ." Быстрая сортировка прошла! " cr else readed_data array_length @ heapsort then r> r> 2drop
 ; 

variable counter 0 counter !
( n -- )
: count_log2
	0 counter !
	begin 
		1 counter +!
		2/ dup 2 < until
	counter @ 2*
;

." Введите размер массива" cr
1 fetch-input 
readed_data @ array_length !
cr ." Размер массива присвоен: " array_length ? cr
array_length @ count_log2 depth_of_recursion !
." Введите массива" cr
array_length @ fetch-input cr
." Ввёденный массив" cr
array_length @ readed_data print_array
readed_data array_length @ intro_sort 
cr ." Отсортированный массив" cr
array_length @ readed_data print_array
