= speed_racer

* http://github.com/bguthrie/speed_racer

== DESCRIPTION:

  require 'lib/speed_racer'
  require 'example/sort'
  
  SpeedRacer.go(10) do
    data "hello, world"
  
    measure("gsub")  { |s| s.gsub(/ll/, "rr") }
    measure("gsub!") { |s| s.gsub!(/ll/, "rr"); s }
    against("index") { |s| s["ll"] = "rr"; s }
  end
  
  SpeedRacer.go(10) do
    include Sort
    
    data (1..300).map {|n| rand(100)}
    
    measure("quicksort in place") {|a| quicksort_in_place(a.dup)}
    measure("combsort")           {|a| combsort(a.dup)}
    measure("quicksort copy")     {|a| quicksort_copy(a.dup)}
    measure("bubblesort")         {|a| bubblesort(a.dup)}
    
    against("built-in sort")      {|a| builtinsort(a.dup)}
  end

== FEATURES/PROBLEMS:

* FIX (list of features or problems)

== SYNOPSIS:

  FIX (code sample of usage)

== REQUIREMENTS:

* FIX (list of requirements)

== INSTALL:

* FIX (sudo gem install, anything else)

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
