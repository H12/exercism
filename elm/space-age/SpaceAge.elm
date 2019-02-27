module SpaceAge exposing (Planet(..), ageOn)


type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


ageOn : Planet -> Float -> Float
ageOn planet seconds =
    secondsToYears seconds / orbitalPeriodInEarthYears planet


secondsToYears : Float -> Float
secondsToYears seconds =
    seconds / secondsPerYear


secondsPerYear : Float
secondsPerYear =
    31557600


orbitalPeriodInEarthYears : Planet -> Float
orbitalPeriodInEarthYears planet =
    case planet of
        Mercury ->
            0.2408467

        Venus ->
            0.61519726

        Earth ->
            1

        Mars ->
            1.8808158

        Jupiter ->
            11.862615

        Saturn ->
            29.447498

        Uranus ->
            84.016846

        Neptune ->
            164.79132
