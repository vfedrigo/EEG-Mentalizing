function varargout = sample2(varargin)
% SAMPLE2 MATLAB code for sample2.fig
%      SAMPLE2, by itself, creates a new SAMPLE2 or raises the existing
%      singleton*.
%
%      H = SAMPLE2 returns the handle to a new SAMPLE2 or the handle to
%      the existing singleton*.
%
%      SAMPLE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLE2.M with the given input arguments.
%
%      SAMPLE2('Property','Value',...) creates a new SAMPLE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sample2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sample2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sample2

% Last Modified by GUIDE v2.5 15-Jan-2019 10:31:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sample2_OpeningFcn, ...
                   'gui_OutputFcn',  @sample2_OutputFcn, ...
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


% --- Executes just before sample2 is made visible.
function sample2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sample2 (see VARARGIN)

% Choose default command line output for sample2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sample2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = sample2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in radio1A.
function radio1A_Callback(hObject, eventdata, handles)
% hObject    handle to radio1A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio1A
handles.A1 = 'A';
guidata(hObject,handles);

% --- Executes on button press in radio1B.
function radio1B_Callback(hObject, eventdata, handles)
% hObject    handle to radio1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio1B
handles.A1 = 'B';
guidata(hObject,handles);

% --- Executes on button press in radio1C.
function radio1C_Callback(hObject, eventdata, handles)
% hObject    handle to radio1C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio1C
handles.A1 = 'C';
guidata(hObject,handles);

% --- Executes on button press in radio3A.
function radio3A_Callback(hObject, eventdata, handles)
% hObject    handle to radio3A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio3A
handles.A3 = 'A';
guidata(hObject,handles);

% --- Executes on button press in radio3B.
function radio3B_Callback(hObject, eventdata, handles)
% hObject    handle to radio3B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio3B
handles.A3 = 'B';
guidata(hObject,handles);

% --- Executes on button press in radio3C.
function radio3C_Callback(hObject, eventdata, handles)
% hObject    handle to radio3C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio3C
handles.A3 = 'C';
guidata(hObject,handles);

% --- Executes on button press in radio4A.
function radio4A_Callback(hObject, eventdata, handles)
% hObject    handle to radio4A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio4A
handles.A4 = 'A';
guidata(hObject,handles);

% --- Executes on button press in radio4B.
function radio4B_Callback(hObject, eventdata, handles)
% hObject    handle to radio4B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.A4 = 'B';
guidata(hObject,handles);

% --- Executes on button press in radio4C.
function radio4C_Callback(hObject, eventdata, handles)
% hObject    handle to radio4C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio4C
handles.A4 = 'C';
guidata(hObject,handles);

% --- Executes on button press in radio2A.
function radio2A_Callback(hObject, eventdata, handles)
% hObject    handle to radio2A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio2A
handles.A2 = 'A';
guidata(hObject,handles);

% --- Executes on button press in radio2B.
function radio2B_Callback(hObject, eventdata, handles)
% hObject    handle to radio2B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio2B
handles.A2 = 'B';
guidata(hObject,handles);

% --- Executes on button press in radio2C.
function radio2C_Callback(hObject, eventdata, handles)
% hObject    handle to radio2C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio2C
handles.A2 = 'C';
guidata(hObject,handles);

% --- Executes on button press in radio5A.
function radio5A_Callback(hObject, eventdata, handles)
% hObject    handle to radio5A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio5A
handles.A5 = 'A';
guidata(hObject,handles);

% --- Executes on button press in radio5B.
function radio5B_Callback(hObject, eventdata, handles)
% hObject    handle to radio5B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio5B
handles.A5 = 'B';
guidata(hObject,handles);

% --- Executes on button press in radio5C.
function radio5C_Callback(hObject, eventdata, handles)
% hObject    handle to radio5C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio5C
handles.A5 = 'C';
guidata(hObject,handles);





% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radio1B.
function radio1B_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to radio1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nameField_Callback(hObject, eventdata, handles)
% hObject    handle to nameField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nameField as text
%        str2double(get(hObject,'String')) returns contents of nameField as a double

participantNumber = get(hObject, 'String')
data = struct('participantID', participantNumber);
hObject.UserData = data;

% --- Executes during object creation, after setting all properties.
function nameField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nameField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function passedText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to passedText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function failedText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to failedText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in doneButton.
function doneButton_Callback(hObject, eventdata, handles)
% hObject    handle to doneButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

answerVector = char(strcat({handles.A1}, {handles.A2}, {handles.A3}, ...
    {handles.A4}, {handles.A5}))
correctAnswers = 'BCBCA';
score = sum(answerVector == correctAnswers)
handles.score = score

if (score >= 4)
    set(handles.passedText, 'visible', 'on')
elseif (score < 4)
    set(handles.failedText, 'visible', 'on')
end

h = findobj('Tag', 'nameField');
nameData = h.UserData
nameData = nameData.participantID



if exist('results.mat','file')
    %file exists so load it and append the new to it
    fileData = load('results.mat');
    fileData.cumulativeDataStruct.(nameData) = {score, answerVector};
    save('results.mat', '-struct', 'fileData');
else
    cumulativeDataStruct.(nameData) = {score, answerVector}
    save('results.mat', 'cumulativeDataStruct')
end


% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
matlabImage = imread('points.png');
image(matlabImage)
axis off
axis image

% Hint: place code in OpeningFcn to populate axes7


% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

axes(hObject)
matlabImage = imread('move.png');
image(matlabImage)
axis off
axis image

% Hint: place code in OpeningFcn to populate axes8


% --- Executes during object creation, after setting all properties.
function axes9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

axes(hObject)
matlabImage = imread('choice.png');
image(matlabImage)
axis off
axis image

% Hint: place code in OpeningFcn to populate axes9
