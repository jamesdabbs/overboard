require 'rails_helper'

describe User do
  describe "omniauth" do
    def auth extra={}
      Hashie::Mash.new({
        info: {
          email: "james@theironyard.com",
          name:  "James Dabbs"
        },
        extra: {
          favorite_movie: "Alien"
        }
      }).merge extra
    end

    it "can create from omniauth data" do
      user = User.from_omniauth auth
      expect(user).to be_persisted
      expect(user.email).to eq "james@theironyard.com"
      expect(user.google_auth_data["extra"]["favorite_movie"]).to eq "Alien"
    end

    it "claims existing employee roles by email" do
      employee = create :employee, email: auth.info.email
      user = User.from_omniauth auth
      employee.reload
      expect(employee.user).to eq user
    end

    it "can lookup from omniauth data" do
      create :user, email: "su@theironyard.com", name: "Su Kim"

      user = User.from_omniauth auth(info: { email: "su@theironyard.com" })
      expect(user.name).to eq "Su Kim"
    end

    it "rejects non-TIY users" do
      expect do
        User.from_omniauth auth(info: { email: "jamesdabbs@gmail.com" })
      end.to raise_error
    end
  end
end
