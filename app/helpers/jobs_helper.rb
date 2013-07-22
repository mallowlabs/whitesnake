module JobsHelper
  def combined_scripts(job_setting)
    %w[before_script script after_script].map {|type|
      "# #{type}\n" + [job_setting[type]].join("\n") + "\n"
    }.join("\n")
  end
end
