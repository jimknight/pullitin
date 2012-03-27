require 'rubygems'
require 'mechanize'
require 'pry'

agent = Mechanize.new
stack = agent.get(ARGV[0]).links

while l = stack.pop
  next unless l.uri
  host = l.uri.host
  next unless host.nil? or host == agent.history.first.uri.host
  begin
    next if agent.visited? l.href
  rescue
    puts "error l.href"
  end

  puts "crawling #{l.uri}"
  begin
    page = l.click
    next unless Mechanize::Page === page
    stack.push(*page.links)
   #puts page.body
  rescue
    puts "error - skipping"
  end
end