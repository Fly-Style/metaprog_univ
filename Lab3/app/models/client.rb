class Client < ActiveRecord::Base


  def self.authenticate (name,password)
    client = find_by_username(name)
    if client && client.password == password
      puts 'auth'
      client
    else
      puts 'fail'
      nil
    end
  end

  def self.setChances(ride_id, first, second)
    ride = Riding.find(ride_id)
    ride.first = first
    ride.second = second
    ride.visible = true
    ride.active = true
    ride.save
  end

end
