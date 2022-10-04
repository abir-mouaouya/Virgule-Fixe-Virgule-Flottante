function varargout = VFlottante(varargin)
% VFLOTTANTE MATLAB code for VFlottante.fig
%      VFLOTTANTE, by itself, creates a new VFLOTTANTE or raises the existing
%      singleton*.
%
%      H = VFLOTTANTE returns the handle to a new VFLOTTANTE or the handle to
%      the existing singleton*.
%
%      VFLOTTANTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VFLOTTANTE.M with the given input arguments.
%
%      VFLOTTANTE('Property','Value',...) creates a new VFLOTTANTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VFlottante_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VFlottante_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VFlottante

% Last Modified by GUIDE v2.5 26-Oct-2021 17:30:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VFlottante_OpeningFcn, ...
                   'gui_OutputFcn',  @VFlottante_OutputFcn, ...
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


% --- Executes just before VFlottante is made visible.
function VFlottante_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VFlottante (see VARARGIN)

% Choose default command line output for VFlottante
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VFlottante wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VFlottante_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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
if(get(handles.pushbutton1,'value'))
    
    A=get(handles.edit1,'string')
    n=length(A)
    S=A(1)
    E=0
    F=0
     if(get(handles.radiobutton2,'value')) 
         %%%%%%%%   Simple Précision  %%%%%%%%
        N=8
        M=23
     else
        %%%%%%%%%%% ********** Double précision  ***********  %%%%%%%%%%%%%
        if(get(handles.radiobutton1,'value'))
            N=11
            M=52
        end 
    end 
    
    if(get(handles.radiobutton3,'value')) 
    %%%% Tester la validité de nbr entré %%%%%
    if((isempty(find(A == '2')) && isempty(find(A == '3')) && isempty(find(A == '4'))&& isempty(find(A== '5'))&& isempty(find(A == '6'))&& isempty(find(A == '7')) && isempty(find(A == '8'))&& isempty(find(A == '9'))&& isempty(find(A == '.'))&& isempty(find(A == ','))))
          if(get(handles.radiobutton2,'value')) 
         %%%%%%%%   Simple Précision  %%%%%%%%
        N=8
        M=23
        E=A(2:9)
        F=A(10:n)
      
     else
        %%%%%%%%%%% ********** Double précision  ***********  %%%%%%%%%%%%%
        if(get(handles.radiobutton1,'value'))
            N=11
            M=52
            E=A(2:11)
            F=A(12:n)
        end 
    end 
        
        Edecimal=bin2dec(E)
        Fdecimal=0;
        
        for i=1:N
        Fdecimal=Fdecimal+(str2num(F(i))*2^(-i))
        i=i+1
        end 
        
    %%%% Etudions les cas 
        if(Edecimal<(2^(N)-1) && Edecimal~=0)
           VFlottante=((-1)^S)*2^(Edecimal-(2^(N)/2-1))*(1+Fdecimal);
           
        else
            if(Edecimal==0)
                if(Fdecimal==0)
                    VFlottante=0
                else
                    VFlottante=((-1)^S)*2^(-(2^(N)/2-2))*(0+Fdecimal);
                end
                
            else 
                
               if(Edecimal==(2^N)-1)
                if(Fdecimal==0)
                    if(S==1)
                        VFlottante='-oo'
                    else
                        VFlottante='+oo'
                    end 
                else 
                    VFlottante='NaN'
                end 
               end 
             end 
        end
        
   q=2^(length(F)-1)*2^(length(length(F)))
   DN=20*2^(length(E))*log10(2)
   DG=-2^(-2^(length(E)-1))
   DD=2^(-2^(length(E)-1))
   D='['
   D=strcat(D,num2str(DG),',',num2str(DD),']')   % domaine de définition 
    set(handles.text4,'string',VFlottante)
    set(handles.text8,'string',S)
    set(handles.text10,'string',E)
    set(handles.text12,'string',F)
    set(handles.text14,'string',q)
    set(handles.text16,'string',DN)
    set(handles.text18,'string',D)
    else 
        set(handles.text4,'string','nomre saisi est invalide')
    end
    
    
    
    % Décimal vers binaire 
    else 
        
        if(get(handles.radiobutton4,'value'))
            
        % le signe %%%%%%%    
            if(str2num(A)>0)
                S='0'
            else
                S='1'
            end 
            
         %La mantisse 
         
              %%***** Conversion du nombre en binaire
     Vflottante=0;
    if(isempty(find(A == '.')))
        %si le nombre ne contient pas de virgule
        VFlottante=dec2bin(str2num(A),8);
        v=0;      
    set(handles.text4,'string', VFlottante)
    set(handles.text8,'string',S) 
    else
        v=1;
        virgule = find(A == '.');  
        PE=floor(str2num(A))
        P=dec2bin(abs(PE))
        PD = A(virgule+1:length(A))
        t=strcat('0.',PD);
        D='.'
        PD=str2num(t)   
        t=length(A)-virgule;
    %%%%%%%%%%%%%% Transformer la partie décimal en binaire %%%%%%%%%%%%%%%%%%
     while (t~=0 || PD == 1)
         R=PD*2;
         if(R < 1)
             D=strcat(D,'0')
             PD=R
         else       
             D=strcat(D,'1')
             PD=R-1
         end 
         t=t-1
     end   
     V = strcat(P,D)  
    end 
    if(v)
    B = str2num(V) 
    if(floor(A)~=1)
        %décalage vers la gauche 
       j=0;
       H=B
       while(floor(H)~=1)
           H=H*0.1
           j=j+1
       end
      T=num2str(H)
       mantisse=T(3:length(num2str(H)));     
    else 
        %décalage à droite
     j=0;
     H=B;
     while(floor(H)~=1)
         H=H*10;
         j=j-1;
     end 
      T=num2str(H)
      mantisse=T(3:length(num2str(H)));   
    end 
  
    %vérifier la taille de la mantisse , et completer par les zéro
    if(length(mantisse)<M )
        while(length(mantisse)<M)
            mantisse=strcat(mantisse,'0')
        end
    end
    
         %l'exposant
         if(N == 8)
             ED=124+j;
             
         else
             ED=1024+j;
         end
         exposant=dec2bin(ED)
         VFlottante=strcat(num2str(S),exposant,mantisse)
       %insertion des données 
    set(handles.text4,'string',VFlottante)
    set(handles.text8,'string',S)    
    set(handles.text10,'string',exposant)
    set(handles.text12,'string',mantisse)  
   q=2^(length(mantisse)-1)*2^(length(length(mantisse)))
    set(handles.text14,'string',q) 
   DN=20*2^(length(exposant))*log10(2)
    set(handles.text16,'string',DN)
    set(handles.text18,'string','_')   
     end       
       
        end 
    end 
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.pushbutton2,'value'))
 set(Home,'visible','on');
 set(VFlottante,'visible','off');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
