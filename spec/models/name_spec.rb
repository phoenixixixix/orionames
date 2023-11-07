require "rails_helper"

RSpec.describe Name, type: :model do
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
