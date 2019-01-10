function [sys,x0,str,ts,simStateCompliance] = saeroanim(t,x,u,flag,Config)
%SAEROANIM S-Function for displaying 6DoF trajectories
%

% Copyright 1990-2014 The MathWorks, Inc.
% J.Hodgson  
% Modified by: S.Gage, S. Tamayo.

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
     [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(Config);
     
     
  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case {1 , 3, 9},
     sys=[];
     
  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
     sys = [];
     if Config.Animenable
        mdlUpdate(t,x,u,Config);
     end

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u,Config);

 
otherwise
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%

   error(message('aeroblks:saeroanim:invalidFlag', num2str( flag )));

end

% end sanim
%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(Config)

%
% Set Sizes Matrix
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 0;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [Config.update 0]; % fixed sample time

%
% specify that the simState for this s-function is same as the default 
%
simStateCompliance = 'DefaultSimState'; 

if ~Config.Animenable
   return
end

%
% Initialize Figure Window
%

   h_f=findobj('type','figure','Tag','6DOF anim');
   
   if isempty(h_f)
     h_anim=figure;
     delete(uigettool(h_anim,'Exploration.Brushing'));
     delete(uigettool(h_anim,'DataManager.Linking'));
     delete(findall(h_anim,'Tag','figDataManagerBrushTools'));
     delete(findall(h_anim,'Tag','figBrush'));
     delete(findall(h_anim,'Tag','figLinked'));
   else
     h_anim=h_f;
   end

   if ~strcmpi(get(h_anim,'windowStyle'),'docked')
       set(h_anim,'resize','off','position',[253 112 546 449]);
   end
   
   set(h_anim,'name','Animation Figure', ...
           'renderer','zBuffer', ...
           'clipping','off', ...
           'Tag','6DOF anim');
   
   if ~isempty(h_anim)
      h_del = findobj(h_anim,'type','axes');
      delete(h_del);
      figure(h_anim);
   end
%
% Initialize Axes
%
   handle.axes(1)=axes;
   axis(Config.axes);
   set(handle.axes(1),'visible','on','xTick',[],'yTick',[],'zTick',[],'box','on', ...
           'dataAspectRatio',[1 1 1], ...
           'projection','pers', ...
           'units','normal', ...
           'position',[0.1 0.1 0.75 0.75], ...
           'Color',[.94 .94 .94], ...
           'clipping','off',...
           'BoxStyle','full');
   
%
% Initialize Trajectory 
%
 
   handle.line(1) = line(0,0,0);
   set(handle.line(1),'lineStyle','-','color',[0 0 1],'userData',0,'clipping','off');
   handle.line(2) = line(0,0,0);
   set(handle.line(2),'lineStyle',':','color',[1 0 0],'clipping','off');

%
% Initialize Time & Utilities for back-stepping support
%
   handle.Id = '6DOF';
   handle.Model = Config.Model;
   handle.Index = 0;
   handle.snapshot = [];
   
%
% Draw in Target Position
%   

	P.Vert = Config.craft/2*[-1 -1 -1;1 -1 -1;1 1 -1;-1 1 -1;-1 -1 1;1 -1 1;1 1 1;-1 1 1];
	P.Vert(:,1)=P.Vert(:,1)+Config.target(1);
	P.Vert(:,2)=P.Vert(:,2)+Config.target(2);
	P.Vert(:,3)=P.Vert(:,3)+Config.target(3);
	P.faces = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
	handle.target = patch('vertices',P.Vert,'faces',P.faces);
	set(handle.target,'faceColor',[1 0 0], ...
                  'edgeColor',[0 0 0]);
               
%
% Draw in Missile Shape
%
   [xm,ym,zm] = miss_shape;
   xm=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]-0.5;
ym=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]-0.5;
zm=3*([0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]-0.5);
   handle.craft = patch(xm,ym,zm,[1 ;0 ;1 ; 0;2;2]);
   
	vert = Config.craft*get(handle.craft,'vertices');
   set(handle.axes(1),'userData',vert)
   set(handle.craft,'edgeColor',[0 0 0],'clipping','off');
