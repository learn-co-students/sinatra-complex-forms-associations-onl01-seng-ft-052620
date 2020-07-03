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
    if !!params[:pet][:owner_id] && !params[:owner][:name].empty?
      redirect '/pets/failure'
    end
    @pet = Pet.create(params[:pet])
    @pet.owner = Owner.create(params[:owner]) unless params[:owner][:name].empty?
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if params[:owner][:name].empty? 
      @pet.update(owner: Owner.find(params[:pet][:owner_id]))
    else
      @pet.update(owner: Owner.create(name: params[:owner][:name]))
    end
    redirect to "pets/#{@pet.id}"
  end
end