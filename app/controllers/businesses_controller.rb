class BusinessesController < ActionController::API
  DATE = Date.new(2016, 9, 12) 

  def index
    businesses = Business.all 
    summary = []
    businesses.each do |business|
      if business.monthly_transactions(DATE).count > 0
        summary << {
          id: business.id,
          business: business.name,
          transactions: business.monthly_transactions(DATE).count,
          total_spent: business.monthly_total(DATE),
          ignore: business.ignore,
          whittle: business.whittle,
          whittle_target: business.whittle_target
       }
     end
    end
    render json: {
      summary: summary 
    }
  end

  def update
    business = Business.find(params[:id])
    if params[:ignore]
      business.update(ignore: params[:ignore])
    end
    if params[:whittle] 
      business.update(whittle: params[:whittle], whittle_target: business.monthly_total(DATE))
    end
  end

end
