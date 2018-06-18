class AnimalsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  get '/animals' do

    @title = "Animals Index"

    @animals = Animal.all

    erb :'animals/index'

  end

  get '/animals/new' do

    @animal = Animal.new

    erb :'animals/new'

  end

  get '/animals/:id' do

    id = params[:id].to_i

    @animal = Animal.find id

    erb :'animals/show'

  end

  post '/animals' do

    animal = Animal.new

    animal.scientific_animal_name = params[:scientific_animal_name]
    animal.common_animal_name = params[:common_animal_name]

    animal.save

    redirect '/animals'

  end

  put '/animals/:id' do

    id = params[:id].to_i

    animal = Animal.find id

    animal.scientific_animal_name = params[:scientific_animal_name]
    animal.common_animal_name = params[:common_animal_name]

    animal.save

    redirect '/animals'

  end

  delete '/animals/:id' do

    id = params[:id].to_i

    Animal.destroy id

    redirect '/animals'

  end

  get '/animals/:id/edit' do

    id = params[:id].to_i

    @animal = Animal.find id

    erb :'animals/edit'

  end

end
