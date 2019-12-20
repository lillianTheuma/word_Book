class Word
  attr_accessor :word
  attr_reader :id

  @@words = {}
  @@words_sold = {}

  @@total_rows = 0

  def initialize(attributes)
    @word = attributes.fetch(:word)
    @id = attributes.fetch(:id) || @@total_rows += 1

  end

  def self.all
    @@words.values()
  end
  def self.all_sold
    @@words_sold.values()
  end

  def save
    @@words[self.id] = Word.new({ :word => self.word, :id => self.id })
  end

  def ==(word_to_compare)
    self.word == word_to_compare.word()
  end

  def self.clear
    @@words = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@words[id]
  end

  def self.search(search)
    @@words.values().select { |a| a.word.match(/#{search}/i)}
  end

  def update(word)
    self.word = word
    @@words[self.id] = Word.new({ :word => self.word, :id => self.id })
  end

  def self.sort()
    sorted_array = []

    self.all.each do |a|
      sorted_array.push(a.word)
    end
    results = sorted_array.sort.map { |a|  self.search(a)[0] }
  end

  def delete
    @@words.delete(self.id)
  end

  def definitions
    Definition.find_by_word(self.id)
  end




end
