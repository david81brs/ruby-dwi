class Activity
  attr_accessor :id_activity, :subject,:done_ratio, :project_name, :assigned_to_name, :due_date, :start_date, :cfn_area, :cfn_notes_monitor, :cfn_resource, :cfn_performance, :cfn_recomend_dificulties, :cfn_description, :cfn_product, :cfn_unit, :cfn_product_description, :cfn_qtd_program, :cfn_qtd_exec, :cfn_macrochallenge, :updated_at, :tracker_type, :status, :cfn
  def initialize(subject, done_ratio)
    @subject = subject
    @done_ratio = done_ratio
    @cfn = Array.new
  end
  def to_s
    puts "#{id_activity} - #{done_ratio} - #{subject} - #{cfn_macrochallenge} #{cfn}"
  end
end
  
 
