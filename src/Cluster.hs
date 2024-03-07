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
        emptyCluster
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
