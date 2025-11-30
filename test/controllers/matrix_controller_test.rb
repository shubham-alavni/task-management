require "test_helper"

class MatrixControllerTest < ActionDispatch::IntegrationTest
  test "should return submatrix for valid input" do
    matrix = [
      [ 1, 0, 1, 1 ],
      [ 1, 1, 1, 0 ],
      [ 0, 1, 1, 1 ]
    ]
    post max_submatrix_url, params: { matrix: matrix }, as: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert json["submatrix"].is_a?(Array)
  end

  test "should return error for invalid input" do
    post max_submatrix_url, params: { matrix: "not_a_matrix" }, as: :json
    assert_response :bad_request
    json = JSON.parse(response.body)
    assert_equal "Invalid input", json["error"]
  end
end
