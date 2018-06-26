RSpec.describe Parser do
  it 'has a version number' do
    expect(Parser::VERSION).not_to be nil
  end

  describe '.proceed' do
    let(:str) do
      <<-EOT
        Events[0].Country=USA
        Events[0].City=New York
      EOT
    end
    it 'should parse values with spaces' do
      expect(Parser.proceed(str)).to eq({'Country' => 'USA', 'City' => 'New York'})
    end

    let(:types) do
      <<-EOT
        Events[0].Number=123
        Events[0].String=lorem
        Events[0].True=true
        Events[0].False=false
        Events[0].NumString=12lorem
      EOT
    end
    it 'should return values in proper types' do
      result = Parser.proceed(types)
      expect(result['Number']).to be_a(Integer)
      expect(result['String']).to be_a(String)
      expect(result['True']).to be_a(TrueClass)
      expect(result['False']).to be_a(FalseClass)
      expect(result['NumString']).to be_a(String)
    end

    let(:array) do
      <<-EOT
        Events[0].Hash.Arr[0]=123
        Events[0].Hash.Arr[1]=456
        Events[0].Hash.Arr[2]=789
        Events[0].Hash.String=abc
      EOT
    end
    it 'should work with nested hash and array' do
      expect(Parser.proceed(array)).to eq({'Hash' => {'Arr' => [123, 456, 789], 'String' => 'abc'}})
    end
  end
end
