using Images
using FileIO

"""
    substitution_encryption(image, keys; path_for_result="./encrypted.png")

Performs substitution encryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the order of the keys matter.

# Arguments
- `image::Array{RGB{N0f8},2}`: A loaded image.
- `keys::Array{Int64, 1}`: Keys for encryption.
- `path_for_result::String`: The path for storing the encrypted image.

# Returns
- `encryptedImage::Array{RGB{N0f8}, 2}`: Encrypted image.

# Example
```jldoctest
julia> using Images, ChaoticEncryption

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_encryption(img, keys)
ENCRYPTING
ENCRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.902,0.902,0.902)
 RGB{N0f8}(0.918,0.918,0.918)     RGB{N0f8}(0.753,0.753,0.753)
 RGB{N0f8}(0.027,0.027,0.027)     RGB{N0f8}(0.051,0.051,0.051)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.02,0.02,0.02)
 RGB{N0f8}(0.369,0.369,0.369)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.576,0.576,0.576)  …  RGB{N0f8}(0.769,0.769,0.769)
 RGB{N0f8}(0.894,0.894,0.894)     RGB{N0f8}(0.463,0.463,0.463)
 RGB{N0f8}(0.376,0.376,0.376)     RGB{N0f8}(0.757,0.757,0.757)
 RGB{N0f8}(0.631,0.631,0.631)     RGB{N0f8}(0.325,0.325,0.325)
 RGB{N0f8}(0.647,0.647,0.647)     RGB{N0f8}(0.655,0.655,0.655)
 ⋮                             ⋱
 RGB{N0f8}(0.086,0.086,0.086)     RGB{N0f8}(0.098,0.098,0.098)
 RGB{N0f8}(0.769,0.769,0.769)     RGB{N0f8}(0.251,0.251,0.251)
 RGB{N0f8}(0.459,0.459,0.459)     RGB{N0f8}(0.016,0.016,0.016)
 RGB{N0f8}(0.302,0.302,0.302)     RGB{N0f8}(0.804,0.804,0.804)
 RGB{N0f8}(0.153,0.153,0.153)  …  RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.78,0.78,0.78)        RGB{N0f8}(0.8,0.8,0.8)
 RGB{N0f8}(0.075,0.075,0.075)     RGB{N0f8}(0.988,0.988,0.988)
 RGB{N0f8}(0.208,0.208,0.208)     RGB{N0f8}(0.498,0.498,0.498)
 RGB{N0f8}(0.839,0.839,0.839)     RGB{N0f8}(0.576,0.576,0.576)
```
"""
function substitution_encryption(
    image::Array{RGB{N0f8},2},
    keys::Vector{Int64};
    path_for_result::String="./encrypted.png",
)
    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    encryptedImage = copy(image)

    println("ENCRYPTING")

    for i = 1:height
        for j = 1:width
            rgb = encryptedImage[i, j]
            r, g, b = trunc(Int, rgb.r * 255), trunc(Int, rgb.g * 255), trunc(Int, rgb.b * 255)
            encryptedImage[i, j] = RGB((r ⊻ keys[z]) / 255, (g ⊻ keys[z]) / 255, (b ⊻ keys[z]) / 255)
            z += 1
        end
    end

    println("ENCRYPTED")
    save(path_for_result, encryptedImage)

    return encryptedImage
end


