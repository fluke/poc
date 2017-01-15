module ActiveRecord
  # https://github.com/rails/rails/blob/master/activerecord/lib/active_record/timestamp.rb
  module Timestamp
    def timestamp_attributes_for_update
      [:updated_at, :updated_on, :modifiedOn]
    end

    def timestamp_attributes_for_create
      [:created_at, :created_on, :createdOn]
    end
  end

  # https://github.com/rails/rails/blob/master/activerecord/lib/active_record/reflection.rb#L607
  module Reflection
    class AssociationReflection
      def derive_foreign_key
        if belongs_to?
          "#{name}_id_fk"
        elsif options[:as]
          "#{options[:as]}_id_fk"
        else
          # This is patched in config/initializers/active_support.rb
          active_record.name.foreign_key
        end
      end
    end
  end
end