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
    = No0p
      -- REST API MESSAGES
    | LoadTodosRequest (Result Http.Error (List Todo))
    | PostTodoRequest (Result Http.Error Todo)
    | UpdateTodoRequest (Result Http.Error Todo)
    | DeleteTodoRequest (Result Http.Error Int)
      -- LOCAL MESSAGES
    | PostTodo
    | Change String String
    | CompleteTodo ( Int, Bool )
    | DeleteTodo Int
