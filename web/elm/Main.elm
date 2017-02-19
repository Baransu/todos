module Main exposing (..)

import Html exposing (Html, div, text, button, ul, li, span)
import Rest
import Todos
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( [], Rest.sendTodosRequest )


view : Model -> Html Msg
view model =
    div []
        [ Todos.viewTodos model ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadTodos result ->
            let
                todos =
                    Result.withDefault [] result
            in
                ( todos, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
