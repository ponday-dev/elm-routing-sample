module Echo.View exposing (view)

import Html exposing (Html, div, text)

import Echo.Model exposing (Model)
import Echo.Message exposing (Msg)

view: Model -> Html Msg
view model =
    div []
        [ div [] [ text "echo route" ]
        , div [] [ text model.msg ]
        ]
