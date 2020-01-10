// RUN: %soll -lang=Yul %s
{
  sstore(0, xor(0xffff, 0))
  sstore(1, xor(0xffff, not(0)))
  sstore(2, xor(0xffff, 0xffffffffffffffff))
  sstore(3, xor(0xffff, 0xffffffffffffffffff00000000000000))
  sstore(4, xor(0xffff, 0xffffffffffffffffff00000000000000ffffffffffffffff))
  sstore(5, xor(0xffff, 0xffffffffffffffffff00000000000000ffffffffffffffff0000000000000000))
  sstore(6, xor(0xffff, 0xaaaaaaaaaaaaaa555555555555555555aa5555555555555aa555555555555555))
  sstore(7, xor(
    0x5555555555550000aaaaaaaaaaaaaa000000aaaaaaaaa000000aaaaaaaaaaaaa,
    0xaaaaaaaaaaaaaa555555555555555555aa5555555555555aa555555555555555
  ))
}
// ----
// Trace:
// Memory dump:
//      0: 0000000000000000000000000000000000000000000000000000000000000007
//     20: ffffffffffffaa55ffffffffffffff55aa55fffffffff55aa55fffffffffffff
// Storage dump:
//   0000000000000000000000000000000000000000000000000000000000000000: 000000000000000000000000000000000000000000000000000000000000ffff
//   0000000000000000000000000000000000000000000000000000000000000001: ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000
//   0000000000000000000000000000000000000000000000000000000000000002: 000000000000000000000000000000000000000000000000ffffffffffff0000
//   0000000000000000000000000000000000000000000000000000000000000003: 00000000000000000000000000000000ffffffffffffffffff0000000000ffff
//   0000000000000000000000000000000000000000000000000000000000000004: 0000000000000000ffffffffffffffffff00000000000000ffffffffffff0000
//   0000000000000000000000000000000000000000000000000000000000000005: ffffffffffffffffff00000000000000ffffffffffffffff000000000000ffff
//   0000000000000000000000000000000000000000000000000000000000000006: aaaaaaaaaaaaaa555555555555555555aa5555555555555aa55555555555aaaa
//   0000000000000000000000000000000000000000000000000000000000000007: ffffffffffffaa55ffffffffffffff55aa55fffffffff55aa55fffffffffffff
