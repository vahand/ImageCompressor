{--
-- EPITECH PROJECT, 2024
-- compressor
-- File description:
-- Pixel
--}


module Pixel
    (
        defaultPixel,
        randomPixel,
        createPixel,
        emptyPixel,
        square,
        euclideanDistance
    ) where

import Color
import DataStruct
import System.Random

defaultPixel :: Pixel
defaultPixel = Pixel { x = 0, y = 0, color = defaultColor }

randomPixel :: StdGen -> Pixel
randomPixel gen = Pixel { x = 0, y = 0, color = randomColor gen }

createPixel :: Int -> Int -> Color -> Pixel
createPixel xp yp c = Pixel { x = xp, y = yp, color = c }

emptyPixel :: [Pixel] -> [Pixel]
emptyPixel _ = []

square :: Int -> Int
square d = d * d

euclideanDistance :: Pixel -> Pixel -> Float
euclideanDistance (Pixel _ _ (Color r1 g1 b1)) (Pixel _ _ (Color r2 g2 b2)) =
    sqrt $ fromIntegral $ square(r1 - r2) + square(g1 - g2) + square(b1 - b2)
