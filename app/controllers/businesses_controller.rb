class BusinessesController < ActionController::API
  def index
    businesses = Business.all 
    date = Date.new(2016, 9, 12) 
    summary = []
    businesses.each do |business|
      if business.monthly_transactions(date).count > 0
        summary << {
          business: business.name,
          transactions: business.monthly_transactions(date).count,
          total_spent: business.monthly_total(date)
       }
     end
    end
    render json: {
      summary: summary 
    }
  end



end
