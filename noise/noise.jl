#import Pkg; 
#Pkg.add("Noise")

using Images, FileIO, Noise

image = load("../images/pratica5.png")

function avg_images(images_arr)
    x, y = size(images_arr[1])
    total = length(images_arr)
    img = zeros(x, y)

    for i in images_arr
        img += i / total
    end

    img 
end

function generate_noise_array(array_length)
    arr = []
    for _ in 1:array_length
        push!(arr, add_gauss(image))
    end
   
    arr
end

noises = generate_noise_array(64)
save("noise64.jpeg", avg_images(noises))