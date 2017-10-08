class PresentationsController < ApplicationController
  def advance_time 
    $date = Date.new(2016, 10, 14)
    p User.first
    User.first.transfer_whittle_savings
  end

  def reset_time
    $date = Date.new(2016, 9, 9)
  end
end