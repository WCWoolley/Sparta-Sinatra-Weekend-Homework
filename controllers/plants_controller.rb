class PlantsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  get '/plants' do

    @title = "Plants Index"

    @plants = Plant.all

    erb :'plants/index'

  end

  get '/plants/new' do

    @plant = Plant.new

    erb :'plants/new'

  end

  get '/plants/:id' do

    id = params[:id].to_i

    @plant = Plant.find id

    erb :'plants/show'

  end

  post '/plants' do

    plant = Plant.new

    plant.Scientific_Plant_Name = params[:Scientific_Plant_Name]
    plant.Common_Plant_Name = params[:Common_Plant_Name]

    plant.save

    redirect '/plants'

  end

  put '/plants/:id' do

    id = params[:id].to_i

    plant = Plant.find id

    plant.Scientific_Plant_Name = params[:Scientific_Plant_Name]
    plant.Common_Plant_Name = params[:Common_Plant_Name]

    plant.save

    redirect '/plants'

  end

  delete '/plants/:id' do

    id = params[:id].to_i

    Plant.destroy id

    redirect '/plants'

  end

  get '/plants/:id/edit' do

    id = params[:id].to_i

    @plant = Plant.find id

    erb :'plants/edit'

  end

end
