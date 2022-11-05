module CD.BaseTypes

import public Control.Monad.Trans
import public Control.Monad.Either

public export
record Error where
  constructor Error_
  msg : String

public export
CoreIO : Type -> Type
CoreIO = EitherT Error IO
