using Images, FileIO, FFTW

image = HSV.(load("../images/Image_noise.jpg"))

#https://docs.juliahub.com/ColorTypes/db21U/0.11.0/
#https://juliaimages.org/v0.23/examples/color_channels/rgb_hsv_thresholding/#RGB-to-HSV-and-thresholding
M, N = size(image)

place_holder = zeros(M*2, N*2)

for row in 1:M
    for col in 1:N
        place_holder[row, col] = Float64(image[row, col].v)
    end
end

intensity = place_holder

shifted_image = (fftshift ∘ fft)(intensity)

#= spectre = abs.(sqrt.(shifted_image.^2)/256)
save("spectre.jpeg", spectre)
 =#
filter = Float64.(load("./filter.jpeg"))

unshifteddft = ifft(ifftshift(shifted_image .* filter))

for row in 1:M
    for col in 1:N
        value = Float64(unshifteddft[row, col].re)
        hsv_elem = image[row, col]
        image[row, col] = HSV(hsv_elem.h, hsv_elem.s, value)
    end
end

save("reduced_noise.jpeg", image)