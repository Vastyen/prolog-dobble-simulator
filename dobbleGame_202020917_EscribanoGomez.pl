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

/*
  _____ ___   _      ___             _    ___      _   
 |_   _|   \ /_\    / __|__ _ _ _ __| |__/ __| ___| |_ 
   | | | |) / _ \  | (__/ _` | '_/ _` (_-<__ \/ -_)  _|
   |_| |___/_/ \_\  \___\__,_|_| \__,_/__/___/\___|\__|
                                                       */
% ----------------------------------------------------
% Tipo de Dato Abstracto: CardsSet
% ----------------------------------------------------


% Lista de Predicados

% cardsSet(Elements, NumE, MaxC, Seed, CS).
% recorrerCarta(Carta).
% cardsSetIsDobble(CS).
% isPrime(Numero).
% maxCards(CS, MaxC, Result).
% largoLista(Lista, Largo).
% agregarCarta(Lista1, Lista2, ListaResultado).
% primeraCarta(OrdenPrimeraCarta,CartaA).
% primerCiclo(I,J,NuevoK,Cuerpo).
% segundoCiclo(Q,I,J,K2,Cuerpo).
% tercerCiclo(X,Y,K2,Cuerpo).
% ordenN(OrdenJuego,1,CartaB).
% ordenNN(OrdenJuego,1,CartaC).
% agregarCarta([CartaA|CartaB],CartaC,Mazo).
% nthElement(Posicion, Lista, Elemento).
% cardsSetNthCard(NumeroCarta, CS, Carta).
% encontrarCarta(NumeroCarta, MazoCuerpo, Carta).
% cardsSetFindTotalCards(Carta, TotalCards).
% calcularOrden(NumeroElementos, Orden).
% cardsSetMissingCards(Carta, CS).
% cadenaCarta(Carta, String).
% cadenaCartas(ListaCartas, String).
% cardsSetToString(CS, String).

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


% ----------------------------------------------------
% Método Constructor
% ----------------------------------------------------

% Descripción: Constructor cardsSet, crea un mazo de cartas y lo guarda en CS.
% Dominio: Elemento (list) X NumE (integer) X MaxC (integer) 
% Seed (integer) X CS (list).
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

% Ejemplos cardsSet
% cardsSet([1,2,3],3,7,43435,CS).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]

% cardsSet([1,2,3,4,5],18,57,43435,CS).
% false


% ----------------------------------------------------
% Métodos cardsSet
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

% ----------------------------------------------------
% ----------------------------------------------------

% Descripcion: Verifica si un numero ingresado es primo o no.
% Dominio: Numero.
isPrime(Numero):-
    not((NumeroNuevo is Numero-1,between(2,NumeroNuevo,N), 0 is mod(Numero,N))),
    not(Numero is 1).

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

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Este predicado encapsulado se encarga de encontrar la carta o elemento n.
% Dominio: Numero de la posición, lista de elementos y el elemento a retornar.
encontrarCarta(0, [],_).
encontrarCarta(0,[Salida|_],Carta):-
    Carta = Salida,!.
encontrarCarta(NumeroCarta, [_|MazoCuerpo], Carta):-
    NumeroCarta2 is NumeroCarta-1,
    encontrarCarta(NumeroCarta2, MazoCuerpo, Carta).

% ----------------------------------------------------
% ----------------------------------------------------
% Descripción: A partir de una carta de muestra, determina cuantas cartas pueden ser creadas.
% Dominio: Una carta y el resultado (numero) de posibles cartas.
cardsSetFindTotalCards([], 0).
cardsSetFindTotalCards(Carta, TotalCards):-
   largoLista(Carta, Largo),
   TotalCards is (Largo*Largo-Largo+1).

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
% Tipo de Dato Abstracto: Game
% ----------------------------------------------------

% Lista de Predicados

% dobbleGame(NumPlayers, CS, Mode, Seed, G).
% getAreaDeJuego(G, Area).
% getPiezasDisponibles(G, PiezasDisponibles).
% getTurns(G, Turns).
% getPlayersScore(G, PlayersScore).
% getPlayers(G, Players).
% getNumPlayers(G, NumPlayers).
% getStatus(G, Status).
% getMode(G, Mode).
% dobbleGameRegister(User, G, GameOut).
% dobbleGameWhoseTurnIsIt(G, User).
% dobbleGamePlay(G,Action,GameOut).
% dobbleGamePlay(G, Lista, GameOut).
% dobbleGameStatus(G, GameStatus).
% dobbleGameScore(G, User, Score).
% dobbleGameToString(G, String).

