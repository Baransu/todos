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
        [ input [ type_ "text", value model.title, onInput <| Change "title" ] []
        , input [ type_ "text", value model.description, onInput <| Change "description" ] []
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

        UpdateTodoRequest result ->
            let
                todos =
                    case result of
                        Ok todo ->
                            model.todos
                                |> List.map
                                    (\a ->
                                        if a.id == todo.id then
                                            todo
                                        else
                                            a
                                    )

                        Err _ ->
                            model.todos
            in
                ( { model | todos = todos }, Cmd.none )

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

        CompleteTodo ( id, completed ) ->
            ( model, Rest.updateTodoRequest ( id, completed ) )

        Change field value ->
            case field of
                "title" ->
                    ( { model | title = value }, Cmd.none )

                "description" ->
                    ( { model | description = value }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
