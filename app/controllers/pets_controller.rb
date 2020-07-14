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
    
    @pet = Pet.create(name: params[:pet_name])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = owner
      @pet.save
    else
      owner = Owner.find_by(name: params["pet"]["owner_id"]["name"])
      @pet.owner = owner
      @pet.save
    end
      
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    ####### bug fix
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end
    #######
  
    
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owners << Owner.create(name: params["owner"]["name"])
    end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
end