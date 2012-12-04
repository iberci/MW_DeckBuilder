class DecksController < ApplicationController
   %w{tempfile csv prawn nokogiri}.each {|f| require f}

  def new
    type = params['type']

    file = Tempfile.open('Deck', Rails.root.join('tmp')) do |f|
      deck = Deck.new(params[:deck])

      deck.send("write_#{type}", f)

      f.flush
      send_file(f.path, filename:"Deck.#{type}", type:send_type(type))
    end
  end

  def create
    file = params[:file]
    ext = File.extname(file.original_filename)[1..-1]
    @deck = Deck.send("build_from_#{ext}", file)

    render 'cards/index'
  end

  private 

  def send_type(type)
    case(type) 
    when 'pdf' then 'application/pdf'
    else "text/#{type}"
    end
  end
  
end
