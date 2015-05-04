module DpointsHelper
  def tag_decorator(tags)
    tagarray = tags.split(",")
    tagout=""
    tagarray.each do |t|
      case t
        when "stop-failure"
          tagout << "<span class='alert label'>stop-failure</span> "
        when "stop-success"
          tagout << "<span class='success label'>stop-success</span> "
        when "begin", "end"
          tagout << "<span class='info label'>#{t}</span> "
        else
          if t.include? ":"
            tn=t.split(":").first
            tv=t.split(":").last
            tagout << "<span class='label'>#{tn}</span><span class='secondary label'>#{tv}</span> "
          else
            tagout << "<span class='info label'>#{t}</span> "
          end
      end
    end
    tagout.html_safe
  end

  def trended_metrics_decorator(metrics)
    metricsarray = metrics.split(",")
    out=""
    metricsarray.each do |m|
      mn=m.split(":").first
      mv=m.split(":").last
      out << "<span class='warning label'>#{mn}</span><span class='secondary label'>#{mv}</span> "
    end
    out.html_safe
  end

  def tags_decorator(tags)
    tagsarray = tags.split(",")
    out=""
    tagsarray.each do |m|
      mn=m.split(":").first
      mv=m.split(":").last
      out << "<span class='label'>#{mn}</span><span class='secondary label'>#{mv}</span> "
    end
    out.html_safe
  end
end
