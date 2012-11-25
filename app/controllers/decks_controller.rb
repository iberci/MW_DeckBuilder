class DecksController < ApplicationController
   require 'tempfile'
   require 'csv'
   def index
     tokens = params['cards']
       
     type = params['type']

     file = Tempfile.open('Deck', Rails.root.join('tmp')) do |f|
        self.send("build_#{type}_file", f, tokens)

        f.flush
        send_file(f.path, filename:"Deck.#{type}", type:"text/#{type}")
     end
   end

   private 
   def build_xml_file(f, tokens)
     builder = Builder::XmlMarkup.new(target:f, indent:2)
     builder.instruct!
     builder.xml do |xml| 
        xml.cards do |cards_section|

           for token in tokens
              cards_section.card do |card_section| 

                 card  = Card.find(token.first)
                 card_section.code(card.code)
                 card_section.name(card.name)
                 card_section.amount(token.last)
              end
           end
        end
     end
   end

   def build_csv_file(f, tokens)
      CSV.open(f.path, "wb") do |csv|
         for token in tokens
           card = Card.find(token.first)
           csv << [card.code, token.last, card.name]
         end
      end
   end

end
