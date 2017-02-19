module Types exposing (..)

import Http


type alias Model =
    List Todo


type alias Todo =
    { id : Int
    , title : String
    , description : String
    }


type Msg
    = LoadTodos (Result Http.Error (List Todo))
