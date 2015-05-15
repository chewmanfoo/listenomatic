class Dpoint < ActiveRecord::Base
  validates :app_name, presence: true
  
  alias_attribute :uuid, :pipeline_instance_id

#####################################################################################################
#    S C O P E S
#####################################################################################################

  scope :by_uuid, lambda{ |i| where(pipeline_instance_id: i) }
  scope :by_sabre_phase, lambda{ |i| where(sabre_phase: i) }
  scope :by_task, lambda{ |i| where(task: i) } 
  scope :by_tag, lambda{ |i| where("tags like ?", "%#{i}%") }

  def release
    ca=tags.split(',').grep /^release/
    ca.first.split(":").last unless ca.empty?
  end
  
  def elapsed
#    ta=self.tags.split(',').grep /^end/
#    unless ta.empty?
#      begin_dp = Dpoint.by_uuid(self.uuid).by_sabre_phase(self.sabre_phase).by_task(self.task).by_tag("begin").first
#      if begin_dp.blank? 
#        nil
#      else
#        Time.parse(timestamp) - Time.parse(begin_dp.timestamp)
#      end      
#    end
  end

  def phase_elapsed
#    begin_dp = Dpoint.by_uuid(self.uuid).by_sabre_phase(self.sabre_phase).sort_by(&:timestamp).first
#    Time.parse(timestamp) - Time.parse(begin_dp.timestamp)
  end

  def uuid_elapsed
#    begin_dp = Dpoint.by_uuid(self.uuid).sort_by(&:timestamp).first
#    Time.parse(timestamp) - Time.parse(begin_dp.timestamp)
  end

  def as_json(options={})
    super.as_json(options).merge({:release => release, :elapsed => elapsed, :phase_elapsed => phase_elapsed, :uuid_elapsed => uuid_elapsed})
  end
end
