{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Network.Simple.TCP (serve, HostPreference(HostAny), Socket, closeSock, send, recv)
import Network.Socket (socket)


main :: IO ()
main = do
    let port = "6379"
    putStrLn $ "Redis server listening on port " ++ port
    serve HostAny port $ \(socket, address) -> do
        putStrLn $ "successfully connected client: " ++ show address
        loop socket

loop :: Socket -> IO()
loop sock = do
    msg <- recv sock 128
    case msg of
        Nothing -> putStrLn "Client has exited!"
        (Just bs) -> do
            send sock "+PONG\r\n"
            loop sock
            
