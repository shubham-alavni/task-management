require "test_helper"
require Rails.root.join("app/services/max_submatrix_finder_service")

class MaxSubmatrixFinderServiceTest < ActiveSupport::TestCase
  test "returns empty array for empty matrix" do
    matrix = []
    result = MaxSubmatrixFinderService.call(matrix)
    assert_equal [], result
  end

  test "returns empty array for matrix with empty rows" do
    matrix = [ [] ]
    result = MaxSubmatrixFinderService.call(matrix)
    assert_equal [], result
  end

  test "returns largest submatrix of 1s in a simple matrix" do
    matrix = [
      [ 1, 0, 1, 1 ],
      [ 1, 1, 1, 1 ],
      [ 0, 1, 1, 1 ]
    ]
    result = MaxSubmatrixFinderService.call(matrix)
    expected = [
      [ 1, 1, 1 ],
      [ 1, 1, 1 ]
    ]
    assert_equal expected, result
  end

  test "returns the whole matrix if all 1s" do
    matrix = [
      [ 1, 1 ],
      [ 1, 1 ]
    ]
    result = MaxSubmatrixFinderService.call(matrix)
    expected = [
      [ 1, 1 ],
      [ 1, 1 ]
    ]
    assert_equal expected, result
  end

  test "returns single cell if only one 1" do
    matrix = [
      [ 0, 0 ],
      [ 0, 1 ]
    ]
    result = MaxSubmatrixFinderService.call(matrix)
    expected = [ [ 1 ] ]
    assert_equal expected, result
  end

  test "returns correct submatrix for complex case" do
    matrix = [
      [ 0, 1, 1, 0 ],
      [ 1, 1, 1, 1 ],
      [ 1, 1, 1, 0 ],
      [ 0, 1, 1, 1 ]
    ]
    result = MaxSubmatrixFinderService.call(matrix)
    expected = [
                  [ 1, 1 ],
                  [ 1, 1 ],
                  [ 1, 1 ],
                  [ 1, 1 ]
              ]
    assert_equal expected, result
  end
end
