(** [ocamlmark] support. *)

(** {1:syntax Syntax sniffing} *)

type syntax = [ `Ocamldoc | `Ocamlmark ]
(** The type for document syntaxes. *)

val sniff_syntax : ?default:syntax -> text:string -> unit -> syntax
(** [sniff_syntax ~text] sniffes a syntax for [text], defaulting
    to [default] if nothing smells (defaults to [`Ocamldoc]). *)

(** {1:parsing ocamlmark parsing} *)

val parse_comment :
  ?buffer:Buffer.t -> location:Lexing.position -> text:string -> unit ->
  Ast.t * Warning.t list
(** [parse_comment ~location ~text] parses the ocamlmark [text] assuming it
    corresponds to [location]. [buffer] is used as a scratch buffer. *)
