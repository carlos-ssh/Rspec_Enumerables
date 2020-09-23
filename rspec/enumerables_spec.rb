# frozen_string_literal: true

require_relative '../lib/enumerables'

class Enumerable do
  let(:arr) { [1, 2, 3, 4] }

  describe '#my_each' do
    it 'return enumerator if block not given' do
      expect(arr.my_each.class).to eql(Enumerator)
    end

    it 'return array' do
      expect(arr.my_each { |x| x }).to eql(arr)
    end
  end

  describe '#my_each_with_index' do
    it 'return enumerator if block is not given' do
      expect(arr.my_each_with_index.class).to eql(Enumerator)
    end

    it 'return array when a block is given ' do
      arr = [11, 22, 31, 224, 44]
      expect(arr.my_each_with_index do |val, index|
      puts "index: #{index} for #{val}" if val < 30
      end).to eql([11, 22, 31, 224, 44])
    end
  end

  describe '#my_all?' do
    it 'return true if all in the array complete the condition in the block' do
      arr = %w[ant bear cat]
      expect(arr.my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return true if no one in the array complete the condition in the block' do
      arr = %w[ant bear cat]
      expect(arr.my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'return false if no one in the array match with the regex' do
      arr = %w[ant bear cat]
      expect(arr.my_all?(/t/)).to eql(false)
    end

    it 'return ture if all in the array are in the argument class ' do
      arr = [1, 2i, 3.14]
      expect(arr.my_all?(Numeric)).to eql(true)
    end

    it 'return false if one element in the array is nil or false ' do
      arr = [nil, false, 99]
      expect(arr.my_all?).to eql(false)
    end

    it 'return true if the array is empty' do
      arr = []
      expect(arr.my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'return true if any in the array complete with condition in the block' do
      arr = %w[ant bear cat]
      expect(arr.my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return true if any in the array complete with condition in the block' do
      arr = %w[ant bear cat]
      expect(arr.my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'return false if no one if the array match with the regex' do
      arr = %w[ant bear cat]
      expect(arr.my_any?(/d/)).to eql(false)
    end

    it 'return true if any element in the array  complete with the condition of the argument' do
      arr = [nil, false, 99]
      expect(arr.my_any?(Integer)).to eql(true)
    end

    it 'return true if any element in the array is different than false or nil' do
      arr = [nil, false, 99]
      expect(arr.my_any?).to eql(true)
    end

    it 'return false is the array is empty' do
      arr = []
      expect(arr.my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'return true if no array in block' do
      arr = %w[ant bear cat]
      expect(arr.my_none? { |word| word.length >= 5 }).to eql(true)
    end

    it 'return true if one in the array complete with condition in the block' do
      arr = %w[ant bear cat]
      expect(arr.my_none? { |word| word.length >= 4 }).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'return true if one in the array match with the regex' do
      arr = %w[ant bear cat]
      expect(arr.my_none?(/d/)).to eql(true)
    end

    it 'return false if no one if the array is in the class' do
      arr = [1, 3.14, 42]
      expect(arr.my_none?(Float)).to eql(false)
    end

    it 'return true if the array is empty' do
      arr = []
      expect(arr.my_none?).to eql(true)
    end

    it 'return true if the array only have a nil' do
      arr = [nil]
      expect(arr.my_none?).to eql(true)
    end

    it 'return true if the array only have a nil and false' do
      arr = [nil, false]
      expect(arr.my_none?).to eql(true)
    end

    it 'return true if one in the array is true' do
      arr = [nil, false, true]
      expect(arr.my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'return the length of the array if block and argument is not given' do
      arr = [1, 2, 4, 2]
      expect(arr.my_count).to eql(4)
    end

    it 'return the number of times that the method find the argument in the array' do
      arr = [1, 2, 4, 2]
      expect(arr.my_count(2)).to eql(2)
    end

    it 'return the number of times that a element complete with the condition in the block' do
      arr = [1, 2, 4, 2]
      expect(arr.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
    it 'return the array aplying the condition in the block for each element' do
      range = (1..4)
      expect(range.my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'return the array aplying the condition in the proc when a proc is given and a block is given' do
      my_proc = proc { |i| i * i }
      range = (1..4)
      expect(range.my_map(my_proc) { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'return the array aplying the condition in the proc when a proc is given and a block is not given' do
      my_proc = proc { |i| i * i }
      range = (1..4)
      expect(range.my_map(my_proc)).to eql([1, 4, 9, 16])
    end

    it 'return enumerator when block is not given' do
      range = (1..4)
      expect(range.my_map.class).to eql(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'computes all the items in enumerable according to a given block and returns the result' do
      range = (5..10)
      expect(range.my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'computes the items in enumerable according to an initial memo value and an operator and returns the result' do
      range = (5..10)
      expect(range.my_inject(1, :*)).to eql(151_200)
    end

    it 'combine every element in array aplying the binary operation that in the block and start the argument given' do
      range = (5..10)
      expect(range.my_inject(1) { |product, n| product * n }).to eql(151_200)
    end

    it 'apply binary condition in the block for every element in the array of srtings' do
      range = %w[cat sheep bear]
      expect(range.my_inject do |memo, word|
      memo.length > word.length ? memo : word
      end).to eql('sheep')
    end
  end

  describe '#multiply_els' do
    it 'return the result of the binary operation in the block calling my_inject inside of the method' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end
  end

  describe '#my_select' do
    it 'return an array with the elments that complete with condition in the block' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_select(&:even?)).to eql([2, 4])
    end

    it 'return enumerator if block is not given' do
      arr = [1, 2, 3, 4, 5]
      expect(arr.my_select.class).to eql(Enumerator)
    end
  end
end