%
% Set Handles of graphics in Figure UserData
%   
   set(h_anim,'userData',handle);
%   
%MCOS support for back-stepping
%
  data.handle = h_anim;
  data.sixDofData = 0;
  b=snapshotanim(data);
  Simulink.SimulationStepper(bdroot).addSnapshotInterface(b);


%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function mdlUpdate(t,x,u,Config) %#ok<INUSL>

%
% Obtain Handles of Figure Objects
%
    handle = get(findobj('type','figure','Tag','6DOF anim'),'userData');

    if isempty(findobj('type','figure','Tag','6DOF anim'))
     %figure has been manually closed
     return
    end

    
%
% Form Transformation Matrix
%
    cph = cos(u(4));		% Roll
    sph = sin(u(4));
    cth = cos(u(5));		% Pitch
    sth = sin(u(5));
    cps = cos(u(6));		% Yaw
    sps = sin(u(6)); 
    attitude = [cth*cps sph*sth*cps-cph*sps cph*sth*cps+sph*sps
                cth*sps sph*sth*sps+cph*cps cph*sth*sps-sph*cps
                -sth         sph*cth         cph*cth];            
      
%
% Update Craft Object 
%
   vert = get(handle.axes(1),'userData');
   a=size(vert,1);
   dum =attitude*vert'+repmat(u(1:3,1),1,a);
   set(handle.craft,'vertices',dum');
%
% Update Line Objects
%
    x1 = get(handle.line(1),'XData');  
    x2 = get(handle.line(1),'YData');
    x3 = get(handle.line(1),'ZData');
    init = get(handle.line(1),'userData');
    if init
        x1 = [x1 u(1)];
        x2 = [x2 u(2)];
        x3 = [x3 u(3)];
   else
       x1 = u(1);
       x2 = u(2);
       x3 = u(3);
       set(handle.line(1),'userData',1);
    end

    set(handle.line(1),'XData',x1, ...
                       'YData',x2, ...
                       'ZData',x3);	
    
                   
    set(handle.line(2),'XData',x1, ...
                       'YData',x2, ...
       		       'ZData',repmat(Config.axes(6),length(x1),1));	
%
% Set position of target view to Target
%
switch Config.camera_view 
   
case 1,			% Fixed Observer Position
   set(handle.axes(1),'cameraUpVector',[0 0 -1], ...
      'cameraPosition',Config.camera_pos, ...
      'cameraTarget',u(1:3), ...
      'cameraViewAngle',Config.view);
case 2,			% Cockpit View
%   Target= Config.target';
   ax = Config.axes;
   seeker_dir = sqrt(sum((ax(2)-ax(1))^2+(ax(4)-ax(3))^2+(ax(6)-ax(5))^2))*attitude*[1;0;0];
   seeker_pos = attitude*[Config.craft 0 0]';
   set(handle.axes(1),'cameraUpVector',attitude*[0 0 -1]', ...
           'cameraPosition',u(1:3)+seeker_pos, ...
           'cameraTarget',u(1:3)+seeker_dir, ...
           'cameraViewAngle',Config.view);
case 3,			% Relative Position View
   set(handle.axes(1),'cameraUpVector',[0 0 -1], ...
           'cameraPosition',u(1:3)+Config.camera_pos', ...
           'cameraTarget',u(1:3), ...
           'cameraViewAngle',Config.view);
end


%
% Force MATLAB to Update Drawing
%
   drawnow

% end mdlUpdate

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u,Config) %#ok<INUSL>
    
    sys = ceil(t/Config.update)*Config.update+Config.update;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% miss_shape
% Function to draw shape of missile object
%=============================================================================
%
function [x,y,z]=miss_shape

	num=9;		     % Number of z-y segments to make the circle
