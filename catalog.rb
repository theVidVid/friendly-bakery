require '/app.rb'

get "/catalog" do
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
    erb :catalog
end