import Pkg; 
Pkg.add("Images")
Pkg.add("FileIO")
#Pkg.add("ImageMagick")
#Pkg.add("ImageIO")

using Images, FileIO

img_filament_path = "../images/tungsten_filament_shaded.tif"
img_filament = load(img_filament_path)

img_shading_path = "../images/tungsten_sensor_shading.tif"
img_shading = load(img_shading_path)

img_filament = Float64.(img_filament)
img_shading = Float64.(img_shading)

img = img_filament ./ img_shading

println(img[1])
println(img_filament[1])

save("img.jpeg", img)