class Client::ProductsController < ApplicationController
  def index
    response = HTTP.get("http://localhost:3000/api/products")
    @products = response.parse
    render 'index.html.erb'
  end
  def new
    render 'new.html.erb'
  end
  def create
    response = HTTP.post(
                          "http://localhost:3000/api/products",
                           form: {
                                 name: params[:name],
                                 price: params[:price],
                                 description: params[:description],
                                 image_url: params[:image_url]
                                }
                                )
    @product = response.parse
    redirect_to "/client/products/#{product["id"]}"
  end
  def show
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
    @product = response.parse
    render 'show.html.erb'
  end
  def edit
    @id = params[:id]
    response = HTTP.get("http://localhost:3000/api/products/#{params[:id]}")
      @recipe = response.parse
      render 'edit.html.erb'
  end
  def update
    response = HTTP.patch(
      "http://localhost:3000/api/products#{params[:id]}"
      form: {
        name: params[:name],
        price: params[:price],
        description: params[:description],
        subtotal: params[:subtotal],
        tax: params[:tax],
        total: params[:total],
        image_url: params[:image_url]
      })
    @product = response.parse
    redirect_to "/client/prodicts/#{product['id']}"
  end
end
