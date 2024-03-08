{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Main
--}

module Main (main) where

import Options
import DataStruct
import Cluster
import System.Random

import System.Environment (getArgs)
import Parser

main :: IO ()
main = do
    args <- getArgs
    opts <- parseArgs args
    print opts
    gen <- newStdGen
    let tab = createTabClusteropts opts gen
    linesFromFile <- getLinesListFromFile $ getFilePath opts
    let pixelsLet = parse linesFromFile
    putStr (showListOfCluster (assignPixelsToClusters pixelsLet tab))
