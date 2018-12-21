% Code for creating a set out of a list
create_set(X, Y) :-
  uniquefier(X, [], Y).

uniquefier([], Set, Set).

uniquefier([H|T], Set, Y) :-
  member(H, Set),
  uniquefier(T, Set, Y).

uniquefier([H|T], Set, Y) :-
  uniquefier(T, [H|Set], Y).

% Code for slicing (removing) a particular element from set
slice(X, Y, Z) :-
  slicer(X, Y, [], Z).

slicer(_, [], Set, Set).

slicer(X, [Y_H|Y_T], Set, Z) :-
  X = Y_H,
  slicer(X, Y_T, Set, Z).

slicer(X, [Y_H|Y_T], Set, Z) :-
  slicer(X, Y_T, [Y_H|Set], Z).

% Code for finding the union of 2 sets
union(X, Y, Z) :-
  union_looper(X, Y, [], Z).

union_looper([], [], Set, Set).

union_looper(X, [], Set, Z) :-
  append(X, Set, NSet),
  union_looper([], [], NSet, Z).

union_looper([], Y, Set, Z) :-
  append(Y, Set, NSet),
  union_looper([], [], NSet, Z).

union_looper([X_H|X_T], Y, Set, Z) :-
  member(X_H, Y),
  slice(X_H, Y, Y_N),
  union_looper(X_T, Y_N, [X_H|Set], Z).

union_looper([X_H|X_T], Y, Set, Z) :-
  union_looper(X_T, Y,[X_H|Set], Z).

% Code for calculating the intersection of 2 sets
intersection(X, Y, Z) :-
  intsect_looper(X, Y, [], Z).

intsect_looper([], [], Set, Set).

intsect_looper(_, [], Set, Z) :-
  intsect_looper([], [], Set, Z).

intsect_looper([], _, Set, Z) :-
  intsect_looper([], [], Set, Z).

intsect_looper([X_H|X_T], Y, Set, Z) :-
  member(X_H, Y),
  slice(X_H, Y, Y_N),
  intsect_looper(X_T, Y_N, [X_H|Set], Z).

intsect_looper([_|X_T], Y, Set, Z) :-
  intsect_looper(X_T, Y, Set, Z).

% Code for calculating the difference of 2 sets
difference(X, Y, Z) :-
  diff_looper(X, Y, [], Z).

diff_looper([], [], Set, Set).

diff_looper(X, [], Set, Z) :-
  append(X, Set, NSet),
  diff_looper([], [], NSet, Z).

diff_looper([], _, Set, Z) :-
  diff_looper([], [], Set, Z).

diff_looper([X_H|X_T], Y, Set, Z) :-
  member(X_H, Y),
  slice(X_H, Y, Y_N),
  diff_looper(X_T, Y_N, Set, Z).

diff_looper([X_H|X_T], Y, Set, Z) :-
  diff_looper(X_T, Y, [X_H|Set], Z).

% Code for calculating the Cartesian product of 2 sets
product(A, B, Z) :-
  B_o = B,
  cart_prod(A, B, B_o, [], Z).

cart_prod([], [], _, Set, Set).

cart_prod([], B_o, B_o, Set, Z) :-
  cart_prod([], [], B_o, Set, Z).

cart_prod([_|A_T], [], B_o, Set, Z) :-
  B_c = B_o,
  cart_prod(A_T, B_c, B_o, Set, Z).

cart_prod([A_H|A_T], [B_H|B_T], B_o, Set, Z) :-
  cart_prod([A_H|A_T], B_T, B_o, [[A_H, B_H]| Set], Z).
