require "rails_helper"

describe Event, type: "model" do

  it "is invalid without a title" do
    event = build(:event, title: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without a date" do
    event = build(:event, date: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an approval" do
    event = build(:event, approved: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an image" do
    event = build(:event, image_id: nil)

    expect(event).not_to be_valid
  end

  it "is invalid without an image" do
    event = build(:event, image_id: nil)

    expect(event).not_to be_valid
  end

  it "is valid with all attributes" do
    event = create(:event)

    expect(event).to be_valid
  end

  it "cannot have a blank title" do
    event = build(:event, title: "")

    expect(event).not_to be_valid
  end

  it "cannot have a blank date" do
    event = build(:event, title: "")

    expect(event).not_to be_valid
  end

  it "cannot have a duplicate title" do
    existing_event = create(:event)
    event = build(:event, title: existing_event.title)
    event_up = build(:event, title: existing_event.title.upcase)

    expect(event).not_to be_valid
    expect(event_up).not_to be_valid
  end

  it "can have many categories" do
    event = create(:event)
    category1 = create(:category, name:"Theater")
    category2 = create(:category, name:"Family")
    Categorization.create(category_id: category1.id, event_id: event.id)
    Categorization.create(category_id: category2.id, event_id: event.id)
    expect(event.categories.count).to eq 2
  end
end