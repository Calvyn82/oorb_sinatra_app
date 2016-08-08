require 'json'

class JSONBuilder
  LETTERS  = File.read(File.expand_path('../../data/letters.txt', __FILE__)).split(/\n/)
  SECTIONS = File.read(File.expand_path('../../data/sections.txt', __FILE__)).split(/\n/)

  def build(letters: LETTERS, sections: SECTIONS)
    {
      'letters'  => letters,
      'sections' => sections
    }
  end
end
