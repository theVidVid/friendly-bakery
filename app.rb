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

post "/catalog" do
    @white_round_cake = Cakes.new("white-round-cake.jpeg", "White round cake topped with sliced fruit", "$48")
    @strawberry_chocolate_cake = Cakes.new("Strawberry_Chocolate_Cake.jpg", "Chocolate ganache & strawberry cake", "$36")
    @classic_chocolate_mousse = Cakes.new("chocolate_cake.jpg", "Classic chocolate mousse cake", "$34")
    @cakes = [@white_round_cake, @strawberry_chocolate_cake, @classic_chocolate_mousse]
    @chocolate_chip = Cookies.new("chocolate_chip_cookies.jpg", "Salted chocolate chip", "$4")
    @salted_peanut_butter = Cookies.new("peanut_butter_cookie.jpg", "Salted peanut butter", "$4")
    @macadamia_nut = Cookies.new("White-Chocolate-Macadamia-Nut-Cookies.jpg", "Macadamia nut", "$4")
    @cookies = [@chocolate_chip, @salted_peanut_butter, @macadamia_nut]
    @egg_tart_muffin = Muffins.new("creme_brulee_muffin.jpg", "Brulee Egg Tart", "$7")
    @spinach_banana = Muffins.new("spinach_banana_muffin.jpg", "Spinach Banana", "$5")
    @green_tea_muffin = Muffins.new("Matcha-Green-Tea-Muffins.jpg", "Matcha Green Tea", "$5")
    @muffins = [@egg_tart_muffin, @spinach_banana, @green_tea_muffin]    
    puts "PARAMS"
    puts params.inspect
    puts "PARAMS"

    @firstName = params[:firstName]
    @lastName = params[:lastName]   
    @email = params[:email]
    puts @email
  
    from = Email.new(email: @email)
    to = Email.new(email: 'ianjvidaurre@gmail.com')
    subject = 'Thank you for signing up for our email list.'
    content = Content.new(type: 'text/plain', value: "Bakery Email sign-up confirmation.
        Thank you for your interest in Brooklyn Baked Goods Collective, #{@firstName} #{@lastName}!
        
        We aim to provide the best selection of baked goods to sweeten your
        event, whether it be a birthday, graduation, anniversary, wedding, or even 
        on your daily commute.

        Please take a peek at our catalog and please allow 24 hours for our team
        review your order. 

        Cakes

        White round cake topped with sliced fruit - $48
        Chocolate ganache & strawberry cake - $36
        Classic chocolate mousse cake - $34

        Cookies

        Salted chocolate chip - $4/$20 single/dozen
        Salted peanut butter - $4/$20 single/dozen
        Macadamia nut - $4/$20 single/dozen

        Muffins 

        Brulee Egg Tart - $7
        Spinach Banana - $5
        Matcha Green Tea - $5
        
        Stay tuned for seasonal menu changes!")
    mail = Mail.new(from, subject, to, content)
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers    
    erb :catalog
end 