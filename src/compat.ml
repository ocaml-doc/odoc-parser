module Option = struct
  type 'a t = 'a option = None | Some of 'a

  let is_some = function None -> false | Some _ -> true
  let value ~default = function None -> default | Some x -> x

  let join_list l =
    let rec loop acc = function
      | [] -> Some (List.rev acc)
      | Some a :: q -> loop (a :: acc) q
      | None :: _ -> None
    in
    loop [] l
end

module Char = struct
  include Char

  let equal (x : char) y = x = y
end

module String = struct
  include String

  let for_all f str =
    let rec aux i =
      if i >= String.length str then true
      else if f (String.get str i) then aux (i + 1)
      else false
    in
    aux 0

  (* This is taken from the OCaml stdlib (more or less) - only here because we support
     4.02 and capitalize_ascii only arrived in 4.03. When we drop support
     for 4.02 we can remove the following 3 functions *)

  let capitalize_ascii =
    let uppercase_ascii =
      let open Char in
      function 'a' .. 'z' as c -> unsafe_chr (code c - 32) | c -> c
    in

    let apply1 f s =
      let open String in
      if length s = 0 then s
      else
        let r = sub s 1 (length s - 1) in
        make 1 (f (unsafe_get s 0)) ^ r
    in

    apply1 uppercase_ascii

  (* The following function is taken from the OCaml stdlib. It's here because we support building
     om OCaml < 4.04. Once we drop support for 4.03 and before we can remove the following function *)
  let split_on_char sep s =
    let open String in
    let r = ref [] in
    let j = ref (length s) in
    for i = length s - 1 downto 0 do
      if unsafe_get s i = sep then (
        r := sub s (i + 1) (!j - i - 1) :: !r;
        j := i)
    done;
    sub s 0 !j :: !r
end
