desc "Fetch jobs"
task :fetch_jobs => :environment do
  require 'nokogiri'
  require 'open-uri'

  require 'tasks/sites/santacruzjobs.rb'
  require 'tasks/sites/cybercoders.rb'
   # require 'tasks/sites/startuply.rb'
  require 'tasks/sites/githubjobs.rb'
  require 'tasks/sites/indeed.rb'
  require 'tasks/sites/simplyhired.rb'

   Job.destroy_all(['created_at < ?', 7.days.ago])

end





# users.each do |user|

	# if user.siteN
	#    @keywords = user.keywords
	#    job = siteN.fetch(@keywords)
	#    job.user = user
	#    job.save
	# end
# end
