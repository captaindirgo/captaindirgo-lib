
type PreClientState = { kind : "pre" }
type ConnectedState = { kind : "connected" }
type ErrorState = { kind : "error" }

export type ClientState =
  PreClientState
  | ConnectedState
  | ErrorState
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
    return { state : { kind : "connected"} }
}
