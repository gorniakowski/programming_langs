fun alternate(numbers: (int) list) =
     if null numbers
     then 0
     else hd numbers -alternate(tl numbers)
          val test_alternate_1 = alternate [6,5,1] = 2
          val test_alternate_2 = alternate [] = 0
          val test_alternate_3 = alternate [~100] = ~100
          val test_alternate_4 = alternate [1, ~2, 3, ~4] = 10
          val test_alternate_5 = alternate [~1, 2, ~3, 4] = ~10
fun alternate2 (numbers:(int) list)=
 let fun helper (numbers: int list, sign: int)=
          if null numbers
          then 0
          else if sign = 0
               then hd numbers + helper(tl numbers, 1)
               else ~1 * hd numbers + helper(tl numbers,0)
in
     helper(numbers,0)
end
val test_alternate_1 = alternate2 [6,5,1] = 2
val test_alternate_2 = alternate2 [] = 0
val test_alternate_3 = alternate2 [~100] = ~100
val test_alternate_4 = alternate2 [1, ~2, 3, ~4] = 10
val test_alternate_5 = alternate2 [~1, 2, ~3, 4] = ~10
