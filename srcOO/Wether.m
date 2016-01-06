    %%  Class Header
    % Zweck: In Instanzen dieser klasse wird das Wetter f�r das Spiel
    % erstellt und die �nderung des Wetters w�hrend des Spiels berechnet.
    % Weiter wird das Windpfeilshape in AAbh�ngikeit der Windst�rke
    % erstellt und dessen Farbe ermittelt.
    
    %   Class Name: Wether.m
    %   Call: name = Wether()
    %
    %% Changelog
    % * Version 00.00.13  12.11.15  Raphael Waltensp�l    Menu zur eingabe von
    % Parametern erstellt
    % * Version 00.01.00  22.11.15  Raphael Waltensp�l    Umbau in
    % Objektoriert erfogt
    % * Version 00.01.01  12.11.15  Raphael Waltensp�l    Menu zur eingabe von
    % Parametern erwiter auf Objektorientiert
    % * Version 00.01.02  10.12.15  Raphael Waltensp�l   Neu Erstellen der
    % Handle Classes GameParameter, Gamestates, Wether
    % * Version 00.01.11  02.01.16  Raphael Waltensp�l   Aufr�umen fertigstellen
    % Gameablauf
    % * Version 01.00.00b  03.01.16  Raphael Waltensp�l   Buglist Testen
    
    %% Input und Output
    % f�r Methoden, siehe Methoden
    
    %   Konstruktor:   GameParameter
    %   Precondition:  GameParameter sind Instanziert
    %
    %   Postcondition: Instanz von FlightPath ist erstellt
    %   
    %	Variables:
    %       F�r Instanzvariabeln siehe Properties
    %
    %%   Implementierte Methoden

    %% Buglist TODO / this
%% Classdef
 classdef Wether < handle
    properties
        gameParameter; % Instanz der GameParameter
        wind; % die Windst�rke auf in x richtung
    end
    
    methods
        %% Wether Konstruktor 
        % Zweck: Instanz von Wether ist erzeugt
        
        % Pre: die GameParameter sind Instanziert und �bergeben
        %
        % Post: Wether ist erstellt
        %
        % Input: GameParameter
        %
        % Output: Instanz Wether
        %
        % Modifizierte Instanzvariable
        %   this.wind --
        function [this] = Wether(GameParameter)            
            %% v von wind wird in m/s berechnetMittelwert 0 Normalverteilt
            this.gameParameter = GameParameter; 
            % die Windst�rke wird Normalverteilt gerechnet unter einbezug der einstelllungen
            this.wind = randn() * 10 * this.gameParameter.numberWind; 
        end
        
        %% Wether updateWether 
        % Zweck: Die Windst�rke wird neu berechnet, dies in abh�ngikeit von
        % der Aktuellen Windst�rke
        
        % Pre: Wether ist erstellt
        %
        % Post: this.wind ist neu gerechnet
        %
        % Input: Wether Instanz
        %
        % Output: void
        %
        % Modifizierte Instanzvariable
        %   this.wind --
        function [] = updateWether(this)
            % die �nderung Windst�rke wird Normalverteilt gerechnet unter einbezug der einstelllungen
            this.wind = this.wind + (this.wind / 100 * randn() * 10 * this.gameParameter.numberWind); 
        end
        
        %% Wether getWindShape 
        % Zweck: Das Windshape wird in Abh�ngikeit der Windst�rke
        % berechnet, und Als [x,y] Array zur�ckgegeben.
        
        % Pre: Wether ist erstellt
        %
        % Post: windVektor ist zur�ckgegeben
        %
        % Input: Wether Instanz
        %
        % Output: windVektor --
        %
        function [windVektor] = getWindShape(this)
            % Das Windpfeilshape
            x = [0, 60, 60, 210, 210, 60, 60 ,0];
            y = [0 , -45, -15, -15 ,15, 15, 45, 0];
            x = x * this.wind / 50; % Das Windpfeilshape in abh�ngigkeit der Windst�rke
            % Das Windpfeilshape wird in der Rechten oberen Ecke plaziert.
            x = x + this.gameParameter.PLOT_W - (max(x)+10);
            y = y + this.gameParameter.PLOT_H - (max(y)+10);
            windVektor = [x;y];
        end
        
        %% Wether getWindShapeColor 
        % Zweck: Die Farbe des Windshape wird in Abh�ngikeit der Windst�rke
        % berechnet, und Als [r,g,b] Array zur�ckgegeben.
        
        % Pre: Wether ist erstellt
        %
        % Post: windVektor ist zur�ckgegeben
        %
        % Input: Wether Instanz
        %
        % Output: windShapeColor --
        %
        function [windShapeColor] = getWindShapeColor(this)
            % Hier wird die Farbe des Windpfeilshapes ermittelt
            % Diese geht von Rot in Gr�n �ber
            if this.wind > 60;
                windTemp = 1;
            else
                windTemp = abs(this.wind/60);
            end
            r = windTemp;
            g = 1-windTemp;
            b = 0;
            windShapeColor = [r,g,b];
        end

    end
    
end

