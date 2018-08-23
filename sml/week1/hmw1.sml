fun is_older (date1:int * int *int, date2:int * int *int) =
     if #1 date1 < #1 date2 then
          true
     else if #1 date1 = #1 date2 then
               if #2 date1 < #2 date2 then
                    true
               else if #2 date1 = #2 date2 then
                         if #3 date1 < #3 date2 then
                              true
                         else
                              false
               else
                    false
     else false

fun number_in_month (dates: (int * int *int) list, month:int) =
     if null(dates)
     then 0
     else if #2 (hd(dates)) = month
          then 1 + number_in_month (tl(dates), month)
          else number_in_month (tl(dates), month)

fun number_in_months (dates: (int *int *int) list, months: (int) list) =
     if null(months)
     then 0
     else number_in_month(dates,hd(months)) + number_in_months(dates,tl(months))

fun dates_in_month (dates: (int * int *int) list, month:int) =
     if null(dates)
     then []
     else if #2 (hd(dates)) = month
          then hd(dates) :: dates_in_month (tl(dates), month)
          else dates_in_month (tl(dates), month)

fun dates_in_months (dates: (int *int *int) list, months:(int) list) =
     if null (months)
     then []
     else dates_in_month (dates, hd(months)) @ dates_in_months(dates, tl(months))

fun get_nth (words: (string) list, n: int) =
     if n = 1
     then hd(words)
     else get_nth(tl(words), n-1)

fun date_to_string (date:int *int *int) =
     let
     val months=["January ", "February ", "March ", "April ", "May ", "June ",
                "July ", "August ", "September ", "October ", "November ", "December "]
     in
     get_nth (months,#2 date) ^ Int.toString(#3 date)^", " ^  Int.toString(#1 date)
     end

fun number_before_reaching_sum (n: int, numbers: (int) list) =
     let
          fun sumator (numbers:(int) list, sum: int, counter: int) =
               if sum < n
               then let
                    val sum = sum + hd (numbers)
                    val counter = counter +1
                    in
                         sumator (tl(numbers), sum, counter)
                    end
               else
                    counter -1
     in
          sumator(numbers,0,0)
     end
fun what_month (n: int) =
     let val months = [31,28,31,30,31,30,31,31,30,31,30,31]
     in number_before_reaching_sum(n, months)+1
     end

fun month_range (day1: int, day2: int) =
     if day1 > day2
     then []

     else if day1 = day2
     then what_month(day2)::[]

     else what_month (day1)::month_range(day1 + 1, day2)

fun oldest (dates:(int *int *int) list) =
     if null(dates)
     then NONE
     else let
               fun find_oldest(dates: (int *int *int) list) =
                    if null (tl(dates))
                    then hd (dates)
                    else
                    let val tl_ans = find_oldest(tl(dates))
                    in if is_older(hd(dates),tl_ans)
                         then hd(dates)
                       else tl_ans
                    end
          in
          SOME (find_oldest(dates))
          end
(*these are challenge functions *)
(*this function checks wheter number n is in the list numbers if it is it returns true *)
fun checker (numbers: int list, n: int) =
     if null numbers
     then false
     else if n = hd numbers
     then true
     else checker (tl numbers,n)
(*this function removes duplicates from a int list *)
fun remove_duplicate (months: int list) =
    if null(months)
    then[]
    else
         if checker(tl months, hd months)
         then remove_duplicate(tl months)
         else hd(months)::remove_duplicate(tl months)


fun number_in_months_challenge(dates: (int *int *int)list, months:(int)list ) =
     number_in_months(dates, remove_duplicate months)

fun dates_in_months_challenge(dates: (int *int *int)list, months:(int)list ) =
     dates_in_months(dates, remove_duplicate months)

fun reasonable_date (date: int *int *int) =
     let val months_31 =[1,3,5,7,8,10,12]
         val months_30 =[4,6,9,11]
     in

          if #1 date > 0 andalso (#2 date >= 1 andalso #2 date <= 12)
          then
               if checker (months_31, #3 date)
               then if #3 date >=1 andalso #3 date <=31
                    then true
                    else false
               else if checker(months_30, #3 date)
               then if #3 date >=1 andalso #3 date <=30
                    then true
                    else false
               else
                    if (#1 date mod 400 = 0 orelse #1 date mod 4 = 0) andalso (#1 date mod 100 <>0)
                    then if #3 date >=1 andalso #3 date <=29
                         then true
                         else false
                    else
                         if #3 date >=1 andalso #3 date <=28
                         then true
                         else false
          else false
     end
