class MatrixController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /max_submatrix
  # Finds the largest submatrix of 1s in the given matrix.
  def max_submatrix
    matrix = params[:matrix]
    unless matrix.is_a?(Array) && matrix.all? { |row| row.is_a?(Array) }
      return render json: { error: "Invalid input" }, status: :bad_request
    end

    submatrix = MaxSubmatrixFinderService.call(matrix)
    render json: { submatrix: submatrix }
  end
end
