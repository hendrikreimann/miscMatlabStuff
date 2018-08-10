function [s1, s2] = lineSegmentDistance ...
( ...
    r1, ... % center of line segment 1
    r2, ... % center of line segment 2
    e1, ... % direction of line segment 1
    e2, ... % direction of line segment 2
    L1, ... % length of line segment 1
    L2 ... % length of line segment 2
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
lineDistance = norm(s);

%! Now for the squared in-plane distance risq between two line segments:
% Rectangle half lengths h1=L1/2, h2=L2/2	
h1 = L1*0.5;
h2 = L2*0.5;

% If the origin is contained in the rectangle, 
% life is easy: the origin is the minimum, and 
% the in-plane distance is zero!
if ((lambda0*lambda0 <= h1*h1) && (mu0*mu0 <= h2*h2))
    s1 = r1 + lambda0*e1;
    s2 = r2 + mu0*e2;
    return;
end


% else
% Find minimum of f = gamma^2+delta^2-2*gamma*delta*(e1*e2)
% where gamma, delta are the line parameters reckoned from the intersection
% (=lam0,mu0)

%! First, find the lines gammaM and deltaM that are nearest to the origin:
gamma1 = - lambda0 - h1;
gamma2 = - lambda0 + h1;
gammaM = gamma1;
if (gamma1*gamma1 > gamma2*gamma2)
    gammaM = gamma2;
end
delta1 = - mu0 - h2;
delta2 = - mu0 + h2;
deltaM = delta1;
if ( delta1*delta1 > delta2*delta2 )
    deltaM = delta2;
end

% Now choose the line gamma = gammaM and optimize delta:
gamma = gammaM;
deltaPrime = gamma * e12;
% check if deltaPrime is within [-mu0 +- L/2]
aa = mu0 + deltaPrime;
if ( aa*aa <= h2*h2 )
    % somewhere along the side gamma = gammaM
    delta = deltaPrime;
else 
    % deltaPrime out of range --> corner next to deltaPrime
    delta = delta1;
    a1 = deltaPrime - delta1;
    a2 = deltaPrime - delta2;
    if ( a1*a1 > a2*a2 )
        delta = delta2;
    end
end
% Distance at these gam, del:
f1 = gamma*gamma + delta*delta - 2*gamma*delta*e12;
gammaProposed1 = gamma;
deltaProposed1 = delta;

% Now choose the line delta = deltaM and optimize gamma:
delta = deltaM;
gammaPrime = delta * e12;
aa = lambda0 + gammaPrime;
if ( aa*aa <= h1*h1 )
    % somewhere along the side delta = deltaM
    gamma = gammaPrime;
else 
    % gammaPrime out of range --> corner next to gammaPrime
    gamma = gamma1;
    a1 = gammaPrime - gamma1;
    a2 = gammaPrime - gamma2;
    if ( a1*a1 > a2*a2 )
        gamma = gamma2;
    end
end
f2 = gamma*gamma + delta*delta - 2*gamma*delta*e12;
gammaProposed2 = gamma;
deltaProposed2 = delta;

% Compare f1 and f2 to find distance between the two line segments:
lineSegmentDistance = f1;
gammaSolution = gammaProposed1;
deltaSolution = deltaProposed1;
if ( f2 < f1 )
    lineSegmentDistance = f2;
    gammaSolution = gammaProposed2;
    deltaSolution = deltaProposed2;
end

s1 = r1 + lambda0*e1 + gammaSolution*e1;
s2 = r2 + mu0*e2 + deltaSolution*e2;

