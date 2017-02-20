module Rest exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
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


decodePostTodo : Decode.Decoder Todo
decodePostTodo =
    Decode.field "data" decodeTodo


postTodo : ( String, String ) -> Http.Request Todo
postTodo ( title, description ) =
    let
        todo =
            Encode.object
                [ ( "title", Encode.string title )
                , ( "description", Encode.string description )
                ]

        body =
            Encode.object [ ( "todo", todo ) ]
                |> Http.jsonBody
    in
        Http.post "/api/todos" body decodePostTodo


getTodosRequest : Cmd Msg
getTodosRequest =
    Http.send LoadTodosRequest getTodos


postTodoRequest : ( String, String ) -> Cmd Msg
postTodoRequest todo =
    Http.send PostTodoRequest <| postTodo todo
