classdef  FlightPath < handle
%%  Class Header
%
%   Class Name: FlightPath.m
%   Call: name = FlightPath()
%
%   Zweck: In der Instanz dieser klasse findet die berechnung der Flugbahn
%   statt. Wieter stellen Instanzen dieser klasse die methode zur
%   trefferermittlung zu verf�gung
%
%% Changelog
% Version 00.00.01  07.10.15  Raphael Waltensp�l    Erstellt des Main
% Objekts, noch nicht Objekt Orientiert.
% Version 00.00.07  19.10.15  Joel Koch             Einschlag implementier
% Version 00.00.08  21.10.15  Raphael Waltensp�l    Flugparabel berechnung
% erster entwurf
% Version 00.00.09  22.10.15  Raphael Waltensp�l    Koordinaten der
% Flugparabel berechnen und ausgeben
% Version 00.01.00  22.11.15  Raphael Waltensp�l    Umbau in
% Objektoriert erfogt
% Version 00.01.04  11.12.15  Raphael Waltensp�l   Implementieren der
% Funktionen des Landscapes in Handle Class Landscape
% Version 00.01.06  28.12.15  Raphael Waltensp�l   Trefferermittlung
% Version 00.01.08  31.12.15  Raphael Waltensp�l   Trefferermittlung
% Version 00.01.11  02.01.16  Raphael Waltensp�l   Aufr�umen fertigstellen
% Gameablauf
% Version 01.00.00b  03.01.16  Raphael Waltensp�l   Buglist Testen
% Kommentieren Dokumentieren
%
%
%%  Input und Output: f�r Methoden, siehe Methoden
%   Konstruktor:   void
%   Precondition:  
%
%   Postcondition: Instanz von FlightPath ist erstellt
%   
%	Variables:
%       F�r Instanzvariabeln siehe Properties
%
%%   Implementierte Methoden
% [this]= FlightPath()
% [retCoordinates] = calcCoordinates(this, energie, winkel, Wether, Landscape, Player)
% [percentDamage] = isHit(this, PlayerArray, playerNr)
%
%% Buglist TODO / this
%%   #1
%  Berechnen der Flugbahn
%  TODO:
%  das Programm hat noch bugs mit den Arrays Landscape und
%  Flighpath zu vergleichen. Dies insbesonder wenn aus dem Bild
%  geschossen wird. Es kann ein IndexExceedsMatrixDimensions
%  Exeption geworfen werden. Behandelt wird diese momentran noch, in dem der n�chste Spielr am zug ist...

    properties
        impact; % Einschlagkoordinatn [x;y]
    end
    
    methods
            %% FlightPath Konstruktor 
            % Zweck: Instanz von GameStates ist erzeugt
            %
            % Pre: 
            %
            % Post: FlightPath ist erstellt
            %
            % Input: void
            %
            % Output: Instanz FlightPath
            %
            % Modifizierte Instanzvariable
        function [this]= FlightPath()
            
        end
            %% FlightPath calcCoordinates 
            % Zweck: Berechnet die Koordinaten der Flugbahn numerisch
            % Dies unter ber�cksichtigung von Wind und Lufztwiederstand
            %
            % Pre: instanz FlightPath it erstellt
            % energie ist zwischen 0 und 100000
            % winkel ist zwischen 0 und 180 Grad
            % Instanzen Wether, Landscape, Player sind erstellt
            %
            % Post: Flugbahnkoordinaten sind berechnet
            %
            % Input: instanz FlightPath
            % energie
            % winkel 
            % Wether 
            % Landscape
            % Player
            %
            % Output: retCoordinates [x;y] -- Array mit den
            % Flugbahnkoordinaten
            %
        function [retCoordinates] = calcCoordinates(this, energie, winkel, Wether, Landscape, Player)

            %% Parameter
            % Der Winkel in Grad und Rad
            % 
            % $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
            % 
            angle = winkel;
            angRad = pi() * angle/180;
            
            %% Berechnung der Abbschussgeschwindigkeit
            % 
            % $$Energie Projektil: E_{prj} \ Geschwindigkeit Projektil: v_{prj} \ Msse Projektil: m_{Projektil}$$
            % 
            % $$Wirkungsgrad Kanon: n_{can} Energie Treibladung $$
            %
            % $$E_{prj} = \frac{m_{prj}}{2} v_{prj}^{2}$$
            %
            % $$E_{prj} = E_{trbl} * n_{can}$$
            %
            % $$v_{prj} = \sqrt{ \frac{2 E_{prj}}{m_{prj}}}$$
            %
            masseProjektil = 1; % Variable erst in sp�teren Versionen ver�nderbar
            energieTreibladung = energie; % Variable erst in sp�teren Versionen ver�nderbar
            wirkungsGradKanone = 1; % Variable erst in sp�teren Versionen ver�nderbar
            masseKanone = 10000; % Variable erst in sp�teren Versionen verwendet
            g = 9.81; % Variable erst in sp�teren Versionen ver�nderbar (Wenn Planten implementiert)
            
            % Die Energie wird auf das Projektil gerechnet
            vStart = sqrt( 2 * energieTreibladung * wirkungsGradKanone / masseProjektil);
            % Die Startgeschwindigkeiten werden berechnet
            vxStart = cos(angRad) * vStart; %Startgeschwindigkeit in X Richtung
            vyStart = sin(angRad) * vStart; %Startgeschwindigkeit in Y Richtung
            
            % Die Maximale zeit f�r die Berechnung
            tmax = 60;
     
            dichteMedium = 1.2 *10^(-3); % Dichte der Athmosph�re Variable erst in sp�teren Versionen ver�nderbar (Wenn Planten implementiert)
            koeffzient = 1; % koeffizient des Geschosses
            
            %deltaT = 0.001; % Schrittweite f�r die Numerische Berechnung
            deltaT = 0.002; % Schrittweite f�r die Numerische Berechnung ge�ndert Joel Koch 4.1.16: Sonst reichts nicht beim vertikalen Schuss zur�ck auf den boden.
            
            vx = (vxStart); % Startgeschwindigkeit in X Richtung speichern
            vy = (vyStart); % Startgeschwindigkeit in Y Richtung speichern
            n=1; % Schleifenz�hler auf eins
            
            playerStartPos = Player.positionXY; % Startposition speichern
            x(n) = playerStartPos(1,1);  % Schuss X Startposition festlegen
            y(n) = playerStartPos(2,1)+10; % Schuss Y Startposition festlegen
            
            %% Schleife zur Numerischen berechnung der Flugparabel
            for t = 0 : deltaT : tmax
                ve = [vx, vy] / sqrt(vx^2 + vy^2); % Einsvektor f�r die Kraft des Flugluftwiederstandes
                fVector = ve * (sqrt(vx^2 + vy^2)^2 * koeffzient * dichteMedium); % Kraft des Flugluftwiederstandes berechnen [Fx;Fy]
                % �nderung v in X richtung berechnen inklusive der
                % Windrichtung
                vx = vx - fVector(1,1)*deltaT - (Wether.wind + vx) * abs(Wether.wind + vx) * koeffzient * dichteMedium * deltaT;
                % �nderung v in Y richtung berechnen inklusive der
                vy = vy - g * deltaT - fVector(1,2)*deltaT;
                
                % Speichern der Parameter in einem Array
                x(n+1) = x(n)+vx * deltaT;
                y(n+1) = y(n)+vy * deltaT;
                n = n+1;               
            end
            
            coordinates = [x;y]; % Speichern der Koordinaten
            
            landArray = Landscape.getLandscape; % Speichern des Landscapes Array
            
            %finalLength = 13000; % Die Finale L�nge des Arrays (JOKO: welches Array?? coordinates w�re ja 300000 lang)
            finalLength = 30000;
            
            for ak = 1 : 1 : length(coordinates)
                xcor = round(coordinates(1,ak)); % gerundter x Wert an stelle ak im Array
                ycor = coordinates(2,ak); % y Wert an stelle ak im Array
                
                % Wenn nun an der Stelle X der Y Wert der Flugbahn kleiner ist als der Y Wert der Landscape so ist dies ein einschlag 
                % Weil die Array-Gr�sse des LAndscape-Polygons variabel ist
                % (Krater), muss di Pr�fung mit "inpoygon" erfolgen:
                
                % alter Code:
                %if  ycor < landArray(2, xcor) 
                %    this.impact = [xcor; ycor];
                %    finalLength = ak; % Die l�nge der Flugbahn wird begrenzt
                %    break
                %end 
                
                in = inpolygon(xcor,ycor,landArray(1,:), landArray(2,:));
                if in ~= 0 
                    this.impact = [xcor; ycor];
                    finalLength = ak; % Die l�nge der Flugbahn wird begrenzt
                    fprintf('   => ak limit =  %d' , ak) 
                    break
                end
                    
                
                               
                % Wenn nun die Stelle X gr�sser ist als 1000 wurde aus dem
                % bild gefeuert
                if xcor > 999
                    this.impact = [1000; ycor];
                    finalLength = ak;
                    break
                end
                % Wenn nun die Stelle X gr�sser ist als 4 wurde aus dem
                % bild gefeuert
                if xcor < 4
                    this.impact = [1; ycor];
                    finalLength = ak;
                    break
                end
            end
            retCoordinates = coordinates(:,1:finalLength); % Die Koordinaten werden zur�ckgegeben
           
        end
        
        %% FlightPath isHit 
        % Zweck: Pr�fen ob ein Speiler getroffen wurde
        %
        % Pre: instanz FlightPath it erstellt,
        %  playerNr ist bekannt und �bergeben
        %
        % Post: Ermittelt ob der Spieler mit der playerNr getroffen wurde
        % und der Schaden wurde zur�ckgegeben
        %
        % Input: instanz FlightPath
        % PlayerArray --
        % playerNr --
        %
        % Output: percentDamage-- Schaden am Spieler
        %
        function [percentDamage] = isHit(this, PlayerArray, playerNr)
           
            tempPsXY = PlayerArray(playerNr).tankArray; % Spieler wird gespeicher
            % Pr�fen ob impaktkoordinaten iauf dem Spieler liegen
            if this.impact(1,1) > min(tempPsXY(1,:)) && this.impact(1,1) < max(tempPsXY(1,:))
                percentDamage = 100; % 100 prozent Schaden wenn getroffen
            else
                percentDamage = 0; % 0 prozent Schaden wenn nicht getroffen
            end
        end
        
    end
    
end

