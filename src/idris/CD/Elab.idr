module Elab

import Language.Reflection
import Language.Reflection.Types
import Language.Reflection.Syntax

getSingleCon : TypeInfo -> Elab Con
getSingleCon (MkTypeInfo _ _ [con]) = pure con
getSingleCon (MkTypeInfo _ _ _) = fail "data objects must have one and only one constructor"

makeSimpleRecordFromJS : Name -> Elab ()
makeSimpleRecordFromJS n =
  do
    ti <- getInfo' n
    con <- getSingleCon ti
    
    let onlyRealArgs = filter notZeroArgs con.args
    
    traverse {f=Elab}
      (\arg => 
    -- ignore $ traverse {f=Elab}
    --   (\arg => do
    --      decl <- mkDeclareLensArg ti con arg
    --      declare decl)
    --   onlyRealArgs

    let decl = `[
    
-- ** start code template ** 
TEMPLATE : JSObject -> CoreIO ~(n)
TEMPLATE =
  (map cn (fromJS a) 
  >>= flip (map (fromJS b))
  >>= flip (map (fromJS c))
       
          
                
    pure ()
  where
    notZeroArgs : Arg x -> Bool
    notZeroArgs a = case a.count of
                      M0 => False
                      _ => True
    
