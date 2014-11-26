function colorArray = MainColor(Y)
if ~isempty(Y)
    
    %Y=imread('license1.png');
    
    %% convert to rgb
    %if (min(min(X))>=1 & max(max(X))<=256) & all(all(abs(X-floor(X))<eps)) == 1
    %    Y=ind2rgb(X,map);
    %elseif size(X,3) == 3
    %    Y=X;
    %else
    %    Y=ind2rgb(X,jet(256));
    %end
    
    
    % figure(1)
    % imagesc(Y)
    % axis equal
    % axis off
    
    %% convert to hsv
    Z=rgb2hsv(Y);
    s=size(Z);
    tmp=reshape(Z,[s(1)*s(2) s(3)]);
    M=mean(tmp);
    C=reshape(M,[1 1 3]);
    C(:,:,3)=1;
    
    %% prepare scale bars
    Hbar=linspace(0,1,256);
    Hbar=repmat(Hbar,[64,1]);
    Hbar=padarray(Hbar,[64 64 ],M(1),'both');
    Hbar=Hbar*255;
    
    Sbar=linspace(0,1,256);
    Sbar=repmat(Sbar,[64,1]);
    Sbar=padarray(Sbar,[64 64 ],M(2),'both');
    Sbar=Sbar*255;
    
    
    Vbar=linspace(0,1,256);
    Vbar=repmat(Vbar,[64,1]);
    Vbar=padarray(Vbar,[64 64 ],M(3),'both');
    Vbar=Vbar*255;
    
    colorArray = [Hbar(1) Sbar(1) Vbar(1)];
    
    
    % %% display
    % figure(2)
    % subplot(1,3,1);
    % subimage(Hbar',hsv(256));
    % title('Hue')
    % axis tight
    % axis off
    % caxis auto
    %
    % subplot(1,3,2);
    % subimage(Sbar',jet(256));
    % title('Saturation')
    % axis tight
    % axis off
    % caxis auto
    %
    %
    % subplot(1,3,3);
    % subimage(Vbar',jet(256));
    % title('Luminance')
    % axis tight
    % axis off
    % caxis auto
else
    colorArray = [0,0,0];
end