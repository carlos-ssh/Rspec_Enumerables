# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

def my_each
  return to_enum unless block_given?

  i = 0
  arr = to_a
  while i <= arr.length - 1
    yield (arr[i])
    i += 1
  end
  self
end

def my_each_with_index
  return to_enum unless block_given?

  i = 0
  arr = to_a
  while i <= arr.length - 1
    yield(arr[i], i)
    i += 1
  end
  self
end

def my_all_option1(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    elsif input.is_a?(Regexp)
      count += 1 unless (x =~ input).nil?
    elsif input.is_a?(Class)
      count += 1 if x.is_a?(input)
    end
  end
  count
end

def my_all?(input = nil)
  arr = to_a
  if block_given? == false && input.nil? == true
    if block_given? == false && (arr.include?(false) == false && arr.include?(nil) == false)
      true
    else
      false
    end
  elsif block_given? == false && !input.nil?
    count = my_all_option1(input, arr)
    count == arr.length
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
    count == arr.length
  end
end

def my_any_option(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    elsif input.is_a?(Regexp)
      count += 1 unless (x =~ input).nil?
    elsif input.is_a?(Class)
      count += 1 if x.is_a?(input)
    elsif input.is_a?(String)
      count += 1 if x == input
    end
  end
  count
end

def my_any?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if block_given? == false && (arr.my_all? { |x| x.nil? || x == false }) == false
      true
    else
      false
    end
  elsif block_given? == false && !input.nil?
    count = my_any_option(input, arr)
    count >= 1
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
    count >= 1
  end
end

def my_none_option(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    elsif input.is_a?(Regexp)
      count += 1 unless (x =~ input).nil?
    elsif input.is_a?(Class)
      count += 1 if x.is_a?(input)
    end
  end
  count
end

def my_none?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if block_given? == false && arr.my_all? { |x| x.nil? || x == false } == true
      true
    else
      false
    end
  elsif block_given? == false && !input.nil?
    count = my_none_option(input, arr)
    count.zero?
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
    count.zero?
  end
end

def my_count_option(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    else
      count
    end
  end
  count
end

def my_count(input = nil)
  if block_given? == false && input.nil?
    arr = to_a
    arr.length
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = my_count_option(input, arr)
  elsif block_given? == true
    count = 0
    arr = to_a
    arr.my_each do |x|
      count += 1 if yield(x)
    end
    count
  end
end

def my_map(input = nil)
  return to_enum if block_given? == false && input.nil?

  if block_given? && input.nil?
    new_array = []
    my_each do |x|
      new_value = yield(x)
      new_array << new_value
    end
  elsif block_given? == false && !input.nil?
    new_array = []
    my_each do |x|
      new_array << input[x] if input.is_a?(Proc)
    end
  elsif block_given? == true && input.is_a?(Proc)
    new_array = []
    my_each do |x|
      new_array << input[x] if input.is_a?(Proc)
    end
  end

  new_array
end

def my_inject_option1(initial, arr)
  if initial.is_a?(Symbol) && arr.my_all?(Integer)
    if initial == :+
      memo = 0
      arr.each { |x| memo += x }
    elsif initial == :-
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo -= arr[i]
        i += 1
      end
    elsif initial == :*
      memo = 1
      arr.each { |x| memo *= x }
    elsif initial == :/
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo /= arr[i]
        i += 1
      end
    end
  end
  memo
end

def my_inject_option2(initial, input, arr)
  if input == :+
    memo = initial
    arr.each do |x|
      memo += x
    end
  elsif input == :-
    memo = initial
    arr.each do |x|
      memo -= x
    end
  elsif input == :*
    memo = initial
    arr.each do |x|
      memo *= x
    end
  elsif input == :/
    memo = initial
    arr.each do |x|
      memo /= x
    end
  end
  memo
end

def my_inject(initial = nil, input = nil)
  raise LocalJumpError if block_given? == false && input.nil? && initial.nil?

  if block_given? == false && input.nil? && initial.nil? == false
    arr = to_a
    memo = my_inject_option1(initial, arr)
    memo
  elsif block_given? == false && initial.nil? == false && input.nil? == false
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.is_a?(Symbol)
      memo = my_inject_option2(initial, input, arr)
      memo
    end
  elsif block_given? == true && initial.nil? == false && input.nil?
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.nil?
      memo = initial
      arr.my_each { |x| memo = yield(memo, x) }
      memo
    elsif initial.is_a?(Integer) && arr.my_all?(String) && input.nil?
      memo = initial
      memo
    end
  elsif block_given? == true && initial.nil? && input.nil?
    arr = to_a
    if arr.my_all?(Integer)
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo = yield(memo, arr[i])
        i += 1
      end
      memo
    elsif arr.my_all?(String)
      memo = []
      arr.my_each { |x| memo = yield(memo, x) }
      memo
    end
  end
end

def multiply_els(input)
  input.my_inject(1) { |k, n| k * n }
end

def my_select
  return to_enum unless block_given?

  arr = to_a
  new_array = []
  arr.my_each do |x|
    new_array << x if yield(x) == true
  end
  new_array
end

public 'my_each'
public 'my_each_with_index'
public 'my_all?'
public 'my_any?'
public 'my_none?'
public 'my_count'
public 'my_map'
public 'my_inject'
public 'my_inject'
public 'multiply_els'
public 'my_select'

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
