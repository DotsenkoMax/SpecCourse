zero_matrix_from_shape =: 3 : 0
'n m' =: y
matrix =: (n, m) $ 0
matrix
)

identity_matrix_from_shape =: 3 : 0
'n' =: y
row =: 1, (n $ 0)
LL =: (n, n) $ row
LL
)
 
dot =: +/ . *

index =: -1
jindex =: -1
minor =: 1
GET_LU =: 3 : 0
	'n m' =. $A 
    	if. index = n do.
		'LU GETTED'
	else.
		if. (index - 1) < jindex do.
			NB. Calculating uij
			uij =. jindex { index {A
			if. index = 0 do.
 				uij =. uij  
			else.  
 				L_i_row =. (((index) $ 1 ), ((m - index)) $ 0) # index { L
 				U_j_column =. (((index) $ 1) , ((m - index)) $ 0) # jindex { (|: U)
 				uij =. (jindex { index {A) - (L_i_row dot U_j_column)
			end.
			NB. We need to change i j elemnt of U
			row_full_i =:  (1 { $U) $ index
 			U =: ((uij jindex } row_full_i } U ) row_full_i } U)
			NB. U 1!:2 (2)  	
		else.
			NB. Calculating lij
			lij =. jindex { index {A
			ujj =. jindex { jindex { U
			assert (ujj = 0 ) = 0
			if. jindex = 0 do.
			else.
 				L_i_row =. (((jindex) $ 1 ), ((m - jindex)) $ 0) # index { L
 				U_j_column =. (((jindex) $ 1) , ((m - jindex)) $ 0) # jindex { (|: U)
 				lij =. (jindex { index {A) - (L_i_row dot U_j_column)
			end.
			lij =. lij % ujj
			NB. We need to change i j elemnt of L
			row_full_i =:  (1 { $L) $ index
 			L =: ((lij jindex } row_full_i } L ) row_full_i } L)
		end.	
		NB. It must be used for recursion
		jindex =: jindex + 1
		if. jindex > n - 1 do.
			jindex =: 0
			index =: index + 1
		else. 
		jindex =:	jindex
		end.
		GET_LU 1  
	end.
)



IS_LU_ADEQUATE =: 3 : 0
	if. minor = (1 { $A) do.
		'LU разложение существует' 1!:2 (2) 
		1
	else.
		determinant =: 0
		if. minor = 1 do.
			determinant =: det ((minor - 1) { |: ((minor - 1) { A))
		else.
			determinant =: det ((0, (minor - 1)) { |: ((0, (minor - 1)) { A))
		end.	
		if. determinant = 0 do.
			'LU разложения не существует' 1!:2 (2) 
			0
		else.
			minor =: minor + 1
			IS_LU_ADEQUATE 1
		end. 
	end.
)


do =: 0 !: 1
det =: - / . *
lu =: 0 : 0
	index =: 0
	jindex =: 0
	U =: ($A) $ 0
	L =: identity_matrix_from_shape (1 { $A)
	GET_LU 1
)

haslu =: 0 : 0
	minor =. 1
	result =: IS_LU_ADEQUATE 1
)


NB. We have A, L, and U
NB. Also we have global var index, jindex

NB. A =: 3 3 $ (i. 9)
A =: 3 3 $ 1 2 3 4 5 6 7 8 9
U =: ($A) $ 0
L =: identity_matrix_from_shape (1 { $A)

'Введите матрицу А'