class CardsController < ApplicationController

  DEFAULT_PER_PAGE = 20
  def index
    @cards = Card.order('name').includes(:school_levels)
    @cards = @cards.send(:for_school, params[:for_school]) if params[:for_school]
    @cards = @cards.send(:for_type, params[:for_type]) if params[:for_type]

    @cards = @cards.paginate(page:(params[:page] || 1), per_page:(params[:per_page] || DEFAULT_PER_PAGE))

    @cards = @cards.map{|c| c.attributes.merge(:levels => c.school_levels.map {|sl| sl.attributes})}
    
    respond_to do |format|
      format.html
      format.json do 
        render json:@cards.to_json
      end
    end
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find_or_create(params[:code])
  end

  def create
    @card = Card.create!(params[:card])
    flash[:message] = "Card #{@card.code} successfully created"
    redirect_to index_path
  rescue Exception => e
    @card = Card.new(params[:card])
    flash[:error] = e.message
    render new_card_path
  end
end
