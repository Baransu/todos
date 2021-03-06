module View exposing (view)

import Html exposing (Html, li, ul, div, text, button, input, textarea)
import Html.Attributes exposing (style, value, type_)
import Html.Events exposing (onClick, onInput)
import Markdown exposing (Options, defaultOptions)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", value model.title, onInput <| Change "title" ] []
        , textarea [ value model.description, onInput <| Change "description" ] []
        , button [ onClick PostTodo ] [ text "send request" ]
        , viewTodos model.todos
        ]


options : Options
options =
    { defaultOptions
        | sanitize = True
        , smartypants = True
    }


viewTodo : Todo -> Html Msg
viewTodo { id, completed, title, description } =
    let
        styles =
            if completed then
                [ ( "text-decoration", "line-through" ) ]
            else
                []
    in
        li [ style styles ]
            [ div [] [ text <| toString id ]
            , div [] [ text title ]
            , Markdown.toHtmlWith options [] description
            , button
                [ onClick <| CompleteTodo ( id, not completed )
                ]
                [ text "complete" ]
            , button [ onClick <| DeleteTodo id ] [ text "delete" ]
            ]


viewTodos : List Todo -> Html Msg
viewTodos todos =
    ul [] <| List.map viewTodo todos
