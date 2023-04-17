module Main exposing ( main )

import Browser
import Browser.Navigation as Nav
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Url exposing ( Url )
import Url.Parser as P
import Url.Parser.Query as Q

import Components exposing ( .. )
import Difficulty exposing ( Difficulty )

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }

type Msg
  = UrlRequest Browser.UrlRequest
  | UrlChange Url

type alias Model =
    { difficulty : Maybe Difficulty
    , key : Nav.Key
    }

getDiffParam : Url -> Maybe String
getDiffParam url =
  let diffParamParser = P.query (Q.string "d")
  in
  case P.parse diffParamParser url of
      Just x -> x
      Nothing -> Nothing 

init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let diff = case getDiffParam url of
                  Just name -> Difficulty.fromString name
                  Nothing -> Nothing
    in
    ( Model diff key, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlChange _ -> ( model, Cmd.none )
    UrlRequest request ->
      case request of
        Browser.Internal url ->
          ( model
          , Nav.load (Url.toString url)
          )
        Browser.External url ->
          ( model
          , Nav.load url
          )
          

view : Model -> Browser.Document Msg
view model =
    Browser.Document "Minesweeper" (
      case model.difficulty of
        Just diff ->
          [ div []
              [ p [] [ text ("Current difficulty is " ++ diff.displayName) ]
              , br [] []
              , difficultySelector
              , br [] []
              , aboutPage
              ]
          ]
        Nothing ->
          [ h1 [] [ text "Unknown Difficulty." ]
          , difficultySelector
          , br [] []
          , aboutPage
          ]
    )
