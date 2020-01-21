require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an word path', {:type => :feature}) do
  it('creates an word and then goes to the word page') do
    visit('/words')
    click_on('Add a new word')
    fill_in('word_name', :with => 'This is a word')
    click_on('Add word')
    expect(page).to have_content('This is a word')
  end
end

describe('create a meaning', {:type => :feature}) do
  it('creates an word and then goes to the word page') do
    word = Word.new({:name => "This is a word", :id => nil})
    word.save
    visit("/words/#{word.id}")
    fill_in('poster_name', :with => "Test")
    fill_in('meaning', :with => 'Definition goes here')
    click_on('Add meaning')
    expect(page).to have_content('Definition goes here')
  end
end
