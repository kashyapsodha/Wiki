require 'sinatra'

set :bind, '0.0.0.0'

get "/" do
  erb :welcome
end

get "/new" do
  erb :new  
end

get "/:title" do
  @title = params[:title]
  @content = page_content(@title)

  erb :show
end

get "/:title/edit" do
  @title = params[:title]
  @page_content = page_content(@title)

  erb :edit
end

post "/create" do
  save_content(params[:title], params[:content])

  redirect "/#{params[:title]}"
end

put "/:title" do
  save_content(params[:title], params[:content])

  redirect "/#{params[:title]}"
end

delete "/:title" do
  delete_content(params[:title])

  redirect "/"
end

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", 'w') do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
end

