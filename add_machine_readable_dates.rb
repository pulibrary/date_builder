require 'chronic'

class AddMachineReadableDates
    def initialize(date_record)
      @date_record = date_record
    end
  
    def call
      if (date_record.begin || date_record.end) && !date_record.expression
        begin_date_valid = Chronic.parse(date_record.begin)
        end_date_valid = Chronic.parse(date_record.end)
        #proceed only if Chronic can parse one of the dates
        if begin_date_valid || end_date_valid
          if begin_date_valid && end_date_valid
            date_record.expression = "#{date_record.begin}-#{date_record.end}"
          else
            date_record.expression = date_record.begin || date_record.end
          end
        end
      end
    end
  
    private
  
    attr_reader :date_record
  end
