require "rails_helper"

RSpec.describe Filters::FilterProxy do
  before do
    @proxy = Filters::NameFilterProxy
    @proxy_model_class = Name
    @proxy_scopes_module = Filters::NameFilterScopes
    @proxy_scope = @proxy_model_class.extending(@proxy_scopes_module)
  end

  describe ".filter_by" do
    it "combines all filter scopes into a single query" do
      result = @proxy.filter_by(category: "male", letter: "Ф")

      expect(result.to_sql).to include(sql_filter_clause(@proxy_scope.category("male").to_sql))
      expect(result.to_sql).to include(sql_filter_clause(@proxy_scope.letter("Ф").to_sql))
    end

    it "ignores scopes with empty/blank values" do
      result = @proxy.filter_by(category: "")

      expect(result.to_sql).to_not include("category")
    end

    it "ignores undefined scopes" do
      result = @proxy.filter_by(nomatch: "nomatch")

      expect(result.to_sql).to_not include("nomatch")
    end
  end

  private

  def sql_filter_clause(query)
    query.match(/WHERE (.*)/).captures[0]
  end
end
