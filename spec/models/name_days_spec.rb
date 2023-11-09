require "rails_helper"

RSpec.describe NameDay, type: :model do
  describe "validations" do
    describe "#name_day_uniqueness" do
      it "does not create name day if it already exist" do
        existing_nd = create(:name_day)

        expect {
          NameDay.create(day: existing_nd.day, month: existing_nd.month)
        }.to change { NameDay.count }.by(0)
      end
    end

    describe "#names_list_fullness" do
      it "does not crate name day if names list field is empty" do
        name_day = build(:name_day, names_list: [])

        expect(name_day).to be_invalid
        expect { name_day.save! }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "callbacks" do
    describe "#clean_names_in_names_list" do
      subject { name_day.names_list }

      let(:name_day) { build(:name_day) }

      it "expect to not include white spaces and empty strings" do
        edge_cases = ["", "    "]
        name_day.names_list = edge_cases
        name_day.save

        edge_cases.each do |edge_case|
          expect(subject).to_not include(edge_case)
        end
      end

      it "strips white spaces" do
        name_day.names_list = ["   White Space   "]
        name_day.save

        expect(subject).to contain_exactly("White Space")
      end

      context "on update" do
        let(:name_day) { create(:name_day) }

        it "expect to not include white spaces and empty strings" do
          edge_cases = ["", "    "]
          name_day.update!(names_list: name_day.names_list.concat(edge_cases))

          edge_cases.each do |edge_case|
            expect(subject).to_not include(edge_case)
          end
        end

        it "strips white spaces" do
          name_day.names_list = ["   White Space   "]
          name_day.save

          expect(subject).to contain_exactly("White Space")
        end
      end
    end
  end

  describe ".celebration_today" do
    subject { described_class.celebration_today }

    let!(:target_name_day) { create(:name_day, celebration_status: "today") }

    it "returns NameDay with today's celebration status" do
      expect(subject).to eq(target_name_day)
    end
  end

  describe ".celebration_tomorrow" do
    subject { described_class.celebration_tomorrow }

    let!(:target_name_day) { create(:name_day, celebration_status: 2) }

    it "returns NameDay with tomorrow's celebration status" do
      expect(subject).to eq(target_name_day)
    end
  end

  describe ".refresh_celebration_status" do
    subject { described_class.refresh_celebration_status }

    let(:target_name_day) { create(:name_day) }

    it "clears today's celebration status" do
      target_name_day.today!
      expect { subject }.to change { target_name_day.reload.celebration_status }.to("empty")
    end

    it "clears tomorrow's celebration status" do
      target_name_day.tomorrow!
      expect { subject }.to change { target_name_day.reload.celebration_status }.to("empty")
    end
  end
end
