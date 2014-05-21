site = 'http://www.santacruzjobs.com/browse_jobs.shtml?sid=&action=browse_category&cat_id=26&cat_name=Tech%3A+Software+and+Databases'
s = "http://www.santacruzjobs.com/"

doc = Nokogiri::HTML(open(site))
i= 0
doc.css('#search_results').children.each do |result|

	if i == 0
		i = i + 1
		next
	end

	@job = Job.new
	@job.location = result.children[4].children.text
	#link
	@job.link = "http://www.santacruzjobs.com/" + result.children.children[4].attributes["href"].value
	#company
	@job.company = result.children[2].children.text
	#position
	@job.title = result.children.children[4].children.text
	@job.haveapplied = false
	@job.interested = true
	@job.referred = s

	@job.save
end
