{--
-- EPITECH PROJECT, 2024
-- compressor
-- File description:
-- Color
--}

module Color
    (
        defaultColor,
        createColor,
        randomColor,
        sumcolor,
        averagecolor
    ) where

import DataStruct
import System.Random

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

-- for each cluster of the list
-- cluster pixels list -> sum of colors of pixels list -> current centroid --> new centroid
averagecolor :: [Pixel] -> Color -> Color -> Color
averagecolor [] _ def = def
averagecolor tab sums _ = Color (red sums `div` length tab)
    (green sums `div` length tab) (blue sums `div` length tab)
