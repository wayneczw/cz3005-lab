%% my facts
male(yeye). %% grandfather
male(xiaochun). %% father
male(zhiwei). %% myself
male(linfeng). %% cousin
mael(zhihong).
male(william). %% husband of qiuhua(aunt), hence my uncle
female(biqun). %% mother
female(qiuhua). %% aunt, sister of my father
female(qinhua). %% aunt, sister of my father
brother(xiaochun,qiuhua).
brother(xiaochun,qinhua).
sister(qiuhua,qinhua).
sister(qiuhua,xiaochun).
sister(qinhua,qiuhua).
sister(qinhua,qiuhua).
parent_of(yeye,xiaochun).
parent_of(yeye,qiuhua).
parent_of(yeye,qinhua).
parent_of(xiaochun,zhiwei).
parent_of(biqun,zhiwei).
parent_of(qinhua,linfeng).
parent_of(qiuhua,zhihong).
parent_of(william,zhihong).


%% question's facts
%% male(jerry).
%% male(stuart).
%% male(warren).
%% male(peter).
%% female(kather).
%% female(maryalice).
%% female(ann).
%% brother(jerry,stuart).
%% brother(jerry,kather).
%% brother(peter,warren).
%% sister(ann,maryalice).
%% sister(kather,jerry).
%% parent_of(warren,jerry).
%% parent_of(maryalice,jerry).

%% %% Reorder: 10, 9, 8, 2, 4, 3, 1, 5, 7, 6, 12, 11, 14, 13
%% brother(peter,warren).
%% brother(jerry,kather).
%% brother(jerry,stuart).
%% male(stuart).
%% male(peter).
%% male(warren).
%% male(jerry).
%% female(kather).
%% female(ann).
%% female(maryalice).
%% sister(kather,jerry).
%% sister(ann,maryalice).
%% parent_of(maryalice,jerry).
%% parent_of(warren,jerry).

%% my definitions
father(F,C) :- male(F), parent_of(F,C).
mother(M,C) :- female(M), parent_of(M,C).
son(P,S) :- male(S), parent_of(P,S).
daughter(P,D) :- female(D), parent_of(P,D).
grandfather(Gf,Gc) :- father(Gf,P), parent_of(P,Gc).
sibling(S1,S2) :- parent_of(P,S1), parent_of(P,S2), S1 \= S2.
spouse(H,W) :- male(H), female(W), parent_of(H,C), parent_of(W,C).
aunt(A,C) :- (female(A), sibling(A,P), parent_of(P,C));
					(female(A), spouse(B,A), sibling(B,P), parent_of(P,C)).
uncle(U, C) :- (male(U), sibling(U,P), parent_of(P,C));
						(male(U), spouse(U,S), sibling(S,P), parent_of(P,C)).
cousin(C1,C2) :- sibling(P1,P2), parent_of(P1,C1), parent_of(P2,C2).


