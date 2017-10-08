class BusinessesController < ApplicationController

  def index
    businesses = Business.all 
    summary = []
    businesses.each do |business|
      if business.monthly_transactions($date).count > 0
        summary << {
          id: business.id,
          business: business.name,
          transactions: business.monthly_transactions($date).count,
          total_spent: business.monthly_total($date),
          ignore: business.ignore,
          whittle: business.whittle,
          whittle_target: business.whittle_target
       }
     end
    end
    render json: {
      summary: summary,
      date: $date, 
      last_months_savings: calculate_whittle_savings
    }
  end

  def update
    business = Business.find(params[:id])
    if params[:ignore]
      business.update(ignore: params[:ignore])
    end
    if params[:whittle] 
      business.update(whittle: params[:whittle], whittle_target: business.monthly_total($date))
    end
  end

  def calculate_whittle_savings
    businesses = Business.all
    savings = 0

    businesses.each do |business|
      if business.whittle && !business.ignore
        savings += [0, business.whittle_target - business.monthly_total($date)].max
      end
    end

    savings.round(2)
  end

end
