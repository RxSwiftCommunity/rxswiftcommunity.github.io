module CustomHelpers

  def item_to_html(item_hash)
    name = item_hash['name']
    link = item_hash['link']
    description = item_hash['description']
    <<-EOS
      <div class="js-grid-item grid-item">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="project-title"><a href="#{link}">#{name}</a></h4>
          </div>
          <div class="panel-body">
            <p>#{description}</p>
          </div>
        </div>
      </div>
    EOS
  end

end
