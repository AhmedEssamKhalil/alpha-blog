require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    
    def setup
       @category = Category.create(name: "sports") 
    end
    test "should get categories index" do
        get :index
        assert_response :success
    end
    
    test "should get New" do
        get :new
        assert_response :success
    end
    
    test "should get Show" do
        get(:show, {'id' => @category.id})
        assert_response :success
    end
end