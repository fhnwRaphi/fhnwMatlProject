function [] = Artillery()
%% Matlab function:  Artillery.m
%
% Zweck:
%   Rootprogarmm des Matlapprojektes "Spiel Artillery"
%   Steuert den Programmablauf
%   Ertellt alle ben�tigten Instanzen

%% Changelog
% Hier sind die Commits des ganzen Projektes aufgef�hrt. Diese wurden aus
% dem Github �bernommen. Die f�r die jeweilige Klasse Relevanten Versionen
% sind in der Klasse oim Speziellen aufgef�hrt. Diese �nderungsliste dient
% lediglich der Dokumentation des Projektes. Gearbeitet wird mit den Git
% Commits,
% Version 00.00.01  07.10.15  Raphael Waltensp�l    Erstellt des Main
% Objekts, noch nicht Objekt Orientiert.
% Version 00.00.03  15.10.15  Joel Koch             Panzer erstellt
% Version 00.00.04  16.10.15  Joel Koch             Erstes Gui entworfen
% Version 00.00.05  17.10.15  Joel Koch             Lanschaft Algorithmus
% implementiert
% Version 00.00.06  18.10.15  Joel Koch             Powerbar implementiert
% Version 00.00.07  19.10.15  Joel Koch             Einschlag implementier
% Version 00.00.08  21.10.15  Raphael Waltensp�l    Flugparabel berechnung
% erster entwur
% Version 00.00.09  22.10.15  Raphael Waltensp�l    Koordinaten der
% Flugparabel berechnen und ausgeben
% Version 00.00.10  25.10.15  Joel Koch             Panzer Detailliert
% entworfn
% Version 00.00.11  28.10.15  Joel Koch Code Aufger�umt
% Version 00.00.12  28.10.15  Joel Koch Intersection implementiert
% Version 00.00.13  12.11.15  Raphael Waltensp�l    Menu zur eingabe von
% Parametern erstellt
% Version 00.01.00  22.11.15  Raphael Waltensp�l    Umbau in
% Objektoriert erfogt
% Version 00.01.01  12.11.15  Raphael Waltensp�l    Menu zur eingabe von
% Parametern erwiter auf Objektorientiert
% Version 00.01.02  10.12.15  Raphael Waltensp�l   Neu Erstellen der
% Handle Classes GameParameter, Gamestates, Wether
% Version 00.01.03  11.12.15  Raphael Waltensp�l   Neu Erstellen der
% Handle Classes Figure, Player
% Version 00.01.04  11.12.15  Raphael Waltensp�l   Implementieren der
% Funktionen des Landscapes in Handle Class Landscape
% Version 00.01.05  12.12.15  Raphael Waltensp�l   Implementieren der
% Funktione FligthPath in Handle Classes, 
% Version 00.01.05  20.12.15  Raphael Waltensp�l   Implementieren der
% Funktione Panzer in Player, neu Panzer Farbe, Intersection in Figure,
% Version 00.01.06  28.12.15  Raphael Waltensp�l   Trefferermittlung
% Version 00.01.07  30.12.15  Raphael Waltensp�l   Artillery Ablauf
% Version 00.01.08  31.12.15  Raphael Waltensp�l   Trefferermittlung
% Version 00.01.09  31.12.15  Raphael Waltensp�l   Implementieren der
% Funktione Powerbar und Eventhandler in Figure,
% Version 00.01.10  01.01.16  Raphael Waltensp�l   Neu Entwickeln der
% Buttons / Game Mode Taktik in Figure
% Version 00.01.11  02.01.16  Raphael Waltensp�l   Aufr�umen fertigstellen
% Gameablauf
% Version 01.00.00b  03.01.16  Raphael Waltensp�l   Buglist Testen

% Kommentieren Dokumentieren
%
%% Inputs und Outputs: Keine
%
% Preconditions:
% Matlab 2015b

% Postconditions:
% keine

