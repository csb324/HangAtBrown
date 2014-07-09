require 'rails_helper'
require 'pry'

describe Event do

  before(:each) do
    # add a user
    @ruth = create(:user, first_name: "Ruth")
    # add a normal event, without a topic
    @lunch = create(:event_with_host, user: @ruth, event_type: "eat")
    @cram_sesh = create(:event_with_host, user: @ruth, topic: "Economics")
  end

  describe '#initialize' do
    it 'has the parameters that you give it' do
      expect(@lunch.event_type).to eq "eat"
    end
  end

  describe '#host' do
    it 'has a host, who is the person with a creator rsvp' do
      expect(@lunch.host).to eq @ruth
    end
  end

  describe '#subjects' do
    it 'if it has a topic, the topic is the subject' do
      expect(@cram_sesh.subjects).to contain_exactly "Economics"
    end
  end

end
