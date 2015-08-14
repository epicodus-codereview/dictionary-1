require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/word')
require('./lib/definition')

get('/') do
  erb(:index)
end

get('/words/') do
  @words = Word.all()
  erb(:words)
end

get('/words/new/') do
  @words = Word.all()
  erb(:word_form)
end

post('/words/new/') do
  word = params.fetch('word')
  @word = Word.new(:word => word)
  @word.save
  @words = Word.all
  erb(:words)
end

get('/words/:id/') do
  @word = Word.find(params.fetch('id').to_i)
  erb(:word)
end

get('/words/:id/new/') do
  @word = Word.find(params.fetch('id').to_i)
  erb(:definition_form)
end

post('/words/:id/new/') do
  definition = params.fetch('definition')
  @definition = Definition.new(:definition => definition)
  @definition.save()
  @word = Word.find(params.fetch('id').to_i)
  @word.add_definition(@definition)
  erb(:word)
end