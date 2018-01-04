module Main exposing (..)

import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)

import Navigation exposing (Location)

import Routing exposing (Route(..))
import Echo.Model
import Echo.Message
import Echo.Update
import Echo.View

---- MODEL ----


type alias Model =
    { route: Route
    , echoModel: Echo.Model.Model
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            parseLocation location
    in
        model ! []


parseLocation: Location -> Model
parseLocation location =
    let
        route =
            Routing.parseLocation location
        echoModel =
            case route of
                EchoRoute message ->
                    Echo.Model.init message
                _ ->
                    Echo.Model.init ""
    in
        { route = route
        , echoModel = echoModel
        }

---- UPDATE ----


type Msg
    = LocationChanged Location
    | EchoMsg Echo.Message.Msg
    | ClickLink String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EchoMsg message ->
            let
                (echoModel, cmd) =
                    Echo.Update.update message model.echoModel
            in
                { model | echoModel = echoModel } ! [Cmd.map EchoMsg cmd]
        LocationChanged location ->
            let
                model =
                    parseLocation location
            in
                model ! []
        ClickLink link ->
            model ! [Navigation.newUrl link]


---- VIEW ----


view : Model -> Html Msg
view model =
    page model


page: Model -> Html Msg
page model =
    case model.route of
        TopRoute ->
            div []
                [ div [] [ text "top" ]
                , button [ onClick (ClickLink "/echo/message") ] [ text "link" ]
                ]
        EchoRoute message ->
            Html.map EchoMsg (Echo.View.view model.echoModel)
        NotFoundRoute ->
            div [] [ text "Not Found" ]


---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program LocationChanged
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
