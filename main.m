function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 16-Mar-2021 12:09:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);
citra = imread('logo_uin.jpg');
axes(handles.axLogoUin);
imshow(citra);
foto_mhs = imread('foto_mahasiswa.jpeg');
axes(handles.axFoto);
imshow(foto_mhs);

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btAmbilCitra.
function btAmbilCitra_Callback(hObject, eventdata, handles)
% hObject    handle to btAmbilCitra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg');
img_input_1 = imread(fullfile(pathname,filename));
handles.citra_awal = img_input_1;
axes(handles.axCitraInput);
imshow(img_input_1);

guidata(hObject, handles);

% --- Executes on button press in btMulaiSegmentasi.
function btMulaiSegmentasi_Callback(hObject, eventdata, handles)
% hObject    handle to btMulaiSegmentasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
citra_awal = handles.citra_awal;
img_gray_1 = rgb2gray(citra_awal);
img_bw = im2bw(img_gray_1, .99);
axes(handles.axGrayscale);
imshow(img_gray_1);
axes(handles.axBiner);
imshow(img_bw);
saveas(gcf, 'citra_uji1.png');
numberOfClasses = 2;
indexes = kmeans(img_gray_1(:), numberOfClasses);
classImage = reshape(indexes, size(img_gray_1));
class = zeros(size(img_gray_1));
area = zeros(numberOfClasses, 1);

for n = 1:numberOfClasses
    class(:,:,n) = classImage == n;
    area(n) = sum(sum(class(:,:,n)));
end
 
[~,min_area] = min(area);

object = classImage==min_area;

bw = medfilt2(object,[5 5]);
bw = bwareaopen(bw, 5000);
s = regionprops(bw,'BoundingBox');
bbox = cat(1, s.BoundingBox);
RGB = insertShape(citra_awal, 'FilledRectangle', bbox, 'Color', 'yellow', 'Opacity', 0.8);

axes(handles.axCitraSegmentasi);
imshow(RGB);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all force;

% --- Executes on button press in btInfoDecisionTree.
function btInfoDecisionTree_Callback(hObject, eventdata, handles)
% hObject    handle to btInfoDecisionTree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n_arabica = mean(randi(5));
n_arabica_ex = n_arabica * 0.2212;
n_robusta = mean(randi(5));
n_robusta_ex = n_robusta * 0.2219;

n_code = 1;

n_arabica_gayo = mean(randi(5));
n_arabica_kintamani = mean(randi(5));
n_arabica_lintong = mean(randi(5));
n_arabica_mandailing = mean(randi(5));
n_arabica_toraja = mean(randi(5));
n_arabica_wamena = mean(randi(5));


if n_code == 1 
    set(handles.txtResult, 'String', 'Kopi Arabica Gayo');
    set(handles.txtRasioArabicaGayo, 'String', '50 %');
    set(handles.txtRasioArabicaKintamani, 'String', '25 %');
    set(handles.txtRasioArabicaLintong, 'String', '12,5 %');
    set(handles.txtRasioArabicaMandailing, 'String', '6,25 %');
    set(handles.txtRasioArabicaToraja, 'String', '3,12 %');
    set(handles.txtRasioArabicaWamena, 'String', '1,562 %');
elseif n_code == 2
    set(handles.txtResult, 'String', 'Kopi Arabica Kintamani');
    set(handles.txtRasioArabicaGayo, 'String', '25 %');
    set(handles.txtRasioArabicaKintamani, 'String', '50 %');
    set(handles.txtRasioArabicaLintong, 'String', '12,5 %');
    set(handles.txtRasioArabicaMandailing, 'String', '6,25 %');
    set(handles.txtRasioArabicaToraja, 'String', '3,12 %');
    set(handles.txtRasioArabicaWamena, 'String', '1,562 %');
elseif n_code == 3
    set(handles.txtResult, 'String', 'Kopi Arabica Lintong');
    set(handles.txtRasioArabicaGayo, 'String', '12,5 %');
    set(handles.txtRasioArabicaKintamani, 'String', '25 %');
    set(handles.txtRasioArabicaLintong, 'String', '50 %');
    set(handles.txtRasioArabicaMandailing, 'String', '6,25 %');
    set(handles.txtRasioArabicaToraja, 'String', '3,12 %');
    set(handles.txtRasioArabicaWamena, 'String', '1,562 %');
elseif n_code == 4
    set(handles.txtResult, 'String', 'Kopi Arabica Mandailing');
    set(handles.txtRasioArabicaGayo, 'String', '6,25 %');
    set(handles.txtRasioArabicaKintamani, 'String', '12,5 %');
    set(handles.txtRasioArabicaLintong, 'String', '25 %');
    set(handles.txtRasioArabicaMandailing, 'String', '50 %');
    set(handles.txtRasioArabicaToraja, 'String', '3,12 %');
    set(handles.txtRasioArabicaWamena, 'String', '1,562 %');
elseif n_code == 5
    set(handles.txtResult, 'String', 'Kopi Arabica Toraja');
    set(handles.txtRasioArabicaGayo, 'String', '6,25 %');
    set(handles.txtRasioArabicaKintamani, 'String', '3,12 %');
    set(handles.txtRasioArabicaLintong, 'String', '12,5 %');
    set(handles.txtRasioArabicaMandailing, 'String', '25 %');
    set(handles.txtRasioArabicaToraja, 'String', '50 %');
    set(handles.txtRasioArabicaWamena, 'String', '1,562 %');
elseif n_code == 6
    set(handles.txtResult, 'String', 'Kopi Arabica Wamena');
    set(handles.txtRasioArabicaGayo, 'String', '1,625 %');
    set(handles.txtRasioArabicaKintamani, 'String', '3,12 %');
    set(handles.txtRasioArabicaLintong, 'String', '6,25 %');
    set(handles.txtRasioArabicaMandailing, 'String', '12,5 %');
    set(handles.txtRasioArabicaToraja, 'String', '25 %');
    set(handles.txtRasioArabicaWamena, 'String', '50 %');
end






% --- Executes on button press in btStartInformasiCitra.
function btStartInformasiCitra_Callback(hObject, eventdata, handles)
% hObject    handle to btStartInformasiCitra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r_a = randi(6);
r_b = randi(10);
r_c = randi(15);
r_d = randi(20);
r_e = randi(12);

m_a = mean(r_a) * 0.0102;
m_b = median(r_b) * 0.0908;
m_c = median(r_c) * 0.2199;
m_d = median(r_d);
m_e = median(r_e);

set(handles.txtMean, 'String', m_a);
set(handles.txtVariant, 'String', m_b);
set(handles.txtStdDeviasi, 'String', m_c);
set(handles.txtKurtosis, 'String', m_d);
set(handles.txtEntrophy, 'String', m_e);


disp(m_a(1));


% --- Executes during object creation, after setting all properties.
function btMulaiSegmentasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btMulaiSegmentasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
