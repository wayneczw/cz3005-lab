%% Facts
competitor(sumsum,appy).
developed(sumsum,galacticas3).
smartphonetech(galacticas3).
steal(stevey,galacticas3).
boss(appy,stevey).
business(X) :- smartphonetech(X).
rival(X,Y) :- competitor(X,Y); competitor(Y,X).


%% Definitions
unethical(W) :- boss(X,W), steal(W,Y), rival(X,Z), developed(Z,Y), business(Y).

%% [trace]  ?- unethical(X).
%%    Call: (8) unethical(_13078) ? creep
%%    Call: (9) boss(_13292, _13078) ? creep
%%    Exit: (9) boss(appy, stevey) ? creep
%%    Call: (9) steal(stevey, _13294) ? creep
%%    Exit: (9) steal(stevey, galacticas3) ? creep
%%    Call: (9) rival(appy, _13294) ? creep
%%    Call: (10) competitor(appy, _13294) ? creep
%%    Fail: (10) competitor(appy, _13294) ? creep
%%    Redo: (9) rival(appy, _13294) ? creep
%%    Call: (10) competitor(_13292, appy) ? creep
%%    Exit: (10) competitor(sumsum, appy) ? creep
%%    Exit: (9) rival(appy, sumsum) ? creep
%%    Call: (9) developed(sumsum, galacticas3) ? creep
%%    Exit: (9) developed(sumsum, galacticas3) ? creep
%%    Call: (9) business(galacticas3) ? creep
%%    Call: (10) smartphonetech(galacticas3) ? creep
%%    Exit: (10) smartphonetech(galacticas3) ? creep
%%    Exit: (9) business(galacticas3) ? creep
%%    Exit: (8) unethical(stevey) ? creep
%% X = stevey.

