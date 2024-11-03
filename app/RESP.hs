module RESP where

import qualified Data.ByteString as BS

data RESP
  = Simple
  | Bulk
  | Aggregate

strToRESP :: String -> String
strToRESP xs = ""