%% Innerhalb der Funktion Artillery zug�ngliche Variablen
% Variabeln
%   iCount      -- Schleifenz�hlvariable    (double)
%   pk          -- Schleifenz�hlvariable    (double)
%   player()    -- Array welcher alle Player Instanzen enh�lt ([]Player)
%   terrain     -- Lanschaftsarray ([]double)
%	tank        -- Tankarray ([double,double])
%   windShape   -- windshape handler (objektHandler)
%   roundEnd    -- Variable f�r Programmsteuerung {0= Runde L�ft 1= Runde Beendet}
%   fire        -- Variable f�r Programmsteuerung {0= Schuss nicht erfolgt 1= Schuss erfolgt}
%   power       -- Variable f�r Schussenergie (double)
%   angle       -- ariable f�r Schusswinkel in Grad (double)
%   powertimer  -- Timer f�r Power, wie lange wurde die Maus gedr�ckt... (double)
%   coordinate  -- Array mit den flugbahnkoordinaten ([x,y] Double)
%   terrain     -- Array mit den Terrainkoordinaten ([x,y] Double) 1002 length
%
% Erstellte Instanzen
%   param       -- ent�lt alle Benutzereinstellungen    (GameParameter)
%   state       -- enth�lt alle Spielkontrollvariabeln  (GameStates)
%   screen      -- Intsatnz des Menu                    (Figure)
%   player(x)   -- Instanz eines Spieler                (Player)
%   gameScreen  -- Instanz des Spielfeldes              (Figure)
%   lndsc       -- Instanz Landscape erzeugen           (Landscape)
%   weth        -- Instanz Wetter                       (Wether)
%   shot        -- Instanz der Flugbahn                 (FlightPath)
%
%%   Verwendete Instanz Variablen 
%   param.playerQuantety -- Ent�lt die Anzahl der Mitspieler (double)
%   param.numberRounds -- Enth�lt die anzahl gew�nschter spielrunden (double)
%   param.numberMode -- Enth�lt Wert f�r Taktik oder Geschiklichkeit {1=T/2=G}
%
%   gameScreen.fireEvent -- variable f�r Programmsteuerung {0= Schuss nicht erfolgt 1= Schuss erfolgt}
%   gameScreen.mousedown -- variable f�r Programmsteuerung {0= Maus nicht gedr�ckt1= Maus gedr�ckt}
%   gameScreen.mouseX    -- Xpoition der Maus auf dem Bildschirm
%   gameScreen.mouseY    -- Ypoition der Maus auf dem Bildschirm
%
%   player(x).tankHandler -- Enth�lt das tankhandler objekt
%   player(x).livePoints -- Enth�lt die Lebenspunkte eines Spielers
%   player(x).score --  Enth�lt die Siegespunkte eines Spielers
%
%   lndsc.terrainArray -- Enth�lt das Array der ALndschaft
%   
%%   Verwendete Instanz Methoden
%   screen.getFig()      -- gibt den figurehandler zur�ck (figure)
%   screen.drawMenue()   -- zeichnet das Menue ([])
%
%   state.getGameRound -- gibt die Aktuelle spielrunde zur�ck (double)
%   state.setPlayerInGame() -- Setzt die anzahl Spielern im Spiel
%   state.setActualPlayer() -- Setzt den Spiler welcher am zug ist.
%   state.nextPlayer() -- Setzt den Spiler welcher als n�chster am zug ist
%   unter ber�cksichtigung der aktuellen Lebenpunkte
%   state.decreasePlayerInGame -- Reduziert die Anzahl Spieler im Spiel
%   gibt die verbleibende Anzahl zur�ck (double)
%   state.getPlayerInGame() -- gibt die Verbleibende Anzahl Spieler zur�ck (double)
%   state.nextGameRound() -- n�chste Spielrunde, wenn nicht Maximum
%   erreicht, sonst game Ende
%
%   param.getStandardLivePoints --  gibt die standard Lebenspunkte zur�ck
%
%   gameScreen.drawGamescreen() -- Zeichnet das Spielfeld
%   gameScreen.drawInScreen() --Landschaft in Spielfeld Zeichnen
%   gameScreen.updateInScreen() --Landschaft in Spielfeld Updaten
%   gameScreen.drawPlayerPoints() --Zeichnet Die Aktuellen Punktest�nde
%   gameScreen.drawGameRound() --Zeichnet die Aktueller Runde
%   gameScreen.drawElementCol() -- [x,y]Array (Bsp. Tank) Zeichnen und
%   Handler Speichern Farbe wird Mitgegeben (patchobjekt Handler)
%   gameScreen.updateElementCol() --[x,y]Array (Bsp. Wind) Zeichnen, altes Objekt l�schen und
%   Handler Speichern Farbe wird Mitgegeben (patchobjekt Handler)
%   gameScreen.deleteElement() -- L�scht ein Spielelement
%   gameScreen.drawGameButtons() --Zeichnet die Spielbuttons f�r den Taktikmodus
%   gameScreen.drawPowerBar()  -- Zeichnet PowerBar f�r den Geschiklichkeitsmodus
%   gameScreen.drawActualPlayer -- Zeichnet den Text wer aktuell am Zug ist
%   gameScreen.getPower -- Auslesen der Schussenergie Taktik
%   gameScreen.getAngle -- Auslesen des Schusswinkels Taktik
%   gameScreen.updatePowerBar() -- der Powerbalken wird aktualisiert
%   gameScreen.drawImpactCircle() -- Zeichnet den einschalg und gibt das
%   Modifizierte Tarrainarray zur�ck.
%   gameScreen.getFig() -- gibt den Figurehandler zur�ck
%
%   player(x).genTank() -- Tank Berechnen ([])
%   player(x).posTank() -- Tank Positioniren ([])
%   player(x).getTank() -- Tank Variable ([x,y]Array)
%   player(x).getTankColor -- Farbe des Tanks erhalten ([r,g,b])
%   player(x).calcAngle -- Berechnet den Winkel in Grad relativ zur
%   Mausposition (double)
%
%   lndsc.getLandscape()      -- Landschaftarray erhalten ([]double) 
%   lndsc.genLandscape()      -- Landschaft berechnen ([])
%
%   weth.getWindShape         -- Pfeil Shape des Windes 
%   weth.getWindShapeColor    -- Farbe des Pfeilshapes
%
%   shot.calcCoordinates()    --
%   shot.isHit()              -- gibt die Trefferenergie 0, 100 zur�ck (double), 
%   momentan nur 100 sp�tere Versionen des Spiels k�nnen den Tank nur besch�digen 0 bis 99.
%
%   fig.delete                -- Matlab Methode, l�schen einer fig instanz
%         
%%   Verwendete Konstruktoren
%   GameParameter()
%   GameState()
%   Figure()
%   Player()
%   Landscape()
%   Wether()
%   FlightPath(); 
%      
%
%% Buglist TODO / Gesammtes Projekt
%   #1
%  In: coordinate = shot.calcCoordinates(power, angle , weth, lndsc, player(state.getActualPlayer));
%  Berechnen der Flugbahn
%  TODO: try catch entfernen
%  das Programm hat noch bugs mit den Arrays Landscape und
%  Flighpath zu vergleichen. Dies insbesonder wenn aus dem Bild
%  geschossen wird. Es kann ein IndexExceedsMatrixDimensions
%  Exeption geworfen werden. Behandelt wird diese momentran noch, in dem der n�chste Spielr am zug ist...
%   
%   #2
%  In: comet(coordinate(1,:),coordinate(2,:));
%  Zeichnet die Flugbahn des Geschossen
%  TODO: F�r kurze flugbahnen wird der Schuss sehr Langsam
%  gezeichnet.
%  Workaround erstellen
%


