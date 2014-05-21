# Building a Web Scraper with Rails


* use rake files
* rake files populate our database
* rails to manage them via active admin



Make sure we're using the most recent stable version of Rails and Ruby

RVM to manage ruby

`rvm list`

```shell
rvm rubies

   mruby-1.0.0 [ x86_64 ]
   ruby-2.0.0-p451 [ x86_64 ]
   ruby-2.1.0 [ x86_64 ]
=* ruby-2.1.1 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

Create new rails project

`rails new jobscraper -d postgresql`

Install gems

`bundle install`

Create Database

`rake db:create`



create Job resources
`rails g scaffold job title:string location:string link:text haveapplied:boolean company:string interested:boolean referred:string`

`rake db:migrate`


add to gemfile
```ruby
gem 'devise'

gem 'activeadmin', github: 'gregbell/active_admin'
```

`bundle install`

`rails g active_admin:install`

`rails generate active_admin:resource job`

```ruby
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
```

`rails s`

route to login
`localhost:3000/admin/login`

route to manage jobs
`http://localhost:3000/admin/jobs`

free login, table sorting, api


`rails generate task jobs fetch prune clean`

write your nokogiri- webcrawler in `lib/rake/jobs.rake`



```ruby
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


## Usage

`rake job:fetch`

Grab data from DOM element class names.

No need to build an adapter: Active Record sits between nokogiri and database.


Write nokogiri ruby scripts to populate Job attributes and save to database

`require 'tasks/sites/cybercoders.rb'`

you can build algorithms in the sandboxed rails console using nokogiri

`rails c -s`

```ruby
require 'nokogiri'
require 'open-uri'
```
