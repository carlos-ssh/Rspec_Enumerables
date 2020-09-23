
require_relative '../lib/enumerables'


describe Enumerable do
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



end  

