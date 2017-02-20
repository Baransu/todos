module Main exposing (..)

import Html exposing (Html, div, text, button, ul, li, span, input)
import Html.Attributes exposing (value, type_)
import Html.Events exposing (onClick, onInput)
import Rest
import Todos
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model [] "" "", Rest.getTodosRequest )


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", value model.title, onInput Title ] []
        , input [ type_ "text", value model.description, onInput Description ] []
        , button [ onClick PostTodo ] [ text "send request" ]
        , Todos.viewTodos model.todos
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadTodosRequest result ->
            let
                todos =
                    Result.withDefault [] result
            in
                ( { model | todos = todos }, Cmd.none )

        PostTodoRequest result ->
            let
                todos =
                    case result of
                        Ok a ->
                            [ a ]

                        Err _ ->
                            []
            in
                ( { model | todos = model.todos ++ todos }, Cmd.none )

        PostTodo ->
            let
                -- basic vaidation here to check if title nad desritio are not empty
                todo =
                    ( model.title, model.description )
            in
                ( { model
                    | title = ""
                    , description = ""
                  }
                , Rest.postTodoRequest todo
                )

        Title title ->
            ( { model | title = title }, Cmd.none )

        Description description ->
            ( { model | description = description }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
