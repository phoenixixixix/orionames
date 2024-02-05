require "rails_helper"

RSpec.describe Post, type: :model do
  describe "slug" do
    # depends on: config.i18n.default_locale = :en

    it "sets slug from title" do
      title = "match-to-slug"

      post = create(:post, title: title)

      expect(post.slug_en).to eq(title)
    end

    context "when slug is already occupied" do
      it "doesn't create equal slug" do
        title = "occupied"
        occupied_post = create(:post, title: title)

        target_post = create(:post, title: title)

        expect(target_post.slug_en).to_not eq(occupied_post.slug_en)
      end
    end
  end
end
