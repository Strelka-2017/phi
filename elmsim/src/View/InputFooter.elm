module View.InputFooter exposing (viewInputFooter)

import Action exposing (Msg(..))
import Chat.Model exposing (BotChatItem(MultiChoiceItem), ChatItem(BotItem), MultiChoiceAction(McaAddGenerators, McaAddPeers, McaBuyCables, McaRunDay, McaSkipIntro), defaultMcaList, mcaName)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (autofocus, class, style, value)
import Html.Events exposing (keyCode, on, onInput)
import Json.Decode as Json
import Material.Button as Button
import Material.Chip as Chip
import Material.Options as Options
import Model exposing (Model)


viewInputFooter : Model -> Html Msg
viewInputFooter model =
    div [ class "input_footer" ]
        [ div [ class "tint_overlay" ] []
        , multiChoiceFooter model.inputAvailable model
        , div [ class "input_wrapper" ] [ freeTextFooter model ]
        ]


multiChoiceFooter : Bool -> Model -> Html Msg
multiChoiceFooter multiEnabled model =
    div [ class "mca_container" ]
        (List.map (viewMCA multiEnabled) model.mcaList)


freeTextFooter : Model -> Html Msg
freeTextFooter model =
    let
        isEnter num =
            case num of
                13 ->
                    SendUserChatMsg

                _ ->
                    NoOp

        onEnter =
            on "keyup" (Json.map isEnter keyCode)
    in
    div [ class "input_container" ]
        [ input
            [ class "message_input"
            , autofocus True
            , onEnter
            , onInput Input
            , value model.input
            ]
            []
        , div [ class "hline" ] []
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Button.flat
            , Options.onClick SendUserChatMsg
            , Options.cs "send_button"
            ]
            [ text "Send" ]
        ]


viewMCA : Bool -> MultiChoiceAction -> Html Msg
viewMCA enabled action =
    let
        class =
            case enabled of
                True ->
                    "multi_button"

                False ->
                    "multi_button disabled"
    in
    Chip.span
        [ Options.cs class
        , Options.onClick (MultiChoiceMsg action)
        ]
        [ Chip.text [] <| mcaName action ]
