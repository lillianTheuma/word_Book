require 'rspec'
require 'word'
require 'meaning'
require 'pry'

describe '#Word' do

  before(:each) do
    Word.clear
    Meaning.clear
  end

  describe('.all') do
    it("returns an empty array when there are no words") do
      expect(Word.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an word") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save()
      expect(Word.all).to(eq([word, word2]))
    end
  end

  describe('.clear') do
    it("clears all words") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save()
      Word.clear
      expect(Word.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same word if it has the same attributes as another word") do
      word = Word.new({:name => "Blue", :id => nil})
      word2 = Word.new({:name => "Blue", :id => nil})
      expect(word).to(eq(word2))
    end
  end

  describe('.find') do
    it("finds an word by id") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save()
      expect(Word.find(word.id)).to(eq(word))
    end
  end

  describe('#update') do
    it("updates an word by id") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word.update("A Love Supreme")
      expect(word.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an word by id") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save()
      word.delete()
      expect(Word.all).to(eq([word2]))
    end
  end

  describe('#meanings') do
    it("returns an word's meanings") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      meaning = Meaning.new({:poster_name => "Naima", :name => "Naima", :word_id => word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:poster_name => "Naima", :name => "Cousin Mary", :word_id => word.id, :id => nil})
      meaning2.save()
      expect(word.meanings).to(eq([meaning, meaning2]))
    end
  end

  describe('.search') do
    it("searches for an word by name") do
      word = Word.new({:name => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save()
      word3 = Word.new({:name => "Blues clues", :id => nil})
      word3.save()
      expect(Word.search("blue")).to(eq([word2, word3]))
    end
  end

  describe('.sort') do
    it("sorts words by name") do
      word = Word.new({:name => "Blue", :id => nil})
      word.save()
      word2 = Word.new({:name => "A Love Supreme", :id => nil})
      word2.save()
      word3 = Word.new({:name => "Moving Pictures", :id => nil})
      word3.save()
      expect(Word.sort()).to(eq([word2, word, word3]))
    end
  end

end