%% 01 Initialisieren des Spieles
% l�schen des Workspaces
clear;
close all;

param = GameParameter;      % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);  % Instanz Figure erzeugen
screen.drawMenue();             % Zeichen des Menues
waitfor(screen.getFig());       % Warten bis Menue geschlossen wird
 
%% 02 Spieler Erstellen
% in dieser Loop wird ein Array aller Spieler erzeugt
% Der Kontruktor Player() Ben�tigt folgende Variabeln
% iCount - Z�lvariable / Nummer des Spielers - (double)
% ['CrashTestDummy', #] - Name des Spieler / Plazhalter f�r sp�ter
% anpassung - (string)
% 'artillery' - Panzertyp / Plazhalter f�r sp�ter variable - (string)
% param - Spielparameter
for iCount = 1 : 1 : param.playerQuantety
    player(iCount) = Player(iCount, ['CrashTestDummy>> ', num2str(iCount)], 'artillery', param );
end
       
    
    %% 03 Start des Spieles
    % in der Folgenden Whileschleife verbleibt das Spiel bis alle
    % SpielRunden (ganzes Spiel) beendet wird.
    while state.getGameRound <= param.numberRounds
        
        %% Speilfeld Erzeugen
        gameScreen = Figure(state,param); % Instanz Figure erzeugen
        gameScreen.drawGamescreen(); % Spielfeld Zeichnen
        
        %% Hier wird der Status der aktuell noch im spielbefindlichen
        % Spieler gesetzt. Zu beginn des Spiels auf die Anzahl der
        % eingestellten Mitspieler
        state.setPlayerInGame(param.playerQuantety); 

        %% Landschaft Erzeugen und Zeichnen
        lndsc = Landscape(param); % Instanz Landscape erzeugen
        lndsc.genLandscape();       % Landschaft berechnen
        terrain =  lndsc.getLandscape(); % Lanschaftsarray erhalten
        gameScreen.drawInScreen(terrain);   % Landschaft in Spielfeld Zeichnen
        
        gameScreen.drawPlayerPoints(param, player); % Zeichnet Die Aktuellen Punktest�nde
        gameScreen.drawGameRound(param, state); % Zeichnet die Aktueller Runde

        %%  Hier wird f�r jeden Spieler einen Panzer generiert und diesen auf
        % dem Spielfeld Plaziert und gezeichnet
        % Weiter wird jedem Spieler das GezeichneteObjekt wieder
        % Zur�ckgegeben, dies um sp�ter das Objekt l�schen zu k�nnen.
        for iCount = 1 : 1 : param.playerQuantety
            player(iCount).genTank; % Tank Berechnen 
            player(iCount).posTank(lndsc, param); % Tank Positioniren
            tank = player(iCount).getTank; % Tank Variable 
            % Tank Zeichnen und Handler Speichern 
            player(iCount).tankHandler = gameScreen.drawElementCol(tank,player(iCount).getTankColor);      
        end

        %% Wetter Erstellen
        weth = Wether(param); %Wetter Instanz erstellen
        windShape = gameScreen.drawElementCol(weth.getWindShape,weth.getWindShapeColor); %Wetterpfeil Zeichnen

        %% Zug ermitteln
        % Hier wird ausgelost welcher Spielr anf�ngt
        state.setActualPlayer(round((rand) * (param.playerQuantety-1))+1);

        %% Taktik oder Geschicklichkeit
        % Liest aus den Parametern ob der Taktik oder Geschiklichkeitsmodus
        % eingestellt wurde.
        % Ladet den Mode und Zeigt diesen an.
        if param.numberMode == 1;
            gameScreen.drawGameButtons(); % Zeichnet Buttons f�r den Taktikmodus
        else
            gameScreen.drawPowerBar();  % Zeichnet PowerBar f�r den Geschiklichkeitsmodus
        end
        
        %% Start einer Spielrunde
        % In dieser While Schleife verbleibt das Spiel, bis eine Runde
        % beendet wird.
        roundEnd = 0; % Variable zur Spielsteurung
        while roundEnd == 0;
            
            %% Wetter Ermitteln
            % Hier wird das Wetter neu berechnet, der wind �ndert sich
            % leicht (normalverteilter zufall)
            weth.updateWether; % neu berechnen
            gameScreen.updateElementCol(windShape, weth.getWindShape,weth.getWindShapeColor); %windShape neu zeichnen

            gameScreen.drawActualPlayer(state, player(state.getActualPlayer).getTankColor); %Zeichnet den Text wer aktuell am Zug ist
            
            %% Warten auf eingabe
            % Nachfolgend wird auf die eingabe des Spielers gewartet
            fire = 0; % Wurd geschossen 1 wenn schuss erfolgt
            power = 1000; % Schussnergie (sollte zwichen 1000 und 100000 Joul liegen)
            angle = 45; % Abschusswinkel in Grad
            % Ermitteln ob Taktik oder Geschiklichkeit
            if param.numberMode == 1; 
                %% Taktikmodus.
                % warten auf Feuerbefehl Taktik
                while gameScreen.fireEvent == 0;
                    pause(0.1)
                end
                gameScreen.fireEvent = 0; % Feuerbefehl wieder auf Null setzen Taktik
                power = gameScreen.getPower; % Auslesen der Schussenergie Taktik
                angle = gameScreen.getAngle; % Auslesen des Schusswinkels Taktik
            else   
                %% Geschiklichkeitsmodus
                % Warten auf eingabe Geschiklichkeit
                % Polling schleife. Falls Mouse down, z�hlt die Powerbar nach oben
               powertimer = 0; % Timer f�r Power auf null setze
               while fire == 0 % Warten bis eingabe erfolgt
                    pause(0.01); % Pause, wird ben�tigt um elemente zu Zeichnen.
                    while gameScreen.mousedown == 1  % Wenn maus gedr�ckt wird f�ngt das Hochz�len an 
                       powertimer = powertimer * 1.005 + 0.25; % Der Timer z�hlt hoch und beschleunigt zus�tzlich
                       gameScreen.updatePowerBar(powertimer/180);   % der Powerbalken wird aktualisiert
                       fire = 1; % Der Feuerbefehl wird auf erfolgt gesetzt
                       angle = player(state.getActualPlayer).calcAngle(gameScreen.mouseX,gameScreen.mouseY); %Der Winkel Spieler zus mausposition wird ausgelesen.
                       power = powertimer * 200; %der Poerwert wird berechnet
                       pause(0.000001);  % pause um geschwindikeit des Hochz�hlens zu beschr�nken Ansonsten abh�ngik von rechner Leistung
                    end
               end
            end

            %% Schuss Rechnen
            % Hier Wird der Schuss berechnet
            shot = FlightPath(); % Instanz des Schusses erstellen
            % Wenn Spielernummer Gerade, wird der Abschusswinkel gespiegelt
            if mod(state.getActualPlayer, 2) == 0
                angle = 180 - angle;
            end  
            
            % Berechnen der Flugbahn
            % TODO: #1 try catch entfernen
            % das Programm hat noch bugs mit den Arrays Landscape und 
            % Flighpath zu vergleichen. Dies insbesonder wenn aus dem Bild
            % geschossen wird. Es kann ein IndexExceedsMatrixDimensions
            % Exeption geworfen werden. Behandelt wird diese momentran noch, in dem der n�chste Spielr am zug ist... 
            % Joel Koch 4.1.16: Problem behoben.
            
            try 
                coordinate = shot.calcCoordinates(power, angle , weth, lndsc, player(state.getActualPlayer));
            catch       
            end

            %% Schuss Zeichnen
            % Zeichnet die Flugbahn des Geschossen
            % TODO: #2 F�r kurze flugbahnen wird der Schuss sehr Langsam
            % gezeichnet.
            % Workaround erstellen
            % comet(coordinate(1,:),coordinate(2,:));
            
            tmpX= (coordinate(1,:));
            tmpY= (coordinate(2,:));
            fprintf('\nDebug Info Arraysize Comet Coord = %d \n', length(tmpX));
            comet(tmpX,tmpY);
            
            %% Treffer ermitteln
            % Hier Wird ermittelt ob der einschlagpunkt auf einem der
            % Spieler ist
            for pk = 1 : 1 : param.playerQuantety % F�r jeden Spieler
                try % Siehe TODO #1
                    if shot.isHit(player, pk) > 0   % Die Trefferenergie 0, 100 wird ausgelesen, sp�tere Versionen des Spiels k�nnen den Tank nur besch�digen.
                        gameScreen.deleteElement(player(pk).tankHandler); % wenn Getroffen wird Spielfigur gel�scht
                        player(pk).livePoints = player(pk).livePoints - 100;   % Die Lebenspunkte des Spielers werden auf 0 gesetzt
                        player(pk).positionXY = [0,0]; % player kann nicht mehr getroffen werden
                        if state.decreasePlayerInGame <= 1  % die Anzahl verbleibenden Spieler wird reduziert
                            roundEnd = 1; % Ist die Anzahl kleiner 1, so endet die runde
                        end
                    end
                catch
                end
            end

            %% Einschlag Schuss Zeichnen
            % Hier wird die Explosion gezeichnet und das neue Terrainarray
            % mit Krater gespeichert
            try  % Siehe TODO #1
                lndsc.terrainArray = gameScreen.drawImpactCircle(lndsc.getLandscape, shot.impact);
            catch          
            end
            
            terrain =  lndsc.getLandscape(); % lokalspeichern des Terrainarray
            gameScreen.updateInScreen(terrain); % neuzeichnen des Terrainarray
            
            %% Ermitteln des N�chsten Spieler
            % N�cshter spieler mit mehr als 0 lebenspunkten wird ermittrelt
            % Ist nur noch ein spieler vorhanden Erh�lt der verbleibende
            % einen Punkt
            if state.getPlayerInGame > 1
                state.nextPlayer(param, player); 
            else
                state.nextPlayer(param, player);
                %Punkt f�r den letzten verbleibenden Spiler vergeben
                player(state.getActualPlayer).score = player(state.getActualPlayer).score+1;
            end
            pause(0.1); %Pause zum ende der While Schleife, f�r Stabilit�t eingabe etc.
        end
        state.nextGameRound(param); %Runde eins hochz�hlen wenn max anzahl ereicht ende

        for iCount = 1 : 1 : param.playerQuantety % r�cksetzen aller lebenspunkte
            player(iCount).livePoints = param.getStandardLivePoints;
        end

        %   l�schen des Screens wird anschlissend neu gezeichnet
        if state.getGameRound > param.numberRounds    
        pause(13);
        end
        fig = gameScreen.getFig();
        fig.delete;
    end
end

