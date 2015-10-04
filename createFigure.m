%%  Header
%
%   Title: createFigure.m
%
%   Precondition:   nothing
%
%   Postcondition: 
%   Erzeugt ein Grafikfenster in dem das Spiel Abl�uft
%
%   Call: 
%
%	Variables:
%
%   Modified:
%
%   

function [] = createFigure()
    
%% CONSTANTS                                
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

% FIGURE_FULLSCREEN = true;
% FIGURE_WIDTH = 464;     % pixels
% FIGURE_HEIGHT = 750;
% FIGURE_COLOR = [.0,.0,.0];
% AXIS_COLOR = [.2,.0,.0];
% PLOT_W = 200; %width in plot units. this will be main units for program
% PLOT_H = 324; %height
% FONT = 'Courier'; 
% MESSAGE_SPACE = 15; %spacing between message lines
% LARGE_TEXT = 18; %text sizes
% SMALL_TEXT = 14;
% TINY_TEXT = 13;
% TITLE_COLOR = [.0,.8,.0];

%% Setup der Anzeige
    % Ermitteln der Bildschirmgr�sse
    screenSize = get(0,'ScreenSize');
    
    % in die linke obere ecke stzen
    fig = figure('units','normalized','outerposition',[0 0 1 1]);

%     fig = figure('Position',[(screenSize(3)-FIGURE_WIDTH)/2,...
%       (screenSize(4)-FIGURE_HEIGHT)/2, ...
%       FIGURE_WIDTH, ...
%       FIGURE_HEIGHT]);
%       %custom close function.
      
% set(fig,'CloseRequestFcn',@my_closefcn);
    
    %set background color for figure
    set(fig, 'color', FIGURE_COLOR);
    
    %make custom mouse pointer
    pointer = NaN(16, 16);
    pointer(4, 1:7) = 2;
    pointer(1:7, 4) = 2;
    pointer(4, 4) = 1;
    set(fig, 'Pointer', 'Custom');
    set(fig, 'PointerShapeHotSpot', [4, 4]);
    set(fig, 'PointerShapeCData', pointer);
    
%     %register keydown and keyup listeners
%     set(fig,'KeyPressFcn',@keyDownListener)
%     %set(fig, 'KeyReleaseFcn', @keyUpListener);
%     set(fig,'WindowButtonDownFcn', @mouseDownListener);
%     set(fig,'WindowButtonUpFcn', @mouseUpListener);
%     set(fig,'WindowButtonMotionFcn', @mouseMoveListener);
    
    %figure can't be resized
    set(fig, 'Resize', 'off');
    
    mainAxis = axes(); %handle for axis
    axis([0 PLOT_W 0 PLOT_H]);
    axis manual; %axis wont be resized
    
    %set color for the court, hide axis ticks.
    set(mainAxis, 'color', AXIS_COLOR, 'YTick', [], 'XTick', []);
    %handles to title for displaying wave, score
    axisTitle = title('Artillery');
    set(axisTitle, 'FontName', FONT,'FontSize', LARGE_TEXT);
    set(axisTitle, 'Color', TITLE_COLOR);
    
    hold on;

end
