function img_z=Qzeropad(img,M,N)
%{
img_z=zeros(M,N);
temp1=ceil(abs((size(img,1)-M)/2));
temp2=ceil(abs((size(img,2)-N)/2));
img_z(temp1:temp1+size(img,1)-1,temp2:temp2+size(img,2)-1)=img;
%}
img_z=padarray(img,abs(size(img,1)-M),'symmetric');
img_z=padarray(img_z',abs(size(img,2)-N),'symmetric')';
end