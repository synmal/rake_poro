require 'json'
require 'faraday'
require 'date'
require './ig_crawler'

desc 'Getting IG data'

task :crawl do
  # Put ig data here
  # eg. [[1, url-1], [2, url-2]]
  ig_data = []

  output = ig_data.map do |ig|
    ig << IgCrawler::Crawl.new(ig.last).result
  end

  p output
end