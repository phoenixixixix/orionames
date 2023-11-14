require "rails_helper"

RSpec.describe "Filtering names", type: :feature do
  let!(:origin_country) { create(:origin_country) }

  scenario "shows target name" do
    target_name = create(:name, category: "male", origin_country: origin_country)

    visit names_path
    click_on "Male"
    click_on target_name.capital_letter
    click_on origin_country.title
    
    expect(page).to have_content(target_name.title)
  end

  scenario "does not show name if not matched by filters" do
    nomatch = create(:name, title: "Nomatch", category: "female")

    visit names_path
    click_on "Male"
    click_on "Ф"
    click_on origin_country.title

    expect(page).to_not have_content(nomatch.title)
  end
end
