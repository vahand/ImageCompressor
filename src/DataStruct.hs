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
        defaultPixel
    ) where

data Color = Color {
    red :: Int,
    green :: Int,
    blue :: Int
}

defaultColor :: Color
defaultColor = Color { red = 0, green = 0, blue = 0 }

instance Show Color where
    show (Color r g b) = "(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

data Pixel = Pixel {
    x :: Int,
    y :: Int,
    color :: Color
}

defaultPixel :: Pixel
defaultPixel = Pixel { x = 0, y = 0, color = defaultColor }

instance Show Pixel where
    show (Pixel a b c) = "(" ++ show a ++ "," ++ show b ++ ") " ++ show c
