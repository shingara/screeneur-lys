require File.dirname(__FILE__) + '/../test_helper'
require 'screens_controller'

# Re-raise errors caught by the controller.
class ScreensController; def rescue_action(e) raise e end; end

class ScreensControllerTest < Test::Unit::TestCase
  def setup
    @controller = ScreensController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_script_ok
    post 'script', :screen => File.open("#{RAILS_ROOT}/test/fixtures/sources_lys/source_1.txt").read
    assert_response 200, 'OK'
  end

  def test_script_ko
    post 'script', :paste => File.open("#{RAILS_ROOT}/test/fixtures/sources_lys/source_1.txt").read
    assert_response 400, 'KO'
  end
end
