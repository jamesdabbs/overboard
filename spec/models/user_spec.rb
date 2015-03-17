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

  it "may have an active course" do
    course     = create :course
    instructor = create :instructor, :with_account, active_course: course
    expect(instructor.user.active_course).to eq course
  end

  it "may not have an active course" do
    instructor = create :instructor, :with_account
    expect(instructor.user).not_to eq nil
    expect(instructor.user.active_course).to eq nil
  end
end
