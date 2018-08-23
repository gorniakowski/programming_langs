(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw2provided.sml";
val test1 = all_except_option ("string", ["string"]) = SOME []
val test1a = all_except_option ("string", ["string","ala","kot"]) = SOME ["ala","kot"]
val test1b = all_except_option ("string", ["ala","string","kot"]) = SOME ["ala","kot"]

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2a = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
"Fred") = ["Fredrick","Freddie","F"]

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test3a = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
"Fred") = ["Fredrick","Freddie","F"]


val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test4a = similar_names([],{first="1", last="3", middle="2"})= [{first="1", last="3", middle="2"}]

val test5 = card_color (Clubs, Num 2) = Black
val test5a = card_color (Spades,3) = Black
val test5b = card_color(Hearts,Jack) = Red
val test5c =card_color (Diamonds,Queen)= Red

val test6 = card_value (Clubs, Num 2) = 2

val test7  = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7a = (remove_card ([(Clubs, Ace),(Spades, King),(Hearts, Num 2)], (Hearts, Ace), IllegalMove) ; false) handle IllegalMove => true
val test7b = remove_card ([(Clubs, Ace),(Spades, King),(Hearts, Num 2)], (Hearts, Num 2), IllegalMove) =[(Clubs, Ace),(Spades, King)]

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8a = all_same_color [(Hearts, Ace)] = true
val test8b = all_same_color [(Spades, Ace), (Hearts, Ace)] = false
val test8c = all_same_color([(Clubs,Ace),(Spades,Ace),(Diamonds,Ace)]) = false
val test9  = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9a = sum_cards [(Clubs, Num  2),(Clubs, Num 2),(Spades, Ace)] = 15

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false)
              handle IllegalMove => true)
