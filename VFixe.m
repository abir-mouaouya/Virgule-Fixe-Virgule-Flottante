function varargout = VFixe(varargin)
% VFIXE MATLAB code for VFixe.fig
%      VFIXE, by itself, creates a new VFIXE or raises the existing
%      singleton*.
%
%      H = VFIXE returns the handle to a new VFIXE or the handle to
%      the existing singleton*.
%
%      VFIXE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VFIXE.M with the given input arguments.
%
%      VFIXE('Property','Value',...) creates a new VFIXE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VFixe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VFixe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VFixe

% Last Modified by GUIDE v2.5 24-Oct-2021 21:31:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VFixe_OpeningFcn, ...
                   'gui_OutputFcn',  @VFixe_OutputFcn, ...
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


% --- Executes just before VFixe is made visible.
function VFixe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VFixe (see VARARGIN)

% Choose default command line output for VFixe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VFixe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VFixe_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(hObject,'value'))
    set(handles.text3,'string','Nombre Décimal')  
    set(handles.text4,'string','Représentation en Binaire') 
end 
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(hObject,'value'))
    set(handles.text4,'string','Représentation en Décimal')  
    set(handles.text3,'string','Nombre Binaire') 
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   1) Si le botton est activé          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(get(handles.pushbutton1,'value'))
    
    %******* On récupére les valeurs 
    choix = get(handles.popupmenu1,'value');
    A =str2num(get(handles.edit1,'string'));
    NB = num2str(A);
    base=16  
    %lire la valeur de la base
    switch choix
       case 2
             base=16
       case 3
             base=24
    end
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   2) Vérifier Si l'utilisateur a choisi B2D ou D2B  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(get(handles.radiobutton1,'value'))
    
 %%%%%%%%%%%%%      Traitant le cas de la conversion du  décimal en binaire  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(isempty(find(NB == '.')))
        %si le nombre ne contient pas de virgule
        if(A >= 0)    
           VFixe=dec2bin(A,base);
        else
           V=dec2bin(abs(A),base)
           VFixe = bitget(int16(A),16:-1:1)
         %  VCom2=dec2bin(bin2dec(num2str(VCom1))+bin2dec('1'))
        end
    else    %si le nbr contient de la virgule
     virgule = find(NB == '.');  
     
%%%%%%% Convertir le partie entière en binaire
    if (A > 0)
    PEntiere =  floor(A) 
    PE = dec2bin(PEntiere,8)
    else
    PEntiere=floor(abs(A))
       if(PEntiere==0)
        PE='11111111'
       else 
        PE=num2str(bitget(int8(-PEntiere),8:-1:1))
        end 
    end
    
    PD = NB(virgule+1:length(num2str(A)))
    N=length(NB)-virgule
    D='.'
    t=strcat('0.',PD);
    PD=str2num(t)
    M=7
    
    %%%%%%%%%%%%%% Transformer la partie décimal en binaire %%%%%%%%%%%%%%%%%%
     while (M~=0 || PD == 1)
         R=PD*2;
         if(R < 1)
             D=strcat(D,'0')
             PD=R
         else       
             D=strcat(D,'1')
             PD=R-1
         end 
         M=M-1
     end     
     VFixe = strcat(PE,D)
    end
    
   % calcul des prop 
   n=round(log2(A)+0.5)+1
   m=base-n;
   q=2^(-m);
   err=0;
   err_Relatif=0;
   
   %%%%%%%%%%%%% Calcule d'erreur 
      if(~isempty(find(NB == '.')))           
           PEntiere =  floor(str2num(VFixe))
           NB = num2str(VFixe)
           virgule = find(NB == '.'); 
           PD = NB(virgule+1:length(NB))
           PE = bin2dec(num2str(PEntiere))
           N=length(NB)-virgule
           i=1
           somme=0
           for i=1:N
              somme=somme+(str2num(PD(i))*2^(-i))
              i=i+1
           end 
           VF=0
           VF=PE+somme
           err=abs(A - VF)
           err_Relatif=err/A;
      end 
     
   DG=-2^(n-1)
   DD=2^(n-1)-2^(-m)
   D='['
   D=strcat(D,num2str(DG),',',num2str(DD),']')   % domaine de définition 
     % Affichage des proprietes et résultat 
   set(handles.text6,'string',n)
   set(handles.text8,'string',m)
   set(handles.text12,'string',err);   
   set(handles.text2,'string',VFixe);  
   set(handles.text10,'string',abs(q));
   set(handles.text14,'string',err_Relatif);  

else
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Transformation du binaire au décimal     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(get(handles.radiobutton2,'value'))
        
    if(isempty(find(NB == '.')))
        %si le nombre ne contient pas de virgule       
        if( A(1)==1)
            %%%%%%%%%%% nombre sera négatif %%%%%%
            Ab=dec2bin(bin2dec(NB)-1)
            VFixe=-bin2dec(Ab)
        else
            VFixe=bin2dec(NB);
        end 
    else
        virgule = find(NB == '.');
        
    %si le nbr contient de la virgule
    PEntiere =  round(A) 
    PD = NB(virgule+1:length(NB))
    
    %convertir la partie entière en binaire de façon sipmle
    PE = bin2dec(num2str(PEntiere))
    N=length(NB)-virgule
    i=1
    somme=0
    for i=1:N
        somme=somme+(str2num(PD(i))*2^(-i))
        i=i+1
    end 
    VFixe=PE+somme 
   
    end 
    
   n=round(log2(A)+0.5)+1
   m=base-n
   DG=-2^(n-1)
   DD=2^(n-1)-2^(-m)
   D='['
   D=strcat(D,num2str(DG),',',num2str(DD),']')   % domaine de définition
   q=2^(-m)
   
   set(handles.text6,'string',n);
   set(handles.text8,'string',abs(m));
   set(handles.text10,'string',abs(q));
   set(handles.text2,'string',VFixe);     
    end 
end 
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.pushbutton2,'value'))
 set(Home,'visible','on');
 set(VFixe,'visible','off');
end
