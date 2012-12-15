class Deck < ActiveRecord::Base
  %w{builder csv prawn nokogiri}.each {|f| require f}

  attr_accessible :title, :description, :deck_cards, :deck_cards_attributes, :mage, :mage_name

  has_many :deck_cards
  has_many :cards, :through => :deck_cards
  belongs_to :mage, :foreign_key => :mage_name

  accepts_nested_attributes_for :deck_cards 

  class << self

   def build_from_xml(file)

     deck = Nokogiri::XML::Document.parse(file.read()).root

     Deck.new({
       :title => deck.attributes['title'].value, 
       :mage_name => deck.attributes['mage'].value,
       :description => deck.css('description').text,
       :deck_cards_attributes => deck.css('cards card').map do |c|
         ca = c.attributes
         {:card => Card.find(ca['code'].value), :amount => ca['amount'].value}
       end, 
     })
   end

   def build_from_csv(file)
   end

  end

  def write_xml(f)
    builder = ::Builder::XmlMarkup.new(target:f, indent:2)
    builder.instruct!
    builder.deck :title => self.title, :mage => self.mage_name, :version => '1'  do |deck| 
      deck.description self.description
      deck.cards do |cards|
        for dc in self.deck_cards
          cards.card :code => dc.card.code, :name => dc.card.name, :amount => dc.amount
        end
      end
    end
  end

  def write_csv(f)
    CSV.open(f.path, "wb") do |csv|
      csv << [self.title,  self.description]
      for dc in self.deck_cards
        csv << [dc.card.code, dc.amount, dc.card.name]
      end
    end
  end

  def write_pdf(f)
    pdf = Prawn::Document.new
    pdf.text self.title
    pdf.text self.description
    for dc in self.deck_cards
      pdf.text "#{dc.card.code}, #{dc.amount}, #{dc.card.name}"
    end
    pdf.render_file(f.path)
  end
  
end
