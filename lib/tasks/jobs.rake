namespace :jobs do
  desc "TODO"
  task fetch: :environment do

    Job.all.each do |job|
      job.destroy!
    end

    require 'nokogiri'
    require 'open-uri'

    # require 'tasks/sites/santacruzjobs.rb'
    require 'tasks/sites/cybercoders.rb'
     # require 'tasks/sites/startuply.rb'
    # require 'tasks/sites/githubjobs.rb'
    require 'tasks/sites/indeed.rb'
    require 'tasks/sites/simplyhired.rb'

     Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "TODO"
  task prune: :environment do
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "TODO"
  task clean: :environment do
    Job.all.each do |job|
      job.destroy!
    end
  end

end
