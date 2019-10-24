module View.Button exposing (primary, secondary, view)

import Html exposing (Html)
import Html.Attributes as Attr


view : List (Html.Attribute msg) -> List (Html msg) -> Html msg
view attrs children =
    Html.button (attrs ++ [ Attr.class "btn" ]) children


primary : List (Html.Attribute msg) -> List (Html msg) -> Html msg
primary attrs children =
    view (Attr.class "btn-primary" :: attrs) children


secondary : List (Html.Attribute msg) -> List (Html msg) -> Html msg
secondary attrs children =
    view (Attr.class "btn-outline" :: attrs) children
