module Rest exposing (..)

import Http
import Json.Decode as Decode
import Types exposing (..)


decodeTodo : Decode.Decoder Todo
decodeTodo =
    Decode.map3 Todo
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "description" Decode.string)


decodeTodos : Decode.Decoder (List Todo)
decodeTodos =
    Decode.field "data" (Decode.list decodeTodo)


getTodos : Http.Request (List Todo)
getTodos =
    Http.get "/api/todos" decodeTodos


sendTodosRequest : Cmd Msg
sendTodosRequest =
    Http.send LoadTodos getTodos
