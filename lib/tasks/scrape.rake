desc "Scrape the website and create pages."
task :scrape => :environment do
  website_url = "http://sga.com"
  agent = Mechanize.new
  stack = agent.get(website_url).links
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
      puts page.encoding
      puts page.valid_encoding?
      puts page.body
      #Page.create!(:orig_url => l.uri.to_s, :source => page.body.encoding('utf-8'))
     #puts page.body
    rescue
      puts "error - skipping"
    end
  end
end