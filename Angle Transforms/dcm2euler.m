function [theta1,theta2,theta3] = dcm2euler(T,seq)
%Converts from DCM to euler
%%%seq defines the sequence of the transformation; Rxyz,Rzyx,Rxyx,...
T11 = T(1,1); T12 = T(1,2); T13 = T(1,3);
T21 = T(2,1); T22 = T(2,2); T23 = T(2,3);
T31 = T(3,1); T32 = T(3,2); T33 = T(3,3);
switch seq
    case 'Rxyz'
        theta2 = asind(T13);
        theta1 = asind(-T23/cosd(theta2));
        theta3 = acosd(T11/cosd(theta1));
    case 'Rzxy'
        theta2 = asind(T32);
        theta3 = acosd(T33/cosd(theta2));
        theta1 = acosd(T22/cosd(theta2));
    case 'Rxyx'
        theta2 = acosd(T11);
        theta1 = asind(T21/sind(theta2));
        theta3 = asind(T12/sind(theta2));
    case 'Rxzx'
        theta2 = acosd(T11);
        theta3 = acosd(-T12/sind(theta2));
        theta1 = acosd(T21/sind(theta2));
    case 'Ryxz'
        theta2 = asind(-T23);
        theta3 = acosd(T22/cosd(theta2));
        theta1 = acosd(T33/cosd(theta2));
    case 'Ryzx'
        theta2 = asind(T21);
        theta3 = acosd(T22/cosd(theta2));
        theta1 = asind(-T31/cosd(theta2)); 
    case 'Ryxy'
        theta2 = acosd(T22);
        theta3 = acosd(-T23/sind(theta2));
        theta1 = asind(T12/sind(theta2));
    case 'Ryzy'
        theta2 = asind(T22);
        theta3 = acosd(T21/sind(theta2));
        theta1 = asind(T32/sind(theta2));
    case 'Rxzy'
        theta2 = asind(-T12);
        theta3 = asind(T13/cosd(theta2));
        theta1 = acosd(T22/cosd(theta2));
    case 'Rzyx'
        theta2 = asind(-T31);
        theta3 = asind(T32/cosd(theta2));
        theta1 = acosd(T11/cosd(theta2));
    case 'Rzxz'
        theta2 = acosd(T33);
        theta3 = asind(T31/sind(theta2));
        theta1 = acosd(-T23/sind(theta2));
    case 'Rzyz'
        theta2 = acosd(T33);
        theta3 = asind(T32/sind(theta2));
        theta1 = asind(T23/sind(theta2));
end
end
