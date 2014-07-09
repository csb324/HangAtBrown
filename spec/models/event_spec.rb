require 'rails_helper'
require 'pry'

describe Event do

  before(:each) do
    # add a user
    @ruth = create(:user, first_name: "Ruth")
    # add a normal event, without a topic
    @lunch = create(:event, event_type: "eat")
    @lunch_creation = create(:rsvp, event: @lunch, user: @ruth, creator: true)
  end

  describe '#initialize' do
    it 'has the parameters that you give it' do
      expect(@lunch.event_type).to eq "eat"
    end
  end

  describe '#subjects' do
    it "is the host's interests, if no topic exists" do

    end
  end

end
