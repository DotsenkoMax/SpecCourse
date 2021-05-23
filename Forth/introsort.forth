variable readed_data 100 cells allot
variable array_length
variable depth_of_recursion 10 depth_of_recursion ! \ next it is 2 * logariphm

\ QUICK_SORT !!!
: cell- 1 cells - ;

: mid ( l r -- mid ) drop ;
 
: exch ( addr1 addr2 -- ) dup @ >r over @ swap ! r> swap ! ;
 
: partition ( l r -- l r r2 l2 )
  -1 depth_of_recursion +!
  2dup mid @ >r ( r: pivot )
  2dup begin
    swap begin dup @  r@ < while cell+ repeat
    swap begin r@ over @ < while cell- repeat
    2dup <= if 2dup exch >r cell+ r> cell- then
  2dup > until  r> drop ;
 
: qsort ( l r -- )
  depth_of_recursion @ 0= if exit then
  partition  swap rot
  \ 2over 2over - + < if 2swap then
  2dup < if recurse else 1 depth_of_recursion +! 2drop then
  2dup < if recurse else 2drop then ;
 
: quicksort ( array len -- flag)
  dup 2 < if 2drop exit then
  1- cells over + qsort 
  depth_of_recursion @ 0= if -1 ." Переключение на Heapsort." cr else 0 then 
 ;

\ HEAPSORT !!!
: r'@ r> r> r@ swap >r swap >r ;
 
 ( n1 n2 a -- f)
: precedes >r cells r@ + @ swap cells r> + @ swap < ;   
( n1 n2 a --)                    
: exchange >r cells r@ + swap cells r> + over @ over @ swap rot ! swap ! ;                        
 
: print_array ( n addr -- n)
	swap 0 do
	 dup i cells + ? loop cr drop ;
 
: siftDown                             ( a e s -- a e s)
  swap >r swap >r dup                  ( s r)
  begin                                ( s r)
    dup 2* 1+ dup r'@ <                ( s r c f)
  while                                ( s r c)
    dup 1+ dup r'@ <                   ( s r c c+1 f)
    if                                 ( s r c c+1)
      over over r@ precedes if swap then
    then drop                          ( s r c)
    over over r@ precedes              ( s r c f)
  while                                ( s r c)
    tuck r@ exchange                   ( s r)
  repeat then                          ( s r)
  drop drop r> swap r> swap            ( a e s)
;

 ( addr , n -- )
: heapsort                             ( a n --)
  over >r                              ( a n)
  dup 1- 1- 2/                         ( a c s)
  begin                                ( a c s)
    dup 0< 0=                          ( a c s f)
  while                                ( a c s)
    siftDown 1-                        ( a c s)
  repeat drop                          ( a c)
 
  1- 0                                 ( a e 0)
  begin                                ( a e 0)
    over 0>                            ( a e 0 f)
  while                                ( a e 0)
    over over r@ exchange              ( a e 0)
    siftDown swap 1- swap              ( a e 0)
  repeat                               ( a e 0)
  drop drop drop r> drop
;
 

: fetch-input ( sz - )
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
