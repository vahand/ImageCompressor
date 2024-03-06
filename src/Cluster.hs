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
        createTabCluster
    ) where

import DataStruct

data Cluster = Cluster {
    pixels :: [Pixel],
    centroid :: Pixel
}

defaultCluster :: Cluster
defaultCluster = Cluster {pixels = [defaultPixel, defaultPixel],
    centroid = defaultPixel}

instance Show Cluster where
    show (Cluster (b:bs) (Pixel _ _ col)) = "--\n" ++ show col ++ "\n-\n" ++ show b ++ showListOfPixels bs ++ "\n"
    show (Cluster _ _) = ""

showListOfCluster :: [Cluster] -> [Char]
showListOfCluster [] = ""
showListOfCluster (a:as) = show a ++ showListOfCluster as

createTabCluster :: Int -> [Cluster]
createTabCluster 0 = []
createTabCluster n = replicate n defaultCluster
