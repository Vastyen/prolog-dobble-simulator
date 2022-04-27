% Nombre: Bastián Emiliano Escribano Gómez
% Sección: 13204-A-1
% Profesor: Gonzalo Martínez Ramírez

% --------------------------------
% Tipo de Dato Abstracto: cardsSet
% --------------------------------

% Constructor
% Predicado que permite generar una baraja de cartas
% Dominio
% elements: list
% numE: integer
% maxC: integer
% seed: integer
% CS: cards
% cardsSet(Elements, NumE, MaxC, Seed, CS)

cardsSet(Elements, NumE, MaxC, Seed, CS):-
    integer(NumE), NumE > 0,
    integer(MaxC), MaxC > 0,
    integer(Seed), Seed > 0, Seed < MaxC,
    cardsSet = [Elements, NumE, MaxC, Seed, CS].


% 2. Largo de una lista
% 2.1 La consulta también sirve para verificar si una lista es vacía.
%	len(Lista, Largo) es verdadero si Largo es el número de elementos de una lista.

len( [], 0 ).
len( [_|Resto], Largo ) :-
	len( Resto, LargoAcumulado ),
	Largo is LargoAcumulado + 1.

%% Consultas:
% ?- len([1,2,3], Largo).
% Largo=3.
% ?- len([], Largo).
% L=0.

% --------------------------------
% Tipo de Dato Abstracto: dobbleGame
% --------------------------------

% Constructor
% Predicado que permite generar una baraja de cartas
% Dominio


