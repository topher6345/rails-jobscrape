site =  "https://jobs.github.com/positions?description=&location=santa+cruz"
s = "https://jobs.github.com/"
doc = Nokogiri::HTML(open(site))

doc.css("tr").each do |post|
	@job = Job.new
	@job.link = s + post.css("td h4").children[0].attributes["href"].value
	@job.title = post.css("td h4").children[0].children.text
	@job.company = post.css("td")[0].children.children.children[1].text
	@job.location = post.css("td span").children[0].text
	@job.haveapplied = false
	@job.interested = true
	@job.referred = s
	@job.save
end
