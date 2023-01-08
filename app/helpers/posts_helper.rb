module PostsHelper
  def removable_tag_name
    if tag_name = request.params[:tag]
      link_to request.params.except("tag"), class: "removable-post-tag-name" do
        raw "##{tag_name} #{icon("fa-solid", "fa-xmark")}"
      end
    end
  end
end