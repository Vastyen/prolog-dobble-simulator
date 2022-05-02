% Nombre: Bastián Emiliano Escribano Gómez
% Sección: 13204-A-1
% Profesor: Gonzalo Martínez Ramírez

% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
%
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


% ----------------------------------------------------
%% Metas

% Primeras: Generar un mazo de cartas correspondiente a los valores ingresados
% En el predicado cardsSet. 
% ----------------------------------------------------
% Secundarias: Aplicar la fórmula matemática de forma 
% recursiva que permite calcular el número de elemento 
% respectivo a una lista de elementos.
% Generar un número aleatoreo para asignar aleatoriadad a la generación del mazo
% ----------------------------------------------------

cardsSet(Elements, NumE, MaxC, Seed, CS):-
    largoLista(Elements, Largo),
    Largo > 0,
    MaxC > 0,
    Seed > 0,
    crearMazo(NumE, CS).

% 2. Largo de una lista
% 2.1 La consulta también sirve para verificar si una lista es vacía.
% largoLista(Lista, Largo) es verdadero si Largo es el número de elementos de una lista.

largoLista( [], 0 ).
largoLista( [_|Resto], Largo ) :-
	largoLista( Resto, LargoAcumulado ),
	Largo is LargoAcumulado + 1.

%% Consultas:
% ?- len([1,2,3], Largo).
% Largo=3.
% ?- len([], Largo).
% L=0.

% 2.2 Agregar una carta a una lista de cartas.
agregarCarta([],L2,L2).
agregarCarta([Cabeza|L1],L2,[Cabeza|L3]):- 
    agregarCarta(L1,L2,L3).
   
% 2.3 Crea un mazo de cartas, recibe la cantidad de elementos que contiene el cardsSet.
primerCiclo(I,_,I2,[1]):-
    I2 is I+1,!.
primerCiclo(I,J,K,[Cabeza|Cuerpo]):- 
    Cabeza is I * J + (K + 1), 
    NuevoK is K + 1,
    primerCiclo(I,J,NuevoK,Cuerpo).

segundoCiclo(Q,I,_,W,[I2]):-
    W is Q+1,I2 is I+1,!.
segundoCiclo(Q,I,J,K,[Cabeza|Cuerpo]):-
    Cabeza is (Q+2+Q*(K-1)+(((I-1)*(K-1)+J-1) mod Q)),
    K2 is K+1,
    segundoCiclo(Q,I,J,K2,Cuerpo).

tercerCiclo(X,_,X2,[]):-
    X2 is X+1,!.
tercerCiclo(X,Y,K,[Cabeza|Cuerpo]):-
    segundoCiclo(X,Y,K,1,Cabeza),
    K2 is K+1,
    tercerCiclo(X,Y,K2,Cuerpo).

primeraCarta(0,[]):-!.
primeraCarta(Cabeza,[Cabeza|Cuerpo]):-
    NuevaCabeza is Cabeza-1,primeraCarta(NuevaCabeza,Cuerpo).

ordenN(X,NuevoX,[]):-NuevoX is X+1,!.
ordenN(X,Y,[Cabeza|Cuerpo]):-
    primerCiclo(X,Y,1,Cabeza),
    NuevaY is Y+1,ordenN(X,NuevaY,Cuerpo).

ordenNN(X,NuevoX,[]):-
    NuevoX is X+1,!.
ordenNN(X,Y,K):- 
    tercerCiclo(X,Y,1,Q), 
    agregarCarta(Q,Z,K),
    NuevoY is Y+1, ordenNN(X,NuevoY,Z).

crearMazo(OrdenJuego,Mazo):-
    OrdenPrimeraCarta is OrdenJuego+1,
    primeraCarta(OrdenPrimeraCarta,CartaA), 
    ordenN(OrdenJuego,1,CartaB),
    ordenNN(OrdenJuego,1,CartaC),
	agregarCarta([CartaA|CartaB],CartaC,Mazo).


% Consultas
% crearMazo(3, Mazo).
% Mazo = [[3, 2, 1], [5, 6, 7, 1], [8, 9, 10, 1], 
% [11, 12, 13, 1], [5, 8, 11, 2], [6, 9, 12, 2], [7, 10, 13, 2], 
% [5, 9, 13, 3], [6, 10, 11, 3], [7, 8, 12, 3], [5, 10, 12, 4], 
% [6, 8, 13, 4], [7, 9, 11, 4]]


%2.4 nthCard, recibe la un número de carta dentro del mazo.
nthCard(NumeroCarta, NumeroElemento, Carta):-
	crearMazo(NumeroElemento, Mazo),
    encontrarCarta(NumeroCarta, Mazo,Carta).

encontrarCarta(0, [],_).
encontrarCarta(0,[Salida|_],Carta):-
    Carta = Salida,!.
encontrarCarta(NumeroCarta, [_|MazoCuerpo], Carta):-
    NumeroCarta2 is NumeroCarta-1,
    encontrarCarta(NumeroCarta2, MazoCuerpo, Carta).
	
    
% Consultas
% nthCard(0, 3, Carta).
% Carta = [4, 3, 2, 1]
    

% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------

% --------------------------------
% Tipo de Dato Abstracto: dobbleGame
% --------------------------------

% Constructor
% Predicado que permite generar una baraja de cartas
% Dominio

% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------