% ----------------------------------------------------
%% Metas

% Primeras: Generar un juego y todas sus acciones.
% ----------------------------------------------------
% Secundarias: Generar métodos selectores para entregar nuevas listas
% del mismo TDA (dobbleGame) con lo respectivamente solicitado para cada
% predicado. 
% ----------------------------------------------------


% ----------------------------------------------------
% Método Constructor: Game
% ----------------------------------------------------

% Descripción: Predicado que genera un juego.
% Dominio: NumPlayers (int) X CS (cardsSet) X Mode (String) 
% Seed (int) X G (list).
dobbleGame(NumPlayers, CS, Mode, Seed, G):-
	cardsSetIsDobble(CS),
    Seed > 0,
	NumPlayers > 0,
    G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], NumPlayers,"Partida en curso.", Mode].

% ----------------------------------------------------
% Métodos Selectores: Game
% ----------------------------------------------------

% Descripción: Predicado selector que obtiene el área de un juego
% Dominio: Game (dobbleGame) X Area (list).
getAreaDeJuego([Area|_], Area).

% Descripción: Predicado selector que obtiene las piezas disponibles de un juego
% Dominio: Game (dobbleGame) X PiezasDisponibles (list).
getPiezasDisponibles(G, PiezasDisponibles):-
    nthElement(1, G, PiezasDisponibles).

% Descripción: Predicado selector que obtiene los turnos de un juego
% Dominio: Game (dobbleGame) X Turns (int).
getTurns(G, Turns):-
    nthElement(2, G, Turns).

% Descripción: Predicado selector que obtiene la lista de puntajes.
% Dominio: Game (dobbleGame) X PlayersScore (list).
getPlayersScore(G, PlayersScore):-
    nthElement(3, G, PlayersScore).


% Descripción: Predicado selector que obtiene la lista de jugadores
% Dominio: Game (dobbleGame) X Players (list).
getPlayers(G, Players):-
    nthElement(4, G, Players).


% Descripción: Predicado selector que obtiene el número de jugadores
% Dominio: Game (dobbleGame) X NumPlayers (int).
getNumPlayers(G, NumPlayers):-
    nthElement(5, G, NumPlayers).

% Descripción: Predicado selector que obtiene el estado de un juego
% Dominio: Game (dobbleGame) X Status (string).
getStatus(G, Status):-
    nthElement(6, G, Status).

% Descripción: Predicado selector que obtiene el modo de juego de un juego.
% Dominio: Game (dobbleGame) X Mode (string).
getMode(G, Mode):-
    nthElement(7, G, Mode).
  

% ----------------------------------------------------
% Métodos dobbleGame
% ----------------------------------------------------

% Descripción: Predicado que genera un nuevo juego.
% Dominio: User (string) X Game (dobbleGame) X GameOut (dobbleGame).
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

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Predicado que devuelve el turno respectivo de un juego.
% Dominio: Game (dobbleGame) X User (string).
dobbleGameWhoseTurnIsIt(G, User):-
    getTurns(G, TurnoNumero),
    getPlayers(G, Players),
    nthElement(TurnoNumero, Players, User).

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Predicado que realiza una jugada a partir de un juego.
% Dominio: Game (dobbleGame) X Action (atom) X GameOut (dobbleGame).
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



% Descripción: Predicado que realiza una jugada a partir de un juego.
% Dominio: Game (dobbleGame) X Action (list) X GameOut (dobbleGame).
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

% Descripción: Predicado que realiza una jugada a partir de un juego.
% Dominio: Game (dobbleGame) X Action (list) X GameOut (dobbleGame).
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

% Descripción: Predicado que realiza una jugada a partir de un juego.
% Dominio: Game (dobbleGame) X Action (list) X GameOut (dobbleGame).
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
	
% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Predicado que obtiene el estado de un juego.
% Dominio: Game (dobbleGame) X GameStatus (string).
dobbleGameStatus(G, GameStatus):-
    getStatus(G, Status),
    GameStatus = Status.

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Predicado que obtiene el puntaje de un jugador
% Dominio: Game (dobbleGame) X User (string) X Score (int).
dobbleGameScore(G, User, Score):-
    getPlayers(G, Players),
    getPlayersScore(G,PlayersScore),
    nth0(Pos, Players, User),
    nthElement(Pos, PlayersScore, Finding),
    Score = Finding.

% ----------------------------------------------------
% ----------------------------------------------------

