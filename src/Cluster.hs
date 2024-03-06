{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Cluster
--}

module Cluster
    ( Cluster (..),
        defaultCluster,
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
    show (Cluster (b:bs) (Pixel _ _ col)) = "--\n" ++ show col ++ "\n-\n" ++ show b ++ showListOfPixels bs
    show (Cluster _ _) = ""
