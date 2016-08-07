require File.expand_path '../test_helper.rb', __FILE__

class OorbTest < Minitest::Test

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    %w(a b c d e f g h i j l n o p r s t u v y z).each do |l|
      assert_match(/#{l}/, last_response.body)
    end
  end
end
