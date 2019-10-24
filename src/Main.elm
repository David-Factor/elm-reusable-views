module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Event
import View.Button as Button
import View.SplitButton as SplitButton



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { count : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0 }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Increment
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    Html.main_
        []
        [ viewSection "State" <| [ Html.text << String.fromInt <| model.count ]
        , viewBasic
        , viewSimpleButtons
        , viewButtonGroup
        ]


viewSection : String -> List (Html msg) -> Html msg
viewSection title content =
    Html.section
        [ Attr.class "border border-silver rounded m2 p2" ]
        (Html.h2 [] [ Html.text title ] :: content)


viewBasic : Html Msg
viewBasic =
    viewSection "Basic button" <|
        [ Button.basic [ Attr.class "mr1" ] [ Html.text "I am" ]
        , Button.basic [] [ Html.text "Basic" ]
        ]


viewSimpleButtons : Html Msg
viewSimpleButtons =
    viewSection "Simple buttons" <|
        [ Button.view
            [ Event.onClick Increment
            , Attr.class "mr1 bg-silver"
            ]
            [ Html.text "Increment" ]
        , Button.primary
            [ Event.onClick Reset
            , Attr.class "mr1"
            ]
            [ Html.text "Reset" ]
        , Button.secondary
            [ Event.onClick Reset
            ]
            [ Html.text "Hello" ]
        ]


viewButtonGroup : Html Msg
viewButtonGroup =
    viewSection "Button groups" <|
        [ SplitButton.view
            { onClickLeft = Reset
            , onClickRight = Increment
            , leftText = "Hello"
            , attrs = [ Attr.class "mr1" ]
            }
        , SplitButton.viewOutline
            { onClickLeft = Reset
            , onClickRight = Increment
            , leftText = "Hello"
            , attrs = []
            }
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
