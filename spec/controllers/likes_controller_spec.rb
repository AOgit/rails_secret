require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content: 'Oops')
    @like = @user.likes.create(user: @user, secret: @secret)
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot like" do
      post :add_likes
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot unlike" do
      delete :unlike, id: @like
      expect(response).to redirect_to('/sessions/new')
    end
  end
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
      @secret = @user.secrets.create(content: 'Ooops')
    end
    it "cannot access like" do
      post :add_likes, secret_id: @secret.id, like: { secret_id: @secret.id }
      expect(response).to redirect_to("/secrets")
    end	
  end 
end
