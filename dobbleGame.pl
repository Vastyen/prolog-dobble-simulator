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


% --------------------------------
% Tipo de Dato Abstracto: dobbleGame
% --------------------------------

% Constructor
% Predicado que permite generar una baraja de cartas
% Dominio
