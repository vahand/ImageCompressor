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
        parseArgs,
        getFilePath,
        getLim
    ) where

import System.Console.GetOpt
import System.Exit (exitWith, ExitCode (ExitFailure))
import Text.Read (readMaybe)

data Options = Options {
    numberOfColors :: Int,
    convergenceLimit :: Float,
    filePath :: FilePath
} deriving Show

defaultOptions :: Options
defaultOptions = Options { numberOfColors = 0,
    convergenceLimit = 0.0, filePath = "" }

options :: [OptDescr (Options -> Options)]
options = [
    Option ['n'] ["num-colors"] (ReqArg (\arg opt -> case readMaybe arg of
        Just n -> opt { numberOfColors = n }
        Nothing -> opt { numberOfColors = 0 }) "N") "Number of colors",
    Option ['l'] ["convergence-limit"] (ReqArg (\arg opt -> case readMaybe arg of
        Just l -> opt { convergenceLimit = l }
        Nothing -> opt { convergenceLimit = 0.0 }) "L") "Convergence limit",
    Option ['f'] ["fp"] (ReqArg (\arg opt -> opt { filePath = arg }) "F") "FP"
    ]

getFilePath :: Options -> FilePath
getFilePath opts = filePath opts

getLim :: Options -> Float
getLim opts = convergenceLimit opts

printUsage :: IO ()
printUsage =
    putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n" >>
    putStrLn "\tN\t number of colors in the final image" >>
    putStrLn "\tL\t convergence limit" >>
    putStr "\tF\t path to the file " >>
    putStrLn "containing the colors of the pixels"

parseArgs :: [String] -> IO Options
parseArgs args =
    case getOpt Permute options args of
        (opts, [], []) ->
            if numberOfColors (foldl (flip id) defaultOptions opts) == 0 ||
                convergenceLimit (foldl (flip id) defaultOptions opts) == 0.0
                then printUsage >> exitWith (ExitFailure 84)
                else return $ foldl (flip id) defaultOptions opts
        (_, _, _) -> printUsage >> exitWith (ExitFailure 84)
