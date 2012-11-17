class CardsController < ApplicationController
  def index
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
