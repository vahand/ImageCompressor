module Main (main) where

import Lib
import Parser

printLines :: [String] -> IO ()
printLines [] = return ()
printLines (x:xs) = putStrLn x >> printLines xs

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"
    parse "test.txt"
    putStrLn "End of program"
