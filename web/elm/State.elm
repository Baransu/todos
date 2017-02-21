module State exposing (update, init)

import Rest
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model [] "" "", Rest.getTodosRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadTodosRequest result ->
            let
                todos =
                    Result.withDefault [] result
            in
                ( { model | todos = todos }, Cmd.none )

        PostTodoRequest result ->
            let
                todos =
                    case result of
                        Ok a ->
                            [ a ]

                        Err _ ->
                            []
            in
                ( { model | todos = model.todos ++ todos }, Cmd.none )

        UpdateTodoRequest result ->
            let
                todos =
                    case result of
                        Ok todo ->
                            model.todos
                                |> List.map
                                    (\a ->
                                        if a.id == todo.id then
                                            todo
                                        else
                                            a
                                    )

                        Err _ ->
                            model.todos
            in
                ( { model | todos = todos }, Cmd.none )

        DeleteTodoRequest result ->
            let
                todos =
                    case result of
                        Ok id ->
                            model.todos
                                |> List.filter (\a -> a.id /= id)

                        Err _ ->
                            model.todos
            in
                ( { model | todos = todos }, Cmd.none )

        PostTodo ->
            let
                -- basic vaidation here to check if title nad desritio are not empty
                todo =
                    ( model.title, model.description )
            in
                ( { model
                    | title = ""
                    , description = ""
                  }
                , Rest.postTodoRequest todo
                )

        CompleteTodo ( id, completed ) ->
            ( model, Rest.updateTodoRequest ( id, completed ) )

        DeleteTodo id ->
            ( model, Rest.deleteTodoRequest id )

        Change field value ->
            case field of
                "title" ->
                    ( { model | title = value }, Cmd.none )

                "description" ->
                    ( { model | description = value }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )
