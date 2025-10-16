require 'date'

module AddExpression
    def self.transform_numeric_to_alpha_month(number)
      month_hash = {
        "01" => "January",
        "02" => "February",
        "03" => "March",
        "04" => "April",
        "05" => "May",
        "06" => "June",
        "07" => "July",
        "08" => "August",
        "09" => "September",
        "10" => "October",
        "11" => "November",
        "12" => "December"
      }
      month_hash[number]
    end

    def self.call(date_record)
      if (date_record.begin || date_record.end) && !date_record.expression
        begin_date_valid = valid_date?(date_record.begin)
        end_date_valid = valid_date?(date_record.end)

        if begin_date_valid || end_date_valid
          if begin_date_valid && end_date_valid
            date_record.expression = "#{normalize_date(date_record.begin)}-#{normalize_date(date_record.end)}"
          elsif begin_date_valid && (%w[inclusive bulk].include? date_record.date_type)
            date_record.expression = "#{normalize_date(date_record.begin)}-"
          else
            date_record.expression = normalize_date(date_record.begin) || normalize_date(date_record.end)
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

    def self.normalize_date(date_string)
      return false unless date_string

      date_parts = date_string.split('-')
      month = date_parts[1]
      if month
        date_parts[1] = transform_numeric_to_alpha_month(month)
      end 
      date_parts.join(' ')
    end
  end
