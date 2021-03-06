%% 图片格式

set(gca,'fontsize',15,'fontweight','bold');
title('不同厚度对应的反射率');
xlabel('Thickness (nm)');
ylabel('Reflection');
box on
L = findobj(gca,'Type','Line');
set(L,'linewidth',1.5);
%% 只改变厚度

Thickness = [20000, 2, 47,  0, 10000];
n = [1.51361, 3.0802 + 3.3522i, 0.13767 + 3.7917i, 1.48, 1.36];
d = zeros(5,100);
for ii = 1:size(d,2)
    d(:,ii) = Thickness';
    d(4,ii) = 1*(ii-1);
end
theta = 74*pi/180;
lambda = 670;
R1 = zeros(size(d,2),1);
figure
hold on
for ii = 1:size(d,2)
	R1(ii) = MultiLayerReflect(lambda,theta,n,d(:,ii));
end
plot(d(4,:),R1)
%%
% 系统组成和厚度确定，只改变角度
clear
d = [20000, 2, 47, 3.5, 4, 100000];
n = [1.51361, 3.06769 + 3.36054i, 0.16146 + 3.64199i, 1.36, 1.48, 1.36];
theta = [70:0.1:80]'*pi/180;
lambda = 670;
R1 = zeros(size(theta,1),1);
for ii = 1:size(theta,1)
	R1(ii) = MultiLayerReflect(lambda,theta(ii),n,d);
end
plot(70:0.1:80,R1)

%%  
% 系统组成确定，改变厚度和角度
Thickness = [20000, 2, 47,  0, 10000];
n = [1.51361, 3.0802 + 3.3522i, 0.13767 + 3.7917i, 1.48, 1.36];
d = zeros(5,10);
for ii = 1:size(d,2)
    d(:,ii) = Thickness';
    d(4,ii) = 1*(ii-1);
end
theta = [70:0.1:80]'*pi/180;
lambda = 670;
R1 = zeros(size(theta,1),size(d,2))';
figure
hold on
for ii = 1:size(d,2)
    for jj = 1:size(theta,1)
        R1(ii,jj) = MultiLayerReflect(lambda,theta(jj),n,d(:,ii));
    end
    plot(70:0.1:80,R1(ii,:));
end
% [X,Y] = meshgrid(d(4,:),20:0.1:80);
% mesh(X,Y,R1)

%%  

Thickness = [20000, 2, 50, 100000];
d = zeros(4,100);
for ii = 1:size(d,2)
    d(:,ii) = Thickness';
    d(3,ii) = 1*ii;
end
n = [1.51361, 3.06769 + 3.36054i, 0.16146 + 3.64199i, 1.36];
theta = (20:0.1:80)'*pi/180;
lambda = 670;
R2 = zeros(size(theta,1),size(d,2));
for ii = 1:size(theta,1)
    for jj = 1:size(d,2)
        R2(ii,jj) = TMM('TM',lambda,theta(ii),n,d(:,jj));
    end
end
[X,Y] = meshgrid(1:100,20:0.1:80);
mesh(X,Y,R2)

%%

Thickness = [20000, 2, 47, 0, 100000];
n = [1.51361, 3.06769 + 3.36054i, 0.16146 + 3.64199i, 1.45, 1.36];
theta = (50:0.1:90)'/180*pi;
lambda = 670;
d = zeros(5,100);
for ii = 1:size(d,2)
    d(:,ii) = Thickness';
    d(4,ii) = 1*(ii-1);
end
R = zeros(length(theta),size(d,2));
for ii = 1:length(R)
    for jj = 1:size(d,2)
        R(ii,jj) = MultiLayerReflect(lambda,theta(ii),n,d(:,jj));
    end
end
[~,ind] = min(R);
figure
plot(d(4,:),180/pi*theta(ind))
set(gca,'fontsize',15)
