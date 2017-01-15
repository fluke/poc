module ActiveSupport
  module Inflector
    # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb#L236
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      underscore(demodulize(class_name)) + (separate_class_name_and_id_with_underscore ? "_id_fk" : "id_fk")
    end
  end
end