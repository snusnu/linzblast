module BulletHole

  include Math
  
  def random_polygon(min_radius, max_radius)
    rad, poly = 0, []
    while rad <= 2 * PI
      poly << random_point(min_radius, max_radius, rad)
      rad += random_stepsize(min_radius, max_radius, rad)
    end
    poly
  end
    
  def random_point(min_radius, max_radius, rad)
    x = x_coordinate(rad) * min_radius + random_scatter(min_radius, max_radius, rad)
    y = y_coordinate(rad) * min_radius + random_scatter(min_radius, max_radius, rad)
    [ x, y ]
  end
  
  def random_stepsize(min_radius, max_radius, rad)
    0.324
  end
    
  def random_scatter(min_radius, max_radius, rad)
    (rand * 1000) % (max_radius - min_radius)
  end
  
  def x_coordinate(rad)
    return  0 if rad == PI/2 || rad == 3*PI/2
    return  1 if rad == 0    || rad == 2*PI 
    return -1 if rad == PI
    if rad > 0 && rad < PI/2
      cos(rad)
    elsif rad > PI/2 && rad < PI
      -cos(PI/2 - rad)
    elsif rad > PI && rad < 3*PI/2
      -cos(PI/2 - rad)
    elsif rad > 3*PI/2 && rad < 2*PI
      cos(rad - 2*PI)
    else
      raise "[x_coord]: Implement periodic cos behaviour"
    end
  end
  
  def y_coordinate(rad)
    return  0 if rad == PI   || rad == 2*PI
    return  1 if rad == PI/2
    return -1 if rad == 3*PI/2
    if rad >= 0 && rad < PI/2
      sin(rad)
    elsif rad > PI/2 && rad < PI
      sin(PI/2 - rad)
    elsif rad > PI && rad < 3*PI/2
      sin(PI/2 - rad)
    elsif rad > 3*PI/2 && rad < 2*PI
      -sin(rad - 2*PI)
    else
      raise "[y_coord]: Implement periodic sin behaviour"
    end
  end
  
end