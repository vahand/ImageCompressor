{--
-- EPITECH PROJECT, 2024
-- FUN
-- File description:
-- Convergence
--}

module Convergence
    ( isConvergence,
        hasConverge
    ) where

import Cluster
import DataStruct

isConvergence :: Cluster -> Cluster -> Float -> Bool
isConvergence (Cluster _ cl1) (Cluster _ cl2) n =
    if euclideanDistance cl1 cl2 <= n then True else False

hasConverge :: [Cluster] -> [Cluster] -> Float -> Bool
hasConverge [] [] _ = False
hasConverge (s:xs) (ss:ys) a =
    if isConvergence s ss a == True then True else hasConverge xs ys a
hasConverge _ _ _ = False
