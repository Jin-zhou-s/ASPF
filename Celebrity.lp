 %Problem: Given a list of people at a party, for each person the list of
% people they know at the party,  we want to find the celebrities at the party.
% A celebrity is a person that everybody at the party knows but that
% only knows other celebrities. At least one celebrity is present at the party.

%
%
% Example:
%   Adam  knows {Dan,Alice,Peter,Eva},
%   Dan   knows {Adam,Alice,Peter},
%   Eva   knows {Alice,Peter},
%   Alice knows {Peter},
%   Peter knows {Alice}
%
% Solution: the celebrities are Peter and Alice.
%
%
%
% knows(adam,  dan;alice;peter;eva).
% knows(dan,   adam;alice;peter).
% knows(eva,   alice;peter).
% knows(alice, peter).
% knows(peter, alice).

% extended problem instance:
% here hakan, anna, and agatha are the celebrities.
%
knows(adam,  dan;adam,alice;adam,peter;adam,eva;adam,hakan;adam,anna;adam,agatha).
knows(dan,   adam;dan,alice;dan,peter;dan,hakan;dan,anna;dan,agatha).
knows(eva,   alice;eva,peter;eva,adam;eva,hakan;eva,anna;eva,agatha).
knows(alice, peter;alice,adam;alice,hakan;alice,anna;alice,agatha).
knows(peter, alice;peter,adam;peter,hakan;peter,anna;peter,agatha).
knows(hakan, anna;hakan,agatha).
knows(anna,  hakan;anna,agatha).
knows(agatha,  hakan;agatha,anna).

% extract some info
person(X) :- knows(X, _).
person(X) :- knows(_, X).
num_p(N) :- N = #count{P: person(P)} .


% 1) a person is a celebrity if everyone
% knows P
celebrity(C) :-
    person(C),num_p(N),N-1 { knows(P, C) : person(P) } N-1.
 
 %celebrity(C) :-
    %person(C),n-1{ knows(P, C) : person(P) }n-1.
    
    

% 2) and the celebrities only know other
% celebrities, i.e.
% C is not a celebrity if he/she
% knows anyone that is not a celebrity)
    
:- celebrity(C), person(C), not celebrity(P), knows(C, P).


 #show celebrity/1.
