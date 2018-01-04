module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (Parser, parsePath, oneOf, s, string, top, map, (</>))

type Route
    = TopRoute
    | EchoRoute String
    | NotFoundRoute


matcher: Parser (Route -> a) a
matcher =
    oneOf
        [ map TopRoute top
        , map EchoRoute (s "echo" </> string)
        ]


parseLocation: Location -> Route
parseLocation location =
    case (parsePath matcher location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

