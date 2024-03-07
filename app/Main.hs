{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Main
--}

module Main (main) where

import Options
import DataStruct()
import Cluster
import System.Random

import System.Environment (getArgs)
import Parser

printLines :: [String] -> IO ()
printLines [] = return ()
printLines (x:xs) = putStrLn x >> printLines xs

main :: IO ()
main = do
    args <- getArgs
    opts <- parseArgs args
    print opts
    gen <- newStdGen
    let tab = createTabClusteropts opts gen
    putStr (showListOfCluster tab)
