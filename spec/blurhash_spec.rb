RSpec.describe Blurhash do
  it 'has a version number' do
    expect(Blurhash::VERSION).not_to be nil
  end

  describe '.encode' do
    it 'returns a string' do
      pixels = File.read(File.join(__dir__, 'fixtures', 'test.bin')).unpack('C*')
      expect(Blurhash.encode(204, 204, pixels)).to eq 'LFE.@D9F01_2%L%MIVD*9Goe-;WB'
    end
  end

  describe ".decode" do
    it "raise ArgumentError if blurhash is less than 6 characters long" do
      expect { Blurhash.decode("abcde", 204, 204) }.to raise_error(ArgumentError)
    end

    it "returns an array with depth: 3" do
      pixels = Blurhash.decode("LFE.@D9F01_2%L%MIVD*9Goe-;WB", 204, 204)
      expect(pixels).to be_an_instance_of(Array)
      expect(pixels[0][0][0]).not_to be_an_instance_of(Array)
    end
  end

  describe '.components' do
    it 'returns an array' do
      expect(Blurhash.components('LFE.@D9F01_2%L%MIVD*9Goe-;WB')).to eq [4, 3]
    end

    it 'returns nil' do
      expect(Blurhash.components('foo')).to be_nil
    end
  end
end
