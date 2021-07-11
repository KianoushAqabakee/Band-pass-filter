function H = lowpassfilter(type, M, N, D0, n)
[U, V] = meshq(M, N);
D = sqrt(U.^2 + V.^2);
switch type
    case 'ideal'
        H = double(D <=D0);
    case 'btw'
        if nargin == 4
            n = 1;
        end
        H = 1./(1 + (D./D0).^(2*n));
    case 'gaussian'
        H = exp(-(D.^2)./(2*(D0^2)));
end