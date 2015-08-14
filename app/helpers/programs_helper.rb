module ProgramsHelper


  def render_program_subject(subject)
    truncate(subject, length: 13)
  end

end
