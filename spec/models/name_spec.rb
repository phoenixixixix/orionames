require "rails_helper"

RSpec.describe Name, type: :model do
  describe "callbacks" do
    let(:name) { create(:name, title: title) }
    let(:title) { "Дефолт" }

    describe "capitalize title" do
      subject { name.title.first }

      context "when title in lower case" do
        let(:title) { "тест" }

        it "expects title starts with capital" do
          expect(subject).to eq("Т")
        end
      end
    end

    describe "#set_capital_letter" do
      subject { name.capital_letter }

      let(:title) { "Саша" }

      it "sets capital letter field" do
        expect(subject).to eq(title.first)
      end
    end
  end

  describe ".order_by_capital_letter" do
    subject { described_class.order_by_capital_letter }

    before { Name.delete_all }

    it "sorts names by Ukrainian alphabet" do
      greater_in_list = create(:name, title: "А")
      lower_in_list = create(:name, title: "Ф")
      middle_in_list = create(:name, title: "Б")

      expect(subject).to eq([greater_in_list, middle_in_list, lower_in_list])
    end

    context "when persisted name with capital letter out of Ukrainian alphabet" do
      it "should place it in the end of the list" do
        create(:name, title: "А")
        lower_in_list = create(:name, title: "$Nomatch")

        expect(subject.last).to eq(lower_in_list)
      end
    end
  end

  describe ".apply_filters" do
    subject { described_class.apply_filters(filter) }

    let!(:target_name) { create(:name) }

    context "with defined filter" do
      context "by category" do
        let(:filter) { { "by_category" => target_name.category } }

        it "expects names filtered by category" do
          expect(subject).to contain_exactly(target_name)
        end
      end

      context "by origin" do
        let(:origin_country) { create(:origin_country) }
        let(:filter) { { "by_origin" => origin_country.title } }

        it "expects names filtered by origin country" do
          target_name.update(origin_country_id: origin_country.id)

          expect(subject).to contain_exactly(target_name)
        end
      end

      context "by letter" do
        let(:filter) { { "by_letter" => target_name.capital_letter } }

        it "expect names filtered by capital letter" do
          expect(subject).to contain_exactly(target_name)
        end
      end

      context "with multiple filters" do
        let(:origin_country) { create(:origin_country) }
        let(:filter) { { "by_category" => target_name.category,
                               "by_letter" => target_name.capital_letter,
                               "by_origin" => origin_country.title } }

        it "returns target name" do
          target_name.update(origin_country_id: origin_country.id)

          expect(subject).to contain_exactly(target_name)
        end
      end
    end

    context "when passing dangerous(!!) class method as an argument" do
      let(:filter) { { "destroy" => target_name.id } }

      it "returns empty array" do
        expect(subject).to eq([])
      end

      it "does not do any actions" do
        expect { subject }.to change { Name.count }.by(0)
      end
    end
  end
end
