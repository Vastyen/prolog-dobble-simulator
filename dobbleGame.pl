/*
  _         _                  _           _       ___ ___ 
 | |   __ _| |__  ___ _ _ __ _| |_ ___ _ _(_)___  |_ _|_ _|
 | |__/ _` | '_ \/ _ \ '_/ _` |  _/ _ \ '_| / _ \  | | | | 
 |____\__,_|_.__/\___/_| \__,_|\__\___/_| |_\___/ |___|___|
                                                                                                                               
                                                    */

% Nombre: Bastián Emiliano Escribano Gómez
% Sección: 13204-A-1
% Profesor: Gonzalo Martínez Ramírez

% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
%
% --------------------------------
/*
  _____ ___   _      ___             _    ___      _   
 |_   _|   \ /_\    / __|__ _ _ _ __| |__/ __| ___| |_ 
   | | | |) / _ \  | (__/ _` | '_/ _` (_-<__ \/ -_)  _|
   |_| |___/_/ \_\  \___\__,_|_| \__,_/__/___/\___|\__|
                                                       */

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
    largoLista(Elements, LargoElementos),
    Orden is LargoElementos-1,
    OrdenNumE is NumE-1,
    isPrime(Orden),
    isPrime(OrdenNumE),
    LargoElementos == NumE,
    MaxC > 0,
    Seed > 0,
    crearMazo(Orden, TempCS),
    maxCards(TempCS, MaxC, CS).

% Operaciones
% cardsSet([1,2,3,4,5,6,7,8],8,57,43435,CS).
% [[8, 7, 6, 5, 4, 3, 2, 1], [9, 10, 11, 12, 13, 14, 15, 1], 
% [16, 17, 18, 19, 20, 21, 22, 1], [23, 24, 25, 26, 27, 28, 29, 1], 
% [30, 31, 32, 33, 34, 35, 36, 1], [37, 38, 39, 40, 41, 42, 43, 1], 
% [44, 45, 46, 47, 48, 49, 50, 1], [51, 52, 53, 54, 55, 56, 57, 1], 
% [9, 16, 23, 30, 37, 44, 51, 2], [10, 17, 24, 31, 38, 45, 52, 2], 
% [11, 18, 25, 32, 39, 46, 53, 2], [12, 19, 26, 33, 40, 47, 54, 2], 
% [13, 20, 27, 34, 41, 48, 55, 2], [14, 21, 28, 35, 42, 49, 56, 2], 
% [15, 22, 29, 36, 43, 50, 57, 2], [9, 17, 25, 33, 41, 49, 57, 3], 
% [10, 18, 26, 34, 42, 50, 51, 3], [11, 19, 27, 35, 43, 44, 52, 3], 
% [12, 20, 28, 36, 37, 45, 53, 3], [13, 21, 29, 30, 38, 46, 54, 3], 
% [14, 22, 23, 31, 39, 47, 55, 3], [15, 16, 24, 32, 40, 48, 56, 3], 
% [9, 18, 27, 36, 38, 47, 56, 4], [10, 19, 28, 30, 39, 48, 57, 4], 
% [11, 20, 29, 31, 40, 49, 51, 4], [12, 21, 23, 32, 41, 50, 52, 4], 
% [13, 22, 24, 33, 42, 44, 53, 4], [14, 16, 25, 34, 43, 45, 54, 4], 
% [15, 17, 26, 35, 37, 46, 55, 4], [9, 19, 29, 32, 42, 45, 55, 5], 
% [10, 20, 23, 33, 43, 46, 56, 5], [11, 21, 24, 34, 37, 47, 57, 5], 
% [12, 22, 25, 35, 38, 48, 51, 5], [13, 16, 26, 36, 39, 49, 52, 5], 
% [14, 17, 27, 30, 40, 50, 53, 5], [15, 18, 28, 31, 41, 44, 54, 5], 
% [9, 20, 24, 35, 39, 50, 54, 6], [10, 21, 25, 36, 40, 44, 55, 6], 
% [11, 22, 26, 30, 41, 45, 56, 6], [12, 16, 27, 31, 42, 46, 57, 6], 
% [13, 17, 28, 32, 43, 47, 51, 6], [14, 18, 29, 33, 37, 48, 52, 6], 
% [15, 19, 23, 34, 38, 49, 53, 6], [9, 21, 26, 31, 43, 48, 53, 7], 
% [10, 22, 27, 32, 37, 49, 54, 7], [11, 16, 28, 33, 38, 50, 55, 7], 
% [12, 17, 29, 34, 39, 44, 56, 7], [13, 18, 23, 35, 40, 45, 57, 7], 
% [14, 19, 24, 36, 41, 46, 51, 7], [15, 20, 25, 30, 42, 47, 52, 7], 
% [9, 22, 28, 34, 40, 46, 52, 8], [10, 16, 29, 35, 41, 47, 53, 8], 
% [11, 17, 23, 36, 42, 48, 54, 8], [12, 18, 24, 30, 43, 49, 55, 8], 
% [13, 19, 25, 31, 37, 50, 56, 8], [14, 20, 26, 32, 38, 44, 57, 8], 
% [15, 21, 27, 33, 39, 45, 51, 8]]

