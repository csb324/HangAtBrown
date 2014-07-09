require 'rails_helper'

describe Location do

  before(:each) do
    @rock = create(:location, name: "The Rock", description: "It's a library")

    # Happening later
    @study = create(:event, location: @rock)

    # Happened earlier today
    @study_morning = build(:event, location: @rock, start_time: Time.now - 2.hours, end_time: Time.now - 1.hour)
    @study_morning.save(validate: false)

    # Happpening now
    @study_afternoon = build(:event, location: @rock, start_time: Time.now - 1.hour, end_time: Time.now + 1.hour)
    @study_afternoon.save(validate: false)
  end

  describe '#initialize' do
    it 'has a name and a description' do
      expect(@rock.name).to eq "The Rock"
      expect(@rock.description).to eq "It's a library"
    end
  end

  describe '#events' do
    it 'has events' do
      expect(@rock.events).to include(@study)
      expect(@rock.events).to include(@study_morning)
      expect(@rock.events).to include(@study_afternoon)
    end
  end

  describe '#current_events' do
    it 'does not have events that are in the past' do
      expect(@rock.current_events).not_to include(@study_morning)
    end

    it 'has events that are currently happening' do
      expect(@rock.current_events).to include(@study_afternoon)
    end

    it 'does not have events that are in the future' do
      expect(@rock.current_events).not_to include(@study)
    end
  end

  describe '#future_events' do
    it 'has events that are in the future' do
      expect(@rock.future_events).to include(@study)
    end

    it 'does not have events that are not in the future' do
      expect(@rock.future_events).not_to include(@study_afternoon)
      expect(@rock.future_events).not_to include(@study_morning)
    end
  end

  describe '#events_since' do
    it 'has events that happened within the range (including now)' do
      expect(@rock.events_since(1.day)).to include(@study_morning)
      expect(@rock.events_since(1.day)).to include(@study_afternoon)
    end

    it 'does not have events happening later today' do
      expect(@rock.events_since(1.day)).not_to include(@study)
    end

    it 'does not have events that happened before the range' do
      study_yesterday = build(:event, location: @rock, start_time: Time.now - 1.day - 2.hours, end_time: Time.now - 1.day)
      expect(@rock.events_since(1.day)).not_to include(study_yesterday)

      expect(@rock.events_since(1.hour)).not_to include(@study_morning)
    end
  end

end
