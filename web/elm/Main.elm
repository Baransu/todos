module Main exposing (..)

import Html exposing (program)
import State
import Types exposing (..)
import View


main : Program Never Model Msg
main =
    program
        { init = State.init
        , view = View.view
        , update = State.update
        , subscriptions = (\_ -> Sub.none)
        }
