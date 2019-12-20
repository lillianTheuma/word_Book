require 'rspec'
require 'meaning'
require 'word'
require 'pry'

describe '#Meaning' do

  before(:each) do
    Word.clear
    Meaning.clear
    @word = Word.new({:name => "Giant Steps", :id => nil})
    @word.save()
  end

  describe('#==') do
    it("is the same meaning if it has the same attributes as another meaning") do
      meaning = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning2 = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      expect(meaning).to(eq(meaning2))
    end
  end

  describe('.all') do
    it("returns a list of all meanings") do
      meaning = Meaning.new({:name => "Giant Steps", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning2.save()
      expect(Meaning.all).to(eq([meaning, meaning2]))
    end
  end

  describe('.clear') do
    it("clears all meanings") do
      meaning = Meaning.new({:name => "Giant Steps", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning2.save()
      Meaning.clear()
      expect(Meaning.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a meaning") do
      meaning = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning.save()
      expect(Meaning.all).to(eq([meaning]))
    end
  end

  describe('.find') do
    it("finds a meaning by id") do
      meaning = Meaning.new({:name => "Giant Steps", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning2.save()
      expect(Meaning.find(meaning.id)).to(eq(meaning))
    end
  end

  describe('#update') do
    it("updates an meaning by id") do
      meaning = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning.update("Mr. P.C.", @word.id)
      expect(meaning.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an meaning by id") do
      meaning = Meaning.new({:name => "Giant Steps", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning2.save()
      meaning.delete()
      expect(Meaning.all).to(eq([meaning2]))
    end
  end

  describe('.find_by_word') do
    it("finds meanings for an word") do
      word2 = Word.new({:name => "Blue", :id => nil})
      word2.save
      meaning = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning.save()
      meaning2 = Meaning.new({:name => "California", :word_id => word2.id , :id => nil})
      meaning2.save()
      expect(Meaning.find_by_word(word2.id)).to(eq([meaning2]))
    end
  end

  describe('#word') do
    it("finds the word a meaning belongs to") do
      meaning = Meaning.new({:name => "Naima", :word_id => @word.id, :id => nil})
      meaning.save()
      expect(meaning.word()).to(eq(@word))
    end
  end
end
