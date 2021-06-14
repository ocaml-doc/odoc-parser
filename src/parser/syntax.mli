val parse :
  Warning.warning_accumulator ->
  Token.t Location.with_location Stream.t ->
  Ast.docs
