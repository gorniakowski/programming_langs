(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p  =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
val only_capitals = List.filter(fn list => (Char.isUpper o String.sub) (list,0))

val longest_string1  = foldl (fn (string, tmp) => if String.size string > String.size tmp
                                                then string
                                                else tmp)""

val  longest_string2 = foldl (fn (string, tmp) => if String.size string >= String.size tmp
                                                then string
                                                else tmp)""

fun longest_string_helper f = foldl (fn (string, tmp) => if f(String.size string, String.size tmp)
                                                         then string
                                                         else tmp)""
val longest_string3 = longest_string_helper (fn(first,second) => first >second)
val longest_string4 = longest_string_helper (fn(first,second) => first >= second)

val longest_capitalized = longest_string1 o only_capitals

val rev_string =  String.implode o List.rev o String.explode

fun first_answer f lst =
     case lst of
     [] => raise NoAnswer
     | x::xs => case f x of
               SOME value => value
               |NONE => first_answer f xs

fun all_answers f lst =
     let  fun helper list acc =
          case list of
          [] => acc
         | x::xs => case (f x) of
                    SOME value => helper xs (acc@value)
                    | NONE => raise NoAnswer
     in
     SOME (helper lst [])
     handle NoAnswer => NONE
     end
fun count_wildcards some_value =
     g (fn _=>1) (fn _=> 0) some_value

fun count_wild_and_variable_lengths some_value =
	g (fn _=>1) (fn x => String.size x )some_value

fun count_some_var (str, pattrn) =
	g (fn _=>0) (fn x => if str = x then 1 else 0  ) pattrn

fun check_pat pattrn =
	let fun take_out_stings acc pattrn =
			case pattrn of
			Variable x => x::acc
			|TupleP x => List.foldl(fn (x,acc) => (take_out_stings [] x)@acc) []  x
			|ConstructorP (_, patt) => take_out_stings acc patt
			|_ =>acc
		fun repeats (str_lst) =
		 	case str_lst of
			[]=> true
			|x :: xs => if List.exists (fn smth => smth = x)xs
							then false
							else repeats xs

	in
	repeats (take_out_stings [] pattrn)
	end

fun match (v,p) =
 	case (v,p) of
	(_,Wildcard) =>SOME[]
	|(_,Variable s) => SOME[(s,v)]
	|(Unit,UnitP) => SOME[]
	|(Const x', ConstP x) => if x=x'
						then SOME[]
						else NONE
	|(Tuple vs, TupleP ps) =>if List.length ps = List.length vs
			  			then all_answers match (ListPair.zip(vs,ps))
			  			else NONE
	|(Constructor(s2,va),ConstructorP(s1,ptr)) => if s1 = s2
					   					 then match (va,ptr)
					   		 			 else NONE
	|(_,_) => NONE
fun first_match v lst =
	SOME (first_answer (fn p => match(v,p)) lst)
	handle NoAnswer => NONE
