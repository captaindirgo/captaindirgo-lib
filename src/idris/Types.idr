module Types



record Error where
  constructor Error_
  name : String

PubKey : Type
PubKey = JSBufferPtr 32

PrivKey : Type
PrivKey = JSBufferPtr 64


record Config where
  constructor Config_
  nodePubKey : PubKey
  nodePrivKey : PrivKey


data PeerState : Type where
  Pre : PeerState
  

||| State of bitorrent-tracker Client object
data BitTorrentClientState : Type where
  Pre : BitTorrentDiscoverState 
  
  ||| start() has been called on Client object
  ClientStarted : BitTorrentDiscoverState
  
  ||| A tracker has responded
  Connected : BitTorrentDiscoverState 
 
||| The state of the main DHT network 
data DHTState : Type where

data DaemonState : Type where
  Pre : DaemonState
  LookingForPeers : 
  FatalError : Error -> DaemonState
