class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    # binding.pryparam
    @pet = Pet.create(params[:pet])
    if params[:pet]["owner_id"]
      @pet.owner = Owner.find(params[:pet]["owner_id"].first)
    end
    @pet.save
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        owner = Owner.create(name: params["owner"]["name"])
        @pet.owner = owner
        @pet.save
      end
    redirect to "pets/#{@pet.id}"
  end
end