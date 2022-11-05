
type PreClientState = { kind : "pre" }
type ConnectedState = { kind : "connected" }
type ErrorState = { kind : "error" }
type DoneState = { kind : "done" }

export type ClientState =
  PreClientState
  | ConnectedState
  | ErrorState
  | DoneState
   // ...

export type Client<ClientState> = 
{
    state : ClientState
}

/**
 * Public key for a user
 * 
 * @example
 * ```
 * let pubKey = "...pubkey..." as PubKey
 */
export type PubKey = string & { _pubkey: never }
export type PrivKey = string & { _privkey: never }

function connect(c : Client<PreClientState>) : Client<ConnectedState> | Client<ErrorState>
{
    return {state : { kind : "connected"}} 
}

export class State<T> 
{
    constructor(t : T)
    {
        this._state = t;
    }

    readonly _state: T;

    /**
     * >>
     */
    pass<T2>(func : ((t : T) => T2)): StateMonad<T2> 
    { 
        return new StateMonad<T2>(func(this._state))
    }

    // /**
    //  * >>=
    //  */
    // bind<T2>(func : ((t : T) => T2)): StateMonad<T2> 
    // { 
    //     return new StateMonad<T2>(func(this._state))
    // }
}



function doM<T>(t : T) : StateMonad<T>
{
    return new StateMonad(t)
}

function ifM<T>()

function foo(c : StateMonad<Client<PreClientState>>) : StateMonad<Client<ConnectedState | DoneState>>
{
    return c.pass(connect)
            .ifM(isError
               ,report
               ,id)
}
