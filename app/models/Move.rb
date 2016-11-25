class Move
	attr_accessor :col, :row, :score

	def initialize
		col = nil
		row = nil
		score = nil
	end

	def to_s
		"col: #{col}, row: #{row}"
	end
end