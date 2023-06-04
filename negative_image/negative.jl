import Pkg; 
Pkg.add("Images")
Pkg.add("FileIO")

using Images, FileIO

img_filament_path = "../images/tungsten_filament_shaded.tif"
img_filament = load(img_filament_path)

img_filament = Float64.(img_filament)

neg = map(v -> (1-v), img_filament)

save("neg.jpeg", neg)