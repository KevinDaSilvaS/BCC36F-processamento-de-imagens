#= import Pkg; 
Pkg.add("FFTW") =#

using Images, FileIO, FFTW

image = Float64.(load("../images/pratica6.png"))

M, N = size(image)

shifted_image = fftshift(fft(image))

spectre = abs.(0.45 *sqrt.(shifted_image^2)/256 )
save("spectre.jpeg", spectre)

filter = zeros(M, N)

dist = (row, col) -> ((row-M/2)^2 + (col-N/2)^2)^0.5

function buildfilter(D0)
    for row in 1:M
        for col in 1:N
            D = dist(row, col)
            filter[row, col] = ℯ^-(D/2*D0^2)
        end
    end
end

buildfilter(0.5)

save("filter.jpeg", filter)

unshifteddft = ifft(ifftshift(shifted_image .* filter))
image = zeros(M, N)

for row in 1:M
    for col in 1:N
        image[row, col] = unshifteddft[row, col].re
    end
end

println(image[1:10])
save("filtered.jpeg", image)