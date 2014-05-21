class JobsController < InheritedResources::Base

  def index
    @jobs = Job.all
  end

end
