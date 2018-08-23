(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hmw1.sml";

val test1  = is_older ((1,2,3),(2,3,4)) = true
val test1a = is_older ((1,5,3),(1,3,4)) = false
val test1b = is_older ((1,1,1),(1,1,1)) = false
val test1c = is_older ((1,2,4),(1,2,5)) = true

val test2  = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2a = number_in_month([(2012,2,28),(2013,12,1)],5)  = 0
val test2b = number_in_month([(2012,2,28),(2013,12,1),(2056,2,30)],2)  = 2

val test3 = number_in_months
val test3a = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[11]) = 0
val test3b = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val test3c = number_in_months ([],[4]) = 0
val test3d = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,12,3,4]) = 4

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4a = dates_in_month ([(2012,2,28),(2013,12,1),(2012,2,30)],2) = [(2012,2,28),(2012,2,30)]
val test4b = dates_in_month ([(2012,2,28),(2013,12,1),(2012,2,30)],5) = []
val test4c = dates_in_month ([],5) = []

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test5a  = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[15,16,87]) = []
val test5b  = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []
val test5c = dates_in_months ([],[2,3,4]) = []

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test6a = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"
val test6b = get_nth (["hi", "there", "how", "are", "you"], 5) = "you"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test7a = date_to_string (3000, 1, 12) = "January 12, 3000"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8a = number_before_reaching_sum (3, [1,2,3,4,5]) = 1
val test8b =number_before_reaching_sum (15, [1,2,3,4,5]) = 4

val test9 = what_month 70 = 3
val test9a = what_month 30 = 1
val test9b = what_month 121 = 5
val test9c =what_month 33 = 2

val test10 = month_range (31, 34) = [1,2,2,2]
val test10a = month_range(10,9) = []
val test10b = month_range(121,122)=[5,5]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test11a = oldest([]) = NONE

val test12 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,12,3,4]) = 4
val test12a = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,12,3,4,2,12,3,4,4,4,12,2]) = 4
val test12b = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test13 = reasonable_date (2018,4,6) = true
val test13a =reasonable_date(2018,6,31) =false
val test13b = reasonable_date(4,15,25) =false
val test13c = reasonable_date(2020,2,29) =true
val test13d = reasonable_date(2021,2,29) =false
