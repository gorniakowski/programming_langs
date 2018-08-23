fun checker (numbers: int list, n: int) =
     if null numbers
     then false
     else if n = hd numbers
     then true
     else checker (tl numbers,n)



fun remove_duplicate (months: int list) =
     if null(months)
     then[]
     else
               if checker(tl months, hd months)
               then remove_duplicate(tl months)
               else hd(months)::remove_duplicate(tl months)
