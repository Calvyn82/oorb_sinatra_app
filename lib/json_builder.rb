require 'json'

class JSONBuilder
  LETTERS  = File.read(File.expand_path('../../data/letters.txt', __FILE__)).split(/\n/)
  SECTIONS = File.read(File.expand_path('../../data/sections.txt', __FILE__)).split(/\n/)

  def build(letters: LETTERS, sections: SECTIONS)
    {
      'letters'  => build_letters(letters),
      'sections' => build_sections(sections)
    }
  end

  def build_letters(letters)
    letters.map { |line| [line[0], line] }
  end

  def build_sections(sections)
    sections.map { |line| [line[0], line.split(' ')] }
  end
end
