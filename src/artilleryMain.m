%%  Header
%
%   Title: artillery.m
%
%   Precondition:   nothing
%
%   Postcondition:  
%
%   Call: 
%
%	Variables:
%
%   Modified:
%
%


function []=artillery()

close all
clear all
clc
globals();
mousedown = false;
GAMESTATE_PLAYERINPUT = true;
FIREPOWER=0;
GAMESTATE_FIRE= false

%% CONSTANTS                                
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

%% colors
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

GREEN = [.1, .7, .1];
BLUE = [.3, .3, .9];
WHITE = [1, 1, 1];
RED = [.9, .3, .3];

%% Bildschirm Starten
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
fig=createFigure(); %Figure erstellen und FigureHandler dazu erhalten



%generate landscape, get landscape vertices
[terrainshapeX,terrainshapeY] = genLandscape();
c=terrainshapeY;

%draw landscape
terrainhandler = patch(terrainshapeX,terrainshapeY, c,'EdgeColor','interp','MarkerFaceColor','flat');
colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
axis([1 1000 0 750])

% Panzerli: get Vertices
[player1.shapeX, player1.shapeY] = genPlayer(-1);
[player2.shapeX, player2.shapeY] = genPlayer( 5);

%Player center-positions
player1.posX = 40;
player2.posX = 1000-40;
player1.posY = terrainshapeY(40) + 1;
player2.posY = terrainshapeY(1000-40) + 1 ;

% translate player polgon to player position
player1.polygonX = player1.shapeX + player1.posX;
player2.polygonX = player2.shapeX + player2.posX;
player1.polygonY = player1.shapeY + player1.posY;
player2.polygonY = player2.shapeY + player2.posY;

%draw tanks
patch(player1.polygonX, player1.polygonY,'g')
patch(player2.polygonX, player2.polygonY,'y')
    
%draw Powerbar
updatePowerBar(0);

% Enable Mouse interaction
set(fig,'WindowButtonDownFcn',@mymousedowncallback)
set(fig,'WindowButtonUpFcn',@mymouseupcallback)

%Polling schleife. Falls Mouse down, z�hlt die Powerbar nach oben
POWERTIMER=0;
GAMESTATE_PLAYERINPUT=1;

while GAMESTATE_PLAYERINPUT && strcmp(fig.Name,'Artillery')
    pause(0.01);
    if mousedown
       POWERTIMER=POWERTIMER*1.02 + 1.5;
       updatePowerBar(POWERTIMER/180);
    end
    
    if GAMESTATE_FIRE
        GAMESTATE_PLAYERINPUT = false;
        FIREPOWER=min(POWERTIMER/180,1)
        fireAngle=getAngle();
        [impactposX, impactposY, hit] = gunfire(1,player1.posY+10,fireAngle,FIREPOWER);
        impactcrater(impactposX,impactposY);
        updatePowerBar(0);
        GAMESTATE_FIRE = false;
        GAMESTATE_PLAYERINPUT = true;
        POWERTIMER=0;
    end   
end


function [] = updatePowerBar(power)
% zeichnet die powerbar
% untergrund
blueX = [350,650,650,350];
blueY = [700,700,720,720];

pbarX = [350, 350+300*min(power,1), 350+300*min(power,1), 350];
pbarY = blueY;

patch(blueX,blueY,[0.6 0.9 1]); % Hellblau Himmel;
patch(pbarX,pbarY,'R');
%disp('Powerbar updatet.')    
end


function [angle] = getAngle(playernr)
    px=player1.posX 
    py=player1.posY
    mouseposition = get(gca, 'CurrentPoint');
    mx  = max(mouseposition(1,1),px);   % max limitiert den winkel auf 0-90�
    my  = max(mouseposition(1,2),py);   % max limitiert den winkeln auf 0-90�
    angle=asind((my-py)/sqrt((my-py)^2 + (mx-px)^2)) 
end


function [impactposX, impactposY, hit] = gunfire (playernr, startY, fireAngle, power)
    %% Parameter
    %
    %
    % Der winkel in Grad und Rad
    % 
    % $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
    % 
    % fireAngle = 45;
    angRad = pi() * fireAngle/180;
    
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
    masseProjektil = 1;
    energieTreibladung = 1000000;
    wirkungsGradKanone = 1;
    masseKanone = 10000;

    gunposX=player1.posX-7;
    gunposY=player1.posY +3;
    t=[gunposX:1:1000-gunposX];

    vStart = sqrt((2 * energieTreibladung * wirkungsGradKanone) / masseProjektil);
    vxStart = cos(angRad) * vStart;
    vyStart = sin(angRad) * vStart;
    tmax = 1000;

    g = 9.81;

    dichteMedium =1.3;
    koeffzient = 10;
    deltaT = 0.01;

    vx = (vxStart);
    vy = (vyStart);
    n=1;
    x(n)=player1.posX;
    y(n)=player1.posY;

    for t = 0 : deltaT : tmax
        
        ve = [vx, vy]/sqrt(vx^2 + vy^2);
        fVector = ve * (sqrt(vx^2 + vy^2)^2*koeffzient*dichteMedium)*deltaT;
        vx = vx - fVector(:,1)*deltaT;
        vy = vy - g * deltaT - fVector(:,2)*deltaT;

        x(n+1) = x(n)+vx * deltaT;
        y(n+1) = y(n)+vy * deltaT;
        n = n+1;
    end
    
    
    comet(x,y)



