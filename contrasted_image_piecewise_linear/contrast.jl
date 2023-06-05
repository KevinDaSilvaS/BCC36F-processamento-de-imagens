#= import Pkg; 
Pkg.add("Images")
Pkg.add("FileIO") =#

using Images, FileIO

pollen = load("../images/pollen.jpg")

pollen = Float64.(pollen)

input_dark = Float64.(reinterpret(N0f8, UInt8(97)))

input_light = Float64.(reinterpret(N0f8, UInt8(126)))

output_dark = Float64.(reinterpret(N0f8, UInt8(30)))

output_light = Float64.(reinterpret(N0f8, UInt8(170)))

function piecewise(v)
    if v < input_dark
        return (output_dark/input_dark) * v
    end

    if v < input_light
        return output_dark + ((output_light-output_dark)/(input_light-input_dark)) * (v - input_dark)
    end

    output_light + (((1-output_light)/(1-input_light)) * (v - input_light))
end

contrasted = map(v -> piecewise(v), pollen)

save("contrasted.jpeg", contrasted)