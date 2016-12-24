class SessionsController < ActionController::Base
  before_action :require_admin, only: [:adminpanel]
  before_action :require_book,  only: [:bookpanel, :predict]
  # before_action :require_login, only: [:show, :makebet]


  def new
  end

  def show
    usr = session[:client_id]
    @user = Client.find_by_username usr
    @rides = Riding.where(visible: true)
    puts('user incoming')
  end

  def adminpanel
    usr = session[:client_id]
    @user = Client.find_by_username usr
    puts('admin incoming')

  end

  def bookpanel
    usr = session[:client_id]
    @user = Client.find_by_username usr
    @rides = Riding.where(active: false)
    puts('book incoming')
  end

  def bet_actions
    @user = Client.find_by_username session[:client_id]
    @rides = Riding.where(active: true)
  end

  def create
    client = Client.authenticate(params[:login_name], params[:login_pass])
    if client
      session[:client_id] = client.username
      if client.is_super
        redirect_to '/adminpanel'
      else
        if client.is_book
          redirect_to '/bookpanel'
        else redirect_to '/main'
        end
      end
    else
      puts 'lol'
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:client_id] = nil
    redirect_to root_url, :notice => 'Logged out!'
    puts('user destroyed')
  end

  def predict
    data = JSON.parse request.body.read
    print(data)

    first_chance = data['first']
    second_chance = data['second']
    ride_id = data['ride_id']

    Client.setChances(ride_id, first_chance, second_chance)
    redirect_to '/bookpanel'
  end

  def finishBets
    data = JSON.parse request.body.read
    data = data['arr']
    for race_info in data
        data_ = JSON.parse race_info
        bet_winner = data_['winner']
        ride_id = data_['race_id']

        BetToRide.endRace(ride_id, bet_winner)
    end
    redirect_to '/bet_actions'
  end

  def makebet
    hash = JSON.parse request.body.read
    puts hash

    user = Client.find_by_username session[:client_id]
    user.balance = user.balance - hash['expressValue']
    user.save

    bet = Bet.new
    bet.value = hash['expressValue']
    bet.potentialWin = hash['potentialWin']
    bet.sucessful = nil
    bet.active = true
    bet.client_id = user.id
    bet.save

    table = hash['ridesIdArray']
    for t in table
      content = JSON.parse t
      bet_to_ride = BetToRide.new
      bet_to_ride.riding_id = content['ride_id']
      bet_to_ride.bet_id = bet.id
      bet_to_ride.bet_winner = content['bet_winner']
      bet_to_ride.success = nil
      bet_to_ride.save
    end

    redirect_to '/main'
  end

  private

  def current_user
    @current_user ||= Client.find_by_username(session[:client_id]) if session[:client_id]
  end

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def is_admin?
    @is_admin ||= Client.find_by_username(session[:client_id]).is_super if session[:client_id]
  end

  def is_book?
    @is_admin ||= Client.find_by_username(session[:client_id]).is_book if session[:client_id]
  end

  def require_admin
    unless is_admin?
      redirect_to root_path
    end
    end

  def require_book
    unless is_book?
      redirect_to root_path
    end
  end

end
