class ApplicationController < ActionController::Base
  helper_method :populate_filters

  def filters
    @filters ||= {}
  end

  def populate_filters(param)
    filters.merge!(param.stringify_keys) # stringify method to prevent duplications, because argument (param) contains key as symbol, but rails params uses keys in string form
  end
end
