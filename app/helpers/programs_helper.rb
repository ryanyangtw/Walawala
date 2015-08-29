module ProgramsHelper


  def render_program_subject(program)
    truncate(program.subject, length: 13)
  end


  def render_program_owner_name(program)
    program.try(:owner).try(:name)
  end

  def render_program_introduction(program)
    program.introduction
  end

  def render_program_category_title(program, category_piority)
    if category_piority == :first
      program.try(:first_category).try(:title)
    elsif category_piority == :second
      program.try(:second_category).try(:title)
    elsif category_piority == :third
      program.try(:third_category).try(:title)
    end
  end

end
