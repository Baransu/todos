module Rest
    exposing
        ( getTodosRequest
        , postTodoRequest
        , updateTodoRequest
        , deleteTodoRequest
        )

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Types exposing (..)


-- PUBLIC API


getTodosRequest : Cmd Msg
getTodosRequest =
    Http.send LoadTodosRequest getTodos


postTodoRequest : ( String, String ) -> Cmd Msg
postTodoRequest todo =
    Http.send PostTodoRequest <| postTodo todo


updateTodoRequest : ( Int, Bool ) -> Cmd Msg
updateTodoRequest change =
    Http.send UpdateTodoRequest <| updateTodo change


deleteTodoRequest : Int -> Cmd Msg
deleteTodoRequest id =
    Http.send DeleteTodoRequest <| deleteTodo id



-- PRIVATE API
-- DECODER


decodeTodo : Decode.Decoder Todo
decodeTodo =
    Decode.map4 Todo
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "completed" Decode.bool)


decodeTodos : Decode.Decoder (List Todo)
decodeTodos =
    Decode.field "data" (Decode.list decodeTodo)


decodePostTodo : Decode.Decoder Todo
decodePostTodo =
    Decode.field "data" decodeTodo



-- REQUEST METHODS


put : String -> Http.Body -> Decode.Decoder a -> Http.Request a
put url body decoder =
    Http.request
        { method = "PUT"
        , headers = []
        , url = url
        , body = body
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


delete : String -> Int -> Http.Request Int
delete url id =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectStringResponse (\_ -> Ok id)
        , timeout = Nothing
        , withCredentials = False
        }



-- HTTP REQUEST


getTodos : Http.Request (List Todo)
getTodos =
    Http.get "/api/todos" decodeTodos


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


updateTodo : ( Int, Bool ) -> Http.Request Todo
updateTodo ( id, completed ) =
    let
        url =
            "/api/todos/" ++ toString id

        todo =
            Encode.object
                [ ( "completed", Encode.bool completed ) ]

        body =
            Encode.object [ ( "todo", todo ) ]
                |> Http.jsonBody
    in
        put url body decodePostTodo


deleteTodo : Int -> Http.Request Int
deleteTodo id =
    let
        url =
            "/api/todos/" ++ toString id
    in
        delete url id
