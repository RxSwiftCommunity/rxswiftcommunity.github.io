module CustomHelpers

  def item_to_html(item_hash)
    name = item_hash['name']
    link = item_hash['link'] || "https://github.com/#{item_hash['repo']}"

    description = item_hash['description']
    <<-EOS
      <div class="js-grid-item grid-item">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="project-title"><a href="#{link}" target="_blank">#{name}</a></h4>
            #{item_to_github_html(item_hash)}
          </div>
          <div class="panel-body">
            <p>#{description}</p>
          </div>
        </div>
      </div>
    EOS
  end

  def item_to_github_html(item_hash)
    if item_hash.key?('stargazers') then
      stargazers = item_hash['stargazers']
      watchers = item_hash['watchers']
      date = Time.parse(item_hash['updated_at'])

      html = <<-EOS
        <div class="gh-meta">
          <div class="gh-item">
            <svg height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z"></path></svg>
            <span class="text-raised-4">#{stargazers}</span>
          </div>
          <div class="gh-item">
            <svg height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"></path></svg>
            <span class="text-raised-4">#{watchers}</span>
          </div>
          <div class="gh-item">
            <svg height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M8 13H6V6h5v2H8v5zM7 1C4.81 1 2.87 2.02 1.59 3.59L0 2v4h4L2.5 4.5C3.55 3.17 5.17 2.3 7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-.34.03-.67.09-1H.08C.03 7.33 0 7.66 0 8c0 3.86 3.14 7 7 7s7-3.14 7-7-3.14-7-7-7z"></path></svg>
            <span class="text-raised-4">#{time_ago_in_words(date)} ago</span>
          </div>
        </div>
      EOS
    else
      html = ""
    end
  end
end
