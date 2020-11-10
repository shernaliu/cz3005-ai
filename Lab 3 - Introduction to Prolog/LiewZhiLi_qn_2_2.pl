offspring(prince, charles).
offspring(princess, ann).
offspring(prince, andrew).
offspring(prince, edward).

male(X) :- offspring(prince, X).
female(Y) :- offspring(princess, Y).

older(charles, ann).
older(ann, andrew).
older(andrew, edward).

is_older(A, B):- older(A, B).
is_older(A, B):- older(A, M), is_older(M, B).

successors(X, Y) :- insert_sort(X, Y).

insert_sort(X, Y) :- i_sort(X, [], Y).
i_sort([], Acc, Acc).
i_sort([H|T], Acc, Y) :- insert(H, Acc, NewAcc), i_sort(T, NewAcc, Y).

insert(X, [], [X]).
insert(X, [Y|T], [X, Y|T]) :- is_older(X, Y).
insert(X, [Y|T], [Y|NewT]) :- not(is_older(X, Y)), insert(X, T, NewT).

newRoyalSuccession(NewRoyalSuccession):- findall(Y,offspring(_,Y), Offsprings), successors(Offsprings,NewRoyalSuccession).