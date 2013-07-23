module JobsHelper
  def combined_scripts(job_setting)
    [ rbenv_setup_script,
      %w[before_script script after_script].reject {|type|
        job_setting[type].nil? || job_setting[type].strip.empty?
      }.map {|type|
        "# #{type}\n" + [job_setting[type]].join("\n") + "\n"
      },
    ].join("\n")
  end

  def rbenv_setup_script
    <<-'EOS'
PATH=~/.rbenv/bin:$PATH
eval "$(rbenv init -)"
    EOS
  end

  def job_name(repository)
    [
      repository[:owner][:login],
      repository[:name],
    ].join('.')
  end
end
