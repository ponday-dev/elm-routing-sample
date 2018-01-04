module Echo.Update exposing (update)

import Echo.Model exposing (Model)
import Echo.Message exposing (Msg(..))

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateMessage message ->
            { model | msg = message } ! []
