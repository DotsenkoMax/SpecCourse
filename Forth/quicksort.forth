: cell- 1 cells - ;
: mid ( l r -- mid ) drop ;
 
: exch ( addr1 addr2 -- ) dup @ >r over @ swap ! r> swap ! ;
 
: partition ( l r -- l r r2 l2 )
  2dup mid @ >r ( r: pivot )
  2dup begin
    swap begin dup @  r@ < while cell+ repeat
    swap begin r@ over @ < while cell- repeat
    2dup <= if 2dup exch >r cell+ r> cell- then
  2dup > until  r> drop ;
 
: qsort ( l r -- )
  partition  swap rot
  \ 2over 2over - + < if 2swap then
  2dup < if recurse else 2drop then
  2dup < if recurse else 2drop then ;
 
: sort ( array len -- )
  dup 2 < if 2drop exit then
  1- cells over + qsort ;
  
 
: print_array ( n addr -- n)
	swap 0 do
	 dup i cells + ? loop cr drop ;

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
readed_data array_length @ sort 

cr ." Отсортированный массив" cr
array_length @ readed_data print_array
