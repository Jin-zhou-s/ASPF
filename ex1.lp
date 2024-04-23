% The input is known to be bid(men, req, exp)
% Let there be a total of 8 requests to be assessed by 3 members who will specialise in the requests as follows

% member1
bid(member1, request1, expert).
bid(member1, request2, expert).
bid(member1, request3, knowledgeable).
bid(member1, request4, knowledgeable).
bid(member1, request5, familiar).
bid(member1, request6, familiar).
bid(member1, request7, familiar).
bid(member1, request8, inexpert).

% member2
bid(member2, request1, familiar).
bid(member2, request2, inexpert).
bid(member2, request3, expert).
bid(member2, request4, expert).
bid(member2, request5, knowledgeable).
bid(member2, request6, knowledgeable).
bid(member2, request7, familiar).
bid(member2, request8, familiar).

% member3
bid(member3, request1, familiar).
bid(member3, request2, familiar).
bid(member3, request3, familiar).
bid(member3, request4, inexpert).
bid(member3, request5, expert).
bid(member3, request6, expert).
bid(member3, request7, knowledgeable).
bid(member3, request8, knowledgeable).

% Define the parameters m, n, k
% Difference in workload per member not greater than m
% Each application will be approved by n members
% k is the maximum number of familiar requests to be reviewed by each member.
#const m = 1.
#const n = 2.
#const k = 2.

% Exclusion of inexpert requests
assignable(Mem, Req, Exp) :- bid(Mem, Req, Exp), Exp != inexpert.

% Getting members and requests
member(Mem) :- assignable(Mem, _, _).
request(Req) :- assignable(_, Req, _).

% Select exactly n members to review the request
% Ensure that each request is reviewed by exactly n members
% Two common compositions: each filed patent application is assigned to a specific number of n members of the technical committee
{ assigned(Mem, Req, Exp) : assignable(Mem, Req, Exp) } n :- request(Req).
:- request(Req), not #count{ Mem : assigned(Mem, Req, Exp) } = n.

% Calculate the number of requests per member familiar class
% Ensure that each member reviews no more than k requests at the "familiar" level
:- member(Mem), #count{ Req : assigned(Mem, Req, familiar)} > k.

% Calculate the total number of requests per member
% Ensure that the difference in the total number of requests processed between any two members does not exceed m
request_count(Mem, Count) :- member(Mem), Count = #count{ Req : assigned(Mem, Req, _) }.
:- request_count(Mem1, Count1), request_count(Mem2, Count2), Count1 - Count2 > m.
:- request_count(Mem1, Count1), request_count(Mem2, Count2), Count2 - Count1 > m.

% Assigning points to each degree of specialisation
% Since inexpert was eliminated earlier, it is not given here.
score(Mem, Req, 3) :- assigned(Mem, Req, expert).
score(Mem, Req, 2) :- assigned(Mem, Req, knowledgeable).
score(Mem, Req, 1) :- assigned(Mem, Req, familiar).

% Maximise scores so that requests are allocated to as many experts as possible
#maximize{ Score, Req, Mem: score(Mem, Req, Score) }.

% Determination of allocation
assign(Mem, Req) :- score(Mem, Req, _).

% Demonstrate the output of assign/2.
% The output is known to be assign(men, req)
#show assign/2.

% student name: Jin Zhou
% student number: 23016750
