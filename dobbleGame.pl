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

% Predicados
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

% ----------------------------------------------------
% ----------------------------------------------------


% Descripcion: recorre una carta y verifica que el elemento que este sea unico.
% Dominio: Una lista de elementos (Carta).
recorrerCarta([]):-!.
recorrerCarta([Cabeza|Cola]):-
    not(member(Cabeza, Cola)),
    recorrerCarta(Cola).

% ----------------------------------------------------
% ----------------------------------------------------


% Descripcion: recorre una lista de cartas y verifica que la carta sea unica.
% Dominio: Una lista de elementos (Mazo o cardsSet).
cardsSetIsDobble([]):-!.
cardsSetIsDobble([Cabeza|Cola]):-
    recorrerCarta(Cabeza),
    not(member(Cabeza, Cola)),
    cardsSetIsDobble(Cola).

% Operaciones
% cardsSetIsDobble([[13, 19, 25, 31, 37, 50, 56, 8], 
% [14, 20, 26, 32, 38, 44, 57, 8], [15, 21, 27, 33, 39, 45, 51, 8]]).
% true.

% cardsSet([1,2,3],3,7,43435,CS), cardsSetIsDobble(CS).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]

% cardsSetIsDobble([[13, 13, 13, 13, 13, 50, 13, 13], 
% [14, 20, 26, 13, 38, 13, 13, 8], [13, 13, 13, 33, 13, 43, 13, 8]]).
% false.

% ----------------------------------------------------
% ----------------------------------------------------

% Descripcion: Verifica si un numero ingresado es primo o no.
% Dominio: Numero.
isPrime(Number):-
    not((OtherNumber is Number-1,between(2,OtherNumber,N), 0 is mod(Number,N))),
    not(Number is 1).

% Operaciones
% isPrime(3)
% true



% ----------------------------------------------------
% ----------------------------------------------------

% Descripcion: Entrega una n cantidad de elementos de una lista.
% Dominio: Una lista de cartas, la cantidad de cartas, la lista resultante.
maxCards(_, 0, []).
maxCards([Cabeza|Cola], MaxC, [Cabeza|Result]):-
    NewMaxC is MaxC - 1,
    maxCards(Cola, NewMaxC, Result).

% ----------------------------------------------------
% ----------------------------------------------------

% Descripcion: Encuentra el largo de una lista de elementos
% Dominio: Una lista de elementos y el resultado (largo).
largoLista( [], 0 ).
largoLista( [_|Resto], Largo ) :-
	largoLista( Resto, LargoAcumulado ),
	Largo is LargoAcumulado + 1.

%% Consultas:
% ?- len([1,2,3], Largo).
% Largo=3.
% ?- len([], Largo).
% L=0.

% ----------------------------------------------------
% ----------------------------------------------------

% Descripcion: Agrega una carta a una lista de cartas (o una lista a una lista de elementos).
% Dominio: Una lista de elementos inicial, la nueva lista y la lista resultante.
agregarCarta([],L2,L2).
agregarCarta([Cabeza|L1],L2,[Cabeza|L3]):- 
    agregarCarta(L1,L2,L3).
   
% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Crea un mazo en simulación al código en JavaScript. 
% Se utilizan varias recursiones para lograr esto, ya que se realiza la simulación de
% 3 Ciclos for. 
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

% Descripción: Crea el mazo de cartas. (lista de listas).
% Dominio: El orden del juego (entero) y una lista de salida (lista de listas).
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

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Recibe y retorna un número de carta dentro del mazo.
% Dominio: Numero de la posición, lista de elementos y el elemento a retornar.
nthElement(Posicion, Lista, Elemento):-
    encontrarCarta(Posicion, Lista,Elemento).


% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Recibe y retorna un número de carta dentro del mazo.
% Dominio: Numero de la posición, lista de elementos y el elemento a retornar.
cardsSetNthCard(NumeroCarta, CS, Carta):-
    encontrarCarta(NumeroCarta, CS,Carta).


% Descripción: Este predicado encapsulado se encarga de encontrar la carta o elemento n.
% Dominio: Numero de la posición, lista de elementos y el elemento a retornar.
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
% Descripción: A partir de una carta de muestra, determina cuantas cartas pueden ser creadas.
% Dominio: Una carta y el resultado (numero) de posibles cartas.
cardsSetFindTotalCards([], 0).
cardsSetFindTotalCards(Carta, TotalCards):-
   largoLista(Carta, Largo),
   TotalCards is (Largo*Largo-Largo+1).

% Consultas
% findTotalCards([3,5,3,2], TotalCards).
% TotalCards = 13


% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: A partir de un mazo, se calcula las cartas faltantes para que sea un
% mazo valido para jugar.
% Dominio: Carta de ejemplo, mazo valido.
calcularOrden(NumeroElementos, Orden):-
    Orden is NumeroElementos-1.
cardsSetMissingCards([PrimeraCarta|_], MissingCS):-
    largoLista(PrimeraCarta, NumeroElementos),
    calcularOrden(NumeroElementos, Orden),
    crearMazo(Orden, MissingCS).
    
% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Convierte un mazo (o lista de cartas) en un string.
% Dominio: Mazo de cartas y retorna un String con el mazo convertido en String.
cadenaCarta(Carta,String):-
    atomics_to_string(Carta, ', ',Coma),
    string_concat("Carta: ", Coma,Wr),
	string_concat(Wr, "\n", String).

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
    G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], NumPlayers,"Partida en curso.", Mode].

% ----------------------------------------------------
% Métodos Selectores: Game
% ----------------------------------------------------

getAreaDeJuego([Area|_], Area).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getAreaDeJuego(G, Area).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Area = []


