require_relative '../add_machine_readable_dates'

SimpleDateObject = Struct.new(:begin, :end, :expression)

RSpec.describe AddMachineReadableDates do
  it 'does not change the record if there is no expression' do
    date = SimpleDateObject.new(nil, nil, nil)
    described_class.new(date).call
    expect(date.begin).to be_nil
    expect(date.end).to be_nil
    expect(date.expression).to be_nil
  end
  it 'does not change the record if there is a begin date' do
    date = SimpleDateObject.new('1999', nil, '2000')
    described_class.new(date).call
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '2000'
  end
  it 'replaces an empty begin date with the expression if available' do
    date = SimpleDateObject.new(nil, nil, '2000')
    described_class.new(date).call
    expect(date.begin).to eq '2000'
    expect(date.end).to be_nil
    expect(date.expression).to eq '2000'
  end
end
