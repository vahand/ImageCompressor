# Image Compressor

This project was carried out during our second year at EPITECH in **Haskell**.

🚀 The aim of this project was to develop an image compressor program based on the K-means algorithm.

## Launch the program
Launch the program simply lists the various clusters in the new compressed image.

To launch the program, follow these commands from the root directory of the repository:
```
make fclean
make
```
```
./imageCompressor -n [number_of_clusters] -l [convergence_limit] -f [source_image_pixels_list]
```
> **_NOTE_**: if the command `make fclean` return an error, it means that no cleaning was necessary.

## Launch the program with image generation
To get the compressed image in **.png** format, go to `pythonTester` directory by executing the command `cd pythonTester` and follow this command:
```
./compressor.sh [image_to_compress_path] [number_of_clusters] [convergence_limit]
```
The new compressed image will be stored in `/compressed_images` directory.

### Example
By executing `./compressor.sh source_images/Apple_Park.jpg 8 5` command, we obtain the following result:

**Original image:**
![Apple_Park](https://github.com/vahand/ImageCompressor/assets/97789425/eb96864e-1294-4903-9341-09cbd7cf9571)

**Compressed image with *8* clusters and a convergence limit of *5*:**
![Apple_Park_compressed_8](https://github.com/vahand/ImageCompressor/assets/97789425/fd34d9a7-f057-44b6-a6f5-edc1c544fd4f)

