module Main exposing ( main )

import Browser
import Browser.Navigation as Nav
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Url exposing ( Url )
import Url.Parser as P
import Url.Parser.Query as Q

import Difficulty exposing ( Difficulty )

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , onUrlRequest = (\_ -> None)
        , onUrlChange = (\_ -> None)
        }

type Msg = None

type alias Model =
    { difficulty : Maybe Difficulty
    }

getDiffParam : Url -> Maybe String
getDiffParam url =
  let diffParamParser = P.query (Q.string "d")
  in
  case P.parse diffParamParser url of
      Just x -> x
      Nothing -> Nothing 

init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url _ =
    let diff = case getDiffParam url of
                  Just name -> Difficulty.fromString name
                  Nothing -> Nothing
    in
    ( Model diff, Cmd.none)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = (model, Cmd.none)

view : Model -> Browser.Document Msg
view model =
    let aa = case model.difficulty of
               Just x -> x.displayName
               Nothing -> "?????"
    in
    Browser.Document "Minesweeper"
        [ div [] [ text aa ]
        ]
