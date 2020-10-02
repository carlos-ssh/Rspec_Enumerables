module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    enum = to_a
    enum.length.times { |index| yield(enum[index]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    enum = to_a
    enum.length.times { |index| yield(enum[index], index) }
    self
  end

  def my_select
    new_enum = []
    return to_enum(:my_select) unless block_given?

    my_each { |item| new_enum.push(item) if yield(item) }
    is_a?(Hash) ? new_enum.to_h : new_enum
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |item| return false unless yield item }
      return true
    end
    if pattern
      case pattern.class.to_s
      when 'Class' then my_all? { |item| item.is_a?(pattern) }
      when 'Regexp' then my_all? { |item| item =~ pattern }
      else my_all? { |item| item == pattern }
      end
    else
      my_all? { |item| item }
    end
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |item| return true if yield item }
      return false
    end
    if pattern
      case pattern.class.to_s
      when 'Class' then my_any? { |item| item.is_a?(pattern) }
      when 'Regexp' then my_any? { |item| item =~ pattern }
      else my_any? { |item| item == pattern }
      end
    else
      my_any? { |item| item }
    end
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |item| return false if yield item }
      return true
    end
    if pattern
      case pattern.class.to_s
      when 'Class' then my_none? { |item| item.is_a?(pattern) }
      when 'Regexp' then my_none? { |item| item =~ pattern }
      else my_none? { |item| item == pattern }
      end
    else
      my_none? { |item| item }
    end
  end

  def my_count(search = nil)
    counter = 0
    return to_a.length unless block_given? || search

    if search
      my_count { |item| item == search }
    else
      my_each { |item| counter += 1 if yield(item) }
      counter
    end
  end

  def my_map(proc = nil)
    map = []
    return to_enum(:my_map) unless block_given? || proc

    if proc.is_a?(Proc)
      my_each { |item| map << proc.call(item) }
    else
      my_each { |item| map << yield(item) }
    end
    map
  end

  def my_inject(memo = nil, sym = nil)
    if memo.is_a?(Symbol)
      proc = memo.to_proc
      memo = nil
      my_each { |item| memo = memo.nil? ? item : proc.call(memo, item) }
    elsif sym.is_a?(Symbol)
      proc = sym.to_proc
      my_each { |item| memo = memo.nil? ? item : proc.call(memo, item) }
    else
      my_each { |item| memo = memo.nil? ? item : yield(memo, item) }
    end
    memo
  end
end

def multiply_els(numbers)
  numbers.my_inject(&:*)
end
