# rubocop: disable Layout/LineLength
# spec/main_spec.rb

require_relative '../enumerable_methods.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:hsh) { { one: 1, two: 2, three: 3, four: 4, five: 5 } }
  let(:target) { [] }
  let(:str) { %w[hi how hello] }
  describe '#my_each' do
    it 'checks if returns an Enumerator object when no block is given.' do
      expect(arr.my_each).to(satisfy { |output| output.is_a?(Enumerator) })
    end

    it 'checks if array is returned when block is given' do
      expect(arr.my_each { |index| index }).to eql(arr)
    end

    it 'checks if method makes an action for every item in the enumerable.' do
      arr.my_each { |i| target.push(i + 5) }
      expect(target).to(satisfy { |t| t == [6, 7, 8, 9, 10] })
    end
  end

  describe '#my_each_with_index' do
    it 'checks if it returns an Enumerator object when no block is given' do
      expect(arr.my_each_with_index).to(satisfy { |output| output.is_a?(Enumerator) })
    end

    it 'checks if array is returned when block is given' do
      expect(arr.my_each_with_index { |index| index }).to eql(arr)
    end

    it 'checks if hash is returned when block is given' do
      expect(hsh.my_each_with_index { |index| index }).to eql(hsh)
    end

    it 'checks if index is sent to the block' do
      arr.my_each_with_index { |i| target.push(i - 1) }
      expect(target).to eql [0, 1, 2, 3, 4]
    end
  end

  describe '#my_select' do
    it 'selects elements with specific property from array and return' do
      expect(arr.my_select(&:odd?)).to eql([1, 3, 5])
    end

    it 'checks if it returns an Enumerator object when no block is given' do
      expect(arr.my_select).to(satisfy { |output| output.is_a?(Enumerator) })
    end

    it 'checks if hash is returned when a hash is passed' do
      expect(hsh.my_select { |index| index }).to eql(hsh)
    end
  end

  describe '#my_all?' do
    it 'checks if it returns true for all elements when condition is met' do
      expect(arr.my_all? { |x| x >= 1 }).to eql true
    end

    it 'checks if block given are integers' do
      expect(arr.my_all?(Integer)).to eql true
    end

    it 'checks if block given are String' do
      expect(arr.my_all?(String)).to eql false
    end

    it 'checks if characters in a Regexp match' do
      expect(str.my_all?(/h/)).to eql true
    end
  end

  describe '#my_any?' do
    it 'checks if returns true when any element in the enumerable meets a given condition' do
      expect(arr.my_any?(&:even?)).to eql(true)
    end

    it 'checks if returns false when no element in the enumerable meets a given condition' do
      expect(str.my_any? { |i| i.is_a?(Numeric) }).to eql(false)
    end

    it 'checks if any element in the enumerable match with a given regular expression pattern' do
      expect(str.my_any?(/h/)).to eql(true)
    end

    it 'checks if not true when enumerable contains no-string-data-type elements and they are compared to a given regular expression pattern' do
      expect(arr.my_any?(/d/)).to_not eql(true)
    end

    it 'checks if any element in the enumerable is a given type of object' do
      expect([nil, 10, 'ten', 10.0].my_any?(Float)).to eql(true)
    end

    it 'checks if returns true when enumerable is not empty and neither argument nor block are given' do
      expect(arr.my_any?).to eql(true)
    end

    it 'checks if returns false when enumerable is empty and neither argument nor block are given' do
      expect([].my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'checks if returns true when no element in the enumerable meets a given condition' do
      expect(arr.my_none? { |i| i > 5 }).to eql(true)
    end

    it 'checks if returns false when any element in the enumerable meets a given condition' do
      expect(str.my_none? { |i| i == 'hi' }).to eql(false)
    end

    it 'checks if no element in the enumerable match with a given regular expression pattern' do
      expect(str.my_none?(/g/)).to eql(true)
    end

    it 'checks if not false when enumerable contains no-string-data-type elements and they are compared to a given regular expression pattern' do
      expect(arr.my_none?(/d/)).to_not eql(false)
    end

    it 'checks if no element in the enumerable is a given type of object' do
      expect([nil, 10, 'ten', '10.0'].my_none?(Float)).to eql(true)
    end

    it 'checks if returns true when enumerable is full of not-true elements and neither argument nor block are given' do
      expect([nil, false, nil].my_none?).to eql(true)
    end

    it 'checks if returns true when enumerable is empty and neither argument nor block are given' do
      expect([].my_none?).to eql(true)
    end

    it 'checks if returns false when enumerable has any true value and neither argument nor block are given' do
      expect([nil, true, nil].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns the number of items in the enumerable when a block is given' do
      expect(arr.my_count { |x| x > 2 }).to eql(3)
    end

    it 'returns the number of items in the enumerable' do
      expect(arr.my_count).to eql(5)
    end

    it 'returns the number of items in the enumerable that are equal to the item counted' do
      expect(arr.my_count(2)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'checks if a new enumerable is created from applying a block to every item in the caller object' do
      expect(arr.my_map { |i| i * i }).to eql [1, 4, 9, 16, 25]
    end

    it 'checks if no block is given and returns an enumerator' do
      expect(arr.my_map).to(satisfy { |output| output.is_a?(Enumerator) })
    end
  end

  describe '#my_inject' do
    it 'computes all the items in enumerable according to a given operator and returns the result' do
      expect(arr.my_inject(:*)).to eql(120)
    end

    it 'computes all the items in enumerable according to a given block and returns the result' do
      expect(arr.my_inject { |sum, i| sum + i }).to eql(15)
    end

    it 'computes all the items in enumerable according to an initial memo value and an operator and returns the result' do
      expect(arr.my_inject(100, :-)).to eql(85)
    end

    it 'computes all the items in enumerable according to an initial memo value and a block and returns the result' do
      expect(arr.my_inject(1000.0) { |div, i| div / i }).to eql(8.333333333333332)
    end

    it 'computes longest string in array and return it' do
      expect(str.my_inject { |m, w| m.length > w.length ? m : w }).to eql('hello')
    end
  end
end
# rubocop: enable Layout/LineLength
