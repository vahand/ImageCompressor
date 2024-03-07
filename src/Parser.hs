{-
--
-- EPITECH PROJECT, 2024
-- compressor
-- File description:
-- Parser
--
-}

module Parser
    (
        parse,
        getLinesListFromFile
    )
where

import DataStruct

getLinesListFromFile :: FilePath -> IO [String]
getLinesListFromFile path = do
    content <- readFile path
    return $ lines content

getFirstTuple :: String -> (Int, Int)
getFirstTuple str = case reads str of
    [(tuple, "")] -> tuple
    _             -> (0,0)


getSecondTuple :: String -> (Int, Int, Int)
getSecondTuple str = case reads str of
    [(tuple, "")] -> tuple
    _             -> (0,0,0)

concatTuple :: (Int, Int) -> (Int, Int, Int) -> (Int, Int, Int, Int, Int)
concatTuple (a, b) (c, d, e) = (a, b, c, d, e)

getTupleFromLine :: String -> (Int, Int, Int, Int, Int)
getTupleFromLine line = concatTuple
    (getFirstTuple (head (words line)))
    (getSecondTuple (last (words line)))

createPixelFromTuple :: (Int, Int, Int, Int, Int) -> Pixel
createPixelFromTuple (xp, yp, r, g, b) = createPixel xp yp (createColor r g b)

parseLine :: String -> Pixel
parseLine line = createPixelFromTuple (getTupleFromLine line)

parse :: [String] -> [Pixel]
parse [] = []
parse (c:cs) = parseLine c : parse cs
