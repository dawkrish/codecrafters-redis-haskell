{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import qualified Network.Simple.TCP as TCP

main :: IO ()
main = do
    let port = "6379"
    putStrLn $ "Redis server listening on port " ++ port
    TCP.serve TCP.HostAny port $ \(socket, address) -> do
        putStrLn $ "Client connected: " ++ show address
        loop socket
        putStrLn $ "Client disconnected: " ++ show address

loop :: TCP.Socket -> IO()
loop sock = do
    msg <- TCP.recv sock 1024
    case msg of
        Nothing -> putStrLn "Client has exited!"
        (Just bs) -> do
            TCP.send sock "+PONG\r\n"
            loop sock
            
