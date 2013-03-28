function varargout = W_L_test(varargin)
% W_L_TEST M-file for W_L_test.fig
%      W_L_TEST, by itself, creates a new W_L_TEST or raises the existing
%      singleton*.
%
%      H = W_L_TEST returns the handle to a new W_L_TEST or the handle to
%      the existing singleton*.
%
%      W_L_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in W_L_TEST.M with the given input arguments.
%
%      W_L_TEST('Property','Value',...) creates a new W_L_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before W_L_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to W_L_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help W_L_test

% Last Modified by GUIDE v2.5 26-Jul-2012 14:45:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @W_L_test_OpeningFcn, ...
                   'gui_OutputFcn',  @W_L_test_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before W_L_test is made visible.
function W_L_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to W_L_test (see VARARGIN)

% Choose default command line output for W_L_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes W_L_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = W_L_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=1;
axes(handles.axes1);

t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
grid on

hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=2;
axes(handles.axes2);

t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imi=3;
axes(handles.axes3);

t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=4;
axes(handles.axes4);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=5;
axes(handles.axes5);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=6;
axes(handles.axes6);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=7;
axes(handles.axes7);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=8;
axes(handles.axes8);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=9;
axes(handles.axes9);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imi=10;
axes(handles.axes10);


t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
hh=helpdlg('choose the center of the big circle');
waitfor(hh)
[bx,by] = ginput(1);

hh=helpdlg('choose the center of the small circle');
waitfor(hh)
[sx,sy] = ginput(1);



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))

handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Scan_Callback(hObject, eventdata, handles)
% hObject    handle to Open_Scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mapmapmap='jet';
handles.DPI=300;

[filename2,pathname] = uigetfile({'*.tif','*.jpg'},'MultiSelect','on');
filename=cellstr(filename2);
if isequal(filename,0) || isempty(filename)
	return
end

[fxs,fys]=size(cellstr(filename));
%%
% axes(handles.axes1);
Scan_file_name=char([pathname,char(filename)]);

clk=clock;
set(handles.file_text,'string',Scan_file_name)
set(handles.date_text,'string',char([num2str(clk(2)),' / ',num2str(clk(3)),' / ',num2str(clk(1))]))
%     cordinus=cordins(iop,:);
% [x_b,y_b,x_s,y_s,xs,ys]=find_centers(c3,cordinus,rad2);
[t_dos,t_cont,t_cent,t_org]=WL_test_v3(Scan_file_name);

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap(mapmapmap)
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)




% --------------------------------------------------------------------
function Open_analys_Callback(hObject, eventdata, handles)
% hObject    handle to Open_analys (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to save_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Print_report_Callback(hObject, eventdata, handles)
% hObject    handle to Print_report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_org=handles.t_org;
t_dos=handles.t_dos;
t_cent=handles.t_cent;
t_cont=handles.t_cont;
DPI=handles.DPI;
% imagesc(t_dos(:,:,imi))
imagesc(t_org(:,:,imi))
grid on
rep_dos=t_dos(:,:,1);
rep_con=t_con(:,:,1)
for i=2:5
    rep_dose=[rep_dose,t_dos(:,:,i)]
%     hold on
%     contour(t_cont(:,:,i),[0,1],'b')
%     contour(t_cont(:,:,i),[0,5],'g')
end
    



   t_cent(1,1,imi)=bx;
   t_cent(1,2,imi)=by;
   t_cent(1,4,imi)=sy;
   t_cent(1,3,imi)=sx;
   xs=t_cent(1,6,imi);
   ys=t_cent(1,7,imi);
   radiusu=t_cent(1,8,imi);
   t_cent(1,5,imi)=sqrt((bx-sx)^2+(by-sy)^2)*25.4/DPI;
   

newmap3=(find_new_map(xs,ys,sx,sy,30))';
newmapbigu=(find_new_map(xs,ys,bx,by,radiusu))';
[xso,yso]=size(newmapbigu);
t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));

handles.t_cont=t_cont;
handles.t_cent=t_cent;

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
%     imagesc(t_dos(:,:,i))
    imagesc(t_org(:,:,i))
    colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
mean(t_cent(:,5,:))
handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)

% --------------------------------------------------------------------
function Open_scan_square_Callback(hObject, eventdata, handles)
% hObject    handle to Open_scan_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mapmapmap='bone';
handles.DPI=300;

[filename2,pathname] = uigetfile({'*.tif','*.jpg'},'MultiSelect','on');
filename=cellstr(filename2);
if isequal(filename,0) || isempty(filename)
	return
end

[fxs,fys]=size(cellstr(filename));
%%
% axes(handles.axes1);
Scan_file_name=char([pathname,char(filename)]);

clk=clock;
set(handles.file_text,'string',Scan_file_name)
set(handles.date_text,'string',char([num2str(clk(2)),' / ',num2str(clk(3)),' / ',num2str(clk(1))]))
%     cordinus=cordins(iop,:);
% [x_b,y_b,x_s,y_s,xs,ys]=find_centers(c3,cordinus,rad2);
[t_dos,t_cont,t_cent,t_org]=WL_test_v3_sq(Scan_file_name);

for i=1:10
    
    if i==1
        axes(handles.axes1);
        set(handles.text1,'string',num2str(t_cent(1,5,i)))
    elseif i==2
        axes(handles.axes2);
        set(handles.text2,'string',num2str(t_cent(1,5,i)))
    elseif i==3
        axes(handles.axes3);
        set(handles.text3,'string',num2str(t_cent(1,5,i)))
    elseif i==4
        axes(handles.axes4);
        set(handles.text4,'string',num2str(t_cent(1,5,i)))
    elseif i==5
        axes(handles.axes5);
        set(handles.text5,'string',num2str(t_cent(1,5,i)))
    elseif i==6
        axes(handles.axes6);
        set(handles.text6,'string',num2str(t_cent(1,5,i)))
    elseif i==7
        axes(handles.axes7);
        set(handles.text7,'string',num2str(t_cent(1,5,i)))
    elseif i==8
        axes(handles.axes8);
        set(handles.text8,'string',num2str(t_cent(1,5,i)))
    elseif i==9
        axes(handles.axes9);
        set(handles.text9,'string',num2str(t_cent(1,5,i)))
    elseif i==10
        axes(handles.axes10);
        set(handles.text10,'string',num2str(t_cent(1,5,i)))
    end
    imagesc(t_dos(:,:,i))
%     imagesc(t_org(:,:,i))
%     colormap('gray')
    hold on
    contour(t_cont(:,:,i),[0,1],'b')
    contour(t_cont(:,:,i),[0,5],'g')
    hold off
    
        
end
handles.t_org=t_org;
handles.t_dos=t_dos;
handles.t_cont=t_cont;
handles.t_cent=t_cent;
% handles.c3=c3;
handles.meanu=mean(t_cent(:,5,:));
set(handles.text_avg,'string',num2str(mean(t_cent(:,5,:))))
guidata(hObject,handles)
