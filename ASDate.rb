require 'chronic'

# Rails.application.config.after_initialize do

  class ASDate < Sequel::Model(:date)
    include ASModel
    corresponds_to JSONModel(:date)

    set_model_scope :global

    # Sequel FKey fields that should just be copied from initial date if present
    @@association_fields = %w|accession_id
                              deaccession_id
                              archival_object_id
                              resource_id
                              event_id
                              digital_object_id
                              digital_object_component_id
                              date_type_id
                              label_id|

    def around_save
      #if there is neither begin nor end date but there is a date expression
      if (!self.begin && !self.end) && self.expression
        let parsed_date = Chronic.parse(self.expression)
        #proceed only if Chronic can parse the date
        unless parsed_date == nil
          #if the date is parsable as a range, get begin and end
          if parsed_date.class == "Span"
            self.begin = parsed_date.begin
            self.end = parsed_date.end
          #otherwise treat as a single date
          else
            self.begin = self.expression
          end
        end
      end


      #   # parse date
      #   parsed_dates = Timetwister.parse(self.expression)

      #   # store pre-parse date_type
      #   # otherwise, any range will annihilate bulk type
      #   dtype = self.date_type

      #   # store the parsed values for first date if we were able to parse
      #   populate(self, parsed_dates.first, dtype)

        super

      #   parsed_dates.drop(1).each do |ttdate|
      #     date = ASDate.new
      #     populate(date, ttdate, dtype)
      #     date.save
      #   end
      else
        super
      end
    end
  end
# end
