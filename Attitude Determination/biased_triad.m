function [Rbi]=biased_triad(v1b,v1i,v2b,v2i)
%Biased to v1
t1b = v1b;
t1i = v1i;

t2b = cross(v1b,v2b)/norm(cross(v1b,v2b));
t2i = cross(v1i,v2i)/norm(cross(v1i,v2i));

t3b = cross(t1b,t2b);
t3i = cross(t1i,t2i);

Rbi = [t1b t2b t3b] * [t1i t2i t3i]';
end