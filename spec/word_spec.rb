require 'rspec'
require 'word'
require 'definition'
require 'pry'

describe '#Word' do

  before(:each) do
    Word.clear
    Definition.clear
  end

  describe('.all') do
    it("returns an empty array when there are no words") do
      expect(Word.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an word") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:word => "Blue", :id => nil})
      word2.save()
      expect(Word.all).to(eq([word, word2]))
    end
  end

  describe('.clear') do
    it("clears all words") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:word => "Blue", :id => nil})
      word2.save()
      Word.clear
      expect(Word.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same word if it has the same attributes as another word") do
      word = Word.new({:word => "Blue", :id => nil})
      word2 = Word.new({:word => "Blue", :id => nil})
      expect(word).to(eq(word2))
    end
  end

  describe('.find') do
    it("finds an word by id") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:word => "Blue", :id => nil})
      word2.save()
      expect(Word.find(word.id)).to(eq(word))
    end
  end

  describe('#update') do
    it("updates an word by id") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word.update("A Love Supreme")
      expect(word.word).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an word by id") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:word => "Blue", :id => nil})
      word2.save()
      word.delete()
      expect(Word.all).to(eq([word2]))
    end
  end

  describe('#definitions') do
    it("returns an word's definitions") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      definition = Definition.new({:word => "Naima", :word_id => word.id, :id => nil})
      definition.save()
      definition2 = Definition.new({:word => "Cousin Mary", :word_id => word.id, :id => nil})
      definition2.save()
      expect(word.definitions).to(eq([definition, definition2]))
    end
  end

  describe('.search') do
    it("searches for an word by word") do
      word = Word.new({:word => "A Love Supreme", :id => nil})
      word.save()
      word2 = Word.new({:word => "Blue", :id => nil})
      word2.save()
      word3 = Word.new({:word => "Blues clues", :id => nil})
      word3.save()
      expect(Word.search("blue")).to(eq([word2, word3]))
    end
  end

  describe('.sort') do
    it("sorts words by word") do
      word = Word.new({:word => "Blue", :id => nil})
      word.save()
      word2 = Word.new({:word => "A Love Supreme", :id => nil})
      word2.save()
      word3 = Word.new({:word => "Moving Pictures", :id => nil})
      word3.save()
      expect(Word.sort()).to(eq([word2, word, word3]))
    end
  end
end
