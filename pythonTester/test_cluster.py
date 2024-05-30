#!/usr/bin/env python
import math
from colorama import *

def parse_file():
    clusters = []
    pixels = []

    with open('source_cluster.txt', 'r') as f:
        lines = f.readlines()

        for line in lines:
            line = line.strip()
            if line.startswith("# clusters"):
                current_list = clusters
            elif line.startswith("# pixels"):
                current_list = pixels
            elif line.startswith("(") and line.endswith(")"):
                # Parse the tuple and add it to the current list
                values = line[1:-1].split(',')
                values = tuple(map(int, values))
                current_list.append(values)

    return clusters, pixels

def assign_cluster_for_pixel(clusters, pixel):
    min_distance = math.inf
    assigned_cluster = None
    for cluster in clusters:
        distance = math.sqrt((pixel[0] - cluster[0]) ** 2 + (pixel[1] - cluster[1]) ** 2 + (pixel[2] - cluster[2]) ** 2)
        if distance < min_distance:
            min_distance = distance
            assigned_cluster = cluster
    return assigned_cluster

def assign_pixels_to_clusters(clusters, pixels):
    assigned_clusters = []
    for pixel in pixels:
        min_distance = math.inf
        assigned_cluster = None
        for cluster in clusters:
            distance = math.sqrt((pixel[0] - cluster[0]) ** 2 + (pixel[1] - cluster[1]) ** 2 + (pixel[2] - cluster[2]) ** 2)
            if distance < min_distance:
                min_distance = distance
                assigned_cluster = cluster
        assigned_clusters.append(assigned_cluster)
    return assigned_clusters

def get_list_pixels_for_cluster(cluster, pixel_dico):
    pixels = []
    for pixel, assigned_cluster in pixel_dico.items():
        if assigned_cluster == cluster:
            pixels.append(pixel)
    return pixels

def print_cluster_dico(cluster_dico):
    for cluster, pixels in cluster_dico.items():
        print(Fore.BLUE + str(cluster) + " : ")
        for pixel in pixels:
            print(Fore.GREEN + str(pixel))
        print("")

# Example usage
# data struct cluster = (r,g,b)
# data struct pixel = (r,g,b)

clusters, pixels = parse_file()

pixel_dico = {}
for pixel in pixels:
    pixel_dico[pixel] = assign_cluster_for_pixel(clusters, pixel)

cluster_dico = {}
for cluster in clusters:
    cluster_dico[cluster] = get_list_pixels_for_cluster(cluster, pixel_dico)

print_cluster_dico(cluster_dico)

