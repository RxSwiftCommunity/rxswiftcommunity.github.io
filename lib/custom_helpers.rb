module CustomHelpers

  def item_to_html(item_hash)
    name = item_hash['name']
    link = item_hash['link']
    description = item_hash['description']
    <<-EOS
      <div class="col-md-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <a href="#{link}"><h4>#{name}</h4></a>
          </div>
          <div class="panel-body">
            <p>#{description}</p>
          </div>
        </div>
      </div>
    EOS
  end

end
