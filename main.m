close all;
clear all;
clc;
%%
%{
            Kianoush Aqabakee
          student ID: 9512103311
%}
%%
figure
img=imread('chest_Xray.tif');
try
    img_gray=rgb2gray(img)';
end
%img=awgn(double(img_gray),50,'measured','linear');
img=cast(img,'uint8');
subplot(1,2,1)
imshow(img)
title('noisy image')
window=[11,7];
D0 = 0.05*window(1);
filtertype=questdlg('select type of filter','???','ideal','btw','gaussian','gaussian');
loworhi=questdlg('select type of filter','???','low','hi','ow','ow');
switch loworhi
    case 'low'
        H = lowpassfilter(filtertype, window(1), window(2), D0);
    case 'hi'
        H = 1-lowpassfilter(filtertype, window(1), window(2), D0);
    case 'ow'
        H = 1-lowpassfilter(filtertype, window(1), window(2), D0);
        prompt = {'Enter value of a','Enter value of b'};
        dlgtitle = 'Parameter Values';
        dims = [1 10];
        definput = {'0.5','50'};
        anss = inputdlg(prompt,dlgtitle,dims,definput);
        a=str2double(anss{1});
        b=str2double(anss{2});
        H=a+b*H;
end
h = ifft2(H);
M=size(h,1)+size(img,1)-1;
N=size(h,2)+size(img,2)-1;
img2=Qzeropad(img,M,N);
F=fft2(double(img2),M,N);
H=fft2(h,M,N);
LPFS_img = H.*F;
LPF_img=real(ifft2(LPFS_img));
LPF_img=cast(LPF_img,'uint8');
subplot(1,2,2)
imshow(LPF_img, [])
title('Output image')