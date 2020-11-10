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

then(A, B) :- offspring(prince, A), offspring(princess, B).
then(A, B) :- offspring(prince, A), offspring(prince, B), is_older(A, B).
then(A, B) :- offspring(princess, A), offspring(princess, B), is_older(A, B).

successors(X, Y) :- insert_sort(X, Y).

insert_sort(X, Y) :- i_sort(X, [], Y).
i_sort([], Acc, Acc).
i_sort([H|T], Acc, Y) :- insert(H, Acc, NewAcc), i_sort(T, NewAcc, Y).

insert(X, [], [X]).
insert(X, [Y|T], [X, Y|T]) :- then(X, Y).
insert(X, [Y|T], [Y|NewT]) :- not(then(X, Y)), insert(X, T, NewT).

oldRoyalSuccession(OldRoyalSuccession):- findall(Y,offspring(_,Y), Offsprings), successors(Offsprings,OldRoyalSuccession).