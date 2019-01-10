clear; clc;
%60,30,40 unbalanced: Ix<Iz<Iy or Ix>Iz>Iy. pg 115
%30,40,50 balanced: Iz is either largest or smallest
Ix = 30;    Iy = 40;    Iz = 50;
hwx = 0;    hwy = 0;    hwz = 1000;
w1 = 0.3;   w2 = 0;     w3 = 10;
phi = pi/2; theta = pi/2; psi = pi/2;
sim('euler.slx')