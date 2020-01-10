// RUN: %soll -lang=Yul %s
// REQUIRES: declareMulti
{
    let a, b
    function f() -> x { }
    a := f()
    b := 1
}
// ====
// step: unusedPruner
// ----
// {
//     let a, b
//     function f() -> x
//     { }
//     a := f()
//     b := 1
// }
