#=import Pkg; 
Pkg.add("Images")
Pkg.add("FileIO") 
Pkg.add("GLMakie")=#

using GLMakie

using Images, FileIO

image = load("../images/imagem.jpg")

image = Int64.(map(x -> reinterpret(UInt8, N0f8(x)), image))

image_arr = image[:]

f = Figure()
hist(f[1, 1], image_arr, bins = 256)

save("hist.jpeg", f)

x, y = size(image)

println(x, y)

function freq(arr)
    freqmap = Dict()
    for value in arr
        if haskey(freqmap, value)
            freqmap[value]+=1
            continue
        end

        freqmap[value] = 1
    end
    freqmap
end

image_arr_dict = freq(image_arr)

probs_dict = Dict()

for i in 0:256
    probs_dict[i] = get(image_arr_dict, i, 0) / (x*y)
end

function acc_probs()
    sum_probs = 0
    accumulated_probs = Dict()

    for i in 1:256
        sum_probs += probs_dict[i-1]
        accumulated_probs[i] = floor((probs_dict[i] + sum_probs) * 255)
    end

    accumulated_probs
end

accumulated_probs = acc_probs()

histogram_values = collect(values(image_arr_dict))

f = Figure()
hist(f[1, 1], histogram_values, bins = 256)

save("hist_mod.jpeg", f)

image_mod = map(v -> accumulated_probs[v]/255, image)

save("image_mod.jpeg", image_mod)