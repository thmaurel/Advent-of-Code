require 'csv'
t = Time.now
d = CSV.parse(open("data.csv").read).flatten

class Ship
  attr_accessor :x, :y, :face
  def initialize(params = {})
    @x = params[:x]
    @y = params[:y]
    @face = params[:face]
    @wp = params[:wp]
  end

  def move(string)
    case string[0]
    when "N"
      @wp.y += string[1..-1].to_i
    when "S"
      @wp.y -= string[1..-1].to_i
    when "E"
      @wp.x += string[1..-1].to_i
    when "W"
      @wp.x -= string[1..-1].to_i
    when "L"
      (string[1..-1].to_i / 90).times do
        x = @wp.x
        y = @wp.y
        @wp.x = -y
        @wp.y = x
      end
      # case @face
      # when "N"
      #   @face = "W" if string[1..-1].to_i == 90
      #   @face = "S" if string[1..-1].to_i == 180
      #   @face = "E" if string[1..-1].to_i == 270
      # when "S"
      #   @face = "E" if string[1..-1].to_i == 90
      #   @face = "N" if string[1..-1].to_i == 180
      #   @face = "W" if string[1..-1].to_i == 270
      # when "E"
      #   @face = "N" if string[1..-1].to_i == 90
      #   @face = "W" if string[1..-1].to_i == 180
      #   @face = "S" if string[1..-1].to_i == 270
      # when "W"
      #   @face = "S" if string[1..-1].to_i == 90
      #   @face = "E" if string[1..-1].to_i == 180
      #   @face = "N" if string[1..-1].to_i == 270
      # end
    when "R"
      (string[1..-1].to_i / 90).times do
        x = @wp.x
        y = @wp.y
        @wp.x = y
        @wp.y = -x
      end
      # case @face
      # when "N"
      #   @face = "E" if string[1..-1].to_i == 90
      #   @face = "S" if string[1..-1].to_i == 180
      #   @face = "W" if string[1..-1].to_i == 270
      # when "S"
      #   @face = "W" if string[1..-1].to_i == 90
      #   @face = "N" if string[1..-1].to_i == 180
      #   @face = "E" if string[1..-1].to_i == 270
      # when "E"
      #   @face = "S" if string[1..-1].to_i == 90
      #   @face = "W" if string[1..-1].to_i == 180
      #   @face = "N" if string[1..-1].to_i == 270
      # when "W"
      #   @face = "N" if string[1..-1].to_i == 90
      #   @face = "E" if string[1..-1].to_i == 180
      #   @face = "S" if string[1..-1].to_i == 270
      # end

    when "F"
      @x += string[1..-1].to_i * @wp.x
      @y += string[1..-1].to_i * @wp.y
    end
  end
end

wp = Ship.new(x: 10, y: 1, face: "E")

ship = Ship.new(x: 0, y: 0, face: "E", wp: wp)


d.each do |move|
  ship.move(move)
end

p ship
p ship.x.abs + ship.y.abs
