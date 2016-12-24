class Bet < ActiveRecord::Base
  belongs_to :client

  def self.success_check(_betid)
    bet_plural = BetToRide.where(bet_id: _betid)
    puts bet_plural.size

    if bet_plural != nil
        _len = bet_plural.size
        counter = 0
        for raw in bet_plural
            if not raw.success
                bet = Bet.find(_betid)
                bet.sucessful = false
                bet.active = false
                bet.save
                break
            else
                counter += 1
            end

            if _len == counter
                bet = Bet.find(_betid)
                bet.sucessful = true
                Bet.winning_pay bet.client_id, bet.potentialWin
                bet.active = false
                bet.save
            end
        end
    else
        return
    end
  end

  def self.winning_pay(id, prize)
     client = Client.find(id)
      puts  client.balance
      client.balance += prize
      client.save
      puts client.balance
  end
end
