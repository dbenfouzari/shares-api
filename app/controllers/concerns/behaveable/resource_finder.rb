module Behaveable
  module ResourceFinder
    # Get the behaveable object.
    #
    # ==== Returns
    # * <tt>ActiveRecord::Model</tt> - Behaveable instance object.
    def behaveable
      klass, param = behaveable_class
      klass.find(params[param.to_sym]) if klass
    end

    # Lookup behaveable class.
    #
    # ==== Returns
    # * <tt>Response</tt> - Behaveable class or nil if not found.
    def behaveable_class
      params.keys.each do |name|
        if name =~ /(.+)_id$/
          model = name.match(/(.+)_id/)

          return model[1].classify.constantize, name
        end
      end

      nil
    end
  end
end