require_relative '../enumerable_methods.rb'

describe Enumerable do
  test_array = [1, 2, 4, 8, 16, 32, 64]
  test_array2 = %w[Hello Hallo Hola Ciao]
  test_array3 = [false, nil, false, true]
  test_array4 = [true, 1, 10, nil]
  test_array5 = [false, nil, false]

  describe '#my_each' do
    it 'returns an enumerator when no block is given' do
      expect(test_array.my_each).to be_an Enumerator
    end

    it 'returns an object after calling the block for each element in the array' do
      expect(test_array2.my_each { |i| p i }).to be_an Object
    end

    it 'returns an object after calling the block for each element in the range' do
      expect((1..6).my_each { |i| p i }).to be_an Object
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerator when no block is given' do
      expect(test_array.my_each_with_index).to be_an Enumerator
    end

    it 'returns an object after calling the block for each element in the array' do
      expect(test_array2.my_each_with_index { |i| p i }).to be_an Object
    end

    it 'returns an object after calling the block for each element in the range' do
      expect((1..6).my_each_with_index { |i| p i }).to be_an Object
    end
  end

  describe '#my_select' do
    it 'returns an enumerator when no block is given' do
      expect(test_array.my_select).to be_an Enumerator
    end

    it 'returns an array of the elements that meet the block\'s condition' do
      expect(test_array.my_select { |i| i > 16 }).to eql([32, 64])
    end

    it 'returns an array of the elements of the range that meet the block\'s condition' do
      expect((1..25).my_select { |i| (i % 5).zero? }).to eql([5, 10, 15, 20, 25])
    end
  end

  describe '#my_all?' do
    it 'returns false whenever the block returns false' do
      expect(test_array.my_all? { |i| i < 32 }).to be false
    end

    it 'returns false when no block given and one element is false or nil' do
      expect(test_array4.my_all?).to be false
    end

    it 'returns true when all elements meet the block\'s condition' do
      expect(test_array.my_all? { |i| i < 128 }).to be true
    end

    it 'returns true when no block given and all elements are true' do
      expect(test_array2.my_all?).to be true
    end

    it 'returns true when the argument is a class and all elements belong to this class' do
      expect(test_array2.my_all?(String)).to be true
    end

    it 'returns false when the argument is a class and one element doesn\'t belong to this class' do
      expect(test_array4.my_all?(Numeric)).to be false
    end

    it 'returns true when the argument is a Regexp and all elements match this Regexp' do
      expect(test_array2.my_all?(/o/)).to be true
    end
    it 'returns false when the argument is a Regexp and one element doesn\'t match this Regexp' do
      expect(test_array2.my_all?(/h/)).to be false
    end
  end

  describe '#my_any?' do
    it 'returns true whenever the block returns true' do
      expect(test_array.my_any? { |i| i > 32 }).to be true
    end

    it 'returns false when no block given and all elements are false or nil' do
      expect(test_array5.my_any?).to be false
    end

    it 'returns true when one element meet the block\'s condition' do
      expect(test_array.my_any? { |i| i == 64 }).to be true
    end

    it 'returns true when no block given and one element is true' do
      expect(test_array3.my_any?).to be true
    end

    it 'returns true when the argument is a class and one element belongs to this class' do
      expect(test_array4.my_any?(Numeric)).to be true
    end

    it 'returns false when the argument is a class and no element belong to this class' do
      expect(test_array2.my_any?(Numeric)).to be false
    end

    it 'returns true when the argument is a Regexp and one element match this Regexp' do
      expect(test_array2.my_any?(/C/)).to be true
    end
    it 'returns false when the argument is a Regexp and no element match this Regexp' do
      expect(test_array2.my_any?(/z/)).to be false
    end
  end

  describe '#my_none?' do
    it 'returns true when the block always returns false' do
      expect(test_array.my_none?(&:negative?)).to be true
    end

    it 'returns false when no block given and one element is true' do
      expect(test_array3.my_none?).to be false
    end

    it 'returns true when no element meet the block\'s condition' do
      expect(test_array.my_none? { |i| i > 64 }).to be true
    end

    it 'returns true when no block given and no element is true' do
      expect(test_array5.my_none?).to be true
    end

    it 'returns false when the argument is a class and one element belongs to this class' do
      expect(test_array4.my_none?(Numeric)).to be false
    end

    it 'returns true when the argument is a class and no element belong to this class' do
      expect(test_array2.my_none?(Numeric)).to be true
    end

    it 'returns false when the argument is a Regexp and one element match this Regexp' do
      expect(test_array2.my_none?(/C/)).to be false
    end
    it 'returns true when the argument is a Regexp and no element match this Regexp' do
      expect(test_array2.my_none?(/z/)).to be true
    end
  end

  describe '#my_count' do
    it 'returns the number of items in enum through enumeration' do
      expect(test_array2.my_count).to eql(4)
    end

    it 'returns the number of items in enum through enumeration::range' do
      expect((1..30).my_count).to eql(30)
    end
  end

  describe '#my_map' do
    it 'returns an array with the results of running a given block once for every element in enum::range' do
      expect((1..7).my_map { |i| i * 4 }).to eql([4, 8, 12, 16, 20, 24, 28])
    end

    it 'returns an Enumerator if no block is given' do
      expect(test_array.my_map).to be_an Enumerator
    end
  end

  describe '#my_inject' do
    it 'combines all elements applying the specified condition of the block' do
      expect(test_array.my_inject { |i, j| i + j }).to eql 127
    end

    it 'combines all elements and the initial value applying the specified condition of the block' do
      expect(test_array.my_inject(13) { |i, j| i + j }).to eql 140
    end

    it 'combines all elements using the symbol argument as a name method' do
      expect((1..5).my_inject(:*)).to eql 120
    end

    it 'combines all elements and the initial value using the symbol argument as a name method' do
      expect((5..10).my_inject(151_200, :/)).to eql 1
    end
  end

  describe '#multiply_els' do
    it 'returns the multiplication of all elements of an array argument' do
      expect(multiply_els([3, 6, 9])).to eql 162
    end
  end
end
