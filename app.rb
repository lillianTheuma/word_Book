require('sinatra')
require('sinatra/reloader')
require('./lib/word')
require('./lib/definition')
require('pry')
also_reload('lib/**/*.rb')

### GET

get('/') do
  redirect to('/words')
end

get('/words') do
  @words = Word.sort()
  erb(:words)
end

get('/words/new') do
  erb(:new_word)
end

get('/words/:id') do
  erb(:word)
end

### POST

post ('/words') do
  word = params[:word]
  word = Word.new({:word => word, :id => nil})
  word.save()
  redirect to('/words')
end

### PATCH
patch ('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.update(params[:word])
  redirect to('/words')
end

### DELETE

delete ('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  redirect to('/words')
end
