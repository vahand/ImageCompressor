{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Cluster
--}

module Cluster
    ( Cluster (..),
        defaultCluster,
        showListOfCluster,
        createTabCluster,
        createTabClusteropts,
        emptyCluster,
        assignPixelsToClusters
    ) where

import DataStruct
import Options
import System.Random

data Cluster = Cluster {
    pixels :: [Pixel],
    centroid :: Pixel
}

defaultCluster :: StdGen -> Cluster
defaultCluster gen = Cluster {pixels = [defaultPixel],
    centroid = randomPixel gen}

emptyCluster :: [Cluster] -> [Cluster]
emptyCluster [] = []
emptyCluster (cl:cls) = emptyPixel (pixels cl) >> emptyCluster cls

instance Show Cluster where
    show (Cluster (b:bs) (Pixel _ _ col)) = "--\n" ++ show col ++ "\n-\n" ++ show b ++ showListOfPixels bs ++ "\n"
    show (Cluster _ _) = ""

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
