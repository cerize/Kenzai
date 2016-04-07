
class DetermineProjectStateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    puts "$$$$$$$$$$"
    puts "inside project job"
    puts "$$$$$$$$$$"
    project = args[0]
    if  project.aasm_state == 'draft' && Date.today >= project.start_date
      project.start!
    elsif project.aasm_state == 'in_progress' && Date.today > project.end_date
      project.expire!
    end
  end






end
