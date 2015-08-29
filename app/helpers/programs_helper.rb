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
      program.first_category.title
    elsif category_piority == :second
      program.second_category.title
    elsif category_piority == :third
      program.third_category.title
    end
  end

end