"""
    substitution_decryption(image, keys; path_for_result="./decrypted.png")

Performs substitution decryption on a given image with the given keys.

# Algorithm
Iterates simulataneously over each pixel and key, and XORs the pixel value
(all R, G, and B) with the given key. Hence, the keys provided must be the same
as the ones provided during encryption.

# Arguments
- `image`: `::String` or `::Array{RGB{N0f8},2}`. The path to the image or the loaded image to be decrypted.
- `keys::Array{Int64, 1}`: Keys for decryption.
- `path_for_result::String`: The path for storing the decrypted image.

# Returns
- `decryptedImage::Array{RGB{N0f8}, 2}`: Decrypted image.

# Example
```jldoctest
julia> using Images, ChaoticEncryption

julia> img = load("../test_images/camera.jfif")
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.608,0.608,0.608)     RGB{N0f8}(0.0,0.0,0.0)
 ⋮                             ⋱
 RGB{N0f8}(0.4,0.4,0.4)           RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.447,0.447,0.447)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.427,0.427,0.427)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.451,0.451,0.451)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.51,0.51,0.51)     …  RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.537,0.537,0.537)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.412,0.412,0.412)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.0,0.0,0.0)           RGB{N0f8}(0.0,0.0,0.0)

julia> height, width = size(img)
(225, 225)

julia> keys = logistic_key(0.01, 3.97, height * width)
50625-element Vector{Int64}:
   0
  44
   7
  26
  14
 224
  16
 250
 162
 211
   ⋮
  72
 255
  80
  84
  21
 154
 197
  82
 147

julia> substitution_decryption(img, keys)
DECRYPTING
DECRYPTED
225×225 Array{RGB{N0f8},2} with eltype RGB{N0f8}:
 RGB{N0f8}(0.608,0.608,0.608)  …  RGB{N0f8}(0.902,0.902,0.902)
 RGB{N0f8}(0.918,0.918,0.918)     RGB{N0f8}(0.753,0.753,0.753)
 RGB{N0f8}(0.027,0.027,0.027)     RGB{N0f8}(0.051,0.051,0.051)
 RGB{N0f8}(0.149,0.149,0.149)     RGB{N0f8}(0.02,0.02,0.02)
 RGB{N0f8}(0.369,0.369,0.369)     RGB{N0f8}(0.0,0.0,0.0)
 RGB{N0f8}(0.576,0.576,0.576)  …  RGB{N0f8}(0.769,0.769,0.769)
 RGB{N0f8}(0.894,0.894,0.894)     RGB{N0f8}(0.463,0.463,0.463)
 RGB{N0f8}(0.376,0.376,0.376)     RGB{N0f8}(0.757,0.757,0.757)
 RGB{N0f8}(0.631,0.631,0.631)     RGB{N0f8}(0.325,0.325,0.325)
 RGB{N0f8}(0.647,0.647,0.647)     RGB{N0f8}(0.655,0.655,0.655)
 ⋮                             ⋱
 RGB{N0f8}(0.086,0.086,0.086)     RGB{N0f8}(0.098,0.098,0.098)
 RGB{N0f8}(0.769,0.769,0.769)     RGB{N0f8}(0.251,0.251,0.251)
 RGB{N0f8}(0.459,0.459,0.459)     RGB{N0f8}(0.016,0.016,0.016)
 RGB{N0f8}(0.302,0.302,0.302)     RGB{N0f8}(0.804,0.804,0.804)
 RGB{N0f8}(0.153,0.153,0.153)  …  RGB{N0f8}(0.282,0.282,0.282)
 RGB{N0f8}(0.78,0.78,0.78)        RGB{N0f8}(0.8,0.8,0.8)
 RGB{N0f8}(0.075,0.075,0.075)     RGB{N0f8}(0.988,0.988,0.988)
 RGB{N0f8}(0.208,0.208,0.208)     RGB{N0f8}(0.498,0.498,0.498)
 RGB{N0f8}(0.839,0.839,0.839)     RGB{N0f8}(0.576,0.576,0.576)
```
"""
function substitution_decryption(
    image,
    keys::Vector{Int64};
    path_for_result::String="./decrypted.png",
)

    if typeof(image) == String
        image = load(image)
    elseif typeof(image) != Array{RGB{N0f8},2}
        throw(ArgumentError("image must be of the type ::String or ::Array{RGB{N0f8},2}"))
    end

    # Generating dimensions of the image
    height = size(image)[1]
    width = size(image)[2]

    if length(keys) != height * width
        throw(ArgumentError("Number of keys must be equal to height * width of image."))
    end

    z = 1

    decryptedImage = copy(image)
    println("DECRYPTING")

    for i = 1:height
        for j = 1:width
            rgb = decryptedImage[i, j]
            r, g, b = trunc(Int, rgb.r * 255), trunc(Int, rgb.g * 255), trunc(Int, rgb.b * 255)
            decryptedImage[i, j] = RGB((r ⊻ keys[z]) / 255, (g ⊻ keys[z]) / 255, (b ⊻ keys[z]) / 255)
            z += 1
        end
    end

    println("DECRYPTED")
    save(path_for_result, decryptedImage)

    return decryptedImage
end
