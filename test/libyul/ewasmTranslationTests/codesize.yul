// RUN: %soll -lang=Yul %s
// REQUIRES: codesize
{
  sstore(0, codesize())
}
// ----
// Trace:
// Memory dump:
//     20: 00000000000000000000000000000000000000000000000000000000000002ca
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 00000000000000000000000000000000000000000000000000000000000002ca
