module View.SplitButton exposing (Config, view, viewOutline)

import FeatherIcons as Icon exposing (Icon)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event
import View.Button as Button


type alias Config msg =
    { onClickLeft : msg
    , leftText : String
    , onClickRight : msg
    , rightIcon : Icon
    , attrs : List (Html.Attribute msg)
    }


view : Config msg -> Html msg
view =
    viewBase Button.primary


viewOutline : Config msg -> Html msg
viewOutline =
    viewBase Button.secondary



-- View helpers


type alias Node msg =
    List (Html.Attribute msg) -> List (Html msg) -> Html msg


viewBase : Node msg -> Config msg -> Html msg
viewBase node cfg =
    Html.div
        (cfg.attrs ++ [ Attr.class "inline-block" ])
        [ Html.div
            [ Attr.class "flex items-center" ]
            [ node
                [ Event.onClick cfg.onClickLeft
                , Attr.class "rounded-left"
                , Attr.style "border-right" "0"
                ]
                [ Html.text cfg.leftText ]
            , node
                [ Event.onClick cfg.onClickRight
                , Attr.class "rounded-right"
                ]
                [ cfg.rightIcon |> Icon.withSize 18 |> Icon.toHtml [] ]
            ]
        ]
