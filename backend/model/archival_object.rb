class ArchivalObject < Sequel::Model(:archival_object)


    def self.produce_display_string(json)
        display_string = json['title'] || ""

        date_label = json.has_key?('dates') && json['dates'].length > 0 ?
                    json['dates'].map do |date|
                        if date['expression']
                            date['date_type'] == 'bulk' ? "#{I18n.t("date_type_bulk.bulk")}: #{date['expression']}" : date['expression']
                        # elsif date['begin'] and date['end']
                        #     date['date_type'] == 'bulk' ? "#{I18n.t("date_type_bulk.bulk")}: #{date['begin']} - #{date['end']}" : "#{date['begin']} - #{date['end']}"
                        # else
                        #     date['date_type'] == 'bulk' ? "#{I18n.t("date_type_bulk.bulk")}: #{date['begin']}" : date['begin']
                        else
                            AddExpression.expression(date['begin'], date['end'], date['date_type'])
                        end
                    end.join(', ') : false

        display_string += ", " if json['title'] && date_label
        display_string += date_label if date_label

        display_string
    end

end