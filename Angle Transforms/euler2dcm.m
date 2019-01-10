function [T] = euler2dcm(theta1,theta2,theta3,seq)

switch seq
    case 'Rxyz'
        R1 = transform_x(theta1);
        R2 = transform_y(theta2);
        R3 = transform_z(theta3);
    case 'Rxzy'
        R1 = transform_x(theta1);
        R2 = transform_z(theta2);
        R3 = transform_y(theta3);
    case 'Rxyx'
        R1 = transform_x(theta1);
        R2 = transform_y(theta2);
        R3 = transform_x(theta3);
    case 'Rxzx'
        R1 = transform_x(theta1);
        R2 = transform_z(theta2);
        R3 = transform_x(theta3);
    case 'Ryxz'
        R1 = transform_y(theta1);
        R2 = transform_x(theta2);
        R3 = transform_z(theta3);
    case 'Ryzx'
        R1 = transform_y(theta1);
        R2 = transform_z(theta2);
        R3 = transform_x(theta3);
    case 'Ryxy'
        R1 = transform_y(theta1);
        R2 = transform_x(theta2);
        R3 = transform_y(theta3);
    case 'Ryzy'
        R1 = transform_y(theta1);
        R2 = transform_z(theta2);
        R3 = transform_y(theta3);
    case 'Rzxy'
        R1 = transform_z(theta1);
        R2 = transform_x(theta2);
        R3 = transform_y(theta3);
    case 'Rzyx'
        R1 = transform_z(theta1);
        R2 = transform_y(theta2);
        R3 = transform_x(theta3);
    case 'Rzxz'
        R1 = transform_z(theta1);
        R2 = transform_x(theta2);
        R3 = transform_z(theta3);
    case 'Rzyz'
        R1 = transform_z(theta1);
        R2 = transform_y(theta2);
        R3 = transform_z(theta3);
end
    T = R3*R2*R1;
end