% Descripción: Predicado que genera un string a partir de de un juego.
% Dominio: Game (dobbleGame) X String (string).
dobbleGameToString(G, String):-
    getTurns(G, Turns),
    getNumPlayers(G, NumPlayers),
    getStatus(G, Status),

	string_concat("Turno: \n", Turns, Aux1),
    string_concat("Numero de Jugadores: \n", NumPlayers, Aux2),
    string_concat("Estado del Juego: \n", Status, Aux3),

    string_concat(Aux1, Aux2, Aux10),
    string_concat(Aux10, Aux3, String).


% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
/*
            ___  _                _        
           | __|(_)___ _ __  _ __| |___ ___
           | _| | / -_) '  \| '_ \ / _ (_-<
           |___|/ \___|_|_|_| .__/_\___/__/
              |__/          |_|            
*/
% ----------------------------------------------------
% Ejemplos
% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSet

% cardsSet([1,2,3],3,7,43435,CS).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]

% cardsSet([1,2,3,4,5],18,57,43435,CS).
% false

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos recorrerCarta

% recorrerCarta([1,2,2]).
% false

% recorrerCarta([1,2,3]).
% true

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSetIsDobble

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

% Ejemplos isPrime

% isPrime (3)
% true
% isPrime (4) 
% false

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos maxCards 

% maxCards([1,2,3], 2, Result).
%  Result = [1,2]


% maxCards([1,2,3], 1, Result).
%  Result = [1]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos largoLista

% ?- largoLista([1,2,3], Largo).
% Largo=3.

% ?- largoLista([], Largo).
% L=0.

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos agregarCarta

% agregarCarta([[1,2,3]], [4,5,6], Resultado).
% Resultado = [[1,2,3], [4,5,6]]

% agregarCarta([[1,2,3], [4,5,6]], [7,8,9], Resultado).
% Resultado = [[1,2,3], [4,5,6], [7,8,9]]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos crearMazo

