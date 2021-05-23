\ HEAPSORT !!!
: r'@ r> r> r@ swap >r swap >r ;
 
 ( n1 n2 a -- f)
: precedes >r cells r@ + @ swap cells r> + @ swap < ;   
( n1 n2 a --)                    
: exchange >r cells r@ + swap cells r> + over @ over @ swap rot ! swap ! ;                        
 
: print_array ( n addr -- n)
	swap 0 do
	 dup i CELLS + ? loop cr ;
 
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
 
 ( addr_on_last , n -- )
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
 
 
variable readed_data 100 cells allot
variable array_length

: fetch-input ( sz - )
     0 do 
     	pad 40 accept   
     	pad swap s>number? drop
     	d>s readed_data i cells + ! loop ;

." Введите размер массива" cr
1 fetch-input 
readed_data @ array_length !
cr ." Размер массива присвоен: " array_length ? cr
." Введите массива" cr
array_length @ fetch-input cr
." Ввёденный массив" cr
array_length @ readed_data print_array
array_length @ heapsort 

cr ." Отсортированный массив" cr
array_length @ readed_data print_array
