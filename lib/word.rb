class Word
  attr_accessor :name
  attr_reader :id

  @@words = {}
  @@total_rows = 0

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) || @@total_rows += 1

  end

  def self.all
    @@words.values()
  end
  def self.all_sold
    @@words_sold.values()
  end

  def save
    @@words[self.id] = Word.new({ :name => self.name, :id => self.id })
  end

  def ==(word_to_compare)
    self.name() == word_to_compare.name()
  end

  def self.clear
    @@words = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@words[id]
  end

  def self.search(search)
    @@words.values().select { |a| a.name.match(/#{search}/i)}
  end

  def update(name)
    self.name = name
    @@words[self.id] = Word.new({ :name => self.name, :id => self.id })
  end

  def self.sort()
    sorted_array = []

    self.all.each do |a|
      sorted_array.push(a.name)
    end
    results = sorted_array.sort.map { |a|  self.search(a)[0] }
  end

  def delete
    @@words.delete(self.id)
  end


  def meanings
    Meaning.find_by_word(self.id)
  end




end
