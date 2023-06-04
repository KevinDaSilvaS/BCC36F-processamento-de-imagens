#= import Pkg; 
Pkg.add("Images")
Pkg.add("FileIO") =#

#https://docs.makie.org/stable/

using Images, FileIO

pollen = load("../images/pollen.jpg")

println(pollen[1].val)

pollen = map(v -> split(bitstring(reinterpret(UInt8, N0f8(v))), ""), pollen)

#= plane1 = map(v -> parse(Int, join([v[1], "0", "0", "0", "0", "0", "0", "0"]); base=2)/255, pollen)
plane2 = map(v -> parse(Int, join(["0", v[2], "0", "0", "0", "0", "0", "0"]); base=2)/255, pollen)
plane3 = map(v -> parse(Int, join(["0", "0", v[3], "0", "0", "0", "0", "0"]); base=2)/255, pollen)
plane4 = map(v -> parse(Int, join(["0", "0", "0", v[4], "0", "0", "0", "0"]); base=2)/255, pollen)
plane5 = map(v -> parse(Int, join(["0", "0", "0", "0", v[5], "0", "0", "0"]); base=2)/255, pollen)
plane6 = map(v -> parse(Int, join(["0", "0", "0", "0", "0", v[6], "0", "0"]); base=2)/255, pollen)
plane7 = map(v -> parse(Int, join(["0", "0", "0", "0", "0", "0", v[7], "0"]); base=2)/255, pollen)
plane8 = map(v -> parse(Int, join(["0", "0", "0", "0", "0", "0", "0", v[8]]); base=2)/255, pollen) =#

#map(x -> println(x), pollen[1:50])

#println(parse(Int, join(pollen[1]); base=2), v)

#= save("plane1.jpeg", plane1)
save("plane2.jpeg", plane2)
save("plane3.jpeg", plane3)
save("plane4.jpeg", plane4)
save("plane5.jpeg", plane5)
save("plane6.jpeg", plane6)
save("plane7.jpeg", plane7)
save("plane8.jpeg", plane8) =#

compressed_pollen = map(v -> parse(UInt8, join([v[1], v[2], v[3], v[4], v[5], "0", "0", "0"]); base=2)/255, pollen)

println(compressed_pollen[1])

save("compressed_pollen.jpeg", compressed_pollen)