// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "soll/Parse/Parser.h"

using namespace std;

namespace soll {

static bool isObject(const Token &Tok) {
  return Tok.isAnyIdentifier() &&
         Tok.getIdentifierInfo()->getName().equals("object");
}

static bool isData(const Token &Tok) {
  return Tok.isAnyIdentifier() &&
         Tok.getIdentifierInfo()->getName().equals("data");
}

unique_ptr<SourceUnit> Parser::parseYul() {
  ParseScope SourceUnitScope{this, 0};
  vector<unique_ptr<Decl>> Nodes;

  if (Tok.is(tok::l_brace)) {
    auto Body = parseAsmBlock();
    auto Code = make_unique<YulCode>(std::move(Body));
    auto DataList = make_unique_vector<YulData>();
    auto Obj = make_unique<YulObject>("object", std::move(Code),
                                      make_unique_vector<YulObject>(),
                                      std::move(DataList));
    Nodes.push_back(std::move(Obj));
  } else if (isObject(Tok)) {
    Nodes.push_back(parseYulObject());
  } else if (Tok.is(tok::l_brace)) {
    // Special case: Code-only form.
    assert(false && "not support code-only form");
    __builtin_unreachable();
  }
  return make_unique<SourceUnit>(std::move(Nodes));
}

unique_ptr<YulObject> Parser::parseYulObject() {
  ConsumeToken();

  auto Name = stringUnquote(std::string(Tok.getLiteralData(), Tok.getLength()));

  ConsumeStringToken();
  ExpectAndConsume(tok::l_brace);

  auto Code = parseYulCode();
  auto DataList = make_unique_vector<YulData>();

  while (Tok.isNot(tok::r_brace)) {
    if (isObject(Tok)) {
      assert(false && "not support declare an object inside other object");
      __builtin_unreachable();
    } else if (isData(Tok)) {
      DataList.push_back(parseYulData());
    } else {
      ConsumeAnyToken();
    }
  }

  ExpectAndConsume(tok::r_brace);
  auto Obj = make_unique<YulObject>(Name, std::move(Code),
                                    make_unique_vector<YulObject>(),
                                    std::move(DataList));
  return Obj;
}

unique_ptr<YulCode> Parser::parseYulCode() {
  ConsumeToken();
  auto Body = parseAsmBlock();
  auto Code = make_unique<YulCode>(std::move(Body));
  return Code;
}

unique_ptr<YulData> Parser::parseYulData() {
  ConsumeToken();
  auto Name = stringUnquote(std::string(Tok.getLiteralData(), Tok.getLength()));
  ConsumeStringToken();
  auto Body = make_unique<StringLiteral>(
      stringUnquote(std::string(Tok.getLiteralData(), Tok.getLength())));
  auto Data = make_unique<YulData>(Name, std::move(Body));
  ConsumeStringToken();
  return Data;
}

} // namespace soll