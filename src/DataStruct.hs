{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- DataStruct
--}

module DataStruct
    (
        Color (..),
        Pixel (..),
        Cluster (..),
        showListOfPixels
    ) where

data Color = Color {
    red :: Int,
    green :: Int,
    blue :: Int
} deriving Eq

instance Show Color where
    show (Color r g b) = "(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

data Pixel = Pixel {
    x :: Int,
    y :: Int,
    color :: Color
} deriving Eq

instance Show Pixel where
    show (Pixel a b c) = "(" ++ show a ++ "," ++ show b ++ ") " ++ show c

data Cluster = Cluster {
    pixels :: [Pixel],
    centroid :: Pixel
}

instance Show Cluster where
    show (Cluster (b:bs) (Pixel _ _ col)) = "--\n" ++ show col ++ "\n-\n" ++ show b ++ showListOfPixels bs ++ "\n"
    show (Cluster _ _) = ""

showListOfPixels :: [Pixel] -> [Char]
showListOfPixels [] = ""
showListOfPixels (a:as) = "\n" ++ show a ++ showListOfPixels as
