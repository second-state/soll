// RUN: %soll -lang=Yul %s
// REQUIRES: selfbalance
{
  sstore(0, selfbalance())
}
// ====
// EVMVersion: >=istanbul
// ----
// Trace:
//   INVALID()
// Memory dump:
// Storage dump:
