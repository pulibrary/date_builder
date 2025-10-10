require 'date'

module AddExpression
    def self.call(date_record)
      if (date_record.begin || date_record.end) && !date_record.expression
        begin_date_valid = valid_date?(date_record.begin)
        end_date_valid = valid_date?(date_record.end)
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

    def self.valid_date?(date_string)
      return false unless date_string

      date_parts = date_string.split('-')
      return false unless (1..3).include? date_parts.length
      return false unless date_parts.all? {|part| part.match? /\A\d{2,4}\z/}

      year = date_parts[0]
      month = date_parts[1] || '01'
      day = date_parts[2] || '01'

      return false if month.length != 2 || day.length != 2

      Date.valid_date? year.to_i, month.to_i, day.to_i
    end
  end
