        person(abby;bess;cody;dana).

likes(dana, cody).
:- likes(abby, dana).
:- likes(dana, abby).
1{likes(bess, cody); likes(bess,dana)}. 
likes(abby, X) :- likes(bess, X).
likes(cody, X) :- likes(X, cody).
:- likes(X, X).
1{likes(X,Y): person(Y)}4 :- person(X).
#show likes/2.
