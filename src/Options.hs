{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Options
--}

module Options
    ( Options (..),
        defaultOptions,
        options,
        parseArgs
    ) where

import System.Console.GetOpt
import System.Exit (exitFailure)

data Options = Options {
    numberOfColors :: Int,
    convergenceLimit :: Int,
    filePath :: FilePath
} deriving Show

defaultOptions :: Options
defaultOptions = Options { numberOfColors = 0,
    convergenceLimit = 0, filePath = "" }

options :: [OptDescr (Options -> Options)]
options = [
    Option ['n'] ["num-colors"] (ReqArg (\arg opt -> opt
        { numberOfColors = read arg }) "N") "Nbr of colors in the final image",
    Option ['l'] ["convergence-limit"] (ReqArg (\arg opt -> opt
        { convergenceLimit = read arg }) "L") "Convergence limit",
    Option ['f'] ["file-path"] (ReqArg (\arg opt -> opt
        { filePath = arg }) "F") "File containing the colors of the pixels"
    ]

parseArgs :: [String] -> IO Options
parseArgs args =
    case getOpt Permute options args of
        (opts, [], []) -> return $ foldl (flip id) defaultOptions opts
        (_, _, _) ->
            putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n" >>
            putStrLn "\tN\t number of colors in the final image" >>
            putStrLn "\tL\t convergence limit" >>
            putStr "\tF\t path to the file " >>
            putStrLn "containing the colors of the pixels" >>
            exitFailure
