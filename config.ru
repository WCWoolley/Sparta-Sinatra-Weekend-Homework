require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require_relative './models/Animal.rb'
require_relative './controllers/animals_controller.rb'
require_relative './models/Plant.rb'
require_relative './controllers/plants_controller.rb'

use Rack::Reloader
use Rack::MethodOverride

run Rack::Cascade.new ([
  AnimalsController,
  PlantsController
  ])
