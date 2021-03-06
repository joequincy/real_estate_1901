class House
  attr_reader :price, :address, :rooms
  def initialize(price, address)
    @price = price
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def rooms_from_category(category)
    @rooms.select {|room| room.category == category}
  end

  def area
    @rooms.inject(0) {|area,room| area += room.area}
  end

  def price_per_square_foot
    area == 0 ? nil : (@price.sub("$","").to_f / area).round(2)
  end

  def rooms_sorted_by_area
    @rooms.sort {|a,b| b.area <=> a.area}
  end

  def rooms_by_category
    output = {}
    categories = []
    @rooms.each do |room|
      if !categories.include?(room.category)
        categories << room.category
        output[room.category] = rooms_from_category(room.category)
      end
    end
    return output
  end
end
