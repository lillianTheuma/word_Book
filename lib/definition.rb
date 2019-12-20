class Definition
  attr_reader :id
  attr_accessor :word, :word_id

  @@definitions = {}
  @@total_rows = 0

  def initialize(attributes)
    @word = attributes.fetch(:word)
    @word_id = attributes.fetch(:word_id)
    @id = attributes.fetch(:id) || @@total_rows += 1
  end

  def ==(definition_to_compare)
    (self.word() == definition_to_compare.word()) && (self.word_id() == definition_to_compare.word_id())
  end

  def self.all
    @@definitions.values
  end

  def save
    @@definitions[self.id] = Definition.new({:word => @word, :word_id => @word_id, :id => @id})
  end

  def self.find(id)
    @@definitions[id]
  end

  def update(word, word_id)
    self.word = word
    self.word_id = word_id
    @@definitions[self.id] = Definition.new({:word => @word, :word_id => @word_id, :id => @id})
  end

  def delete
    @@definitions.delete(self.id)
  end

  def self.clear
    @@definitions = {}
  end

  def self.find_by_word(alb_id)
    definitions = []
    @@definitions.values.each do |definition|
      if definition.word_id == alb_id
        definitions.push(definition)
      end
    end
    definitions
  end

  def word
    Word.find(self.word_id)
  end
end
