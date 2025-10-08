# Rails.application.config.after_initialize do

  class ASDate < Sequel::Model(:date)
    include ASModel
    corresponds_to JSONModel(:date)

    set_model_scope :global

    def around_save
      AddMachineReadableDates.new(self).call
      super
    end
  end
# end