%% 1. spouse(X,Y).
%% X = xiaochun,
%% Y = biqun ;
%% X = william,
%% Y = qiuhua ;
%% [trace]  ?- spouse(X,Y).
%%    Call: (8) spouse(_3974, _3976) ? creep
%%    Call: (9) male(_3974) ? creep
%%    Exit: (9) male(yeye) ? creep
%%    Call: (9) female(_3976) ? creep
%%    Exit: (9) female(biqun) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(biqun, xiaochun) ? creep
%%    Fail: (9) parent_of(biqun, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(biqun, qiuhua) ? creep
%%    Fail: (9) parent_of(biqun, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(biqun, qinhua) ? creep
%%    Fail: (9) parent_of(biqun, qinhua) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qiuhua) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(qiuhua, xiaochun) ? creep
%%    Fail: (9) parent_of(qiuhua, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(qiuhua, qiuhua) ? creep
%%    Fail: (9) parent_of(qiuhua, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(qiuhua, qinhua) ? creep
%%    Fail: (9) parent_of(qiuhua, qinhua) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qinhua) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(qinhua, xiaochun) ? creep
%%    Fail: (9) parent_of(qinhua, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(qinhua, qiuhua) ? creep
%%    Fail: (9) parent_of(qinhua, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(qinhua, qinhua) ? creep
%%    Fail: (9) parent_of(qinhua, qinhua) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(kather) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(kather, xiaochun) ? creep
%%    Fail: (9) parent_of(kather, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(kather, qiuhua) ? creep
%%    Fail: (9) parent_of(kather, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(kather, qinhua) ? creep
%%    Fail: (9) parent_of(kather, qinhua) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(maryalice) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(maryalice, xiaochun) ? creep
%%    Fail: (9) parent_of(maryalice, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(maryalice, qiuhua) ? creep
%%    Fail: (9) parent_of(maryalice, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(maryalice, qinhua) ? creep
%%    Fail: (9) parent_of(maryalice, qinhua) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(ann) ? creep
%%    Call: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, xiaochun) ? creep
%%    Call: (9) parent_of(ann, xiaochun) ? creep
%%    Fail: (9) parent_of(ann, xiaochun) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qiuhua) ? creep
%%    Call: (9) parent_of(ann, qiuhua) ? creep
%%    Fail: (9) parent_of(ann, qiuhua) ? creep
%%    Redo: (9) parent_of(yeye, _4230) ? creep
%%    Exit: (9) parent_of(yeye, qinhua) ? creep
%%    Call: (9) parent_of(ann, qinhua) ? creep
%%    Fail: (9) parent_of(ann, qinhua) ? creep
%%    Redo: (9) male(_3974) ? creep
%%    Exit: (9) male(xiaochun) ? creep
%%    Call: (9) female(_3976) ? creep
%%    Exit: (9) female(biqun) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(biqun, zhiwei) ? creep
%%    Exit: (9) parent_of(biqun, zhiwei) ? creep
%%    Exit: (8) spouse(xiaochun, biqun) ? creep
%% X = xiaochun,
%% Y = biqun ;
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qiuhua) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(qiuhua, zhiwei) ? creep
%%    Fail: (9) parent_of(qiuhua, zhiwei) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qinhua) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(qinhua, zhiwei) ? creep
%%    Fail: (9) parent_of(qinhua, zhiwei) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(kather) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(kather, zhiwei) ? creep
%%    Fail: (9) parent_of(kather, zhiwei) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(maryalice) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(maryalice, zhiwei) ? creep
%%    Fail: (9) parent_of(maryalice, zhiwei) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(ann) ? creep
%%    Call: (9) parent_of(xiaochun, _4230) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (9) parent_of(ann, zhiwei) ? creep
%%    Fail: (9) parent_of(ann, zhiwei) ? creep
%%    Redo: (9) male(_3974) ? creep
%%    Exit: (9) male(zhiwei) ? creep
%%    Call: (9) female(_3976) ? creep
%%    Exit: (9) female(biqun) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qiuhua) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qinhua) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(kather) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(maryalice) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(ann) ? creep
%%    Call: (9) parent_of(zhiwei, _4230) ? creep
%%    Fail: (9) parent_of(zhiwei, _4230) ? creep
%%    Redo: (9) male(_3974) ? creep
%%    Exit: (9) male(linfeng) ? creep
%%    Call: (9) female(_3976) ? creep
%%    Exit: (9) female(biqun) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qiuhua) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qinhua) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(kather) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(maryalice) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(ann) ? creep
%%    Call: (9) parent_of(linfeng, _4230) ? creep
%%    Fail: (9) parent_of(linfeng, _4230) ? creep
%%    Redo: (9) male(_3974) ? creep
%%    Exit: (9) male(william) ? creep
%%    Call: (9) female(_3976) ? creep
%%    Exit: (9) female(biqun) ? creep
%%    Call: (9) parent_of(william, _4230) ? creep
%%    Exit: (9) parent_of(william, zhihong) ? creep
%%    Call: (9) parent_of(biqun, zhihong) ? creep
%%    Fail: (9) parent_of(biqun, zhihong) ? creep
%%    Redo: (9) female(_3976) ? creep
%%    Exit: (9) female(qiuhua) ? creep
%%    Call: (9) parent_of(william, _4230) ? creep
%%    Exit: (9) parent_of(william, zhihong) ? creep
%%    Call: (9) parent_of(qiuhua, zhihong) ? creep
%%    Exit: (9) parent_of(qiuhua, zhihong) ? creep
%%    Exit: (8) spouse(william, qiuhua) ? creep
%% X = william,
%% Y = qiuhua .