getPiezasDisponibles(G, PiezasDisponibles):-
    nthElement(1, G, PiezasDisponibles).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPiezasDisponibles (G, PiezasDisponibles).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% PiezasDisponibles = []


getTurns(G, Turns):-
    nthElement(2, G, Turns).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getTurns(G, Turns).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Turns = []

getPlayersScore(G, PlayersScore):-
    nthElement(3, G, PlayersScore).


getPlayers(G, Players):-
    nthElement(4, G, Players).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPlayers(G, Players).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Players = []

getNumPlayers(G, NumPlayers):-
    nthElement(5, G, NumPlayers).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getNumPlayers(G, NumPlayers).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% NumPlayers = 3


getStatus(G, Status):-
    nthElement(6, G, Status).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getStatus(G, Status).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Status = "Partida en curso."


getMode(G, Mode):-
    nthElement(7, G, Mode).
  
% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getMode(G, Mode).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% Mode = StackMode


dobbleGameRegister(User, G, GameOut):-
    getAreaDeJuego(G, Area),
    getPiezasDisponibles(G, PiezasDisponibles),
    getTurns(G, Turns),
    getPlayersScore(G, PlayersScore),
    getPlayers(G, Players),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),
    getMode(G, Mode),
    not(member(User, Players)),
    NumPlayers > 0,
    append(Players, [User], NewPlayers),
    NewNumPlayers is NumPlayers-1,
    GameOut = [Area, PiezasDisponibles,Turns,PlayersScore,NewPlayers,NewNumPlayers,Status,Mode].

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS),
% dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]


dobbleGameWhoseTurnIsIt(G, User):-
    getTurns(G, TurnoNumero),
    getPlayers(G, Players),
    nthElement(TurnoNumero, Players, User).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGameWhoseTurnIsIt(GameOut, User).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [[], [], 0, [], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% User = "Gonzalo"


dobbleGamePlay(G,Action,GameOut):-
    Action == null,
    getAreaDeJuego(G, Area),
    getPiezasDisponibles(G, PiezasDisponibles),
    getPlayersScore(G, PlayersScore),
    getPlayers(G, Players),
    getTurns(G, Turns),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),
    getMode(G, Mode),
    getPlayersScore(G, PlayersScore),
    GameOut = [Area, PiezasDisponibles, Turns,PlayersScore,Players, NumPlayers,Status,Mode].

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,null,GameOut).
% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]


dobbleGamePlay(G,[Action|_],GameOut):-
    Action == pass,
    getTurns(G, Turn),
    NewTurns is Turn+1,
    getAreaDeJuego(G, Area),
    getPiezasDisponibles(G, PiezasDisponibles),
    getPlayersScore(G, PlayersScore),
    getPlayers(G, Players),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),
    getMode(G, Mode),
    getPlayersScore(G, PlayersScore),
    GameOut = [Area, PiezasDisponibles,NewTurns,PlayersScore,Players,NumPlayers,Status,Mode].

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,[pass],GameOut).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

dobbleGamePlay(G,[Action|_],GameOut):-
    Action == finish,
    getAreaDeJuego(G, Area),
    getPiezasDisponibles(G, PiezasDisponibles),
    getTurns(G, Turns),
    getPlayersScore(G, PlayersScore),
    getPlayers(G, Players),
    getNumPlayers(G, NumPlayers),
    getMode(G, Mode),
    getPlayersScore(G, PlayersScore),
    GameOut = [Area, PiezasDisponibles,Turns,PlayersScore,Players, NumPlayers,"Juego terminado.",Mode].

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,[finish],GameOut).
% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]

dobbleGamePlay(G, Action, GameOut):-
    largoLista(Action, LargoAction),
    LargoAction == 3,
    nthCard(2, Action, Elemento),
    getPiezasDisponibles(G, PiezasDisponibles),
    PrimeraCarta = [PiezasDisponibles|_],
    RestoCartas = [_|PiezasDisponibles],
    member(Elemento, PrimeraCarta),
    getPlayersScore(G, PlayersScore),
    getTurns(G, TurnoNumero),
    getPlayers(G, Players),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),
    getMode(G, Mode),
    TurnoNumeroAux is TurnoNumero+1,

    GameOut = [PrimeraCarta, RestoCartas, TurnoNumeroAux,PlayersScore,Players,NumPlayers, Status, Mode].
	
% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGamePlay(GameOut,[spotIt, "Dobble", 2],GameOut2).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut2 = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]


dobbleGameStatus(G, GameStatus):-
    getStatus(G, Status),
    GameStatus = Status.

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut), dobbleGameScore(GameOut, "Gonzalo", Score).
%% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% Status = "Partida en curso."
	
dobbleGameScore(G, User, Score):-
    getPlayers(G, Players),
    getPlayersScore(G,PlayersScore),
    nth0(Pos, Players, User),
    nthElement(Pos, PlayersScore, Finding),
    Score = Finding.

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut), dobbleGameScore(GameOut, "Gonzalo", Score).
%% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% Score = Score

    
dobbleGameToString(G, String):-
    getTurns(G, Turns),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),

	string_concat("Turno: \n", Turns, Aux1),
    string_concat("Numero de Jugadores: \n", NumPlayers, Aux2),
    string_concat("Estado del Juego: \n", Status, Aux3),

    string_concat(Aux1, Aux2, Aux10),
    string_concat(Aux10, Aux3, String).

% Operaciones
% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGamePlay(GameOut,[spotIt, "Dobble", 2],GameOut2), 
% dobbleGameToString(GameOut2, String).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% GameOut2 = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% String = "Turno: \n1Numero de Jugadores: \n2Estado del Juego: \nPartida en curso."

