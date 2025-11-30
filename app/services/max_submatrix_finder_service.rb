class MaxSubmatrixFinderService
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.call(matrix)
    new(matrix).call
  end

  def call
    return [] if matrix.empty? || matrix[0].empty?
    n = matrix.size
    m = matrix[0].size
    heights = Array.new(m, 0)
    max_area = 0
    max_rect = [ 0, 0, 0, 0 ] # [row_start, row_end, col_start, col_end]

    n.times do |i|
      m.times do |j|
        heights[j] = matrix[i][j] == 0 ? 0 : heights[j] + 1
      end

      stack = []
      left = Array.new(m, 0)
      right = Array.new(m, m)

      # Calculate left limits
      m.times do |j|
        while stack.any? && heights[stack[-1]] >= heights[j]
          stack.pop
        end
        left[j] = stack.empty? ? 0 : stack[-1] + 1
        stack << j
      end

      stack.clear

      # Calculate right limits
      (m-1).downto(0) do |j|
        while stack.any? && heights[stack[-1]] >= heights[j]
          stack.pop
        end
        right[j] = stack.empty? ? m : stack[-1]
        stack << j
      end

      m.times do |j|
        area = heights[j] * (right[j] - left[j])
        if area > max_area
          max_area = area
          row_end = i
          row_start = i - heights[j] + 1
          col_start = left[j]
          col_end = right[j] - 1
          max_rect = [ row_start, row_end, col_start, col_end ]
        end
      end
    end

    row_start, row_end, col_start, col_end = max_rect
    return [] if max_area == 0

    submatrix = []
    (row_start..row_end).each do |i|
      row = []
      (col_start..col_end).each do |j|
        row << matrix[i][j]
      end
      submatrix << row
    end
    submatrix
  end
end
