class Meaning
  attr_reader :id
  attr_accessor :name, :word_id, :poster_name

  @@meanings = {}
  @@total_rows = 0

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @word_id = attributes.fetch(:word_id)
    @id = attributes.fetch(:id) || @@total_rows += 1
    @poster_name = attributes.fetch(:poster_name)
  end

  def ==(meaning_to_compare)
    (self.name() == meaning_to_compare.name()) && (self.word_id() == meaning_to_compare.word_id())
  end

  def self.all
    @@meanings.values
  end

  def save
    @@meanings[self.id] = Meaning.new({:poster_name => @poster_name, :name => @name, :word_id => @word_id, :id => @id, :poster_name => @poster_name})
  end

  def self.find(id)
    @@meanings[id]
  end

  def update(name, word_id)
    self.name = name
    self.word_id = word_id
    @@meanings[self.id] = Meaning.new({:poster_name => @poster_name, :name => @name, :word_id => @word_id, :id => @id, :poster_name => @poster_name})
  end

  def delete
    @@meanings.delete(self.id)
  end

  def self.clear
    @@meanings = {}
  end

  def self.find_by_word(alb_id)
    meanings = []
    @@meanings.values.each do |meaning|
      if meaning.word_id == alb_id
        meanings.push(meaning)
      end
    end
    meanings
  end

  def word
    Word.find(self.word_id)
  end
end
