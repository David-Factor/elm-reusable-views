module View.DropDown exposing (Config, State, close, init, view)

import Browser.Events
import FeatherIcons as Icon
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event
import Json.Decode as Decode
import View.Button as Button



-- STATE


type State
    = State DropState


init : State
init =
    State Closed


type DropState
    = Open
    | Closed



-- UPDATES


toggle : State -> State
toggle (State state) =
    case state of
        Open ->
            State Closed

        Closed ->
            State Open


close : Sub State
close =
    Browser.Events.onClick <| Decode.succeed <| State Closed



-- VIEWS


type alias Config msg =
    State -> msg


view : Config msg -> State -> Html msg
view toMsg state =
    Html.div
        [ Attr.class "relative" ]
        [ Button.primary
            [ stopPropOnClick <| toMsg (toggle state)
            , Attr.class "flex items-center"
            ]
            [ Html.span [ Attr.class "mr1" ] [ Html.text "Hello" ]
            , Icon.chevronDown |> Icon.withSize 18 |> Icon.toHtml []
            ]
        , viewDropDown
            [ Attr.class "absolute"
            , Attr.style "top" "100%"
            , stopPropOnClick <| toMsg (State Open)
            ]
            state
        ]


viewDropDown : List (Html.Attribute msg) -> State -> Html msg
viewDropDown attrs (State dropState) =
    case dropState of
        Open ->
            Html.div
                (attrs ++ [ Attr.class "p4 border border-silver rounded bg-white" ])
                [ Html.text "Hi!" ]

        Closed ->
            Html.text ""



-- VIEW HELPERS


stopPropOnClick : msg -> Html.Attribute msg
stopPropOnClick msg =
    Event.stopPropagationOn "click" <| Decode.succeed ( msg, True )
