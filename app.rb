require('sinatra')
require('sinatra/reloader')
require('./lib/word')
require('./lib/meaning')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  redirect to('/words')
end

get('/words') do
  @words = Word.sort
  @words_sold = Word.all_sold
  erb(:words)
end

get('/words/search') do
  user_search = params[:search]
  @search = Word.search(user_search)
  erb(:search)
end


get ('/words/new') do
  erb(:new_word)
end

post ('/words') do
  name = params[:word_name]
  word = Word.new({:name => name, :id => nil})
  word.save()
  redirect to('/words')
end

get ('/words/:id') do
  @word = Word.find(params[:id].to_i())
  erb(:word)
end

get ('/words/:id/edit') do
  @word = Word.find(params[:id].to_i())
  erb(:edit_word)
end

patch ('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.update(params[:name])
  redirect to('/words')
end

get ('/words/:id/buy') do

    @word = Word.find(params[:id].to_i())
    @word.sold
    redirect to('/words')
end
delete ('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  redirect to('/words')
end

get ('/words/:id/meanings/:meaning_id') do
  @meaning = Meaning.find(params[:meaning_id].to_i())
  erb(:meaning)
end

post ('/words/:id/meanings') do
  @word = Word.find(params[:id].to_i())
  meaning = Meaning.new({:name => params[:meaning_name], :word_id => @word.id, :id => nil, :artist_name => params[:artist_name], :year_recorded => params[:year_recorded], :studio => params[:studio]})
  meaning.save()
  erb(:word)
end

patch ('/words/:id/meanings/:meaning_id') do
  @word = Word.find(params[:id].to_i())
  meaning = Meaning.find(params[:meaning_id].to_i())
  meaning.update(params[:name], @word.id, params[:artist_name], params[:year_recorded])
  erb(:word)
end

delete ('/words/:id/meanings/:meaning_id') do
  meaning = Meaning.find(params[:meaning_id].to_i())
  meaning.delete
  @word = Word.find(params[:id].to_i())
  erb(:word)
end
