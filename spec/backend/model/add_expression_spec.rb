require_relative '../../../backend/model/add_expression'

SimpleDateObject = Struct.new(:begin, :end, :expression, :date_type)

RSpec.describe AddExpression do
  it 'does not change the record if there is no begin or end date' do
    date = SimpleDateObject.new(nil, nil, nil, 'single')
    AddExpression.call(date)
    expect(date.begin).to be_nil
    expect(date.end).to be_nil
    expect(date.expression).to be_nil
  end
  it 'does not change the record if there is a mis-match date' do
    date = SimpleDateObject.new('1999', nil, '2000', 'single')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '2000'
  end

  it 'creates an expression if there is a begin year but no end date' do
    date = SimpleDateObject.new('1999', nil, nil, 'single')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999'
  end

  it 'creates an expression if there is a begin date but no end date' do
    date = SimpleDateObject.new('1999-03-05', nil, nil, 'single')
    AddExpression.call(date)
    expect(date.begin).to eq '1999-03-05'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999 March 05'
  end

  it 'creates an expression if there is an end date but no begin date' do
    date = SimpleDateObject.new(nil, '1999', nil, 'single')
    AddExpression.call(date)
    expect(date.begin).to be_nil
    expect(date.end).to eq '1999'
    expect(date.expression).to eq '1999'
  end

  it 'creates an expression if there is an end date but no begin date for a bulk date' do
    date = SimpleDateObject.new(nil, '1999', nil, 'bulk')
    AddExpression.call(date)
    expect(date.begin).to be_nil
    expect(date.end).to eq '1999'
    expect(date.expression).to eq '1999'
  end

  it 'creates an expression if there is both a begin year and an end year' do
    date = SimpleDateObject.new('1999', '2005', nil, 'inclusive')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to eq '2005'
    expect(date.expression).to eq '1999-2005'
  end

  it 'creates an expression if there is both a begin month and an end month' do
    date = SimpleDateObject.new('1999-03', '2005-04', nil, 'inclusive')
    AddExpression.call(date)
    expect(date.begin).to eq '1999-03'
    expect(date.end).to eq '2005-04'
    expect(date.expression).to eq '1999 March-2005 April'
  end

  it 'creates an expression if there is both a begin date and an end date' do
    date = SimpleDateObject.new('1999-03-05', '2005-04-10', nil, 'inclusive')
    AddExpression.call(date)
    expect(date.begin).to eq '1999-03-05'
    expect(date.end).to eq '2005-04-10'
    expect(date.expression).to eq '1999 March 05-2005 April 10'
  end

  it 'creates an expression from a month if there is a begin date but no end date' do
    date = SimpleDateObject.new('1999-05', nil, nil, 'single')
    AddExpression.call(date)
    expect(date.begin).to eq '1999-05'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999 May'
  end

  it 'recognizes an inclusive open year range' do
    date = SimpleDateObject.new('1999', nil, nil, 'inclusive')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999-'
  end

  it 'recognizes a bulk open year range' do
    date = SimpleDateObject.new('1999', nil, nil, 'bulk')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999-'
  end

  describe 'valid_date?' do
    %w[
      2025-01-01
      2025-01
      2025
      1996
      1944
      1990-11-12
    ].each do |date|
      it 'recognizes #{date} as valid' do
        expect(AddExpression.valid_date?(date)).to be true
      end
    end

    %w[
      202020-01
      2025-02-29
      2020-1
      2025-012
      02025-012-012
      0
      2020-01-01-01
    ].each do |date|
      it "recognizes #{date} as invalid" do
        expect(AddExpression.valid_date?(date)).to be false
      end
    end
  end
end
