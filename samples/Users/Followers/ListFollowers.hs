{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Common
import Prelude ()

import qualified Github.Request         as Github
import qualified Github.Users.Followers as Github

main :: IO ()
main = do
    auth <- getAuth
    possibleUsers <- Github.executeRequestMaybe auth $ Github.usersFollowingR "mike-burns" Nothing
    putStrLn $ either (("Error: " <>) . tshow)
                      (foldMap ((<> "\n") . formatUser))
                      possibleUsers

formatUser :: Github.SimpleOwner -> Text
formatUser = Github.untagName . Github.simpleOwnerLogin
