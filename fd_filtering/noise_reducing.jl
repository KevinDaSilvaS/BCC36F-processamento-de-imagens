using Images, FileIO, FFTW

image = Float64.(load("../images/pratica7.png"))

M, N = size(image)

place_holder = zeros(M*2, N*2)

for row in 1:M
    for col in 1:N
        place_holder[row, col] = image[row, col]
    end
end

image = place_holder

shifted_image = (fftshift ∘ fft)(image)

#= spectre = abs.(sqrt.(shifted_image.^2)/256)
println(spectre[1:10])
save("spectre.jpeg", spectre) =#

filter = Float64.(load("./filter_noise.jpg"))

unshifteddft = ifft(ifftshift(shifted_image .* filter))
image = zeros(M, N)

for row in 1:M
    for col in 1:N
        image[row, col] = unshifteddft[row, col].re
    end
end

save("nonoise.jpeg", image)