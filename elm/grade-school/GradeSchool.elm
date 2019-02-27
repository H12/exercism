module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)

import Dict exposing (Dict)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Int (List Student)


empty : School
empty =
    Dict.empty


addStudent : Grade -> Student -> School -> School
addStudent grade student school =
    studentsInGrade grade school
        |> (::) student
        |> List.sort
        |> (\students -> Dict.insert grade students school)


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade =
    Dict.get grade >> Maybe.withDefault []


allStudents : School -> List ( Grade, List Student )
allStudents =
    Dict.toList
