\ Кажется, что есть 4 сособа контролировать время компиляции immediate, postpone, literal и пара []
\ Так вот - всё, что мы напишем, внутри последней и вместе с literal будет сделано во врмея компиляции при возможности
\ Давайте это проверим

: compiler_function [ 1 2 +  2 * ] literal ;

: runtime_function 1 2 +  2 *  . ;

: use_compiler_fucntion_in_runtime 1 2 + [ compiler_function ] literal ;

see compiler_function
cr
see runtime_function
cr
see use_compiler_fucntion_in_runtime
cr

\ : compiler_function  
\  6 . ;


\ : runtime_function  
\  1 2 + 2 * . ; 

\ : use_compiler_fucntion_in_runtime  
\  1 2 + 6 ;


\ В итоге любой макрос написанный так -- можно использовать в рантайме и он будет предпосчитан во время компиляции 
\ P.S. Возможно я что-то не понял, но про какие "скобочки" в задании идёт речь. У нас же "обратно" польская запись, в которой скобок нет.

