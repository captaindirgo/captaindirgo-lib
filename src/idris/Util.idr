module Util

||| exports an Idris function so that a javacript module that requires this file can call it.
||| @ name name of function
||| @ f  function to run
%foreign "javascript:lambda: (t,t2,x,v) => {exports[x] = a => v(a)()}"
public export
prim_export : {t: Type} -> (name : String) -> (f : t -> PrimIO v) -> PrimIO () 

