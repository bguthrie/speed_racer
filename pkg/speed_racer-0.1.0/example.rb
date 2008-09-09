require 'lib/speed_racer'
require 'example/sort'

SpeedRacer.go(10) do
  data "hello, world"

  measure("gsub") { |s| s.gsub(/ll/, "rr") }
  measure("gsub!") { |s| s.gsub!(/ll/, "rr"); s }
  against("index") { |s| s["ll"] = "rr"; s }
end

puts ""

SpeedRacer.go(10) do
  include Sort
  
  data (1..300).map {|n| rand(100)}
  
  measure("quicksort in place") {|a| quicksort_in_place(a.dup)}
  measure("combsort")           {|a| combsort(a.dup)}
  measure("quicksort copy")     {|a| quicksort_copy(a.dup)}
  measure("bubblesort")         {|a| bubblesort(a.dup)}
  
  against("built-in sort")      {|a| builtinsort(a.dup)}
end

