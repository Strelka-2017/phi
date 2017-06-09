module Action exposing (Msg(..))

import Simulation.Model exposing (PVPanel, Peer, TransmissionLine, Weather, WindTurbine)


type Msg
    = Input String
    | SendUserChatMsg
    | SendBotChatMsg String
    | NoOp
    | CheckWeather
    | DescribeNode Int
    | AddPVPanel PVPanel
    | AddWindTurbine WindTurbine
    | AddPeer Peer
    | AddEdge TransmissionLine
    | RenderPhiNetwork
    | UpdateWeather Weather
    | CallTurn
    | Tick Int
    | DaySummary
