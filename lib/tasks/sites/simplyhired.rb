i = 1
s = "http://www.simplyhired.com"


while i < 2 do
site = "http://www.simplyhired.com/search?q=web&l=santa-cruz%2C+ca&pn=" + i.to_s
 doc = Nokogiri::HTML(open(site))

	doc.css("#jobs").css(".result").each do |link|
		@job = Job.new
		@job.link = s + link.css("h2").css("a").first.attributes["href"].value
		@job.title = link.css("h2").css("a").children.text
		@job.location = "Greater Santa Cruz"
		@job.haveapplied = false
    	@job.interested = true
		@job.referred = s

		@job.save
	end
i = i + 1
end
