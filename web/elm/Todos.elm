module Todos exposing (..)

import Html exposing (Html, li, ul, div, text)
import Types exposing (..)


viewTodo : Todo -> Html Msg
viewTodo { id, title, description } =
    li []
        [ div [] [ text title ]
        , div [] [ text description ]
        ]


viewTodos : List Todo -> Html Msg
viewTodos todos =
    ul [] <| List.map viewTodo todos
