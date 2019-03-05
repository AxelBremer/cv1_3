function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    lim = floor(kernel_size/2);
    x = -lim:lim;
    nor = 1/(sigma*sqrt(2*pi));
    for i = 1:kernel_size
        G(i) = nor*exp(-(x(i)^2)/(2*sigma^2));
    end
    
    G = G/sum(G);
end