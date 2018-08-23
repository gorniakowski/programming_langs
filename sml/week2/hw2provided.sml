(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2
(* put your solutions for problem 1 here *)
fun all_except_option (word, list_words) =
     let
         fun helper(list_words,passed_list)=
          case list_words of
          [] => NONE
          |x::xs => if same_string(word,x)
                    then SOME(passed_list @ xs)
                    else helper (xs,x::passed_list)
     in
          helper(list_words,[])
     end
fun get_substitutions1(substitutions,s) =
     case substitutions of
     [] => []
     | x::xs => case all_except_option(s,x) of
                NONE => get_substitutions1(xs,s)
               |SOME i => i @ get_substitutions1 (xs,s)
fun get_substitutions2 (substitutions,s) =
     let fun helper(substitutions,acc)=
          case substitutions of
          [] => acc
          |x::xs => case all_except_option(s,x) of
                    NONE => helper(xs,acc)
                    |SOME i => helper(xs, i@acc)
     in
     helper (substitutions,[])
     end
fun similar_names(substitutions, full_name)=
     case full_name of
          {first=first,middle=middle,last=last} =>
               let val first_names =get_substitutions1(substitutions,first)
                   fun produce_subs(first_names)=
                   case first_names of
                   [] => []
                   |x::xs => {first=x, middle=middle ,last=last}::produce_subs(xs)
                in
                full_name::produce_subs(first_names)
                end
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color (suit,rank)=
     case suit of
     Clubs => Black
     |Spades => Black
     |_ => Red
fun card_value (suit,rank) =
     case rank of
     Num i => i
     |Ace => 11
     |_ => 10
fun remove_card (cs,c,e) =
     let fun helper (bef_cs,past_cs) =
          case bef_cs of
          [] => raise e
          | x::xs => if x = c
                     then past_cs @ xs
                     else helper(xs,past_cs @ [x])
     in
     helper (cs,[])
     end
fun all_same_color (cs) =
     case cs of
     [] => true
     |x::[] => true
     |x::xs::xs'=> if card_color(x)=card_color(xs)
                   then all_same_color(xs::xs')
                   else false
fun sum_cards(cs)=
     let fun helper(cs,acc) =
          case cs of
          [] => acc
          | x::xs => helper (xs,acc + card_value(x))
     in
     helper(cs,0)
     end

fun score (hc, goal)=
     let
          val sum = sum_cards(hc)
          fun prescore() =
          if sum > goal
          then 3 * (sum - goal)
          else goal - sum
     in
     if all_same_color(hc)
     then  prescore() div 2
     else prescore()
     end
fun officiate (card_list, move_list, goal) =
     let
          fun helper (held_cards, moves_remaining,card_list_remaining) =
          case moves_remaining of
          [] => score(held_cards,goal)
          |y::ys => case y of
                    Discard c => helper (remove_card(held_cards,c,IllegalMove),ys,card_list_remaining)
                    |Draw => case card_list_remaining of
                              [] => score(held_cards,goal)
                              |x::xs => if sum_cards(x::held_cards) > goal
                                        then score (x::held_cards,goal)
                                        else helper (x::held_cards,ys,xs)
     in
     helper ([],move_list,card_list)
     end