% cardsSet([1,2,3,4,5],18,57,43435,CS).
% false

%_____________________________



recorrerCarta([]):-!.
recorrerCarta([Cabeza|Cola]):-
    not(member(Cabeza, Cola)),
    recorrerCarta(Cola).

isDobble([]):-!.
isDobble([Cabeza|Cola]):-
    recorrerCarta(Cabeza),
    not(member(Cabeza, Cola)),
    isDobble(Cola).

% Operaciones
% isDobble([[13, 19, 25, 31, 37, 50, 56, 8], 
% [14, 20, 26, 32, 38, 44, 57, 8], [15, 21, 27, 33, 39, 45, 51, 8]]).
% true.
% cardsSet([1,2,3,4,5,6,7,8],8,57,43435, CS), isDobble(CS).
% [8, 7, 6, 5, 4, 3, 2, 1], [9, 10, 11, 12, 13, 14, 15, 1], 
% [16, 17, 18, 19, 20, 21, 22, 1], [23, 24, 25, 26, 27, 28, 29, 1], 
% [30, 31, 32, 33, 34, 35, 36, 1], [37, 38, 39, 40, 41, 42, 43, 1], 
% [44, 45, 46, 47, 48, 49, 50, 1], [51, 52, 53, 54, 55, 56, 57, 1], 
% [9, 16, 23, 30, 37, 44, 51, 2], [10, 17, 24, 31, 38, 45, 52, 2], 
% [11, 18, 25, 32, 39, 46, 53, 2], [12, 19, 26, 33, 40, 47, 54, 2], 
% [13, 20, 27, 34, 41, 48, 55, 2], [14, 21, 28, 35, 42, 49, 56, 2], 
% [15, 22, 29, 36, 43, 50, 57, 2], [9, 17, 25, 33, 41, 49, 57, 3], 
% [10, 18, 26, 34, 42, 50, 51, 3], [11, 19, 27, 35, 43, 44, 52, 3], 
% [12, 20, 28, 36, 37, 45, 53, 3], [13, 21, 29, 30, 38, 46, 54, 3], 
% [14, 22, 23, 31, 39, 47, 55, 3], [15, 16, 24, 32, 40, 48, 56, 3],
% [9, 18, 27, 36, 38, 47, 56, 4], [10, 19, 28, 30, 39, 48, 57, 4], 
% [11, 20, 29, 31, 40, 49, 51, 4], [12, 21, 23, 32, 41, 50, 52, 4], 
% [13, 22, 24, 33, 42, 44, 53, 4], [14, 16, 25, 34, 43, 45, 54, 4], 
% [15, 17, 26, 35, 37, 46, 55, 4], [9, 19, 29, 32, 42, 45, 55, 5], 
% [10, 20, 23, 33, 43, 46, 56, 5], [11, 21, 24, 34, 37, 47, 57, 5], 
% [12, 22, 25, 35, 38, 48, 51, 5], [13, 16, 26, 36, 39, 49, 52, 5], 
% [14, 17, 27, 30, 40, 50, 53, 5], [15, 18, 28, 31, 41, 44, 54, 5],
% [9, 20, 24, 35, 39, 50, 54, 6], [10, 21, 25, 36, 40, 44, 55, 6], 
% [11, 22, 26, 30, 41, 45, 56, 6], [12, 16, 27, 31, 42, 46, 57, 6],
% [13, 17, 28, 32, 43, 47, 51, 6], [14, 18, 29, 33, 37, 48, 52, 6], 
% [15, 19, 23, 34, 38, 49, 53, 6], [9, 21, 26, 31, 43, 48, 53, 7], 
% [10, 22, 27, 32, 37, 49, 54, 7], [11, 16, 28, 33, 38, 50, 55, 7], 
% [12, 17, 29, 34, 39, 44, 56, 7], [13, 18, 23, 35, 40, 45, 57, 7], 
% [14, 19, 24, 36, 41, 46, 51, 7], [15, 20, 25, 30, 42, 47, 52, 7],
% [9, 22, 28, 34, 40, 46, 52, 8], [10, 16, 29, 35, 41, 47, 53, 8],
% [11, 17, 23, 36, 42, 48, 54, 8], [12, 18, 24, 30, 43, 49, 55, 8], 
% [13, 19, 25, 31, 37, 50, 56, 8], [14, 20, 26, 32, 38, 44, 57, 8],
% [15, 21, 27, 33, 39, 45, 51, 8]]



