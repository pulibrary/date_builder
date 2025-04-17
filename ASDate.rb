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

# Rails.logger breaks ASpace
# Rails.logger.warn('we are in the new date_test!')

end
