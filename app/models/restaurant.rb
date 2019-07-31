class Restaurant
  attr_reader :name, :address
  def initialize(attributes)
    @name = attributes[:name]
    @address = format_address(attributes[:location][:display_address])
  end

  private

  def format_address(input)
    street = input.first
    city = input.second
    return street + ", " + city
  end
end
