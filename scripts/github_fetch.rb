#!/usr/bin/env ruby

require 'httparty'
require 'psych'
require 'colorize'

unless ENV.key?('GITHUB_CLIENT_ID') && ENV.key?('GITHUB_CLIENT_SECRET') then
    puts "Please set GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET environment variables".red
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

                gh_meta = HTTParty.get("https://api.github.com/repos/#{repo}?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}")
                item["stargazers"] = gh_meta["stargazers_count"] || item["stargazers"]
                item["watchers"] = gh_meta["subscribers_count"] || item["stargazers"]
                item["updated_at"] = gh_meta["updated_at"] || item["updated_at"]

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