%f�r debug einschlag krater testen: gerade von oben nach unten
x=ones(1,size(t,2))*((90.1-fireAngle)/90)*1000;
y=1000-t;
plot(x,y);



% collision detection 
% 'in' und 'on' sind wie eine maske f�r die x und y punkte.
% um den Einschlag zu detektieren, muss einfach die erste davon verwendet
% werden, die 1 und nicht 0 ist.
[in,on]= inpolygon(x,y,terrainshapeX,terrainshapeY); % on line points: unwichtig
on=[];
plot(x(in),y(in),'r+') % points inside
impactindex=find(in,1,'first')   % erster index innerhalb des terrain-polygons
impactposX=x(impactindex)
impactposY=y(impactindex)
hit = 0;
end


function [] = impactcrater(impactposX, impactposY)
% rechnet den impactcrater ins terrain-polygono hinein.
% Krater besteht aus 2 phasen. phase 1: loch, es wird absolut gerechnet ein
% Kreis oder kreis�hnliches Loch aus dem polygon rausgerechnet. Phase 2
% erzeugt relativ zur bestehenden terrain-Linie einen leichten H�gel. Als
% m�gliche 3. Phase k�nnte oberhalb des Terrains noch der Blast-Radius
%(Shock-Zone) angezeichnet werden (nur ganz kurz). Panzer innerhalb dieses
% Shock-Radius stehen f�r 2 Z�ge  unter Schock und schiessen
% ungenau. 
        
explosionradius=8+round(8*rand);%explosion radius nicht immer gleich gross
deformY=real(sqrt(explosionradius.^2-(terrainshapeX-(round(impactposX))).^2)); % halbkreisformel
%dieser halbkreis kann jetzt nicht einfach vom bestehenden gel�nde
%subtrahiert werden, sieht schlecht aus. Besser so: zur obigen
%kreisabweichung (delta) in der Y achse den einschlagpunkt Y addieren.
%Dann auf der x-achse von einschlagpunkt-r 2r nach rechts: den kleineren
%wert nehmen von kreis oder bestehendem terrain. Das s�gt einen kreis aus. 
%�berh�ngende landschaft ist aber nicht m�glich, dort ists dann senkrecht.
deformY=-deformY+round(impactposY); %das kreisdelta auf die h�he des einschlagpunktes (y) beingen
ivon=round(impactposX-explosionradius);
ibis=round(ivon+2*explosionradius);
terrainshapeY(ivon:ibis)=min(terrainshapeY(ivon:ibis),deformY(ivon:ibis));
delete(terrainhandler); % altes Terrain l�schen, danach neues zeichnen, wieder gleichen handler zuweisen!
terrainhandler=patch(terrainshapeX,terrainshapeY, c,'EdgeColor','interp','MarkerFaceColor','flat');

end


function mymousedowncallback(hObject,~)
    if GAMESTATE_PLAYERINPUT
        mouseposition = get(gca, 'CurrentPoint');
        mx  = mouseposition(1,1);
        my  = mouseposition(1,2);
        disp(['You clicked X:',num2str(mx),', Y:',num2str(my)]);
        mousedown=true;
        tic
    end
end


function mymouseupcallback(hObject,~)
    if GAMESTATE_PLAYERINPUT
        mouseposition = get(gca, 'CurrentPoint');
        mx  = mouseposition(1,1);
        my  = mouseposition(1,2);
        disp(['You released button X:',num2str(mx),', Y:',num2str(my), ' Time elapesed: ', num2str(POWERTIMER)]);
        mousedown=false;
        GAMESTATE_FIRE = true
    end
end

%% quelle: http://stackoverflow.com/questions/2769249/matlab-how-to-get-the-current-mouse-position-on-a-click-by-using-callbacks
% set(f,'WindowButtonDownFcn',@mytestcallback)
% function mytestcallback(hObject,~)
% pos=get(hObject,'CurrentPoint');
% disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
% end

%% Quelle :http://stackoverflow.com/questions/14684577/matlab-how-to-get-mouse-click-coordinates
% set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
% function ImageClickCallback ( objectHandle , eventData )
% axesHandle  = get(objectHandle,'Parent');
% coordinates = get(axesHandle,'CurrentPoint'); 
% coordinates = coordinates(1,1:2);
% message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
% helpdlg(message);
% end

end
