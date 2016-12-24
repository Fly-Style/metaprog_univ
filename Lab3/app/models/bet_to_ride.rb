class BetToRide < ActiveRecord::Base
  belongs_to :riding
  belongs_to :bet

  def self.endRace(ride_id, winner)
    ride = Riding.find(ride_id)
    ride.winner = winner
    ride.visible = ride.active = false
    ride.save
    bets_to_ride = BetToRide.where(riding_id: ride_id)

    if bets_to_ride
        for raw in bets_to_ride
          bet_id = raw.bet.id
          puts bet_id

          if raw.bet_winner == winner
              raw.success = true
          else
              raw.success = false
          end
          raw.save

          Bet.success_check(bet_id)
        end
    end
  end
end
