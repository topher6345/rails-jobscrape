# Building a Web Scraper with Rails

## Getting Started

`git clone` the repo

launch an instance of postgresql

`postgres -D /usr/local/pgsql/data`

Create the database

`rake db:create && rake db:migrate`

You are now ready to launch the application locally.

`rails s`

route to login
`localhost:3000/admin/login`

route to manage jobs
`http://localhost:3000/admin/jobs`


## Usage

### Basic Usage

`rake job:fetch` to use nokogiri scripts to fill up the database.


### Where to write scripts

Write your nokogiri script in `lib/tasks/jobs.rake`

I have given each site I search its own script and `require` them in `lib/tasks/jobs.rake`
```ruby
require 'tasks/sites/mysearchscript.rb'
```

### Example script

```ruby
# lib/tasks/sites/mysearchscript.rb
s = "http://www.jobsite.com/"
site = "http://www.jobsite.com/jobs?q=%28iOS+or+Wordpress+or+Web+or+Ruby+or+Music+or+Guitar+or+Developer+or+Engineer+or+Coding+%29&l=95073"
doc = Nokogiri::HTML(open(site))
doc.css('#resultsCol').css(".row").each do |post|
  @job = Job.new
  @job.link  = s + post.children[1].attributes["href"].value
  @job.title =  post.css(".jobtitle").children.text
  @job.company =  post.css(".company").first.children.text
  @job.haveapplied = false
  @job.interested = true
  @job.referred = s
  @job.save
end
```

### Crawling more sites

Discover nokogiri-based web scraping algorithms in the sandboxed rails console.


Make sure you require **open-uri**.
```
$ rails c -s
Loading development environment in sandbox (Rails 4.1.1)
Any modifications you make will be rolled back on exit
2.1.1 :001 > require 'open-uri'
 => true
```


## Tutorial

This is how one would build this application from scratch.

### Requirements

* ruby-2.1.1
* rails 4.1.1
* local instance of postgresql

### Create new rails project

`rails new jobscraper -d postgresql`

### Install gems

`bundle install`


### Create Database

`postgres -D /usr/local/pgsql/data`

`rake db:create`


### Create 'Job' Resource
`rails g scaffold job title:string location:string link:text haveapplied:boolean company:string interested:boolean referred:string`

Use scaffold generator to get .json API for free

`rake db:migrate`


### Add Active Admin

add these lines to your `Gemfile`
```ruby
gem 'devise'
gem 'activeadmin', github: 'gregbell/active_admin'
```
and run

`bundle install`

#### Install ActiveAdmin

`rails g active_admin:install`

#### Register Jobs with ActiveAdmin

`rails generate active_admin:resource job`

#### Customize ActiveAdmin Jobs View

```ruby
# app/admin/job.rb
ActiveAdmin.register Job do

  permit_params :title, :location, :haveapplied, :interested, :referred

  index do
    selectable_column
    id_column
    column :title do |s|
      a href: admin_job_path(s) do
        s.title
      end
    end
    column :location
    column :link do |s|
      a href: s.link do
        s.link
      end
    end
    column :haveapplied
    column :interested
    column :referred
    column :created_at
    column :updated_at
    actions
  end


end
```
#### Add Rake Task

`rails generate task jobs fetch prune clean`

```ruby
# lib/tasks/jobs.rake
namespace :jobs do
  desc "Fill database with Job listings"
  task fetch: :environment do
    require 'nokogiri'
    require 'open-uri'

    # clean database to avoid duplicates
    Job.all.each do |job|
      job.destroy!
    end

    # write your nokogiri scripts here or
    #
    # require 'lib/tasks/sites/santacruzjobs.rb'
    #
    # them from other files.

    # Throw away old jobs
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete Jobs that are older than 7 days"
  task prune: :environment do
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete all jobs."
  task clean: :environment do
    Job.all.each do |job|
      job.destroy!
    end
  end

end

```

If you run `rake -T` you can see these tasks are registered with rake.
```
rake jobs:clean                         # Delete all jobs
rake jobs:fetch                         # Fill database with Job listings
rake jobs:prune                         # Delete Jobs that are older than 7 days
```

Write custom [nokogiri](https://github.com/sparklemotion/nokogiri/tree/master#synopsis) scripts to populate ActiveRecord attributes.
