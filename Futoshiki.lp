number(1..n).

cell(R, C) :- number(R), number(C).

1 { cell_has_number(R, C, N) : number(N) } 1 :- cell(R, C).

:- cell_has_number(R, C1, N), cell_has_number(R, C2, N), C1 != C2.

:- cell_has_number(R1, C, N), cell_has_number(R2, C, N), R1 != R2.

% greater than constraint
A > B :- greater_than(R1,C1, R2,C2), cell_has_number(R1,C1, A), cell_has_number(R2,C2, B).

#show cell_has_number/3.

%Encode for example the question grid above like this:

#const n = 4.
cell_has_number(4,4, 2).
greater_than(1,2, 1,1).
greater_than(1,2, 1,3).
greater_than(3,3, 2,3).
greater_than(3,1, 4,1).
greater_than(4,2, 4,3).