%% 1. uncle(X,zhiwei).
%% [trace]  ?- uncle(X,zhiwei).
%%    Call: (8) uncle(_4002, zhiwei) ? creep
%%    Call: (9) male(_4002) ? creep
%%    Exit: (9) male(yeye) ? creep
%%    Call: (9) sibling(yeye, _4224) ? creep
%%    Call: (10) parent_of(_4222, yeye) ? creep
%%    Fail: (10) parent_of(_4222, yeye) ? creep
%%    Fail: (9) sibling(yeye, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(xiaochun) ? creep
%%    Call: (9) sibling(xiaochun, _4224) ? creep
%%    Call: (10) parent_of(_4222, xiaochun) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) xiaochun\=xiaochun ? creep
%%    Fail: (10) xiaochun\=xiaochun ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qiuhua) ? creep
%%    Call: (10) xiaochun\=qiuhua ? creep
%%    Exit: (10) xiaochun\=qiuhua ? creep
%%    Exit: (9) sibling(xiaochun, qiuhua) ? creep
%%    Call: (9) parent_of(qiuhua, zhiwei) ? creep
%%    Fail: (9) parent_of(qiuhua, zhiwei) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qinhua) ? creep
%%    Call: (10) xiaochun\=qinhua ? creep
%%    Exit: (10) xiaochun\=qinhua ? creep
%%    Exit: (9) sibling(xiaochun, qinhua) ? creep
%%    Call: (9) parent_of(qinhua, zhiwei) ? creep
%%    Fail: (9) parent_of(qinhua, zhiwei) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(zhiwei) ? creep
%%    Call: (9) sibling(zhiwei, _4224) ? creep
%%    Call: (10) parent_of(_4222, zhiwei) ? creep
%%    Exit: (10) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (10) parent_of(xiaochun, _4224) ? creep
%%    Exit: (10) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (10) zhiwei\=zhiwei ? creep
%%    Fail: (10) zhiwei\=zhiwei ? creep
%%    Redo: (10) parent_of(_4222, zhiwei) ? creep
%%    Exit: (10) parent_of(biqun, zhiwei) ? creep
%%    Call: (10) parent_of(biqun, _4224) ? creep
%%    Exit: (10) parent_of(biqun, zhiwei) ? creep
%%    Call: (10) zhiwei\=zhiwei ? creep
%%    Fail: (10) zhiwei\=zhiwei ? creep
%%    Fail: (9) sibling(zhiwei, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(linfeng) ? creep
%%    Call: (9) sibling(linfeng, _4224) ? creep
%%    Call: (10) parent_of(_4222, linfeng) ? creep
%%    Exit: (10) parent_of(qinhua, linfeng) ? creep
%%    Call: (10) parent_of(qinhua, _4224) ? creep
%%    Exit: (10) parent_of(qinhua, linfeng) ? creep
%%    Call: (10) linfeng\=linfeng ? creep
%%    Fail: (10) linfeng\=linfeng ? creep
%%    Fail: (9) sibling(linfeng, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(william) ? creep
%%    Call: (9) sibling(william, _4224) ? creep
%%    Call: (10) parent_of(_4222, william) ? creep
%%    Fail: (10) parent_of(_4222, william) ? creep
%%    Fail: (9) sibling(william, _4224) ? creep
%%    Redo: (8) uncle(_4002, zhiwei) ? creep
%%    Call: (9) male(_4002) ? creep
%%    Exit: (9) male(yeye) ? creep
%%    Call: (9) spouse(yeye, _4224) ? creep
%%    Call: (10) male(yeye) ? creep
%%    Exit: (10) male(yeye) ? creep
%%    Call: (10) female(_4222) ? creep
%%    Exit: (10) female(biqun) ? creep
%%    Call: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) parent_of(biqun, xiaochun) ? creep
%%    Fail: (10) parent_of(biqun, xiaochun) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qiuhua) ? creep
%%    Call: (10) parent_of(biqun, qiuhua) ? creep
%%    Fail: (10) parent_of(biqun, qiuhua) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qinhua) ? creep
%%    Call: (10) parent_of(biqun, qinhua) ? creep
%%    Fail: (10) parent_of(biqun, qinhua) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qiuhua) ? creep
%%    Call: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) parent_of(qiuhua, xiaochun) ? creep
%%    Fail: (10) parent_of(qiuhua, xiaochun) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qiuhua) ? creep
%%    Call: (10) parent_of(qiuhua, qiuhua) ? creep
%%    Fail: (10) parent_of(qiuhua, qiuhua) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qinhua) ? creep
%%    Call: (10) parent_of(qiuhua, qinhua) ? creep
%%    Fail: (10) parent_of(qiuhua, qinhua) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qinhua) ? creep
%%    Call: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) parent_of(qinhua, xiaochun) ? creep
%%    Fail: (10) parent_of(qinhua, xiaochun) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qiuhua) ? creep
%%    Call: (10) parent_of(qinhua, qiuhua) ? creep
%%    Fail: (10) parent_of(qinhua, qiuhua) ? creep
%%    Redo: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, qinhua) ? creep
%%    Call: (10) parent_of(qinhua, qinhua) ? creep
%%    Fail: (10) parent_of(qinhua, qinhua) ? creep
%%    Fail: (9) spouse(yeye, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(xiaochun) ? creep
%%    Call: (9) spouse(xiaochun, _4224) ? creep
%%    Call: (10) male(xiaochun) ? creep
%%    Exit: (10) male(xiaochun) ? creep
%%    Call: (10) female(_4222) ? creep
%%    Exit: (10) female(biqun) ? creep
%%    Call: (10) parent_of(xiaochun, _4224) ? creep
%%    Exit: (10) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (10) parent_of(biqun, zhiwei) ? creep
%%    Exit: (10) parent_of(biqun, zhiwei) ? creep
%%    Exit: (9) spouse(xiaochun, biqun) ? creep
%%    Call: (9) sibling(biqun, _4224) ? creep
%%    Call: (10) parent_of(_4222, biqun) ? creep
%%    Fail: (10) parent_of(_4222, biqun) ? creep
%%    Fail: (9) sibling(biqun, _4224) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qiuhua) ? creep
%%    Call: (10) parent_of(xiaochun, _4224) ? creep
%%    Exit: (10) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (10) parent_of(qiuhua, zhiwei) ? creep
%%    Fail: (10) parent_of(qiuhua, zhiwei) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qinhua) ? creep
%%    Call: (10) parent_of(xiaochun, _4224) ? creep
%%    Exit: (10) parent_of(xiaochun, zhiwei) ? creep
%%    Call: (10) parent_of(qinhua, zhiwei) ? creep
%%    Fail: (10) parent_of(qinhua, zhiwei) ? creep
%%    Fail: (9) spouse(xiaochun, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(zhiwei) ? creep
%%    Call: (9) spouse(zhiwei, _4224) ? creep
%%    Call: (10) male(zhiwei) ? creep
%%    Exit: (10) male(zhiwei) ? creep
%%    Call: (10) female(_4222) ? creep
%%    Exit: (10) female(biqun) ? creep
%%    Call: (10) parent_of(zhiwei, _4224) ? creep
%%    Fail: (10) parent_of(zhiwei, _4224) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qiuhua) ? creep
%%    Call: (10) parent_of(zhiwei, _4224) ? creep
%%    Fail: (10) parent_of(zhiwei, _4224) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qinhua) ? creep
%%    Call: (10) parent_of(zhiwei, _4224) ? creep
%%    Fail: (10) parent_of(zhiwei, _4224) ? creep
%%    Fail: (9) spouse(zhiwei, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(linfeng) ? creep
%%    Call: (9) spouse(linfeng, _4224) ? creep
%%    Call: (10) male(linfeng) ? creep
%%    Exit: (10) male(linfeng) ? creep
%%    Call: (10) female(_4222) ? creep
%%    Exit: (10) female(biqun) ? creep
%%    Call: (10) parent_of(linfeng, _4224) ? creep
%%    Fail: (10) parent_of(linfeng, _4224) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qiuhua) ? creep
%%    Call: (10) parent_of(linfeng, _4224) ? creep
%%    Fail: (10) parent_of(linfeng, _4224) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qinhua) ? creep
%%    Call: (10) parent_of(linfeng, _4224) ? creep
%%    Fail: (10) parent_of(linfeng, _4224) ? creep
%%    Fail: (9) spouse(linfeng, _4224) ? creep
%%    Redo: (9) male(_4002) ? creep
%%    Exit: (9) male(william) ? creep
%%    Call: (9) spouse(william, _4224) ? creep
%%    Call: (10) male(william) ? creep
%%    Exit: (10) male(william) ? creep
%%    Call: (10) female(_4222) ? creep
%%    Exit: (10) female(biqun) ? creep
%%    Call: (10) parent_of(william, _4224) ? creep
%%    Exit: (10) parent_of(william, zhihong) ? creep
%%    Call: (10) parent_of(biqun, zhihong) ? creep
%%    Fail: (10) parent_of(biqun, zhihong) ? creep
%%    Redo: (10) female(_4222) ? creep
%%    Exit: (10) female(qiuhua) ? creep
%%    Call: (10) parent_of(william, _4224) ? creep
%%    Exit: (10) parent_of(william, zhihong) ? creep
%%    Call: (10) parent_of(qiuhua, zhihong) ? creep
%%    Exit: (10) parent_of(qiuhua, zhihong) ? creep
%%    Exit: (9) spouse(william, qiuhua) ? creep
%%    Call: (9) sibling(qiuhua, _4224) ? creep
%%    Call: (10) parent_of(_4222, qiuhua) ? creep
%%    Exit: (10) parent_of(yeye, qiuhua) ? creep
%%    Call: (10) parent_of(yeye, _4224) ? creep
%%    Exit: (10) parent_of(yeye, xiaochun) ? creep
%%    Call: (10) qiuhua\=xiaochun ? creep
%%    Exit: (10) qiuhua\=xiaochun ? creep
%%    Exit: (9) sibling(qiuhua, xiaochun) ? creep
%%    Call: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Exit: (9) parent_of(xiaochun, zhiwei) ? creep
%%    Exit: (8) uncle(william, zhiwei) ? creep
%% X = william .


