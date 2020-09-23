
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
end
