%% First Rule Base
%% Throne is pass down to males in order;
%% if no males, pass down to females in order.

%% Facts
monarch(elizabeth).
prince(charles).
prince(andrew).
prince(edward).
princess(ann).
older(charles,ann).
older(ann,andrew).
older(andrew,edward).

%% Rules
elder(X,Y) :- older(X,Y);
				(older(X,_),older(_,Y)).
old_rank(X,Y) :- (prince(X),princess(Y));
						(prince(X),prince(Y),elder(X,Y));
						(princess(X),princess(Y),elder(X,Y)).

%% quick sort
pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G) :- \+old_rank(X,H), pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]) :- old_rank(X,H), pivoting(H,T,L,G).

quick_sort(List,Sorted) :- q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted) :-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

old_succession(Candidates,Sorted_Candidates) :- quick_sort(Candidates,Sorted_Candidates).
%% [trace]  ?- old_succession([andrew,charles,edward,ann],Succession).
%%    Call: (8) old_succession([andrew, charles, edward, ann], _3324) ? creep
%%    Call: (9) quick_sort([andrew, charles, edward, ann], _3324) ? creep
%%    Call: (10) q_sort([andrew, charles, edward, ann], [], _3324) ? creep
%%    Call: (11) pivoting(andrew, [charles, edward, ann], _3578, _3580) ? creep
%%    Call: (12) old_rank(charles, andrew) ? creep
%%    Call: (13) prince(charles) ? creep
%%    Exit: (13) prince(charles) ? creep
%%    Call: (13) princess(andrew) ? creep
%%    Fail: (13) princess(andrew) ? creep
%%    Redo: (12) old_rank(charles, andrew) ? creep
%%    Call: (13) prince(charles) ? creep
%%    Exit: (13) prince(charles) ? creep
%%    Call: (13) prince(andrew) ? creep
%%    Exit: (13) prince(andrew) ? creep
%%    Call: (13) elder(charles, andrew) ? creep
%%    Call: (14) older(charles, andrew) ? creep
%%    Fail: (14) older(charles, andrew) ? creep
%%    Redo: (13) elder(charles, andrew) ? creep
%%    Call: (14) older(charles, _3582) ? creep
%%    Exit: (14) older(charles, ann) ? creep
%%    Call: (14) older(_3580, andrew) ? creep
%%    Exit: (14) older(ann, andrew) ? creep
%%    Exit: (13) elder(charles, andrew) ? creep
%%    Exit: (12) old_rank(charles, andrew) ? creep
%%    Call: (12) old_rank(charles, andrew) ? creep
%%    Call: (13) prince(charles) ? creep
%%    Exit: (13) prince(charles) ? creep
%%    Call: (13) princess(andrew) ? creep
%%    Fail: (13) princess(andrew) ? creep
%%    Redo: (12) old_rank(charles, andrew) ? creep
%%    Call: (13) prince(charles) ? creep
%%    Exit: (13) prince(charles) ? creep
%%    Call: (13) prince(andrew) ? creep
%%    Exit: (13) prince(andrew) ? creep
%%    Call: (13) elder(charles, andrew) ? creep
%%    Call: (14) older(charles, andrew) ? creep
%%    Fail: (14) older(charles, andrew) ? creep
%%    Redo: (13) elder(charles, andrew) ? creep
%%    Call: (14) older(charles, _3582) ? creep
%%    Exit: (14) older(charles, ann) ? creep
%%    Call: (14) older(_3580, andrew) ? creep
%%    Exit: (14) older(ann, andrew) ? creep
%%    Exit: (13) elder(charles, andrew) ? creep
%%    Exit: (12) old_rank(charles, andrew) ? creep
%%    Call: (12) pivoting(andrew, [edward, ann], _3584, _3562) ? creep
%%    Call: (13) old_rank(edward, andrew) ? creep
%%    Call: (14) prince(edward) ? creep
%%    Exit: (14) prince(edward) ? creep
%%    Call: (14) princess(andrew) ? creep
%%    Fail: (14) princess(andrew) ? creep
%%    Redo: (13) old_rank(edward, andrew) ? creep
%%    Call: (14) prince(edward) ? creep
%%    Exit: (14) prince(edward) ? creep
%%    Call: (14) prince(andrew) ? creep
%%    Exit: (14) prince(andrew) ? creep
%%    Call: (14) elder(edward, andrew) ? creep
%%    Call: (15) older(edward, andrew) ? creep
%%    Fail: (15) older(edward, andrew) ? creep
%%    Redo: (14) elder(edward, andrew) ? creep
%%    Call: (15) older(edward, _3588) ? creep
%%    Fail: (15) older(edward, _3588) ? creep
%%    Fail: (14) elder(edward, andrew) ? creep
%%    Redo: (13) old_rank(edward, andrew) ? creep
%%    Call: (14) princess(edward) ? creep
%%    Fail: (14) princess(edward) ? creep
%%    Fail: (13) old_rank(edward, andrew) ? creep
%%    Redo: (12) pivoting(andrew, [edward, ann], [edward|_3568], _3562) ? creep
%%    Call: (13) pivoting(andrew, [ann], _3568, _3562) ? creep
%%    Call: (14) old_rank(ann, andrew) ? creep
%%    Call: (15) prince(ann) ? creep
%%    Fail: (15) prince(ann) ? creep
%%    Redo: (14) old_rank(ann, andrew) ? creep
%%    Call: (15) prince(ann) ? creep
%%    Fail: (15) prince(ann) ? creep
%%    Redo: (14) old_rank(ann, andrew) ? creep
%%    Call: (15) princess(ann) ? creep
%%    Exit: (15) princess(ann) ? creep
%%    Call: (15) princess(andrew) ? creep
%%    Fail: (15) princess(andrew) ? creep
%%    Fail: (14) old_rank(ann, andrew) ? creep
%%    Redo: (13) pivoting(andrew, [ann], [ann|_3574], _3562) ? creep
%%    Call: (14) pivoting(andrew, [], _3574, _3562) ? creep
%%    Exit: (14) pivoting(andrew, [], [], []) ? creep
%%    Exit: (13) pivoting(andrew, [ann], [ann], []) ? creep
%%    Exit: (12) pivoting(andrew, [edward, ann], [edward, ann], []) ? creep
%%    Exit: (11) pivoting(andrew, [charles, edward, ann], [edward, ann], [charles]) ? creep
%%    Call: (11) q_sort([edward, ann], [], _3596) ? creep
%%    Call: (12) pivoting(edward, [ann], _3596, _3598) ? creep
%%    Call: (13) old_rank(ann, edward) ? creep
%%    Call: (14) prince(ann) ? creep
%%    Fail: (14) prince(ann) ? creep
%%    Redo: (13) old_rank(ann, edward) ? creep
%%    Call: (14) prince(ann) ? creep
%%    Fail: (14) prince(ann) ? creep
%%    Redo: (13) old_rank(ann, edward) ? creep
%%    Call: (14) princess(ann) ? creep
%%    Exit: (14) princess(ann) ? creep
%%    Call: (14) princess(edward) ? creep
%%    Fail: (14) princess(edward) ? creep
%%    Fail: (13) old_rank(ann, edward) ? creep
%%    Redo: (12) pivoting(edward, [ann], [ann|_3580], _3604) ? creep
%%    Call: (13) pivoting(edward, [], _3580, _3604) ? creep
%%    Exit: (13) pivoting(edward, [], [], []) ? creep
%%    Exit: (12) pivoting(edward, [ann], [ann], []) ? creep
%%    Call: (12) q_sort([ann], [], _3602) ? creep
%%    Call: (13) pivoting(ann, [], _3602, _3604) ? creep
%%    Exit: (13) pivoting(ann, [], [], []) ? creep
%%    Call: (13) q_sort([], [], _3602) ? creep
%%    Exit: (13) q_sort([], [], []) ? creep
%%    Call: (13) q_sort([], [ann], _3608) ? creep
%%    Exit: (13) q_sort([], [ann], [ann]) ? creep
%%    Exit: (12) q_sort([ann], [], [ann]) ? creep
%%    Call: (12) q_sort([], [edward, ann], _3614) ? creep
%%    Exit: (12) q_sort([], [edward, ann], [edward, ann]) ? creep
%%    Exit: (11) q_sort([edward, ann], [], [edward, ann]) ? creep
%%    Call: (11) q_sort([charles], [andrew, edward, ann], _3324) ? creep
%%    Call: (12) pivoting(charles, [], _3620, _3622) ? creep
%%    Exit: (12) pivoting(charles, [], [], []) ? creep
%%    Call: (12) q_sort([], [andrew, edward, ann], _3620) ? creep
%%    Exit: (12) q_sort([], [andrew, edward, ann], [andrew, edward, ann]) ? creep
%%    Call: (12) q_sort([], [charles, andrew, edward, ann], _3324) ? creep
%%    Exit: (12) q_sort([], [charles, andrew, edward, ann], [charles, andrew, edward, ann]) ? creep
%%    Exit: (11) q_sort([charles], [andrew, edward, ann], [charles, andrew, edward, ann]) ? creep
%%    Exit: (10) q_sort([andrew, charles, edward, ann], [], [charles, andrew, edward, ann]) ? creep
%%    Exit: (9) quick_sort([andrew, charles, edward, ann], [charles, andrew, edward, ann]) ? creep
%%    Exit: (8) old_succession([andrew, charles, edward, ann], [charles, andrew, edward, ann]) ? creep
%% Succession = [charles, andrew, edward, ann] .

