%========================================================================
% This file contains methods, logic, and code in order to run the
% 'Princess vs. Dragons' program required for Assignment 5 in AUCSC 370.
% The user is prompted to select a board size then navigate around the
% randomly places dragons in order to reach the edge of the board.
%
% Class: AUCSC 370
% Name: Zachary Kelly
% Student ID: 1236421
% Date: November 29th, 2022
%========================================================================

%!=================================NOTE=================================!%
% This program is started by typing 'start.' into the SWI-Prolog console
%!======================================================================!%

%========================================================================
% boardX(Board).
%
% Board -> The variable name that the board of size x will be
%         assigned to.
%
% Creates a board the size of X where X can be any size from 4 - 10.
% The generated board is then assigned to the variable board which
% can be whatever name that is input.
%========================================================================

board4([['--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------']]).

board5([['--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------']]).

board6([['--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------']]).

board7([['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------']]).

board8([['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------']]).

board9([['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
        ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------']]).

board10([['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------'],
         ['--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------', '--------']]).

%========================================================================
% start.
%
% Wrapper for the game, starts the program when called.
%========================================================================

start :-
    welcomeMessage.

%========================================================================
% welcomeMessage.
%
% Prints a welcome message explaining the game to the user, calls
% getBoardSize to get user input.
%========================================================================

welcomeMessage :-
    write("--------------------------------------------------------------------------------------"), nl, nl,
    write("You are the PRINCESS! You must escape the EVIL DRAGONS!"), nl,
    write("Thankfully these DRAGONS are STUPID, they can't even move!"), nl,
    write("Navigate around the DRAGONS to the edge of the board where the water is to WIN!"), nl, nl,
    write("You can move with the following commands:"), nl, nl,
    write("Enter 'L' or 'l' for left."), nl,
    write("Enter 'R' or 'r' for right."), nl,
    write("Enter 'U' or 'u' for up."), nl,
    write("Enter 'D' or 'd' for down."), nl, nl,
    write("Any word or phrase that starts with those letters will move you in that direction!"), nl,
    write("Don't put any spaces before your answer though, or it won't be accepted!"), nl, nl,
    write("--------------------------------------------------------------------------------------"), nl, nl,
    getBoardSize.

%========================================================================
%getBoardSize.
%
%Gets from the user the size of the board they wish to play on, calls
%boardSize to verify the size is within acceptable parameters.
%========================================================================

getBoardSize :-
    write('What size do you want your game board to be: '),
    get0(Size),
    myFlush(Size, [], Array),
    boardSize(Array).

%========================================================================
% myFlush(Input, Array, NewArray).
%
% Input ->  Assumed to be a single character (as ascii), will be checked
%          to see if newline, if not will be added to Array.
% Array -> Assumed to given as an empty list when myFlush first called,
%          will have non-newline characters appended to it.
% NewArray -> The array that will be pattern matched to Array when
%             myFlush detects a newline character.
%
% Takes a character, an array, and a second array to be pattern
% matched. Iterates through the buffer untill a newline character is
% detected, appending all non-newline character into Array up to the
% newline character at which point it pattern matches Array and
% NewArray. Assumes that a newline character will be the final character
% in the buffer.
% ========================================================================

myFlush(Input, Array, NewArray) :-
    Input \== 10, %If we haven't reacher newline (an input of enter) then keep getting characters
    append(Array, [Input], X),
    get0(NewInput),
    myFlush(NewInput, X, NewArray).

myFlush(10, Array, Array). %Reached newline(an input of enter) so stop and pattern match the arrays together.

%========================================================================
% boardSize(Size).
%
% Size -> The size of board the user input in getBoardSize.
%
% Checks to make sure that the users input of what size board they wish
% to play on is within accetable parameters. Calls getEmptyBoard if size
% is correct, otherwise calls getBoardSize to get another input.
%========================================================================

boardSize(Size) :-
                     % 4     5     6     7     8     9     10
    not(member(Size, [[52], [53], [54], [55], [56], [57], [49, 48]])),
    nl, write('Please Choose a number between 4 and 10 (inclusive)'), nl, nl,
    getBoardSize.

boardSize([52]) :- %4
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board4(Board),
    placeDragon(Board, 0, 0, 4, 2, []).

boardSize([53]) :- %5
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board5(Board),
    placeDragon(Board, 0, 0, 5, 2, []).

boardSize([54]) :- %6
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board6(Board),
    placeDragon(Board, 0, 0, 6, 3, []).

boardSize([55]) :- %7
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board7(Board),
    placeDragon(Board, 0, 0, 7, 3, []).

boardSize([56]) :- %8
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board8(Board),
    placeDragon(Board, 0, 0, 8, 4, []).

boardSize([57]) :- %9
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board9(Board),
    placeDragon(Board, 0, 0, 9, 4, []).

boardSize([49, 48]) :- %10
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    board10(Board),
    placeDragon(Board, 0, 0, 10, 5, []).

%========================================================================
% placeDragon(Board, Row, Col, Size, PrincessPosition, DragonPositions).
%
% Board -> The board to be played on, assumed to be a 2D array.
% Row -> The row position being looked at, assumed to be an integer.
% Col -> The column position being looked at, assumed to be an integer.
% Size -> The size of the board, assumed to be an integer.
% PrincessPosition -> The row and column position of where the princess
%                     will be placed. Assumed to be an integer.
% DragonPositions -> The array that will hold the [row, col] positions
%                    of all the dragons placed on the board. Assumed to
%                    be an empty list when placeDragon is first called.
%
% Wrapper for placeDragonHelper, resets the random number used to
% determine whether a dragon is placed or not for every index in board.
%========================================================================

placeDragon(Board, Row, Col, Size, PrincessPosition, DragonPositions) :-
    Rand is random(20), %Generates a number from 0 - 19
    placeDragonHelper(Board, Rand, Row, Col, Size, PrincessPosition, DragonPositions).

%========================================================================
% placeDragonHelper(Board, Rand, Row, Col, Size, PrincessPosition,
%                   DragonPositions).
%
% Board -> The board to be played on, assumed to be a 2D array.
% Rand -> A integer that will be used to determine if a dragon is placed
%         on the board or not. Assumed to be an interger between 0
%         and 19.
% Row -> The row position being looked at, assumed to
%        be an integer.
% Col -> The column position being looked at, assumed to be an integer.
% Size -> The size of the board, assumed to be an integer as well as 1
%         larger then largest index of Board.
% PrincessPosition -> The row and column position of where the princess
%                     will be placed. Assumed to be an integer.
% DragonPositions -> The array that will hold the [row, col] positions
%                    of all the dragons placed on the board.
%
% Takes a board and iterates through all indexes of the board, using
% Rand to determine if a dragon is placed (if rand is less then 5 a
% dragon will be placed). When all indexes have been iterated through
% (row and column are both equal to size) it will place the princess at
% [PrincessPostion, PrincessPostion] and call getDirection.
%========================================================================

placeDragonHelper(Board, Rand, Row, Col, Size, PrincessPosition, DragonPositions) :-
    Rand =< 4, %Rand is less then 5 and we are still within the bounds of the board so a dragon will be placed
    Row < Size,
    Col < Size,
    replace(Board, Row, Col, _, '-DRAGON-', NewBoard),
    append(DragonPositions, [[Row, Col]], X),
    NewCol is Col + 1,
    placeDragon(NewBoard, Row, NewCol, Size, PrincessPosition, X).

placeDragonHelper(Board, Rand, Row, Col, Size, PrincessPosition, DragonPositions) :-
    Rand >= 5, %Rand is between 5 - 19 so no dragon will be placed
    Col < Size,
    NewCol is Col + 1,
    placeDragon(Board, Row, NewCol, Size, PrincessPosition, DragonPositions).

placeDragonHelper(Board, _, Row, Col, Size, PrincessPosition, DragonPositions) :-
    Col == Size, %Iterated through all the columns in a row so move onto next row
    NewRow is Row + 1,
    placeDragon(Board, NewRow, 0, Size, PrincessPosition, DragonPositions).

placeDragonHelper(Board, _, Row, _, Size, PrincessPosition, DragonPositions) :-
    Row == Size, %Reached the end of the board so place princess in the 'middle' of the board
    replace(Board, PrincessPosition, PrincessPosition, _, 'PRINCESS', NewBoard),
    deletePrincessPosition([PrincessPosition, PrincessPosition], DragonPositions, NewDragonPositions),%Remove any dragon
    getDirection(NewBoard, PrincessPosition, PrincessPosition, Size, NewDragonPositions).          %placed at the middle

%========================================================================
% deletePrincessPosition(PrincessPostion, DragonPostions,
%                        NewDragonPositions).
%
% PrincessPosition -> The [row, col] postion of where the princess
%                     should be placed. Assumed to be an array of size
%                     two where index 0 is equal to index 2.
% DragonPositions -> An array holding all the positions that dragons
%                    have been placed on the board. Assumed to be a 2d
%                    array containing [row, col] positions of each
%                    dragon.
% NewDragonPositions -> The array to be pattern matched to
%                       DragonPositions.
%
% Takes the postion the princess will be placed and removes it from the
% list of where dragons have been placed on the board.
%========================================================================

deletePrincessPosition(_, [], []). %We have gone through the list and removed all instances of PrincessPostion

deletePrincessPosition(PrincessPostion, [PrincessPostion | OldListRest], NewList) :- %If PrincessPosition is in the oldList,
    deletePrincessPosition(PrincessPostion, OldListRest, NewList).                   %continue without including it

deletePrincessPosition(PrincessPostion, [First | OldListRest], [First | NewListRest]) :- %If PrincessPosition not equal to
    PrincessPostion \= First,                                                            %first, continue looking through
    deletePrincessPosition(PrincessPostion, OldListRest, NewListRest).                   %the list

%========================================================================
% getDirection(Board, PRow, PCol, Size, DragonPostions).
%
% Board -> Assumed to be a 2D array containing the board being played
%          on.
% PRow -> The current row position of the princess. Assumed to be an
%         integer.
% PCol -> The current column position of the princess. Assumed to be an
%         integer.
% Size -> The size of the game board. Assumed to be an integer as well
%         as 1 larger then the largest index of board.
% DragonPositions -> An array holding all the positions that dragons
%                    have been placed on the board. Assumed to be a 2d
%                    array containing [row, col] positions of each
%                    dragon.
%
% Takes the board and current postion of the princess and:
%       1. Compares the princesses position against DragonPostions to
%          see if princess has hit a dragon, at which point gameLost is
%          called.
%       2. Compares the princesses position to see if it is outside the
%          bounds of the board at which point gameWon is called.
%       3. If neither of 1 or 2 are true then gets from the user the
%          direction they wish to move the princess and calls
%          movePrincess
%========================================================================

getDirection(Board, PRow, PCol, Size, DragonPositions) :-
    PRow \== Size, %User has moved the princess to a blank game tile
    PRow \== -1,
    PCol \== Size,
    PCol \== -1,
    not(member([PRow, PCol], DragonPositions)),
    print2D(Board),
    write('What direction do you want to move: '),
    get0(Direction),
    myFlush(Direction, [], DirectionArray),
    movePrincess(Board, PRow, PCol, DirectionArray, Size, DragonPositions).

getDirection(Board, PRow, PCol, _, DragonPositions) :-
    member([PRow, PCol], DragonPositions), %User has moved the princess into a dragon position
    replace(Board, PRow, PCol, _, '-YUMYUM-', NewBoard),
    print2D(NewBoard),
    gameLost.

getDirection(Board, PRow, PCol, Size, _) :-
    PRow == -1,          %User has moved the princess off the top of the board.
    NewPRow is PRow + 1, %PRow not included in function as it needs to be worked on/for readability
    replace(Board, NewPRow, PCol, Size, '--------', NewBoard),
    print2D(NewBoard),
    gameWon.

getDirection(Board, PRow, PCol, Size, _) :-
    PRow == Size,        %User has moved the princess off the bottom of the board.
    NewPRow is PRow - 1, %PRow not included in function as it needs to be worked on/for readability
    replace(Board, NewPRow, PCol, Size, '--------', NewBoard),
    print2D(NewBoard),
    gameWon.

getDirection(Board, PRow, PCol, Size, _) :-
    PCol == -1,          %User has moved the princess off the left of the board.
    NewPCol is PCol + 1, %PRow not included in function as it needs to be worked on/for readability
    replace(Board, PRow, NewPCol, Size, '--------', NewBoard),
    print2D(NewBoard),
    gameWon.

getDirection(Board, PRow, PCol, Size, _) :-
    PCol == Size,        %User has moved the princess off the right of the board.
    NewPCol is PCol - 1, %PRow not included in function as it needs to be worked on/for readability
    replace(Board, PRow, NewPCol, Size, '--------', NewBoard),
    print2D(NewBoard),
    gameWon.

%========================================================================
% movePrincess(Board, PRow, PCol, DirectionArray, Size, DragonPostions).
%
% Board -> Assumed to be a 2D array containing the board being played
%          on.
% PRow -> The current row position of the princess. Assumed to be an
%         integer.
% PCol -> The current column position of the princess. Assumed to be an
%         integer.
% DirectionArray -> An array containing the input the user gave
%                   regarding which direction they wish to move. Assumed
%                   to contain only integers that will be treated as
%                   ascii, will have only the first index used.
% Size -> The size of the game board. Assumed to be an integer as well
%         as 1 larger then the largest index of board.
% DragonPositions -> An array holding all the positions that dragons
%                    have been placed on the board. Assumed to be a 2d
%                    array containing [row, col] positions of each
%                    dragon.
%
% Takes the direction the user wished to move and checks to see if it is
% acceptable input. If it is not, getDirection is called to get another
% input, otherwise PRow or PCol is modified depending on the user input
% and then sent to getDirection.
%========================================================================

movePrincess(Board, PRow, PCol, [Direction | _], Size, DragonPositions) :-
                         %  l    L   r    R   u    U   d    D
    not(member(Direction, [108, 76, 114, 82, 117, 85, 100, 68])),
    nl, write("Sorry that input wasn't accepted, please try again\n\n"),
    write("--------------------------------------------------------------------------------------"), nl, nl,
    getDirection(Board, PRow, PCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [], Size, DragonPositions) :- %If user just pressed enter for input
    nl, write("Sorry that input wasn't accepted, please try again\n\n"),
    write("--------------------------------------------------------------------------------------"), nl, nl,
    getDirection(Board, PRow, PCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [108 | _], Size, DragonPositions) :- %l
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPCol is PCol - 1,
    replace(Board, PRow, NewPCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, PRow, NewPCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [76 | _], Size, DragonPositions) :- %L
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPCol is PCol - 1,
    replace(Board, PRow, NewPCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, PRow, NewPCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [114 | _], Size, DragonPositions) :- %r
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPCol is PCol + 1,
    replace(Board, PRow, NewPCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, PRow, NewPCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [82 | _], Size, DragonPositions) :- %R
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPCol is PCol + 1,
    replace(Board, PRow, NewPCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, PRow, NewPCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [117 | _], Size, DragonPositions) :- %u
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPRow is PRow - 1,
    replace(Board, NewPRow, PCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, NewPRow, PCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [85 | _], Size, DragonPositions) :- %U
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPRow is PRow - 1,
    replace(Board, NewPRow, PCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, NewPRow, PCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [100 | _], Size, DragonPositions) :- %d
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPRow is PRow + 1,
    replace(Board, NewPRow, PCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, NewPRow, PCol, Size, DragonPositions).

movePrincess(Board, PRow, PCol, [68 | _], Size, DragonPositions) :- %D
    nl, write("--------------------------------------------------------------------------------------"), nl, nl,
    NewPRow is PRow + 1,
    replace(Board, NewPRow, PCol, Size, 'PRINCESS', NewBoard),
    replace(NewBoard, PRow, PCol, Size, '--------', FinalBoard),
    getDirection(FinalBoard, NewPRow, PCol, Size, DragonPositions).

%========================================================================
% gameWon.
%
% Called when the user has moved the princess off the board. Prints a
% message congratulating the user for winning then calls playAgain.
%========================================================================

gameWon :-
    nl,
    write("The PRINCESS has escaped!\n\n"),
    write("YOU WIN!\n\n"),
    playAgain.

%========================================================================
% gameLost.
%
% Called when the user has moved the princess into a dragon. Prints a
% message chastising the user for losing such a simple game then calls
% playAgain.
%========================================================================


gameLost :-
    nl,
    write("You somehow managed to run into a completely avoidable DRAGON!\n"),
    write("The DRAGON gobbles you up. YUM YUM!\n\n"),
    playAgain.

%========================================================================
% playAgain.
%
% Asks the user if they wish to play again, then passes the user input
% to playAgainHelper to see if input was acceptable.
%========================================================================

playAgain :-
    write('Do you wish to play again? (y/n): '),
    get(Answer),
    myFlush(Answer, [], Array),
    playAgainHelper(Array).

%========================================================================
% playAgainHelper(Answer).
%
% Answer -> The input the user gave regarding whether they wish to play
%           again or not. Assumed to be a list of integers with each
%           integer representing an ascii character.
%
% Takes the input the user gave regarding whether they wish to play
% again or not and compares it against acceptable answers. If not
% acceptable, calls playAgain to get another answer. Calls
% start. if the user wants to play again, else calls nothing (at which
% point the program will recurse out of all the methods waiting to be
% recursed out of) and the program will end.
%========================================================================

playAgainHelper(Answer) :-
                       %  y     Y      YES           Yes            yes         n     N     NO        No         no
    not(member(Answer, [[121], [89], [89,69,83], [89,101,115], [121,101,115], [110], [78], [78,79], [78,111], [110,111]])),
    write("Sorry that input wasn't accepted, please try again\n\n"),
    playAgain.

playAgainHelper([121]) :- %y
    nl,
    start.

playAgainHelper([89]) :- %Y
    nl,
    start.

playAgainHelper([89,69,83]) :- %YES
    nl,
    start.

playAgainHelper([89,101,115]) :- %Yes
    nl,
    start.

playAgainHelper([121,101,115]) :- %yes
    nl,
    start.

playAgainHelper([110]) :- %n
    write('Thanks for playing!').

playAgainHelper([78]) :- %N
    write('Thanks for playing!').

playAgainHelper([78,79]) :- %NO
    write('Thanks for playing!').

playAgainHelper([78,111]) :- %No
    write('Thanks for playing!').

playAgainHelper([110,111]) :- %no
    write('Thanks for playing!').

%========================================================================
% replace(Board, Row, Col, Size, Replacement, NewBoard).
%
% Board -> Assumed to be a 2D array containg the board being played on.
% Row -> The current row position of the princess. Assumed to be an
%        integer.
% Col -> The current col position of the princess. Assumed to be an
%        integer.
% Size -> The size of the board. Assumed to be an integer as well as 1
%         larger then the largest index of board.
% Replacement -> What will be put into the board at the given [row,col].
%                Assumed to be a string.
% NewBoard -> The array that will be pattern matched to Board with
%             Replacement placed at the given [row, col].
%
% Takes a board, a [row, col] postion and a string to be placed at the
% [row, col]. Iterates through the given board, while pattern matching
% with NewBoard, untill it reaches the [row, col] index, then places
% replacement at said position in NewBoard.
%
% I found help and guidence in creating this method at:
% https://stackoverflow.com/questions/26719774/replacing-elements-in-list-of-lists-prolog
% Credit to user Nicholas Carey.
%========================================================================

replace([First | Rest], 0, Col, _, Replacement, [RowToBeChanged | Rest]) :- % Found the specific row needed
  replaceColumn(First, Col, Replacement, RowToBeChanged).

replace([First | OldBoardRest], Row, Col, _, Replacement, [First | NewBoardRest]) :- %Assuming Row is positive, and we haven't
  Row > 0,                                                                           %reached 'Col = 0' Decrement Col and call
  NewRow is Row - 1,                                                                 %replace with NewRow and the rest of both
  replace(OldBoardRest, NewRow, Col, _, Replacement, NewBoardRest).                  %boards.

replace(Board, _, -1, _, _, Board).      %Row is equal to -1 / we are off the board no replace should happen

replace(Board, -1, _, _, _, Board).      %Col is equal to -1 / we are off the board no replace should happen

replace(Board, _, Size, Size, _, Board). %Col is equal to size / we are off the board no replace should happen

replace(Board, Size, _, Size, _, Board). %Row is equal to size / we are off the board no replace should happen

replaceColumn([_ | Rest], 0, Replacement, [Replacement | Rest]). %once we area at the specified column, pattern match
                                                                 %with the 'replacement'

replaceColumn([First | OldBoardRest], Col, Replacement, [First | NewBoardRest]) :-  %Assuming Col is positive, and we haven't
  Col > 0 ,                                                                         %reached 'Col = 0' Decrement Col and call
  NewCol is Col - 1 ,                                                               %replaceColumn with NewCol and the rest of
  replaceColumn(OldBoardRest, NewCol, Replacement, NewBoardRest).                   %both boards.

%========================================================================
% print2D(Grid).
%
% Grid -> The item to be printed. Assumed to be a 2D array.
%
% Prints out a lists of lists to standard output so it looks 2
% dimensional. Taken from the AUCSC 370 lab on November 21st, 2022.
%========================================================================

print2D([]) :- nl.

print2D([FirstRow | Rest]) :-
    printRow(FirstRow),
    print2D(Rest).

%========================================================================
% printRow(ARow).
%
% ARow -> The item to be printed. Assumed to be single level array.
%
% Helper to print2D, used to print a single row of a 2D board. Taken
% from the AUCSC 370 lab on November 21st, 2022.
%========================================================================

printRow([]) :- nl.

printRow([Item | Rest]) :-
    writef("%7c", [Item]), %field width of 7, centered
    printRow(Rest).


