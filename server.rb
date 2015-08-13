require 'pry'
require 'sinatra'
require 'shotgun'
require 'csv'

POST_FILE = "post.csv"


def posts
  posts = []
  CSV.foreach(POST_FILE) do |row|
    posts << row
  end
  posts
end

get '/articles/new' do
  erb :index, locals: { posts: posts, variable: posts[1] }
end

post '/posts' do
  CSV.open(POST_FILE, 'a') do |csv|
    csv << [params["title"], params["url"], params["description"]]
  end

  # Send the user back to the home page which shows
  # the list of tasks
  redirect '/articles/new'
end
