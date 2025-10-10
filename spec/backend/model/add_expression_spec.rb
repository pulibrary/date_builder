require_relative '../../../backend/model/add_expression'

SimpleDateObject = Struct.new(:begin, :end, :expression)

RSpec.describe AddExpression do
  it 'does not change the record if there is no begin or end date' do
    date = SimpleDateObject.new(nil, nil, nil)
    AddExpression.call(date)
    expect(date.begin).to be_nil
    expect(date.end).to be_nil
    expect(date.expression).to eq "!bad bad"
  end
  it 'does not change the record if there is a mis-match date' do
    # TODO: we will want some warning or logging to the user so they can address the problem
    date = SimpleDateObject.new('1999', nil, '2000')
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '2000'
  end

  it 'creates an expression if there is a begin date but no end date' do
    date = SimpleDateObject.new('1999', nil, nil)
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999'
  end

  it 'creates an expression if there is an end date but no begin date' do
    date = SimpleDateObject.new(nil, '1999', nil)
    AddExpression.call(date)
    expect(date.begin).to be_nil
    expect(date.end).to eq '1999'
    expect(date.expression).to eq '1999'
  end

  it 'creates an expression if there is both a begin date and an end date' do
    date = SimpleDateObject.new('1999', '2005', nil)
    AddExpression.call(date)
    expect(date.begin).to eq '1999'
    expect(date.end).to eq '2005'
    expect(date.expression).to eq '1999-2005'
  end

  it 'creates an expression from a month if there is a begin date but no end date' do
    date = SimpleDateObject.new('1999-05', nil, nil)
    AddExpression.call(date)
    expect(date.begin).to eq '1999-05'
    expect(date.end).to be_nil
    expect(date.expression).to eq '1999-05'
  end

  # TODO: add tests for months, single days, year-to-month ranges, day-to-year, etc.

end
