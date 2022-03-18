# frozen_string_literal: true

module Behaveable
  # Helpers to find a resource from polymorphic controller association
  module ResourceFinder
    # Get the behaveable object.
    #
    # ==== Returns
    # * <tt>ActiveRecord::Model</tt> - Behaveable instance object.
    def behaveable
      klass, param = behaveable_class
      klass&.find(params[param.to_sym])
    end

    # Lookup behaveable class.
    #
    # ==== Returns
    # * <tt>Response</tt> - Behaveable class or nil if not found.
    def behaveable_class
      params.each_key do |name|
        next unless name =~ /(.+)_id$/

        model = name.match(/(.+)_id/)

        return model[1].classify.constantize, name
      end

      nil
    end
  end
end