%% 2.a
%% X = yeye,
%% Y = xiaochun ;
%% X = yeye,
%% Y = qiuhua ;
%% X = yeye,
%% Y = qinhua ;
%% X = xiaochun,
%% Y = zhiwei ;
%% X = biqun,
%% Y = zhiwei ;
%% X = qinhua,
%% Y = linfeng ;
%% X = qiuhua,
%% Y = zhihong ;
%% X = william,
%% Y = zhihong ;
%% X = warren,
%% Y = jerry ;
%% X = maryalice,
%% Y = jerry.
%% [trace]  ?- parent_of(X,Y).
%%    Call: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(yeye, xiaochun) ? creep
%% X = yeye,
%% Y = xiaochun ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(yeye, qiuhua) ? creep
%% X = yeye,
%% Y = qiuhua ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(yeye, qinhua) ? creep
%% X = yeye,
%% Y = qinhua ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(xiaochun, zhiwei) ? creep
%% X = xiaochun,
%% Y = zhiwei ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(biqun, zhiwei) ? creep
%% X = biqun,
%% Y = zhiwei ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(qinhua, linfeng) ? creep
%% X = qinhua,
%% Y = linfeng ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(qiuhua, zhihong) ? creep
%% X = qiuhua,
%% Y = zhihong ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(william, zhihong) ? creep
%% X = william,
%% Y = zhihong ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(warren, jerry) ? creep
%% X = warren,
%% Y = jerry ;
%%    Redo: (8) parent_of(_4368, _4370) ? creep
%%    Exit: (8) parent_of(maryalice, jerry) ? creep
%% X = maryalice,
%% Y = jerry.


