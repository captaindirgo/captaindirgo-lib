module CD.Util

import CD.BaseTypes

||| exports an Idris function so that a javacript module that requires this file can call it.
||| @ name name of function
||| @ f  function to run
%foreign "javascript:lambda: (t,t2,x,v) => {exports[x] = a => v(a)()}"
export
prim__export : (name : String) -> (f : t -> PrimIO v) -> PrimIO () 

public export
interface FromJS t t2 where
  fromJS : t -> CoreIO t2
  
  
%foreign "javascript:lambda: (s) => {return typeof s === 'string'}"
export
prim__isString : (name : String) -> PrimIO Bool

fromJsToPrim : ((v : t) -> PrimIO Bool) -> AnyPtr -> CoreIO t
fromJsToPrim f v =
  do
    True <- liftIO $ primIO $ f v
      | False => throwE (Error_ "wrong type") --TODO 3 better error message
    pure (believe_me v)

public export 
FromJS String String where
  fromJS = pure {f=CoreIO} --fromJsToPrim prim__isString
  

||| Exports an Idris function so that a javacript module that requires this file can call it.
||| @ ef error function - called when there is an error, typically should throw a js exception
||| @ n name of function - this is the name of function within javascript
||| @ f function - function to run when called from js
export
exportFunc : FromJS t t2 => (e : Error -> IO v) -> (name : String) -> (f : t2 -> IO v) -> IO ()
exportFunc ef n f =
  do
    primIO $ prim__export n 
      (\ap => 
         toPrim $ do
           Right arg <- runEitherT $ fromJS {t} ap
              | Left e => ef e
           f arg
           )

%foreign "javascript:lambda: (str) => {throw new Error(str)}"
export 
prim__throwJSException : String -> PrimIO ()

export 
throwJSException : Error -> IO x
throwJSException e = 
  do 
    primIO $ prim__throwJSException e.msg
    pure (believe_me ()) -- never will be reached


 
