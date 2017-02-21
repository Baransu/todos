module View exposing (..)

import Html exposing (Html, li, ul, div, text, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Types exposing (..)


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
            , div [] [ text description ]
            , button
                [ onClick <| CompleteTodo ( id, not completed )
                ]
                [ text "complete" ]
            , button [ onClick <| DeleteTodo id ] [ text "delete" ]
            ]


viewTodos : List Todo -> Html Msg
viewTodos todos =
    ul [] <| List.map viewTodo todos
