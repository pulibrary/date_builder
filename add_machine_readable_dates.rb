require 'chronic'

class AddMachineReadableDates
    def initialize(date_record)
      @date_record = date_record
    end
  
    def call
      #if there is neither begin nor end date but there is a date expression
      if (!date_record.begin && !date_record.end) && date_record.expression
        parsed_date = Chronic.parse(date_record.expression)
        #proceed only if Chronic can parse the date
        unless parsed_date == nil
          #if the date is parsable as a range, get begin and end
          if parsed_date.class == "Span"
            date_record.begin = parsed_date.begin
            date_record.end = parsed_date.end
          #otherwise treat as a single date
          else
            date_record.begin = date_record.expression
          end
        end
      end
    end
  
    private
  
    attr_reader :date_record
  end
