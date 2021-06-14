module Ast = Ast
module Location = Location

module Warning : sig
  type t = Warning.t = { location : Location.span; message : string }

  val to_string : t -> string

  type 'a with_warnings = { value : 'a; warnings : t list }
end

val parse_comment :
  location:Lexing.position -> text:string -> Ast.docs Warning.with_warnings
