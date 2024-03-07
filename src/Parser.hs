{-
--
-- EPITECH PROJECT, 2024
-- compressor
-- File description:
-- Parser
--
-}

module Parser
    ( parse
    )
where

import System.IO

get_file_content :: String -> IO String
get_file_content filename = readFile filename

get_lines_of_file :: String -> IO [String]
get_lines_of_file filename = do
    content <- get_file_content filename
    return (lines content)

printLines :: [String] -> IO ()
printLines [] = return ()
printLines (x:xs) = putStrLn x >> printLines xs

parse :: String -> IO ()
parse filename = do
    lines <- get_lines_of_file filename
    printLines lines