%%2
%% new quick sort
new_pivoting(H,[],[],[]).
new_pivoting(H,[X|T],[X|L],G) :- \+elder(X,H), new_pivoting(H,T,L,G).
new_pivoting(H,[X|T],L,[X|G]) :- elder(X,H), new_pivoting(H,T,L,G).

new_quick_sort(List,Sorted) :- new_q_sort(List,[],Sorted).
new_q_sort([],Acc,Acc).
new_q_sort([H|T],Acc,Sorted) :-
	new_pivoting(H,T,L1,L2),
	new_q_sort(L1,Acc,Sorted1),new_q_sort(L2,[H|Sorted1],Sorted).

new_succession(Candidates,Sorted_Candidates) :- new_quick_sort(Candidates,Sorted_Candidates).
%% [trace]  ?- new_succession([andrew,charles,edward,ann],Succession).
%%    Call: (8) new_succession([andrew, charles, edward, ann], _3384) ? creep
%%    Call: (9) new_quick_sort([andrew, charles, edward, ann], _3384) ? creep
%%    Call: (10) new_q_sort([andrew, charles, edward, ann], [], _3384) ? creep
%%    Call: (11) new_pivoting(andrew, [charles, edward, ann], _3650, _3652) ? creep
%%    Call: (12) elder(charles, andrew) ? creep
%%    Call: (13) older(charles, andrew) ? creep
%%    Fail: (13) older(charles, andrew) ? creep
%%    Redo: (12) elder(charles, andrew) ? creep
%%    Call: (13) older(charles, _3654) ? creep
%%    Exit: (13) older(charles, ann) ? creep
%%    Call: (13) older(_3652, andrew) ? creep
%%    Exit: (13) older(ann, andrew) ? creep
%%    Exit: (12) elder(charles, andrew) ? creep
%%    Call: (12) elder(charles, andrew) ? creep
%%    Call: (13) older(charles, andrew) ? creep
%%    Fail: (13) older(charles, andrew) ? creep
%%    Redo: (12) elder(charles, andrew) ? creep
%%    Call: (13) older(charles, _3654) ? creep
%%    Exit: (13) older(charles, ann) ? creep
%%    Call: (13) older(_3652, andrew) ? creep
%%    Exit: (13) older(ann, andrew) ? creep
%%    Exit: (12) elder(charles, andrew) ? creep
%%    Call: (12) new_pivoting(andrew, [edward, ann], _3656, _3634) ? creep
%%    Call: (13) elder(edward, andrew) ? creep
%%    Call: (14) older(edward, andrew) ? creep
%%    Fail: (14) older(edward, andrew) ? creep
%%    Redo: (13) elder(edward, andrew) ? creep
%%    Call: (14) older(edward, _3660) ? creep
%%    Fail: (14) older(edward, _3660) ? creep
%%    Fail: (13) elder(edward, andrew) ? creep
%%    Redo: (12) new_pivoting(andrew, [edward, ann], [edward|_3640], _3634) ? creep
%%    Call: (13) new_pivoting(andrew, [ann], _3640, _3634) ? creep
%%    Call: (14) elder(ann, andrew) ? creep
%%    Call: (15) older(ann, andrew) ? creep
%%    Exit: (15) older(ann, andrew) ? creep
%%    Exit: (14) elder(ann, andrew) ? creep
%%    Call: (14) elder(ann, andrew) ? creep
%%    Call: (15) older(ann, andrew) ? creep
%%    Exit: (15) older(ann, andrew) ? creep
%%    Exit: (14) elder(ann, andrew) ? creep
%%    Call: (14) new_pivoting(andrew, [], _3640, _3646) ? creep
%%    Exit: (14) new_pivoting(andrew, [], [], []) ? creep
%%    Exit: (13) new_pivoting(andrew, [ann], [], [ann]) ? creep
%%    Exit: (12) new_pivoting(andrew, [edward, ann], [edward], [ann]) ? creep
%%    Exit: (11) new_pivoting(andrew, [charles, edward, ann], [edward], [charles, ann]) ? creep
%%    Call: (11) new_q_sort([edward], [], _3668) ? creep
%%    Call: (12) new_pivoting(edward, [], _3668, _3670) ? creep
%%    Exit: (12) new_pivoting(edward, [], [], []) ? creep
%%    Call: (12) new_q_sort([], [], _3668) ? creep
%%    Exit: (12) new_q_sort([], [], []) ? creep
%%    Call: (12) new_q_sort([], [edward], _3674) ? creep
%%    Exit: (12) new_q_sort([], [edward], [edward]) ? creep
%%    Exit: (11) new_q_sort([edward], [], [edward]) ? creep
%%    Call: (11) new_q_sort([charles, ann], [andrew, edward], _3384) ? creep
%%    Call: (12) new_pivoting(charles, [ann], _3680, _3682) ? creep
%%    Call: (13) elder(ann, charles) ? creep
%%    Call: (14) older(ann, charles) ? creep
%%    Fail: (14) older(ann, charles) ? creep
%%    Redo: (13) elder(ann, charles) ? creep
%%    Call: (14) older(ann, _3684) ? creep
%%    Exit: (14) older(ann, andrew) ? creep
%%    Call: (14) older(_3682, charles) ? creep
%%    Fail: (14) older(_3682, charles) ? creep
%%    Fail: (13) elder(ann, charles) ? creep
%%    Redo: (12) new_pivoting(charles, [ann], [ann|_3664], _3688) ? creep
%%    Call: (13) new_pivoting(charles, [], _3664, _3688) ? creep
%%    Exit: (13) new_pivoting(charles, [], [], []) ? creep
%%    Exit: (12) new_pivoting(charles, [ann], [ann], []) ? creep
%%    Call: (12) new_q_sort([ann], [andrew, edward], _3686) ? creep
%%    Call: (13) new_pivoting(ann, [], _3686, _3688) ? creep
%%    Exit: (13) new_pivoting(ann, [], [], []) ? creep
%%    Call: (13) new_q_sort([], [andrew, edward], _3686) ? creep
%%    Exit: (13) new_q_sort([], [andrew, edward], [andrew, edward]) ? creep
%%    Call: (13) new_q_sort([], [ann, andrew, edward], _3692) ? creep
%%    Exit: (13) new_q_sort([], [ann, andrew, edward], [ann, andrew, edward]) ? creep
%%    Exit: (12) new_q_sort([ann], [andrew, edward], [ann, andrew, edward]) ? creep
%%    Call: (12) new_q_sort([], [charles, ann, andrew, edward], _3384) ? creep
%%    Exit: (12) new_q_sort([], [charles, ann, andrew, edward], [charles, ann, andrew, edward]) ? creep
%%    Exit: (11) new_q_sort([charles, ann], [andrew, edward], [charles, ann, andrew, edward]) ? creep
%%    Exit: (10) new_q_sort([andrew, charles, edward, ann], [], [charles, ann, andrew, edward]) ? creep
%%    Exit: (9) new_quick_sort([andrew, charles, edward, ann], [charles, ann, andrew, edward]) ? creep
%%    Exit: (8) new_succession([andrew, charles, edward, ann], [charles, ann, andrew, edward]) ? creep
%% Succession = [charles, ann, andrew, edward] .