%%2.b
%% X = yeye,
%% Y = xiaochun ;
%% X = yeye,
%% Y = qiuhua ;
%% X = yeye,
%% Y = qinhua ;
%% X = xiaochun,
%% Y = zhiwei ;
%% X = biqun,
%% Y = zhiwei ;
%% X = qinhua,
%% Y = linfeng ;
%% X = qiuhua,
%% Y = zhihong ;
%% X = william,
%% Y = zhihong ;
%% X = warren,
%% Y = jerry ;
%% X = maryalice,
%% Y = jerry.
%% [trace]  ?- parent_of(X,Y).
%%    Call: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(yeye, xiaochun) ? creep
%% X = yeye,
%% Y = xiaochun ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(yeye, qiuhua) ? creep
%% X = yeye,
%% Y = qiuhua ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(yeye, qinhua) ? creep
%% X = yeye,
%% Y = qinhua ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(xiaochun, zhiwei) ? creep
%% X = xiaochun,
%% Y = zhiwei ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(biqun, zhiwei) ? creep
%% X = biqun,
%% Y = zhiwei ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(qinhua, linfeng) ? creep
%% X = qinhua,
%% Y = linfeng ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(qiuhua, zhihong) ? creep
%% X = qiuhua,
%% Y = zhihong ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(william, zhihong) ? creep
%% X = william,
%% Y = zhihong ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(maryalice, jerry) ? creep
%% X = maryalice,
%% Y = jerry ;
%%    Redo: (8) parent_of(_3804, _3806) ? creep
%%    Exit: (8) parent_of(warren, jerry) ? creep
%% X = warren,
%% Y = jerry.



