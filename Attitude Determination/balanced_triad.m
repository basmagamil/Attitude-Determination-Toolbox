function [Rbi]=balanced_triad(v1b,v1i,v2b,v2i)
t1b = v1b;
t1i = v1i;

t2b = v2b;
t2i = v2i;

t3b2 = cross(t1b,t2b)/norm(cross(t1b,t2b));
t3i2 = cross(t1i,t2i)/norm(cross(t1i,t2i));

Rbi = [t1b t2b t3b2] * inv([t1i t2i t3i2]);
end