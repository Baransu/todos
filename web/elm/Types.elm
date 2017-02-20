module Types exposing (..)

import Http


type alias Model =
    { todos : List Todo
    , title : String
    , description : String
    }


type alias Todo =
    { id : Int
    , title : String
    , description : String
    }


type Msg
    = LoadTodosRequest (Result Http.Error (List Todo))
    | PostTodoRequest (Result Http.Error Todo)
    | PostTodo
    | Title String
    | Description String
