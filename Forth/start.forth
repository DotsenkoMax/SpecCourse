( SWAP	n1 n2 — n2 n1 	Reverses the top two stack items )
( DUP	n — n n 	Duplicates the top stack item)
( OVER	n1 n2 — n1 n2 n1	Copies second item to top)
( ROT	n1 n2 n3 — n2 n3 n1 	Rotates third item to top)
( DROP	n — 	Discards the top stack item)
( TUCK x1 x2 -- x2 x1 x2 )
( .S Показывает все элементы на стеке не удаляя их)
( CR  ---   = '\n')
( SPACES n --- Пишет n пробелов после каретки в терминале)
( SPACE	 --  Prints one blank space at your terminal. )
( ." xxx"  -- Prints the character string xxx at your terminal. The " character terminates the string. )
( MARKER -YOUR_NAME_OF_FLAG -- add maker for ur code, and when u will write "-YOUR_NAME_OF_FLAG" - you will be returned to that state)
1 2 3
.S
CR

: lol 1 2 3 ;

( bye - for returning)

( : equals = if ." REALLY" then ." ALWAYS" ; -- THEN вызывается всегда)
( : equals = if ." REALLY" ELSE ." BOOLSHIT" then ." ALWAYS" ; -- THEN вызывается всегда)

( 1+, 1-, 2+, 2-, 2*, 2/, ABS, NEGATE, MIN, MAX)

( >R  n —  Takes a value off the parameter stack and pushes it onto the return stack.)
( R>  — n  Takes a value off the return stack and pushes it onto the parameter stack.)
( R@  — n  Copies the top item from return stack and pushes it onto the parameter stack.)


( Ещё есть все виды цкилов и фор и вайл и т.д. -- тут https://www.forth.com/starting-forth/6-forth-do-loops/ )


( VARIABLE DATE определение переменной - работем как с адресов в плюсах)
( DATE 8 ! задание переменной)
( DATE @ Положить значение на стэк)
( DATE @ . = DATE ? Вывести значение переменной)
( 6 DATE +! Прибавить n)
( @ - разыименование )

( !   n addr —  Stores a single-length number into the address. )
( @   addr — n Fetches that value at addr.)
( ?   addr — Prints the contents of the address, followed by one space.)
( +!  n addr —  Adds a single-length number to the contents of the address.)

( 0< b -- if b < 0 then -1 else 0)


( n CELLS -- выдает число байт в одной ячейке) 
( VARIABLE LIMITS 4 CELLS ALLOT Создает массив из 5 байт 0 1 2 3 4)
( 220 LIMITS ! - устанавливает значение 220 в нулевую ячейку) 
( 220 n CELLS LIMITS + ! - устанавливает значение 220 в nую ячейку) 

( FILL addr n char — Fills n bytes of memory, beginning the address addr, with value char)

( ERASE addr n —  Stores zeroes into n bytes of memory, beginning at address addr.)



( to show return stack )
: RTEST RP@ DUP >R RP@ RDROP SWAP - ;

RTEST CONSTANT RSTEP
RP@ CONSTANT RBIAS

: .RETURNSTACK \ --
  RP@ RBIAS 
  DO I @ U. RSTEP
  +LOOP CR ;


