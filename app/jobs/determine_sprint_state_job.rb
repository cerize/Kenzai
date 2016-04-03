class DetermineSprintStateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    sprint = args[0]
    if  sprint.aasm_state == 'draft' && Date.today >= sprint.start_date
      puts "inside sprint stable job - start"
      sprint.start!
    elsif sprint.aasm_state == 'in_progress' && Date.today > sprint.end_date
      sprint.finish!
      puts "inside sprint stable job - finish"
    else
      puts "inside sprint stable job - nothing worked"
      puts sprint
    end
  end
end
