require 'test_helper'

class DpointTest < ActiveSupport::TestCase

  setup do
    @dpoint = dpoints(:one)
    @dpoint2 = dpoints(:two)
    @dpoint3 = dpoints(:three)
    @dpoint4 = dpoints(:four)
    @dpoint5 = dpoints(:five)
    @dpoint6 = dpoints(:six)
    @dpoint7 = dpoints(:seven)
    @bad_dpoint = dpoints(:ten)
  end

  test "should require app_name" do
    assert true
  end

  test "should give correct release" do
    dp=Dpoint.create(:app_name => @dpoint.app_name, :pipeline_id => @dpoint.pipeline_id, :pipeline_instance_id => @dpoint.pipeline_instance_id, :sabre_phase => @dpoint.sabre_phase, :tags => @dpoint.tags, :task => @dpoint.task, :timestamp => @dpoint.timestamp, :trended_metrics => @dpoint.trended_metrics)
    assert dp.release == "99.1.1"    
  end

  test "should find dpoints by uuid" do
    @uuid1="ec402268-2f31-45d9-84ab-384d4df0fd07"
    @uuid2="b453c6a5-84ac-4ebe-8daa-ad019fda75d9"
    dp1=Dpoint.create(:app_name => @dpoint.app_name, :pipeline_id => @dpoint.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint.sabre_phase, :tags => @dpoint.tags, :task => @dpoint.task, :timestamp => @dpoint.timestamp, :trended_metrics => @dpoint.trended_metrics)
    dp2=Dpoint.create(:app_name => @dpoint2.app_name, :pipeline_id => @dpoint2.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint2.sabre_phase, :tags => @dpoint2.tags, :task => @dpoint2.task, :timestamp => @dpoint2.timestamp, :trended_metrics => @dpoint2.trended_metrics)
    dp3=Dpoint.create(:app_name => @dpoint3.app_name, :pipeline_id => @dpoint3.pipeline_id, :pipeline_instance_id => @uuid2, :sabre_phase => @dpoint3.sabre_phase, :tags => @dpoint3.tags, :task => @dpoint3.task, :timestamp => @dpoint3.timestamp, :trended_metrics => @dpoint3.trended_metrics)
    assert Dpoint.by_uuid(@uuid1).size == 2
  end

  test "should give correct 'elapsed' for end message" do
    dp1=Dpoint.create(:app_name => @dpoint.app_name, :pipeline_id => @dpoint.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint.sabre_phase, :tags => @dpoint.tags, :task => @dpoint.task, :timestamp => @dpoint.timestamp, :trended_metrics => @dpoint.trended_metrics)
    dp2=Dpoint.create(:app_name => @dpoint2.app_name, :pipeline_id => @dpoint2.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint2.sabre_phase, :tags => @dpoint2.tags, :task => @dpoint2.task, :timestamp => @dpoint2.timestamp, :trended_metrics => @dpoint2.trended_metrics)
    assert dp2.elapsed == 2.2, "oops - gives #{dp2.elapsed} not '2.2'"
  end

  test "should give correct 'elapsed' for begin message" do
    dp1=Dpoint.create(:app_name => @dpoint.app_name, :pipeline_id => @dpoint.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint.sabre_phase, :tags => @dpoint.tags, :task => @dpoint.task, :timestamp => @dpoint.timestamp, :trended_metrics => @dpoint.trended_metrics)
    dp2=Dpoint.create(:app_name => @dpoint2.app_name, :pipeline_id => @dpoint2.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint2.sabre_phase, :tags => @dpoint2.tags, :task => @dpoint2.task, :timestamp => @dpoint2.timestamp, :trended_metrics => @dpoint2.trended_metrics)
    assert dp1.elapsed == nil, "oops - gives #{dp1.elapsed} not 'nil'"
  end

  test "should give correct 'phase_elapsed' for first dpoint in group" do
    dp4=Dpoint.create(:app_name => @dpoint4.app_name, :pipeline_id => @dpoint4.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint4.sabre_phase, :tags => @dpoint4.tags, :task => @dpoint4.task, :timestamp => @dpoint4.timestamp, :trended_metrics => @dpoint4.trended_metrics)
    dp5=Dpoint.create(:app_name => @dpoint5.app_name, :pipeline_id => @dpoint5.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint5.sabre_phase, :tags => @dpoint5.tags, :task => @dpoint5.task, :timestamp => @dpoint5.timestamp, :trended_metrics => @dpoint5.trended_metrics)
    dp6=Dpoint.create(:app_name => @dpoint6.app_name, :pipeline_id => @dpoint6.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint6.sabre_phase, :tags => @dpoint6.tags, :task => @dpoint6.task, :timestamp => @dpoint6.timestamp, :trended_metrics => @dpoint6.trended_metrics)
    dp7=Dpoint.create(:app_name => @dpoint7.app_name, :pipeline_id => @dpoint7.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint7.sabre_phase, :tags => @dpoint7.tags, :task => @dpoint7.task, :timestamp => @dpoint7.timestamp, :trended_metrics => @dpoint7.trended_metrics)
    assert dp4.phase_elapsed == 0.0, "oops - gives #{dp4.phase_elapsed} not 'nil'"
  end

  test "should give correct 'phase_elapsed' for middle dpoint in group" do
    dp4=Dpoint.create(:app_name => @dpoint4.app_name, :pipeline_id => @dpoint4.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint4.sabre_phase, :tags => @dpoint4.tags, :task => @dpoint4.task, :timestamp => @dpoint4.timestamp, :trended_metrics => @dpoint4.trended_metrics)
    dp5=Dpoint.create(:app_name => @dpoint5.app_name, :pipeline_id => @dpoint5.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint5.sabre_phase, :tags => @dpoint5.tags, :task => @dpoint5.task, :timestamp => @dpoint5.timestamp, :trended_metrics => @dpoint5.trended_metrics)
    dp6=Dpoint.create(:app_name => @dpoint6.app_name, :pipeline_id => @dpoint6.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint6.sabre_phase, :tags => @dpoint6.tags, :task => @dpoint6.task, :timestamp => @dpoint6.timestamp, :trended_metrics => @dpoint6.trended_metrics)
    dp7=Dpoint.create(:app_name => @dpoint7.app_name, :pipeline_id => @dpoint7.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint7.sabre_phase, :tags => @dpoint7.tags, :task => @dpoint7.task, :timestamp => @dpoint7.timestamp, :trended_metrics => @dpoint7.trended_metrics)
    assert dp5.phase_elapsed == 34.1, "oops - gives #{dp5.phase_elapsed} not 'nil'"
  end

  test "should give correct 'phase_elapsed' for last dpoint in group" do
    dp4=Dpoint.create(:app_name => @dpoint4.app_name, :pipeline_id => @dpoint4.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint4.sabre_phase, :tags => @dpoint4.tags, :task => @dpoint4.task, :timestamp => @dpoint4.timestamp, :trended_metrics => @dpoint4.trended_metrics)
    dp5=Dpoint.create(:app_name => @dpoint5.app_name, :pipeline_id => @dpoint5.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint5.sabre_phase, :tags => @dpoint5.tags, :task => @dpoint5.task, :timestamp => @dpoint5.timestamp, :trended_metrics => @dpoint5.trended_metrics)
    dp6=Dpoint.create(:app_name => @dpoint6.app_name, :pipeline_id => @dpoint6.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint6.sabre_phase, :tags => @dpoint6.tags, :task => @dpoint6.task, :timestamp => @dpoint6.timestamp, :trended_metrics => @dpoint6.trended_metrics)
    dp7=Dpoint.create(:app_name => @dpoint7.app_name, :pipeline_id => @dpoint7.pipeline_id, :pipeline_instance_id => @uuid1, :sabre_phase => @dpoint7.sabre_phase, :tags => @dpoint7.tags, :task => @dpoint7.task, :timestamp => @dpoint7.timestamp, :trended_metrics => @dpoint7.trended_metrics)
    assert dp7.phase_elapsed == 122.2, "oops - gives #{dp7.phase_elapsed} not 'nil'"
  end
end
