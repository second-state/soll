// RUN: %soll -lang=Yul %s
// REQUIRES: address
{
  sstore(0, address())
}
// ----
// Trace:
// Memory dump:
//     20: 0000000000000000000000000000000011111111000000000000000000000000
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 0000000000000000000000000000000011111111000000000000000000000000
