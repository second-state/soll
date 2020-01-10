// RUN: %soll -lang=Yul %s
// REQUIRES: returnTuple
{
    function f(a, b) -> x, y {
        x := add(a, b)
        y := mul(a, b)
    }
    let r, t := f(6, 7)
    sstore(r, t)
}
// ----
// Trace:
// Memory dump:
// Storage dump:
//   000000000000000000000000000000000000000000000000000000000000000d: 000000000000000000000000000000000000000000000000000000000000002a
