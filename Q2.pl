% Code for creating BST
% Code for creating Node
create_node(Cn, Y_H) :-
  Cn = node(nil, Y_H, nil).

% Code for inserting one particular node
insert(node(A, B, C), Y_H, X) :-
  B @=< Y_H,
  C = nil,
  create_node(Cn, Y_H),
  X = node(A, B, Cn).

insert(node(A, B, C), Y_H, X) :-
  B @> Y_H,
  A = nil,
  create_node(An, Y_H),
  X = node(An, B, C).

insert(node(A, B, C), Y_H, X) :-
  B @=< Y_H,
  C \= nil,
  insert(C, Y_H, R),
  X = node(A, B, R).

insert(node(A, B, C), Y_H, X) :-
  B @> Y_H,
  A \= nil,
  insert(A, Y_H, R),
  X = node(R, B, C).

insert_all(X, [Y_H], Res) :-
  insert(X, Y_H, X1),
  Res = X1.

% Code for inserting all nodes sequentially
insert_all(X, [Y_H|Y_T], Res) :-
  insert(X, Y_H, X1),
  insert_all(X1, Y_T, Res).

% Code for creating BST
create_BST(X, [Y_H|Y_T]) :-
  X_temp = node(nil, Y_H, nil),
  insert_all(X_temp, Y_T, Res),
  X = Res.

% Code for pre-order traversal
pre_order(nil, []).
pre_order(node(A, B, C), X):-
  pre_order(A, An),
  pre_order(C, Cn),
  append([B|An], Cn, X).

% Code for in-order traversal
in_order(nil, []).
in_order(node(A, B, C), X):-
  in_order(A, An),
  in_order(C, Cn),
  append(An, [B|Cn], X).

% Code for post-order traversal
post_order(nil, []).
post_order(node(A, B, C), X):-
  post_order(A, An),
  post_order(C, Cn),
  % append(An, [Cn|B], X).
  append(Cn, [B], Y), append(An, Y, X).

% Code for counting nodes
count(nil, 0).
count(node(A, _, C), X):-
  count(A, An),
  count(C, Cn),
  X is +(+(An, Cn), 1).

% Code for calculating height of tree
height(nil, 0).
height(node(A, _, C), X):-
  height(A, An),
  height(C, Cn),
  An > Cn,
  X is +(An, 1).

height(nil, 0).
height(node(A, _, C), X):-
  height(A, An),
  height(C, Cn),
  An =< Cn,
  X is +(Cn, 1).

% Code for finding node in tree
find(node(_, B, _), B).
find(node(_, B, C), Y) :-
  B @=< Y,
  find(C, Y).
find(node(A, B, _), Y) :-
  B @> Y,
  find(A, Y).
