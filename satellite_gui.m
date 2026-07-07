function satellite_gui()
clc
clear
close
f = figure('Name','Satellite Orbit Simulator',...
    'NumberTitle','off',...
    'Position',[100 100 1200 700]);

uicontrol(f,'Style','text','Position',[20 650 120 20],'String','Area (m^2)');
hA=uicontrol(f,'Style','edit','Position',[150 650 100 25],'String','5');

uicontrol(f,'Style','text','Position',[20 620 120 20],'String','Mass (kg)');
hM=uicontrol(f,'Style','edit','Position',[150 620 100 25],'String','25');

uicontrol(f,'Style','text','Position',[20 590 120 20],'String','Drag Coeff');
hCd=uicontrol(f,'Style','edit','Position',[150 590 100 25],'String','2');

uicontrol(f,'Style','text','Position',[20 540 120 20],'String','Pos X');
hRx=uicontrol(f,'Style','edit','Position',[150 540 100 25],'String','-4817e3');

uicontrol(f,'Style','text','Position',[20 510 120 20],'String','Pos Y');
hRy=uicontrol(f,'Style','edit','Position',[150 510 100 25],'String','4817e3');

uicontrol(f,'Style','text','Position',[20 480 120 20],'String','Pos Z');
hRz=uicontrol(f,'Style','edit','Position',[150 480 100 25],'String','6812e3');

uicontrol(f,'Style','text','Position',[20 430 120 20],'String','Vel X');
hVx=uicontrol(f,'Style','edit','Position',[150 430 100 25],'String','-4739');

uicontrol(f,'Style','text','Position',[20 400 120 20],'String','Vel Y');
hVy=uicontrol(f,'Style','edit','Position',[150 400 100 25],'String','-4516');

uicontrol(f,'Style','text','Position',[20 370 120 20],'String','Vel Z');
hVz=uicontrol(f,'Style','edit','Position',[150 370 100 25],'String','158');

uicontrol(f,'Style','text','Position',[20 320 120 20],'String','No. of Orbits');
hOrbit=uicontrol(f,'Style','edit','Position',[150 320 100 25],'String','5');

uicontrol(f,'Style','text','Position',[20 290 120 20],'String','Time Step');
hDt=uicontrol(f,'Style','edit','Position',[150 290 100 25],'String','1');

hDrag=uicontrol(f,'Style','checkbox','Position',[20 240 150 25],'String','Enable Drag','Value',1);
hJ2=uicontrol(f,'Style','checkbox','Position',[20 210 150 25],'String','Enable J2','Value',1);

uicontrol(f,'Style','pushbutton','String','Run Simulation',...
    'Position',[40 140 180 40],'Callback',@runSimulation);

axOrbit=axes(f,'Units','pixels','Position',[320 250 850 400]);
axAlt=axes(f,'Units','pixels','Position',[320 30 400 150]);
axVel=axes(f,'Units','pixels','Position',[770 30 400 150]);

hInfo=uicontrol(f,'Style','text','Position',[20 20 260 100],...
    'HorizontalAlignment','left','String','Ready');

function runSimulation(hInfo,~)
hInfo=uicontrol(f,'Style','text','Position',[20 20 260 100],...
    'HorizontalAlignment','left','String','Busy');
A=str2double(get(hA,'String'));
if A<0
  hInfo=uicontrol(f,'Style','text','Position',[20 20 260 100],...
    'HorizontalAlignment','left','String',"Area cannot be negative!");
  error("Area cannot be negative")
end
m=str2double(get(hM,'String'));
Cd=str2double(get(hCd,'String'));
dt=str2double(get(hDt,'String'));
nOrbit=str2double(get(hOrbit,'String'));

r=[str2double(get(hRx,'String'));
   str2double(get(hRy,'String'));
   str2double(get(hRz,'String'))];

v=[str2double(get(hVx,'String'));
   str2double(get(hVy,'String'));
   str2double(get(hVz,'String'))];

mu=398600.11e9;
j2=1.08263e-3;
r_eq=6378e3;

data=csvread('alt_density_pratham.csv');
alt=data(:,1);
dens=data(:,2);

rmag=norm(r);
vmag=norm(v);
a=(2/rmag-vmag^2/mu)^(-1);
T=2*pi*sqrt(a^3/mu);

N=floor((T*nOrbit)/dt)+1;

R=zeros(3,N);
V=zeros(3,N);
R(:,1)=r;
V(:,1)=v;

for k=2:N

    rnow=R(:,k-1);
    vnow=V(:,k-1);
    rmag=norm(rnow);

    acc=(-mu/rmag^3)*rnow;

    if get(hJ2,'Value')
        x=rnow(1); y=rnow(2); z=rnow(3);
        fac=1.5*j2*(mu/rmag^2)*(r_eq/rmag)^2;

        acc=acc+[fac*(x/rmag)*(5*z^2/rmag^2-1);
                 fac*(y/rmag)*(5*z^2/rmag^2-1);
                 fac*(z/rmag)*(5*z^2/rmag^2-3)];
    end

    if get(hDrag,'Value')
        altitude=rmag-r_eq;
        rho=interp1(alt,dens,altitude,'linear','extrap');
        drag=-0.5*Cd*rho*(A/m)*norm(vnow)*vnow;
        acc=acc+drag;
    end

    V(:,k)=V(:,k-1)+acc*dt;
    R(:,k)=R(:,k-1)+V(:,k)*dt;
end

altitude_all=sqrt(sum(R.^2,1))-r_eq;
velmag=sqrt(sum(V.^2,1));
time=(0:N-1)*dt;

cla(axOrbit);
axes(axOrbit);
hold on; grid on; axis equal;

[xe,ye,ze]=sphere(40);
surf(r_eq*xe,r_eq*ye,r_eq*ze,'EdgeColor','none');
% alpha(0.3);

orbitLine=plot3(nan,nan,nan,'LineWidth',2);
sat=plot3(nan,nan,nan,'o','MarkerSize',8,'MarkerFaceColor','r');

xlabel('X'); ylabel('Y'); zlabel('Z');
title('Satellite Orbit');

for k=1:max(1,floor(N/300)):N
    set(orbitLine,'XData',R(1,1:k),'YData',R(2,1:k),'ZData',R(3,1:k));
    set(sat,'XData',R(1,k),'YData',R(2,k),'ZData',R(3,k));
    drawnow;
end

cla(axAlt);
plot(axAlt,time/60,altitude_all/1000,'LineWidth',1.5);
grid(axAlt,'on');
title(axAlt,'Altitude vs Time');
xlabel(axAlt,'Time (min)');
ylabel(axAlt,'Altitude (km)');

cla(axVel);
plot(axVel,time/60,velmag/1000,'LineWidth',1.5);
grid(axVel,'on');
title(axVel,'Speed vs Time');
xlabel(axVel,'Time (min)');
ylabel(axVel,'Speed (km/s)');
orbitalMomentum=cross(r(:,1),v(:,1));
eccVec=1/mu * cross(v(:,1),orbitalMomentum) - r(:,1)/norm(r(:,1));
ecc=norm(eccVec);
set(hInfo,'String',sprintf(['Period: %.2f min\n' ...
    'Semi-major axis: %.1f km\n' ...
    'Eccentricity: %.3f \n' ...
    'Max Altitude: %.1f km\n' ...
    'Min Altitude: %.1f km'], ...
    T/60,a/1000,ecc,max(altitude_all)/1000,min(altitude_all)/1000));
end
end
