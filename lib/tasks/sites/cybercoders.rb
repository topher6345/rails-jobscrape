site = "http://www.cybercoders.com/"

i = 1

while i < 2
s = "http://www.cybercoders.com/search/?page=" + i.to_s + "&searchterms=ruby%20OR%20music%20OR%20guitar&searchlocation=95073&newsearch=true&sorttype="

		doc = Nokogiri::HTML(open(s))

		doc.css(".job-listing-container").css(".job-listing-item").each do |link|

			break if link.css(".job-details-container").css(".details").css(".location").first.nil?

			@job = Job.new
			@job.location = link.css(".job-details-container").css(".details").css(".location").first.children.text
			@job.link =  site + link.css(".job-details-container").css(".job-title").css("a").first.attributes["href"].value
			@job.title = link.css(".job-details-container").css(".job-title").css("a").text
			@job.haveapplied = false
			@job.interested = true
			@job.referred = site
			@job.save

		end
i = i + 1
end
