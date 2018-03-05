#!/usr/bin/env ruby

require 'httparty'
require 'psych'
require 'colorize'

unless ENV.key?('GITHUB_USER') && ENV.key?('GITHUB_PERSONAL_ACCESS_TOKEN') then
    puts "Please set GITHUB_USER and GITHUB_PERSONAL_ACCESS_TOKEN environment variables".red
    exit 1
end

begin
    ITEMS_FILE = "data/items.yml"

    yaml = Psych.load_file(ITEMS_FILE)
    sections = yaml["sections"]

    sections.each do |section| 
        section["items"].each do |item|
            # We only need to fetch meta information for GitHub's
            # API if this is a GitHub repo. Otherwise, skip.
            if item.key?("repo") then
                repo = item["repo"]

                gh_meta = HTTParty.get("https://api.github.com/repos/#{repo}",
                                       :basic_auth => {:username => ENV['GITHUB_USER'], :password => ENV['GITHUB_PERSONAL_ACCESS_TOKEN']})

                unless gh_meta.key?("stargazers_count") && gh_meta.key?("subscribers_count") && gh_meta.key?("pushed_at") then
                    puts "Failed fetching meta data for #{repo}. Response is:".red
                    puts "#{gh_meta}".red
                    exit 1
                end

                item["stargazers"] = gh_meta["stargazers_count"]
                item["watchers"] = gh_meta["subscribers_count"]
                item["updated_at"] = gh_meta["pushed_at"]

                puts "#{repo} has #{item["stargazers"]} stargazers, #{item["watchers"]} watchers and was last updated on #{item["updated_at"]}".green
            end
        end
    end

    File.open("data/items.yml", 'w') do |file|
        file.write(Psych.dump(yaml))
    end
rescue => e
    puts "Failed building YAML file with GitHub meta data: #{e}".red
    exit 1
end