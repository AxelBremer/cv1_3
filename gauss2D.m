function G = gauss2D( sigma , kernel_size )
    G = zeros(5,5);
    D = gauss1D(sigma, kernel_size);
    for j = 1:kernel_size
        for i = 1:kernel_size
            G(j,i) = D(i) * D(j);
        end
    end
end