% Verificar si es primo
isPrime(Number):-
    not((OtherNumber is Number-1,between(2,OtherNumber,N), 0 is mod(Number,N))),
    not(Number is 1).

% Operaciones
% isPrime(3)
% true

%_____________________________


maxCards(_, 0, []).
maxCards([Cabeza|Cola], MaxC, [Cabeza|Result]):-
    NewMaxC is MaxC - 1,
    maxCards(Cola, NewMaxC, Result).


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
    

%2.5 findTotalCards, a partir de una carta de muestra, determina cuantas
% cartas pueden ser creadas.
findTotalCards([], 0).
findTotalCards(Carta, TotalCards):-
   largoLista(Carta, Largo),
   TotalCards is (Largo*Largo-Largo+1).

% Consultas
% findTotalCards([3,5,3,2], TotalCards).
% TotalCards = 13

% -------------------- En proceso --------------------
%%2.6 MissingCards.
missingCards(NumeroCartas, TotalCards):-
    crearMazo(NumeroCartas, Mazo),
    largoLista(Mazo, LargoMazo),
    TotalCards = LargoMazo.

% -------------------- En proceso --------------------
% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------

%%2.7 toString. 
% Convierte un mazo (o lista de cartas) en un string.
cadenaCarta(Carta,String):-
    atomics_to_string(Carta, ', ',Coma),
    string_concat("Carta: ", Coma,String), 
    write(Coma), write(.), nl.

cadenaCartas([],""):-!.
cadenaCartas([Cabeza|Cola],String):- 
    cadenaCarta(Cabeza,Cuerpo),
    cadenaCartas(Cola,Carta),
    string_concat(Cuerpo, Carta, String).

toString(Orden,String):-
    crearMazo(Orden, Mazo),    
    cadenaCartas(Mazo,String).


% Operaciones
% toString(2, String).
% String = "Carta: 3, 2, 1Carta: 4, 5, 1Carta: 6, 7, 1Carta: 4, 6, 2Carta: 5, 7, 2Carta: 4, 7, 3Carta: 5, 6, 3"
% 
% toString(2, String).write(String).
% String = Carta: 3, 2, 1Carta: 4, 5, 1Carta: 6, 7, 1Carta: 4, 6, 2Carta: 5, 7, 2Carta: 4, 7, 3Carta: 5, 6, 3

% Particularmente en esta ocasión, es posible utilizare un predicado llamado newLine.
% Obligatoriamente debe estar al interior del predicado, por lo tanto la única forma es 
% Utilizando write adentro del predicado que escribe una carta.

% Carta: 3, 2, 1.
% Carta: 4, 5, 1.
% Carta: 6, 7, 1.
% Carta: 4, 6, 2.
% Carta: 5, 7, 2.
% Carta: 4, 7, 3.
% Carta: 5, 6, 3.


% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
/*
  _____ ___   _      ___                
 |_   _|   \ /_\    / __|__ _ _ __  ___ 
   | | | |) / _ \  | (_ / _` | '  \/ -_)
   |_| |___/_/ \_\  \___\__,_|_|_|_\___|
                                          */
% --------------------------------
% Tipo de Dato Abstracto: Game
% --------------------------------

dobbleGame(NumPlayers, CS, Mode, Seed, G):-
	isDobble(CS),
    Seed > 0,
	NumPlayers > 0,
    G = [[], [], NumPlayers,"En partida.", Mode].


dobbleGameRegister(User, G, GameOut):-
    




