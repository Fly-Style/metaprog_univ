class User < ActiveRecord::Base
    ROLE_USER = 0
    ROLE_ADMIN = 1

    def authentificate(params)
      params[:password] == password
    end
end
