# Source: http://www.yagni.com/combsort/index.php
class Array
  def swap(i, j)
    self[i], self[j] = self[j], self[i]
  end

  def sorted?
    self.each {|i| return false if self[i] != i}
    true
  end
end

module Sort
  def partition(a, first, last)
    pivot = a[first]
    lastS1 = first
    firstUnknown = first + 1
    while firstUnknown <= last do
      if a[firstUnknown] < pivot
        lastS1 += 1
        a.swap(firstUnknown, lastS1)
      end
      firstUnknown += 1
    end
    a.swap(first, lastS1)
    lastS1
  end

  def quicksort_in_place(a, first = 0, last = a.size - 1)
    if first < last 
      pivotIndex = partition(a, first, last)
      quicksort_in_place(a, first, pivotIndex - 1)
      quicksort_in_place(a, pivotIndex + 1, last)
    end
    a
  end
  
  def combsort(a)
    b = a
    gap = b.size
    loop do
      gap = gap * 10 / 13
      gap = 11 if gap == 9 || gap == 10
      gap = 1 if gap < 1
      swapped = false
      (b.size - gap).times do |i|
        j = i + gap
        if b[i] > b[j]
  	b.swap(i, j)
  	swapped = true
        end
      end
      break if gap == 1 && !swapped
    end
    b
  end
  
  def quicksort_copy(a)
    return a if a.size <= 1
    pivot = a[0]
    quicksort_copy(a.select {|value| value < pivot}) + 
      a.select {|value| value == pivot} +
      quicksort_copy(a.select {|value| value > pivot})
  end

  def bubblesort(a)
    loop do
      swapped = false
      (a.size - 1).times do |i|
        j = i + 1
        if a[i] > a[j]
  	a.swap(i, j)
  	swapped = true
        end
      end
      break if !swapped
    end
    a
  end
  
  def builtinsort(a)
    a.sort!; a
  end
end