module BulletHole

  include Math
  
  def random_polygon(radius, impact, distortion)
    rad, poly = 0, []
    while rad <= 2 * PI
      poly << point(radius, impact, distortion, rad)
      rad  += stepsize(radius, impact, distortion, rad)
    end
    poly
  end
    
  def point(radius, impact, distortion, rad)
    x = x_coordinate(rad) * radius(radius, impact, distortion, rad) + rand * 3
    y = y_coordinate(rad) * radius(radius, impact, distortion, rad) + rand * 3
    [ x, y ]
  end
  
  def stepsize(radius, impact, distortion, rad)
    0.04 * (rand * impact)
  end
  
  # rad could be used to make more square like forms
  def radius(radius, impact, distortion, rad)
    radius + impact + (rand * distortion) * ((rand * 10).to_i % 2 == 0 ? 1 : -1)
  end
  
  def x_coordinate(rad)
    if rad < PI
      cos(rad)
    else
      rad = PI - (PI - rad)
      cos(rad)
    end
  end
  
  def y_coordinate(rad)
    if rad < PI
      sin(rad)
    else
      rad = PI - (PI - rad)
      sin(rad)
    end
  end
  
end