%	count=1;	     % Counter for number of individual patches
        xcraft = cell(35,1); %Preallocate for current number of patches
        ycraft = cell(35,1); %Preallocate for current number of patches
        zcraft = cell(35,1); %Preallocate for current number of patches
        
	theta=(360/2/num:360/num:(360+360/2/num))*pi/180;

	len 			= 25.7;				% Total Length (no units)
	radius		= 1.5/2;				% Radius of body
 	s_fore	 	= 5;					% Start of main body (w.r.t. nose)
   	thr_len 		= 1.4;				% Length of Motor exit
 	rad_throt	= 1.3/2;				% radius of motor exit
   	l_fore=len-s_fore-thr_len;			% Length of main body
   	c_g 			= 14;				% Position of c.g. w.r.t nose
   
%
% Fore Body Shape
%
	yc_range =  radius*sin(theta);
	zc_range = -radius*cos(theta);
	for i = 1:num
	   xcraft{i}=[s_fore s_fore s_fore+l_fore s_fore+l_fore ]-c_g;
	   ycraft{i}=[yc_range(i) yc_range(i+1) yc_range(i+1) yc_range(i)];
	   zcraft{i}=[zc_range(i) zc_range(i+1) zc_range(i+1) zc_range(i)];
	end
   count=num+1;   
%
% Throttle Shape
%
	yc_range2 =  rad_throt*sin(theta);
	zc_range2 = -rad_throt*cos(theta);
	for i = 1:num
	   xcraft{count}=[len-thr_len len-thr_len len len]-c_g;
	   ycraft{count}=[yc_range(i) yc_range(i+1) yc_range2(i+1) yc_range2(i)];
      zcraft{count}=[zc_range(i) zc_range(i+1) zc_range2(i+1) zc_range2(i)];
      count=count+1;
	end

%
% Nose Shape
%
	for i = 1:num
	   xcraft{count}=[s_fore s_fore 0 s_fore]-c_g;
	   ycraft{count}=[yc_range(i) yc_range(i+1) 0 yc_range(i)];
      zcraft{count}=[zc_range(i) zc_range(i+1) 0 zc_range(i)];
      count=count+1;
	end
%
% Wing shapes 
%
	xcraft{count}=[10.2 13.6 14.6 15]-c_g;
	ycraft{count}=[-zc_range(1) -zc_range(1)+1.5 -zc_range(1)+1.5 -zc_range(1)];
	zcraft{count}=[0 0 0 0 ];
	xcraft{count+1}=xcraft{count};
	ycraft{count+1}=-ycraft{count};
	zcraft{count+1}=zcraft{count};
	xcraft{count+2}=xcraft{count};
	ycraft{count+2}=zcraft{count};
	zcraft{count+2}=ycraft{count};
	xcraft{count+3}=xcraft{count};
	ycraft{count+3}=zcraft{count};
	zcraft{count+3}=-ycraft{count};
%
% Tail shapes 
%
   count=count+4;
	xcraft{count}=[22.1 22.9 23.3 23.3]-c_g;
	ycraft{count}=[-zc_range(1) -zc_range(1)+1.1 -zc_range(1)+1.1 -zc_range(1)];
	zcraft{count}=[0 0 0 0];
  	xcraft{count+1}=xcraft{count};
	ycraft{count+1}=-ycraft{count};
	zcraft{count+1}=zcraft{count};
	xcraft{count+2}=xcraft{count};
	ycraft{count+2}=zcraft{count};
	zcraft{count+2}=ycraft{count};
	xcraft{count+3}=xcraft{count};
	ycraft{count+3}=zcraft{count};
	zcraft{count+3}=-ycraft{count};
   	count=count+3;
      
%
% Combine individual objects into a single set of co-ordinates and roll through 45 degrees
%
   x=[];y=[];z=[];
   roll = [1 0 0;0 cos(45/180*pi) sin(45/180*pi);0 -sin(45/180*pi) cos(45/180*pi)];
   for i = 1:count
      x = [x xcraft{i}'];
	  y = [y ycraft{i}'];
	  z = [z zcraft{i}'];
   end
   
   for i =1:4
      dum = [x(i,:);y(i,:);z(i,:)];
      dum = roll*dum;
      x(i,:)=dum(1,:);
      y(i,:)=dum(2,:);
      z(i,:)=dum(3,:);
   end
%
% Rescale vertices
%
	x = -x/len;
	y = y/len;
   	z = z/len;
   
% End miss_shape



