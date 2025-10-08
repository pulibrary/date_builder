class ASDate < Sequel::Model(:date)
  include ASModel
  corresponds_to JSONModel(:date)

  set_model_scope :global

  def around_save
    AddExpression.call(self)
    super
  end
end
