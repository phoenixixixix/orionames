xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.tag! "sitemapindex", "xmlns" => "https://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.tag! "url" do
    xml.tag! "loc", root_url
  end

  @names.each do |name|
    xml.tag! "url" do
      xml.tag! "loc", name_url(name)
    end
  end

  @name_days_months.each do |month|
    xml.tag! "url" do
      xml.tag! "loc", name_days_url(month: month)
    end
  end

  xml.tag! "url" do
    xml.tag! "loc", selections_url
  end

  @posts.each do |post|
    xml.tag! "url" do
      xml.tag! "loc", post_url(post)
      xml.lastmod post.updated_at.strftime("%F")
    end
  end
end
