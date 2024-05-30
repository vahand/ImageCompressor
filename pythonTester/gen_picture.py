#!/usr/bin/env python
import sys
from PIL import Image
import random
from colorama import *

def get_clusters_list_from_file(file_path):
    clusters = []

    current_cluster_read = (0,0,0)
    current_pixels_list_read = []
    line_is_cluster = False

    with open(file_path, 'r') as f:
        lines = f.readlines()

        for line in lines:
            line = line.strip()

            # begin new cluster
            if line.startswith("--"):
                clusters.append((current_cluster_read, current_pixels_list_read))
                line_is_cluster = True
                current_pixels_list_read = []
            elif line.startswith("-"):
                current_pixels_list_read = []
                line_is_cluster = False
            else:
                if line_is_cluster == True:
                    value = line[1:-1].split(',')
                    value = tuple(map(int, value))
                    current_cluster_read = value
                    line_is_cluster = False
                else:
                    tuples = line.split(' ')
                    position = tuples[0][1:-1].split(',')
                    position = tuple(map(int, position))

                    rgb_code = tuples[1][1:-1].split(',')
                    rgb_code = tuple(map(int, rgb_code))

                    current_pixels_list_read.append((position, rgb_code))
                    line_is_cluster = False

        clusters.append((current_cluster_read, current_pixels_list_read))

    return clusters


# Pixels list to Image
def draw_picture(clusters, picture_path, width, height):
    img=Image.new('RGB', (width,height), "yellow")

    for cluster in clusters:
        for pixel in cluster[1]:
            img.putpixel(pixel[0], cluster[0])

    img.save(picture_path)

def print_list_cluster(clusters):
    clusters = get_clusters_list_from_file(sys.argv[1])
    for cluster in clusters:
        print(cluster)

def main():
    if (len(sys.argv) >= 5):
        draw_picture(get_clusters_list_from_file(sys.argv[1]), sys.argv[2], int(sys.argv[3]), int(sys.argv[4]))
    else:
        print(Fore.RED + "Bad arguments." + Fore.RESET)
        print("USAGE:")
        print("\t./gen_picture.py [source_file path] [target_picture path] [image width] [image height]")

main()