require "sinatra"
require "sendgrid-ruby"
require "shotgun"
require_relative "baked_goods"

include SendGrid

get "/" do
    erb :index
end

get "/cakes" do
    @white_round_cake = Cakes.new("white-round-cake.jpeg", "White round cake topped with sliced fruit", "$48")
    @strawberry_chocolate_cake = Cakes.new("Strawberry_Chocolate_Cake.jpg", "Chocolate ganache & strawberry cake", "$36")
    @classic_chocolate_mousse = Cakes.new("chocolate_cake.jpg", "Classic chocolate mousse cake", "$34")
    @cakes = [@white_round_cake, @strawberry_chocolate_cake, @classic_chocolate_mousse]        
    erb :cakes
end

get "/cookies" do
    @chocolate_chip = Cookies.new("chocolate_chip_cookies.jpg", "Salted chocolate chip", "$4")
    @salted_peanut_butter = Cookies.new("peanut_butter_cookie.jpg", "Salted peanut butter", "$4")
    @macadamia_nut = Cookies.new("White-Chocolate-Macadamia-Nut-Cookies.jpg", "Macadamia nut", "$4")
    @cookies = [@chocolate_chip, @salted_peanut_butter, @macadamia_nut]        
    erb :cookies
end

get "/muffins" do
    @egg_tart_muffin = Muffins.new("creme_brulee_muffin.jpg", "Brulee Egg Tart", "$7")
    @spinach_banana = Muffins.new("spinach_banana_muffin.jpg", "Spinach Banana", "$5")
    @green_tea_muffin = Muffins.new("Matcha-Green-Tea-Muffins.jpg", "Matcha Green Tea", "$5")
    @muffins = [@egg_tart_muffin, @spinach_banana, @green_tea_muffin]        
    erb :muffins
end

get "/contact" do
    erb :contact, :layout =>
    :contact_layout 
end

post "/contact" do

    @name = params[:name]
    @email = params[:email]
  
    from = Name.new(name: @name)
    to = Email.new(email: 'ianjvidaurre@gmail.com')
    subject = 'Thank you for signing up for our email list.'
    content = Content.new(type: 'text/plain', value: @catalog)
    mail = Mail.new(from, subject, to, content)
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    if response.status_code == 401
      error_hash = JSON.parse(response.body)
      @errors = error_hash["errors"]
    end 
end 

#cakes
london_fog_cake = Cakes.new("london_fog_cake.jpg", "Chocolate cake with Earl Grey buttercream and salted caramel", "$48")
strawberry_chocolate_cake = Cakes.new("Strawberry_Chocolate_Cake.jpg", "Chocolate ganache & strawberry cake", "$36")
classic_chocolate_mousse = Cakes.new("chocolate_cake.jpg", "Classic chocolate mousse cake", "$34")

#cookies
chocolate_chip = Cookies.new("chocolate_chip_cookies.jpg", "Salted chocolate chip", "$4")
salted_peanut_butter = Cookies.new("peanut_butter_cookie.jpg", "Salted peanut butter", "$4")
macadamia_nut = Cookies.new("White-Chocolate-Macadamia-Nut-Cookies.jpg", "Macadamia nut", "$4")

#muffins
egg_tart_muffin = Muffins.new("creme_brulee_muffin.jpg", "Brulee Egg Tart", "$7")
spinach_banana = Muffins.new("spinach_banana_muffin.jpg", "Spinach Banana", "$5")
green_tea_muffin = Muffins.new("Matcha-Green-Tea-Muffins.jpg", "Matcha Green Tea", "$5")