% crearMazo(7, Mazo).
% Mazo = [[8, 7, 6, 5, 4, 3, 2, 1], [9, 10, 11, 12, 13, 14, 15, 1], 
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

% crearMazo(3, Mazo).
% Mazo = [[4, 3, 2, 1], [5, 6, 7, 1], 
% [8, 9, 10, 1], [11, 12, 13, 1], [5, 8, 11, 2], 
% [6, 9, 12, 2], [7, 10, 13, 2], [5, 9, 13, 3], [6, 10, 11, 3],
% [7, 8, 12, 3], [5, 10, 12, 4], [6, 8, 13, 4], [7, 9, 11, 4]]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos nthElement 
% nthElement(5, [[4, 3, 2, 1], [5, 6, 7, 1], [8, 9, 10, 1], 
% [11, 12, 13, 1], [5, 8, 11, 2], [6, 9, 12, 2], [7, 10, 13, 2],
% [5, 9, 13, 3], [6, 10, 11, 3], [7, 8, 12, 3], [5, 10, 12, 4], 
% [6, 8, 13, 4], [7, 9, 11, 4]], Element).
% Element = [6, 9, 12, 2]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSetNthCard

% cardsSet([1,2,3],3,7,43435,CS), cardsSetNthCard(3, CS, Carta).
% Carta = [4,6,2]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSetFindTotalCards

% cardsSetFindTotalCards([3,5,3,2], TotalCards).
% TotalCards = 13
% cardsSetFindTotalCards([9,5,3,2,1,4,9], TotalCards).
% TotalCards = 43

% ----------------------------------------------------
% ---------------------------------------------------

% Ejemplos calcularOrden

% calcularOrden(8, Orden).
% Orden = 7

% calcularOrden(4 Orden).
% Orden = 3

% calcularOrden(14, Orden).
% Orden = 13

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSetMissingCards

% cardsSetMissingCards([[1,2,3],[4,5,6]], MissingCards).
% MissingCards = [[3, 2, 1], [4, 5, 1], [6, 7, 1], 
% [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]


% cardsSetMissingCards([[1,2,3,4,5,6],[4,5,6]], MissingCards).
% MissingCards = [[6, 5, 4, 3, 2, 1], [7, 8, 9, 10, 11, 1], 
% [12, 13, 14, 15, 16, 1], [17, 18, 19, 20, 21, 1], 
% [22, 23, 24, 25, 26, 1], [27, 28, 29, 30, 31, 1], 
% [7, 12, 17, 22, 27, 2], [8, 13, 18, 23, 28, 2],
% [9, 14, 19, 24, 29, 2], [10, 15, 20, 25, 30, 2], 
% [11, 16, 21, 26, 31, 2], [7, 13, 19, 25, 31, 3], 
% [8, 14, 20, 26, 27, 3], [9, 15, 21, 22, 28, 3], 
% [10, 16, 17, 23, 29, 3], [11, 12, 18, 24, 30, 3],
% [7, 14, 21, 23, 30, 4], [8, 15, 17, 24, 31, 4], 
% [9, 16, 18, 25, 27, 4], [10, 12, 19, 26, 28, 4],
% [11, 13, 20, 22, 29, 4], [7, 15, 18, 26, 29, 5], 
% [8, 16, 19, 22, 30, 5], [9, 12, 20, 23, 31, 5], 
% [10, 13, 21, 24, 27, 5], [11, 14, 17, 25, 28, 5], 
% [7, 16, 20, 24, 28, 6], [8, 12, 21, 25, 29, 6], 
% [9, 13, 17, 26, 30, 6], [10, 14, 18, 22, 31, 6], 
% [11, 15, 19, 23, 27, 6]]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos cardsSetToString

%  cardsSet([1,2,3],3,7,43435,CS), cardsSetToString(CS, String).
% String = "Carta: 3, 2, 1\nCarta: 4, 5, 1\nCarta: 6, 7, 
% 1\nCarta: 4, 6, 2\nCarta: 5, 7, 2\nCarta: 4, 7, 3\nCarta: 5, 6, 3\n"

%  cardsSet([1,2,3,4,5,6,7,8],8,57,43435,CS), cardsSetToString(CS, String).
% String = "Carta: 8, 7, 6, 5, 4, 3, 2, 1\nCarta: 9, 10, 11, 12, 13, 14, 15, 1\nCarta: 16, 17, 18, 19, 20, 21, 22, 1\n
% Carta: 23, 24, 25, 26, 27, 28, 29, 1\nCarta: 30, 31, 32, 33, 34, 35, 36, 1\nCarta: 37, 38, 39, 40, 41, 42, 43, 1\n
% Carta: 44, 45, 46, 47, 48, 49, 50, 1\nCarta: 51, 52, 53, 54, 55, 56, 57, 1\nCarta: 9, 16, 23, 30, 37, 44, 51, 2\n
% Carta: 10, 17, 24, 31, 38, 45, 52, 2\nCarta: 11, 18, 25, 32, 39, 46, 53, 2\nCarta: 12, 19, 26, 33, 40, 47, 54, 2\n
% Carta: 13, 20, 27, 34, 41, 48, 55, 2\nCarta: 14, 21, 28, 35, 42, 49, 56, 2\nCarta: 15, 22, 29, 36, 43, 50, 57, 2\n
% Carta: 9, 17, 25, 33, 41, 49, 57, 3\nCarta: 10, 18, 26, 34, 42, 50, 51, 3\nCarta: 11, 19, 27, 35, 43, 44, 52, 3\n
% Carta: 12, 20, 28, 36, 37, 45, 53, 3\nCarta: 13, 21, 29, 30, 38, 46, 54, 3\nCarta: 14, 22, 23, 31, 39, 47, 55, 3\n
% Carta: 15, 16, 24, 32, 40, 48, 56, 3\nCarta: 9, 18, 27, 36, 38, 47, 56, 4\nCarta: 10, 19, 28, 30, 39, 48, 57, 4\n
% Carta: 11, 20, 29, 31, 40, 49, 51, 4\nCarta: 12, 21, 23, 32, 41, 50, 52, 4\nCarta: 13, 22, 24, 33, 42, 44, 53, 4\n
% Carta: 14, 16, 25, 34, 43, 45, 54, 4\nCarta: 15, 17, 26, 35, 37, 46, 55, 4\nCarta: 9, 19, 29, 32, 42, 45, 55, 5\n
% Carta: 10, 20, 23, 33, 43, 46, 56, 5\nCarta: 11, 21, 24, 34, 37, 47, 57, 5\nCarta: 12, 22, 25, 35, 38, 48, 51, 5\n
% Carta: 13, 16, 26, 36, 39, 49, 52, 5\nCarta: 14, 17, 27, 30, 40, 50, 53, 5\nCarta: 15, 18, 28, 31, 41, 44, 54, 5\n
% Carta: 9, 20, 24, 35, 39, 50, 54, 6\nCarta: 10, 21, 25, 36, 40, 44, 55, 6\nCarta: 11, 22, 26, 30, 41, 45, 56, 6\n
% Carta: 12, 16, 27, 31, 42, 46, 57, 6\nCarta: 13, 17, 28, 32, 43, 47, 51, 6\nCarta: 14, 18, 29, 33, 37, 48, 52, 6\n
% Carta: 15, 19, 23, 34, 38, 49, 53, 6\nCarta: 9, 21, 26, 31, 43, 48, 53, 7\nCarta: 10, 22, 27, 32, 37, 49, 54, 7\n
% Carta: 11, 16, 28, 33, 38, 50, 55, 7\nCarta: 12, 17, 29, 34, 39, 44, 56, 7\nCarta: 13, 18, 23, 35, 40, 45, 57, 7\n
% Carta: 14, 19, 24, 36, 41, 46, 51, 7\nCarta: 15, 20, 25, 30, 42, 47, 52, 7\nCarta: 9, 22, 28, 34, 40, 46, 52, 8\n
% Carta: 10, 16, 29, 35, 41, 47, 53, 8\nCarta: 11, 17, 23, 36, 42, 48, 54, 8\nCarta: 12, 18, 24, 30, 43, 49, 55, 8\n
% Carta: 13, 19, 25, 31, 37, 50, 56, 8\nCarta: 14, 20, 26, 32, 38, 44, 57, 8\nCarta: 15, 21, 27, 33, 39, 45, 51, 8\n"


% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos dobbleGame

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3, CS, "StackMode" , 34234, G).
% G = [[“Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", "StackMode"]


% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(10, CS, "RandomMode" , 34234, G).
% G = [[“Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 10, "Partida en curso.", "RandomMode"]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getAreaDeJuego

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getAreaDeJuego(G, Area).
% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% Area = []


% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getPiezasDisponibles

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPiezasDisponibles (G, PiezasDisponibles).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% PiezasDisponibles = []

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getTurns

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getTurns(G, Turns).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Turns = 1

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getPlayersScore

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPlayersScore(G, Score).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Score = [0,0,0]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getPlayers

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getPlayers(G, Players).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Players = []

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getNumPlayers

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getNumPlayers(G, NumPlayers).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% NumPlayers = 3

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getStatus

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getStatus(G, Status).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]

% Status = "Partida en curso."

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo getMode

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), getMode(G, Mode).

% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% Mode = StackMode

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo dobbleGameRegister

% cardsSet([1,2,3],3,7,43435,CS),
% dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]


% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo dobbleGameWhoseTurnIsIt

% cardsSet([1,2,3],3,7,43435,CS), 
% dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGameWhoseTurnIsIt(GameOut, User).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [[], [], 0, [], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% User = "Gonzalo"

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplos dobbleGamePlay

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,null,GameOut).
% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,[pass],GameOut).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]


% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), dobbleGamePlay(G,[finish],GameOut).
% CS = [3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGamePlay(GameOut,[spotIt, "Dobble", 2],GameOut2).
% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut2 = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo dobbleGameStatus

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut), dobbleGameScore(GameOut, "Gonzalo", Score).
%% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% Status = "Partida en curso."

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo dobbleGameScore

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo",G,GameOut), dobbleGameScore(GameOut, "Gonzalo", Score).
%% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% Score = Score

% ----------------------------------------------------
% ----------------------------------------------------

% Ejemplo dobbleGameToString

% cardsSet([1,2,3],3,7,43435,CS), dobbleGame(3,CS, StackMode, 1000, G), 
% dobbleGameRegister("Gonzalo", G, GameOut), 
% dobbleGamePlay(GameOut,[spotIt, "Dobble", 2],GameOut2), 
% dobbleGameToString(GameOut2, String).

% CS = [[3, 2, 1], [4, 5, 1], [6, 7, 1], [4, 6, 2], [5, 7, 2], [4, 7, 3], [5, 6, 3]]
% Mode = StackMode 
% G = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: "], 3, "Partida en curso.", StackMode]
% GameOut = [["Area: "], ["Piezas Disponibles: "], 0, ["PlayersScore: "], ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% GameOut2 = [["Piezas Disponibles: "], 2|_890], [_900, "Piezas Disponibles: "], 1, ["PlayersScore: "], 
% ["Players: ", "Gonzalo"], 2, "Partida en curso.", StackMode]
% String = "Turno: \n1Numero de Jugadores: \n2Estado del Juego: \nPartida en curso."

% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
/*
  ___ _           _     _    ___  __     _ _          
 | __(_)_ _    __| |___| |  / __|/_/  __| (_)__ _ ___ 
 | _|| | ' \  / _` / -_) | | (__/ _ \/ _` | / _` / _ \
 |_| |_|_||_| \__,_\___|_|  \___\___/\__,_|_\__, \___/
                                            |___/     
*/
	     
% ----------------------------------------------------
% ----------------------------------------------------
% ----------------------------------------------------
