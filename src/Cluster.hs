{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Cluster
--}

module Cluster
    (
        defaultCluster,
        emptyCluster,
        showListOfCluster,
        getstdGen,
        createTabClusteropts,
        createTabCluster,
        isTheNearestCluster,
        assignPixelToCluster,
        assignPixelsToClusters,
        updateCentroid,
        kMeans
    ) where

import Pixel
import DataStruct
import Color
import Options
import System.Random

isConvergence :: Cluster -> Cluster -> Float -> Bool
isConvergence (Cluster _ cl1) (Cluster _ cl2) n =
    if abs(euclideanDistance cl1 cl2) <= n then True else False

hasConverge :: [Cluster] -> [Cluster] -> Float -> Bool
hasConverge [] [] _ = False
hasConverge (s:xs) (ss:ys) lim =
    if isConvergence s ss lim == True then True else hasConverge xs ys lim
hasConverge _ _ _ = False

defaultCluster :: StdGen -> Cluster
defaultCluster gen = Cluster {pixels = [],
    centroid = randomPixel gen}

emptyCluster :: [Cluster] -> [Cluster]
emptyCluster [] = []
emptyCluster (cl:cls) = Cluster {
    centroid = centroid cl,
    pixels = []} : emptyCluster cls

showListOfCluster :: [Cluster] -> [Char]
showListOfCluster [] = ""
showListOfCluster (a:as) = show a ++ showListOfCluster as

getstdGen :: StdGen -> StdGen
getstdGen gen = snd (split gen)

createTabClusteropts :: Options -> StdGen -> [Cluster]
createTabClusteropts opts gen = createTabCluster (numberOfColors opts) gen

createTabCluster :: Int -> StdGen -> [Cluster]
createTabCluster 0 _ = []
createTabCluster n seed =
    (defaultCluster gen) : (createTabCluster (n - 1) gen) where
        gen = getstdGen seed

-- targetPixel -> targetCluster -> restOfClusters -> result
isTheNearestCluster :: Pixel -> Cluster -> [Cluster] -> Bool
isTheNearestCluster _ _ [] = True
isTheNearestCluster p c (c':cs) =
    (euclideanDistance (centroid c) p) < (euclideanDistance (centroid c') p)
    && isTheNearestCluster p c cs

assignPixelToCluster :: Pixel -> [Cluster] -> [Cluster]
assignPixelToCluster _ [] = []
assignPixelToCluster p (c:cs) = if (isTheNearestCluster p c cs)
    then c {pixels = p : pixels c} : cs
    else c : assignPixelToCluster p cs

assignPixelsToClusters :: [Pixel] -> [Cluster] -> [Cluster]
assignPixelsToClusters [] cls = cls
assignPixelsToClusters (p:ps) cls =
    assignPixelsToClusters ps (assignPixelToCluster p cls)

-- current cluster list -> new cluster list updated
updateCentroid :: [Cluster] -> [Cluster]
updateCentroid [] = []
updateCentroid (c:cls) = c {centroid = Pixel {x = x (centroid c),
    y = y (centroid c),
    color = (averagecolor (pixels c) (sumcolor (pixels c))
    (color (centroid c)))}} : (updateCentroid cls)

kMeans :: [Cluster] -> [Pixel] -> Float -> [Cluster]
kMeans cls pxls lim =
    if (hasConverge cls (updateCentroid (newList)) lim)
        then (updateCentroid (newList))
        else kMeans (emptyCluster (updateCentroid
        (newList))) pxls lim
    where newList = assignPixelsToClusters pxls cls
