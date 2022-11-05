module CD.Main

import CD.Util

-- public export
-- jsStart : AnyPtr -> PrimIO ()
-- jsStart rawConfig = 
--   do
--     config <- marshall rawConfig
--     pure ()

public export 
main : IO ()
main = 
  do
    -- prim_export "start" jsStart
    pure ()
