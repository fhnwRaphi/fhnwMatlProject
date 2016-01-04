classdef GameStates < handle
%%  Class Header
%
%   Class Name: GameParameter.m
%   Call: name = GameParameter()
%
%   Zweck: In der Instanz dieser Klasse werden alle vom Spieler
%   nicht ver�nderbaren (Konstanten) Parameter gespeichert. 
%   Die Modifikation der Parameter erfolgt durch den Programmierer
%   Weiter dient die Instanz dieser Klasse zum speichern aller
%   Prommablaufsteurungs releveanter Variablen
%
%% Changelog
% Version 00.00.01  07.10.15  Raphael Waltensp�l    Erstellt des Main
% Objekts, noch nicht Objekt Orientiert.
% Version 00.00.11  28.10.15  Joel Koch Code Aufger�umt
% Version 00.01.00  22.11.15  Raphael Waltensp�l    Umbau in
% Objektoriert erfogt
% Version 00.01.02  10.12.15  Raphael Waltensp�l   Neu Erstellen der
% Handle Classes GameParameter, Gamestates, Wether
% Version 00.01.10  01.01.16  Raphael Waltensp�l   Neu Entwickeln der
% Buttons / Game Mode Taktik in Figure
% Version 00.01.11  02.01.16  Raphael Waltensp�l   Aufr�umen fertigstellen
% Gameablauf
% Version 01.00.00b  03.01.16  Raphael Waltensp�l   Buglist Testen
% Kommentieren Dokumentieren
%
%%  Input und Output: f�r Methoden, siehe Methoden
%   Konstruktor:   void
%   Precondition:  
%
%   Postcondition: Ein GameStates Instanz ist erstellt
%   
%	Variables:
%       F�r Instanzvariabeln siehe Properties
%
%%   Implementierte Methoden
% this = GameStates()
% this = setMenueProccessed(this, state)
% state = getProcessState(this)
% [] = setPlayerInGame(this, number)
% [playerInGame] = decreasePlayerInGame(this)
% [playerInGame] = getPlayerInGame(this)
% [] = setActualPlayer(this,number)
% [actPlayer] = getActualPlayer(this)     
% [] = nextPlayer(this, GameParameter, PlayerArray)
% [gameRound] = getGameRound(this)
% [gameRound] = nextGameRound(this, GameParameter)
%
%% Buglist TODO / this
%
    properties (GetAccess = public)
           
           FONT = 'Courier';    % Sans Schriftart f�r Ganzes Spiel 
           FONT_SERIF = 'Times New Roman'; % Serif Schriftart f�r Ganzes Spiel 
           TITLE_SIZE = 19;     % Textgr�sse f�r Titel
           TEXT_SIZE = 15;      % Textgr�sse Standard
           TEXT_SIZE_SMALL = 15; % Textgr�sse Klein
           TEXT_SIZE_TINY = 13;  % % Textgr�sse sehr Klein
           
           TITLE_COLOR = [.0,.1,.8]; % Titelfarbe
           GREEN = [.01, .5, .01];   % Stadnard Gr�n
           HOVER_GREEN = [.01, .7, .01] % Stadnard Gr�n f�r Hovereffekt Momentan nicht verwendet
           BLACK = [.01, .01, .01]; % Stadnard Schwarz
           BACK_BLACK = [.01, .01, .01]; %% Schwarz f�r Hintergrund
           RED = [0.8,0.1,0.15]; % Stadnard Rot
           ORANGE = [0.9,0.4,0.1]; % Stadnard Orange
           YELLOW = [0.9,0.9,0.1]; % Stadnard Gelb
           MAGENTA = [1,0,1]; % Stadnard Magenta
           SKY = [0.6 0.9 1]; % Hellblau Himmel
                                            
           varScreenSize = get(0,'ScreenSize'); % Bildschirmgr�ssen
           SCREEN_WIDTH; % Bildschirmbreite
           SCREEN_HIGH; % Bildschirmh�he
                      
           MENUE_HIGH;  % Menue h�he
           MENUE_WIDTH;  % Menue breite
           MENUE_POSITION;  % Menue position
           
           GAME_HIGH;  % Spiel h�he
           GAME_WIDTH;  % Spiel breite
           GAME_POSITION; % Spiel position
    end
    
    properties (Access = private)
      %% Mit folgenden Parameter wird der Status des Programess Beschrieben
      % Anmerkung. Statemacheen wurde noch nicht weiter verfolgtt. F�r
      % Komplexere Versionen des Programmes vorgesehen
      menueProcessed = 0;
      
      actualPlayer = 1; % Spieler Welcher Am zug ist
      playerInGame; % Anzahl Spieler welcher noch im Spiel verbliben sins
      
      gameRound = 1; % Die Aktuelle Spielrunde
    end
    
    methods
        function this = GameStates()
            
            %% GameState Konstruktor 
            % Zweck: Instanz von GameStates ist erzeugt
            %
            % Pre:  
            %
            % Post: GameStates ist erstellt
            %
            % Input:void
            %
            % Output: Instanz GameState
            %
            % Modifizierte Instanzvariable
            % this.SCREEN_WIDTH
            % this.SCREEN_HIGH
            % this.MENUE_HIGH
            % this.MENUE_WIDTH
            % this.MENUE_POSITION
            % this.GAME_HIGH
            % this.GAME_WIDTH
            % this.GAME_POSITION
            %
           this.SCREEN_WIDTH = this.varScreenSize(3);
           this.SCREEN_HIGH = this.varScreenSize(4);
                                                         
           this.MENUE_HIGH = this.SCREEN_HIGH/8*5;
           this.MENUE_WIDTH = this.MENUE_HIGH/8*5;
           
           this.MENUE_POSITION = [this.SCREEN_WIDTH/2-this.MENUE_WIDTH/2, ...
               this.SCREEN_HIGH/2 - this.MENUE_HIGH/2,this.MENUE_WIDTH, this.MENUE_HIGH];
           
           this.GAME_HIGH= this.varScreenSize(4);
           this.GAME_WIDTH= this.varScreenSize(3);
           
           this.GAME_POSITION = [ 0, 0, this.GAME_WIDTH, this.GAME_HIGH];
        end
        %% GameState setMenueProccessed 
        % Zweck: Setter zum setzen des Menue States
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Menustate ist gesetzt
        %
        % Input: state -- sztatus des menues
        %
        % Output: Instanz GameState
        %
        % Modifizierte Instanzvariable
        %   this.menueProcessed
        %
        function this = setMenueProccessed(this, state)
            this.menueProcessed = state;
        end
        %% GameState getProcessState      
        % Wird noch nicht verwendet
        % Zweck: Getter f�r die Statemachine
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Status ist zur�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %
        % Output: state -- Programmstatus ist zur�ckgegebn
        %
        function state = getProcessState(this)
            state = this.menueProcessed;
        end
        %% GameState setPlayerInGame 
        % Zweck: Setter f�r die Anzahl Spieler im Spiel
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Anzahl Spieler ist gesetzt
        %
        % Input: number -- Anzahl Spieler
        %
        % Output: void
        %
        % Modifizierte Instanzvariable
        %   this.playerInGame
        %
        function [] = setPlayerInGame(this, number)
            this.playerInGame = number ;
        end
        %% GameState decreasePlayerInGame
        % Zweck: Reduziert die Aktuelle anzahl Spieler im Spiel und giebt
        % die neue Anzahl an Spieler zur�ck.
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Anzahl Spieler ist reduziert, die neue ANzahl ist
        % zur�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %
        % Output: playerInGame -- neue Anzahl an Spilern
        %
        % Modifizierte Instanzvariable
        %   this.playerInGame
        %
        function [playerInGame] = decreasePlayerInGame(this)
            this.playerInGame = this.playerInGame - 1;
            playerInGame = this.playerInGame;
        end 
        %% GameState getPlayerInGame      
        % Zweck: Getter f�r Anzahl Spieler im Spiel
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Anzahl Spieler ist zur�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %
        % Output: playerInGame -- Anzahl Spieler welche noch im Spiel sind
        %
        function [playerInGame] = getPlayerInGame(this)
            playerInGame = this.playerInGame;
        end 
        %% GameState setActualPlayer 
        % Zweck: Setter f�r Aktuellen Spieler
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Aktueller Spieler ist gesetzt
        %
        % Input: number -- Aktueller Spieler
        %
        % Output: void
        %
        % Modifizierte Instanzvariable
        %   this.actualPlayer
        %
        function [] = setActualPlayer(this,number)
            this.actualPlayer = number;
        end
        %% GameState getActualPlayer      
        % Zweck: Getter f�r Aktuellen Spieler
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Aktueller Spieler ist zur�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %
        % Output: actPlayer -- Aktueller Spieler
        %
        function [actPlayer] = getActualPlayer(this)
           actPlayer = this.actualPlayer;
        end
        %% GameState nextPlayer      
        % Zweck: Stellt den n�chsten Spieler welchernoch �ber lebenspunkte
        % verf�gt ein
        %
        % Pre: Instanz GameState ist erstellt
        % Instanz GameParameter ist erstellt
        % Instanz Player in PlayerArray sind erstellt
        %
        % Post: der n�chste Spieler ist eingestellt 
        %
        % Input: Instanz GameState, instanzvariabeln
        %  GameParameter --
        %  Player --
        %
        % Output: void
        %
        % Modifizierte Instanzvariable
        %   this.actualPlayer --
        %
        function [] = nextPlayer(this, GameParameter, PlayerArray)
            
            if GameParameter.playerQuantety == this.actualPlayer
                this.actualPlayer = 1;
            else
                this.actualPlayer = this.actualPlayer + 1;
            end
            watchdog = 0;
            while PlayerArray(this.actualPlayer).livePoints <= 0 || watchdog < 2 * GameParameter.playerQuantety 
                if GameParameter.playerQuantety == this.actualPlayer
                    this.actualPlayer = 1;
                else
                    this.actualPlayer = this.actualPlayer + 1;
                end
                watchdog = watchdog + 1;
            end
        end
        %% GameState getGameRound      
        % Zweck: Getter f�r Spielrunde
        %
        % Pre: Instanz GameState ist erstellt
        %
        % Post: Spielrunde ist zur�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %
        % Output: gameRound -- Aktuelle Spielrunde
        %
        function [gameRound] = getGameRound(this)
            gameRound = this.gameRound;
        end
        %% GameState nextGameRound      
        % Zweck: Stellt die n�chste Spielrunde ein
        %
        % Pre: Instanz GameParameter und GameState ist erstellt
        %
        % Post: neue Spielrunde ist eingestellt
        % Aktuelle Spielrunde ist zr�ckgegeben
        %
        % Input: Instanz GameState, instanzvariabeln
        %        GameParameter
        %
        % Output: gameRound -- Aktuelle Spielrunde
        %
        % Modifizierte Instanzvariable
        %   this.gameRound --
        %
        function [gameRound] = nextGameRound(this, GameParameter)
            this.gameRound = this.gameRound + 1;
            if  this.gameRound > GameParameter.numberRounds
                this.gameRound = 'End';
            end
            gameRound = this.gameRound;
        end
        
    end
end

