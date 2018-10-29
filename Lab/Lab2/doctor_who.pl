

%% =============================Define Basic Facts===============================
%% Define libraries
pain_library([unbearable, severe, manageable, mild, no]).
mood_library([calm, angry, weepy, stressed, depressed]).
disease_library([fever, cold, skin_allergy, gastrosis, melancholia]).

%% Disease symptoms libraries
fever_pain_library([severe, manageable, mild]).
fever_mood_library([calm, weepy]).
fever_library([high_temperature, sweat, headache, muscle_ache]).

cold_pain_library([manageable, mild, no]).
cold_mood_library([calm, weepy]).
cold_library([sneeze, cough, weepy, runny_nose, sore_throat]).

skin_allergy_pain_library([manageable, mild, no]).
skin_allergy_mood_library([calm, weepy]).
skin_allergy_library([rashes, itchy, swelling]).

gastrosis_pain_library([unbearable, severe, manageable, mild]).
gastrosis_mood_library([weepy, calm]).
gastrosis_library([stomachache, sweat, vomit, nausea]).

melancholia_pain_library([no]).
melancholia_mood_library([stressed, angry, depressed]).
melancholia_library([weightloss]).

fever(P, M) :- fever_pain_library(PL), member(P, PL), fever_mood_library(ML), member(M, ML).
cold(P, M) :-  cold_pain_library(PL), member(P, PL), cold_mood_library(ML), member(M, ML).
skin_allergy(P, M) :-  skin_allergy_pain_library(PL), member(P, PL), skin_allergy_mood_library(ML), member(M, ML).
gastrosis(P, M) :- gastrosis_pain_library(PL), member(P, PL), gastrosis_mood_library(ML), member(M, ML).
melancholia(P, M) :-  melancholia_pain_library(PL), member(P, PL), melancholia_mood_library(ML), member(M, ML).

:- dynamic maybe/1.


%% =============================Define Helper Predicates===============================
user_reply(y). 

%% Identify the index of an element in the list
indexOf([Element|_], Element, 0). % base case index=0 when first element in the list is Element
indexOf([_|Tail], Element, Index) :-   indexOf(Tail, Element, Index_), % investigate tail of the list
                                            Index is Index_+1. % Index_ for each recursion

%% Identify the length of a list
get_length([], 0 ). % base case L=0
get_length([_|Tail],L) :- get_length(Tail,L_) , L is L_+1. % L++ for each recursion

%% given L=list, find K and I,
%% where K is largest element in the list and I is the index of element K
max_list(L, K, I) :- nth0(I, L, K), \+ (member(E, L), E > K).

%% Write content of input list sequentially
write_list([]) :- nl.
write_list([H|T]) :- write(H), write_list(T).

%% Increment count at a particular index
increment_at_position([H|T], 0, [H1|T]) :- H1 is H+1.  % base case where first element++ when at position 0
increment_at_position([H|T], Index, [H|R]) :-   Index > -1,
                                                  Index_ is Index-1, % decrement position index by 1 recursively until it's 0
                                                  increment_at_position(T, Index_, R),
                                                  !.
increment_at_position(L, _, _, L).


%% =============================Define Main Predicates===============================
%% Get index of disease from disease_library
get_disease_index(Disease, Index) :- disease_library(L), indexOf(L, Disease, Index).

%% Wrapper predicate to increment score of a disease
increment_disease_counter(List, Disease, Result) :- get_disease_index(Disease, Index),
                                                        increment_at_position(List, Index, Result).

%% Identify the disease with highest score at index I, and return the disease
%% If K is <= 0, it means the patient is not identified with any disease, and hence, return healthy.
assess_result(List, Disease):-  max_list(List, K, I),  % obtain I=index with highest score, K=value of score
                                    disease_library(DL),
                                    K > 0,
                                    nth0(I, DL, Disease); % ensure that Disease is the Ith element in DL
                                Disease = healthy. % K<=0, no disease

%% Recursively ask symptoms of Disease, and update the score list
ask_symptom(Disease, ScoreList, NewScoreList, []) :- NewScoreList = ScoreList.
ask_symptom(Disease, ScoreList, NewScoreList, [X|L]) :- (write_list(['Suspecting ', Disease, '. Do you think you have the symptom of ', X, '? (y/n)']),
                                                            read(R), user_reply(R),
                                                            increment_disease_counter(ScoreList, Disease, ScoreList_), % successfully incremented the score
                                                            ask_symptom(Disease, ScoreList_, NewScoreList, L)); % ask next symptom with NewScoreList
                                                        ask_symptom(Disease, ScoreList, NewScoreList, L). % user answered no; ask next symptom

%% Initialise a list of scores for each disease
%% disease score is computed according to number of symptoms matched.
initialise_score_list(List)  :-   disease_library(D),
                                        get_length(D, Len), % Obtain Len=Total number of illness in library
                                        length(List, Len), % Create list of length Len
                                        maplist(=(0), List). % initialise List element as all zero

%% ask for patient's pain level
ask_pain(P) :-  pain_library(L), member(P, L), % randomly select a pain level
                    write_list(['Are you experiencing ', P, ' pain? (y/n)']),  % ask question
                    read(R), user_reply(R);  % process user input
                ask_pain(P). % ask pain level recursively if user did not reply y.


%% ask for patient's mood
ask_mood(M) :-  mood_library(L), member(M, L), % randomly select a mood
                    write_list(['Are you feeling ', M, '? (y/n)']), % ask question
                    read(R), user_reply(R); % process user input
                ask_mood(M). % ask mood recursively if user did not reply y.

%% Initial diagnosis with pain and mood info only
initial_diagnosis(_) :- ask_pain(P), ask_mood(M),
                            (fever(P, M) -> assert(maybe(fever))
                                ; true),
                            (cold(P, M) -> assert(maybe(cold)); true),
                            (skin_allergy(P, M) -> assert(maybe(skin_allergy))
                                ; true),
                            (gastrosis(P, M) -> assert(maybe(gastrosis))
                                ; true),
                            (melancholia(P, M) -> assert(maybe(melancholia))
                                ; true).

%% Further diagnosis by getting more info about the patient's symptoms
further_diagnosis(ScoreList, NewScoreList) :- 
        (maybe(fever) -> (fever_library(FL), ask_symptom(fever, ScoreList, NewScoreList_, FL), retract(maybe(fever)))
            ; maybe(cold) -> (cold_library(CL), ask_symptom(cold, ScoreList, NewScoreList_, CL), retract(maybe(cold)))
            ; maybe(skin_allergy) -> (skin_allergy_library(SL), ask_symptom(skin_allergy, ScoreList, NewScoreList_, SL), retract(maybe(skin_allergy)))
            ; maybe(gastrosis) -> (gastrosis_library(GL), ask_symptom(gastrosis, ScoreList, NewScoreList_, GL), retract(maybe(gastrosis)))
            ; maybe(melancholia) -> (melancholia_library(ML), ask_symptom(melancholia, ScoreList, NewScoreList_, ML), retract(maybe(melancholia)))
            ; fail),
        further_diagnosis(NewScoreList_, NewScoreList);
        NewScoreList = ScoreList. % finished retracting all maybe(X)

%% Wrapper predicate that will call the above predicates to gather info from the patient
main(Result) :- initial_diagnosis(_),
                initialise_score_list(ScoreList),
                further_diagnosis(ScoreList, NewScoreList),
                assess_result(NewScoreList, Result),
                write_list(['Here is your diagnosis: ', Result, '.']).

