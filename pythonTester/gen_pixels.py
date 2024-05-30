#!/usr/bin/env python
import sys
from PIL import Image
import random

def get_pixels_from_image(image_path):
    image = Image.open(image_path).convert("RGB")
    image_width = image.width
    image_height = image.height
    pixels_list = []

    for h in range(image_height):
        for w in range(image_width):
            rgb_code = image.getpixel((w, h))
            pixels_list.append(((w, h), rgb_code))

    return pixels_list

def print_list_pixel(pixels_list):
    for pixel in pixels_list:
        print("(" + str(pixel[0][0]) + "," + str(pixel[0][1]) + ")", end=" ")
        print("(" + str(pixel[1][0]) + "," + str(pixel[1][1]) + "," + str(pixel[1][2]) + ")")

def get_pixels_randomly():
    for i in range(1000):
        print("(0,0) (" + str(random.randint(0,255)) + "," + str(random.randint(0,255)) + "," + str(random.randint(0,255)) + ")")

def main():
    if (len(sys.argv) >= 2):
        print_list_pixel(get_pixels_from_image(sys.argv[1]))
    else:
        print("No image path provided")

main()