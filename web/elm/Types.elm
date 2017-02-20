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
    , completed : Bool
    }


type Msg
    = LoadTodosRequest (Result Http.Error (List Todo))
    | PostTodoRequest (Result Http.Error Todo)
    | UpdateTodoRequest (Result Http.Error Todo)
    | PostTodo
    | Change String String
    | CompleteTodo ( Int, Bool )
