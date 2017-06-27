module Chat.Model exposing (..)

import Dict exposing (Dict)
import Html exposing (img)


type InputType
    = MultiChoiceInput
    | FreeTextInput


type ChatItem
    = UserMessage UserChatMessage
    | BotItem BotChatItem


type alias UserChatMessage =
    String


type alias BotChatMessage =
    String


type BotChatItem
    = WidgetItem Widget
    | BotMessage BotChatMessage
    | MultiChoiceItem MultiChoiceMessage


type alias MultiChoiceMessage =
    { text : String
    , options : List MultiChoiceAction
    }


type MultiChoiceAction
    = McaRunDay
    | McaRunWeek
    | McaWeatherForecast
      --    | McaChangeDesign
    | McaAddPeers
    | McaAddGenerators
    | McaBuyCables
    | McaLeaveBuildMode
    | McaSelectLocation Int


mcaName : MultiChoiceAction -> String
mcaName action =
    case action of
        McaRunDay ->
            "Next Day"

        McaWeatherForecast ->
            "Weather"

        --        McaChangeDesign ->
        --            "Change Design"
        McaAddPeers ->
            "Add Peers"

        McaAddGenerators ->
            "Add Generators"

        McaBuyCables ->
            "Buy Cables"

        McaRunWeek ->
            "Next Week"

        McaLeaveBuildMode ->
            "Leave Build Mode"

        McaSelectLocation n ->
            "Selection some location"


type Widget
    = WeatherWidget
    | BotMultiQuestion
    | ImageSrc String


initChat : ChatItem
initChat =
    BotItem <|
        BotMessage
            """Welcome to Φ Chat! I only respond to commands for now.
Current available commands are:

/weather (i tell you abt the weather today)
/turn (i move to the next day)
/describe [nodeId] (i tell you some info about a specific node)
"""
