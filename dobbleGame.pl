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
% ----------------------------------------------------
% Tipo de Dato Abstracto: CardsSet
% ----------------------------------------------------

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
% cardsSet([1,2,3],3,7,43435,CS).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]

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

% cardsSet([1,2,3],3,7,43435,CS), isDobble(CS).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]

% isDobble([[13, 13, 13, 13, 13, 50, 13, 13], 
% [14, 20, 26, 13, 38, 13, 13, 8], [13, 13, 13, 33, 13, 43, 13, 8]]).
% false.

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


%2.4 nthCard, recibe y retorna un número de carta dentro del mazo.
nthCard(NumeroCarta, CS, Carta):-
    encontrarCarta(NumeroCarta, CS,Carta).

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

calcularOrden(NumeroElementos, Orden):-
    Orden is NumeroElementos-1.
    
missingCards([PrimeraCarta|_], MissingCS):-
    largoLista(PrimeraCarta, NumeroElementos),
    calcularOrden(NumeroElementos, Orden),
    crearMazo(Orden, MissingCS).
    
% -------------------- En proceso --------------------
% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------

% cardsSetToString. 
% Convierte un mazo (o lista de cartas) en un string.
cadenaCarta(Carta,String):-
    atomics_to_string(Carta, ', ',Coma),
    string_concat("Carta: ", Coma,String), 
    write("Carta: "), write(Coma), write(.), nl.

cadenaCartas([],""):-!.
cadenaCartas([Cabeza|Cola],String):- 
    cadenaCarta(Cabeza,Cuerpo),
    cadenaCartas(Cola,Carta),
    string_concat(Cuerpo, Carta, String).

cardsSetToString(CS,String):-   
    cadenaCartas(CS,String).


% Operaciones
% cardsSet([1,2,3,4,5,6,7,8],8,57,43435,CS), cardsSetToString(CS,String).
% String = "Carta: 3, 2, 1Carta: 4, 5, 1Carta: 6, 7, 1Carta: 4, 6, 2Carta: 5, 7, 2Carta: 4, 7, 3Carta: 5, 6, 3"
% 
% cardsSet([1,2,3,4,5,6,7,8],8,57,43435,CS), cardsSetToString(CS,String), write(String).
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
% ----------------------------------------------------
% Tipo de Dato Abstracto: | Game |
% ----------------------------------------------------

dobbleGame(NumPlayers, CS, Mode, Seed, G):-
	isDobble(CS),
    Seed > 0,
	NumPlayers > 0,
    G = [[], [], [], [], NumPlayers,"Partida en curso.", Mode].

% ----------------------------------------------------
% Métodos Selectores: Game
% ----------------------------------------------------

getAreaDeJuego([Area|_], Area).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getAreaDeJuego(G, Area).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% Area = []


getPiezasDisponibles(G, PiezasDisponibles):-
    nthCard(1, G, PiezasDisponibles).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPiezasDisponibles (G, PiezasDisponibles).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% PiezasDisponibles = []



getTurns(G, Turns):-
    nthCard(2, G, Turns).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getTurns(G, Turns).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% Turns = []



getPlayers(G, Players):-
    nthCard(3, G, Players).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPlayers(G, Players).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% Players = []

getNumPlayers(G, NumPlayers):-
    nthCard(4, G, NumPlayers).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getNumPlayers(G, NumPlayers).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% NumPlayers = 3


getStatus(G, Status):-
    nthCard(5, G, Status).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getStatus(G, Status).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% Status = "Partida en curso."


getMode(G, Mode):-
    nthCard(6, G, Mode).
  
% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getMode(G, Mode).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [[], [], 3, "Partida en curso.", StackMode]
% Mode = StackMode


dobbleGameRegister(User, G, GameOut):-
    getAreaDeJuego(G, Area),
    getPiezasDisponibles(G, PiezasDisponibles),
    getTurns(G, Turns),
    getPlayers(G, Players),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),
    getMode(G, Mode),
    append(Players, [User], NewPlayers),
    NewNumPlayers is NumPlayers+1,
    GameOut = [Area, PiezasDisponibles,Turns,NewPlayers,NewNumPlayers,Status,Mode].

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS),
% dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Basti",G,GameOut).







    