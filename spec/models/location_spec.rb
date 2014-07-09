require 'rails_helper'

describe Location do

  let(:rock) { Location.new(name: "The Rock", description: "It used to be called the John.", url: "http://www.jpeg.com/yes.jpg")}

  describe '#initialize' do
    it 'has a name and a description' do
      expect(rock.name).to eq "The Rock"
      expect(rock.description).to eq "It used to be called the John."
    end
  end

  describe '#events' do
    it 'has events' do
      study = create(:event, location: rock)
      study.save(validate: false)
      expect(rock.events).to include(study)
    end
  end

  describe '#current_events' do
    it 'does not have events that are in the past' do
      study_morning = build(:event, location: rock, start_time: Time.now - 2.hours, end_time: Time.now - 1.hour)
      study_morning.save(validate: false)

      expect(rock.current_events).not_to include(study_morning)
    end

    it 'has events that are currently happening' do
      study_afternoon = build(:event, location: rock, start_time: Time.now - 1.hour, end_time: Time.now + 1.hour)
      study_afternoon.save(validate: false)
      expect(rock.current_events).to include(study_afternoon)
    end

  end


end
