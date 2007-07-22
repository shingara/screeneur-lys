require File.dirname(__FILE__) + '/../test_helper'
require 'maps_controller'

# Re-raise errors caught by the controller.
class MapsController; def rescue_action(e) raise e end; end

class MapsControllerTest < Test::Unit::TestCase
  def setup
    @controller = MapsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
