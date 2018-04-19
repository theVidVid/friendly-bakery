
class Baked_goods 
    attr_accessor :image, :description, :price
    def initialize(image, description, price)
        @image = image
        @description = description
        @price = price
    end
end

class Cakes < Baked_goods
    attr_accessor :image, :description, :price
    def initialize(image, description, price)
        super(image, description, price)
    end
end

class Cookies < Baked_goods
    attr_accessor :image, :description, :price
    def initialize(image, description, price)
        super(image, description, price)
    end
end

class Muffins < Baked_goods
    attr_accessor :image, :description, :price
    def initialize (image, description, price)
        super(image, description, price)
    end
end

