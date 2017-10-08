class ApplicationController < ActionController::API

  def initialize
    super
    @@date = Date.new(2016, 9, 14)
  end
end
