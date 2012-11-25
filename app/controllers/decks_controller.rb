class DecksController < ApplicationController
   require 'tempfile'
   require 'csv'
   require 'prawn'

   def index
     type = params['type']

     file = Tempfile.open('Deck', Rails.root.join('tmp')) do |f|
       card_counts = params['cards'].map {|t| {:card => Card.find(t.first), :amount => t.last}}
       self.send("write_#{type}", f, card_counts)

       f.flush
       send_file(f.path, filename:"Deck.#{type}", type:send_type(type))
     end
   end

   private 
   def send_type(type)
     case(type) 
     when 'pdf' then 'application/pdf'
     else "text/#{type}"
     end
   end

   def write_xml(f, card_counts)
     builder = Builder::XmlMarkup.new(target:f, indent:2)
     builder.instruct!
     builder.xml do |xml| 
        xml.cards do |cards_section|

           for cc in card_counts
              cards_section.card do |card_section| 
                 card = cc[:card]

                 card_section.code(card.code)
                 card_section.name(card.name)
                 card_section.amount(cc[:amount])
              end
           end
        end
     end
   end

   def write_csv(f, card_counts)
      CSV.open(f.path, "wb") do |csv|
         for cc in card_counts
           card = cc[:card]
           csv << [card.code, cc[:amount], card.name]
         end
      end
   end

   def write_pdf(f, card_counts)
     pdf = Prawn::Document.new
     for cc in card_counts
       card = cc[:card]
       pdf.text "#{card.code}, #{cc[:amount]}, #{card.name}"
     end
     pdf.render_file(f.path)
   end

end
