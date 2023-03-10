function [x, w] = gausslegendre(np)
% Generates the abscissa and weights for a Gauss-Legendre quadrature.
% Reference:  Numerical Recipes in Fortran 77, Cornell press.
x = zeros(np,1);                                           % Preallocations.
w = x;
m = (np+1)/2;
for ii=1:m
    z = cos(pi*(ii-.25)/(np+.5));                        % Initial estimate.
    z1 = z+1;
while abs(z-z1)>eps
    p1 = 1;
    p2 = 0;
    for jj = 1:np
        p3 = p2;
        p2 = p1;
        p1 = ((2*jj-1)*z*p2-(jj-1)*p3)/jj;       % The Legendre polynomial.
    end
    pp = np*(z*p1-p2)/(z^2-1);                        % The L.P. derivative.
    z1 = z;
    z = z1-p1/pp;
end
    x(ii) = -z;                                   % Build up the abscissas.
    x(np+1-ii) = z;
    w(ii) = 2/((1-z^2)*(pp^2));                     % Build up the weights.
    w(np+1-ii) = w(ii);
end