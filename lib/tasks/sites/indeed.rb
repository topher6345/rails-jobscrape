s = "http://www.indeed.com/"
site = "http://www.indeed.com/jobs?q=%28iOS+or+Wordpress+or+Web+or+Ruby+or+Music+or+Guitar+or+Developer+or+Engineer+or+Coding+%29&l=95073"
doc = Nokogiri::HTML(open(site))
doc.css('#resultsCol').css(".row").each do |post|

	if post.children[1].attributes["href"]
		@job = Job.new
		@job.link  = s + post.children[1].attributes["href"].value
		@job.title =  post.css(".jobtitle").children.text
		@job.company =  post.css(".company").first.children.text
		@job.haveapplied = false
		@job.interested = true
		@job.referred = s
		@job.save
	else
		@job = Job.new
		@job.link = s + post.css(".jobtitle").children[1].attributes["href"].value
		@job.title =  post.css(".jobtitle").children[1].attributes["title"].value
		@job.company = post.css(".company").first.children.text
		@job.haveapplied = false
		@job.referred = s
		@job.interested = true
		@job.save
	end
end
