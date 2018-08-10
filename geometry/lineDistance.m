function [s1, s2] = lineDistance ...
( ...
    r1, ... % center of line segment 1
    r2, ... % center of line segment 2
    e1, ... % direction of line segment 1
    e2 ... % direction of line segment 2
)

% s1 = point with minimal distance on ?
% s2 = point with minimal distance on ?

% See Allen, Evans, Frenkel, Mulder, Adv. Chem. Phys. Vol. LXXXVI, p. 1
% http:homepage.univie.ac.at/franz.vesely/notes/hard_sticks/hst/hst.html
	
% distance vector between centers:
r12 = r2 - r1;

% First, find the normal vector en at minimal distance between the carrier lines g1 and g2:
% Since en is normal both to e1 and e2 we have for any normal vector
%
% r12*e1=lam-mu*(e1*e2)
% r12*e2=lam*(e1*e2)-mu
%
% which yields (excluding the case e1*e2=0) 
%
% lam0=[(e1*r12)-(e1*e2)(e2*r12)]/[1-(e1*e2)^2]
% mu0=-[(e2*r12)-(e1*e2)(e1*r12)]/[1-(e1*e2)^2]
	 
e12 = e1' * e2;
if (abs(e12) < 1e-8)
    lambda0 = e1'*r12;
    mu0 = -(e2'*r12);
elseif (abs(e12 - 1) < 1e-8)
    % TODO: take care of nearly parralel lines, i.e. cvDotProduct(&e1, &e2) ~ 1 
    % the following is a nonsensical solution, just to avoid returning NAN
    mu0 = 0;
    lambda0 = r12'*e1;
else
    lambda0 = (e1'*r12 - e12 * (e2'*r12)) / (1 - e12*e12);
    mu0 =    -((e2'*r12) - e12*(e1'*r12)) / (1 - e12*e12);
end

% s is the vector between the closest points on the line
s = r12 + mu0*e2 - lambda0*e1;
% lineDistance = norm(s);

s1 = r1 + lambda0*e1;
s2 = r2 + mu0*e2;


