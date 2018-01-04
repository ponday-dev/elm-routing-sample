module Echo.Model exposing (Model, init)

type alias Model =
    { msg: String
    }


init: String -> Model
init message =
    Model message

