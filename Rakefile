require 'middleman-gh-pages'

task :lint_projects do
  # TODO. See: https://github.com/chriseidhof/ios-videos/blob/89a5c6364254e03e16196c78c51653e56bab2df9/Rakefile#L21-L35 for example
end

desc "Performs CI deploy if on source branch"
task :travis do
  branch = ENV['TRAVIS_BRANCH']
  pull_request = ENV['TRAVIS_PULL_REQUEST']

  abort 'Must be run on Travis' unless branch

  if pull_request != 'false'
    puts 'Skipping deploy for pull request; can only be deployed from source branch.'
    exit 0
  end

  if branch != 'source'
    puts "Skipping deploy for #{ branch }; can only be deployed from source branch."
    exit 0
  end

  sh "rake deploy"
end

desc "Builds, then publishes"
task :deploy do
  sh "bundle exec rake publish BRANCH_NAME=master ALLOW_DIRTY=true"
end

task :default => [:lint_projects, :travis]
