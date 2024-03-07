{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- DataStruct
--}

module DataStruct
    ( Color (..),
        defaultColor,
        Pixel (..),
        defaultPixel,
        euclideanDistance,
        showListOfPixels,
        randomPixel,
        createColor,
        createPixel,
        averagecolor,
        sumcolor,
        emptyPixel
    ) where

import System.Random

data Color = Color {
    red :: Int,
    green :: Int,
    blue :: Int
} deriving Eq

defaultColor :: Color
defaultColor = Color { red = 0, green = 0, blue = 0 }

createColor :: Int -> Int -> Int -> Color
createColor r g b = Color { red = r, green = g, blue = b }

randomColor :: StdGen -> Color
randomColor gen =
    let (r, gen') = randomR (0, 255) gen
        (g, gen'') = randomR (0, 255) gen'
        (b, _) = randomR (0, 255) gen''
    in Color { red = r, green = g, blue = b }

sumcolor :: [Pixel] -> Color
sumcolor [] = defaultColor
sumcolor (p:ps) =
    let (Color r g b) = color p
        (Color r' g' b') = sumcolor ps
    in Color (r + r') (g + g') (b + b')

averagecolor :: [Pixel] -> Color -> Color -> Color
averagecolor [] _ def = def
averagecolor tab sums _ = Color (red sums `div` length tab)
    (green sums `div` length tab) (blue sums `div` length tab)

instance Show Color where
    show (Color r g b) = "(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

data Pixel = Pixel {
    x :: Int,
    y :: Int,
    color :: Color
} deriving Eq

defaultPixel :: Pixel
defaultPixel = Pixel { x = 0, y = 0, color = defaultColor }

randomPixel :: StdGen -> Pixel
randomPixel gen = Pixel { x = 0, y = 0, color = randomColor gen }

createPixel :: Int -> Int -> Color -> Pixel
createPixel xp yp c = Pixel { x = xp, y = yp, color = c }

emptyPixel :: [Pixel] -> [Pixel]
emptyPixel _ = []

instance Show Pixel where
    show (Pixel a b c) = "(" ++ show a ++ "," ++ show b ++ ") " ++ show c

showListOfPixels :: [Pixel] -> [Char]
showListOfPixels [] = ""
showListOfPixels (a:as) = "\n" ++ show a ++ showListOfPixels as

square :: Int -> Int
square d = d * d

euclideanDistance :: Pixel -> Pixel -> Float
euclideanDistance (Pixel _ _ (Color r1 g1 b1)) (Pixel _ _ (Color r2 g2 b2)) =
    sqrt $ fromIntegral $ square(r1 - r2) + square(g1 - g2) + square(b1 - b2)
