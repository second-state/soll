// RUN: %soll -lang=Yul %s
// REQUIRES: codesize
{
  sstore(0, codesize())
}
// ----
// Trace:
// Memory dump:
//     20: 0000000000000000000000000000000000000000000000000000000000000014
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 0000000000000000000000000000000000000000000000000000000000000014
