%GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
%"Umlauf Orbit Simulator" Copyright (C) 2026 PRATHAM VOHRA
%Author: Pratham Vohra
%Email: vohraofficial7@gmail.com
function [r,v]=elements_to_pos_vel(mu,a,ecc,inc,raan,argper,theta)
  inc=inc*pi/180;
  raan=raan*pi/180;
  argper=argper*pi/180;
  theta=theta*pi/180;
  radius=a*(1-ecc^2)/(1+ecc*cos(theta));
  %radial_speed=sqrt(mu/(a*(1-ecc^2)))*ecc*sin(theta);
  %tangential_speed=sqrt(mu/(a*(1-ecc^2)))*(1+ecc*cos(theta));

  r_perifocal=[radius*cos(theta);radius*sin(theta);0];
  v_perifocal = [-sqrt(mu/(a*(1-ecc^2)))*sin(theta); sqrt(mu/(a*(1-ecc^2)))*(ecc+cos(theta));0];

  %v_perifocal=[-radial_speed*sin(theta)+tangential_speed*cos(theta);...
  %             radial_speed*cos(theta)+tangential_speed*sin(theta);0];



Q = [
cos(raan)*cos(argper)-sin(raan)*sin(argper)*cos(inc), -cos(raan)*sin(argper)-sin(raan)*cos(argper)*cos(inc), sin(raan)*sin(inc);
sin(raan)*cos(argper)+cos(raan)*sin(argper)*cos(inc), -sin(raan)*sin(argper)+cos(raan)*cos(argper)*cos(inc), -cos(raan)*sin(inc);
sin(argper)*sin(inc), cos(argper)*sin(inc), cos(inc)];
%transpose(Q)*Q

r=Q*r_perifocal;
v=Q*v_perifocal;
end
