class Board
	# Class Constants
	X = "X"
	O = "O"
	BLANK = " "

	def initialize(str = nil)
		@grid = Array.new(3){ Array.new(3){ BLANK } }
		
		if str != nil
			for i in 0..(str.length-1)
				row = i / 3
				col = i % 3
				place(col, row, str[i])
			end
		end
	end

	def get(col, row)
		return nil if col < 0 || row < 0 || col > 2 || row > 2
		return @grid[row][col]
	end

	def place(col, row, piece)
		#if (get(col, row) != X) && (get(col, row) != O)
			@grid[row][col] = piece
		#end
	end

	def getWinner
		# Winner by horizontal row
		for row in 0..2
			if get(0, row) == get(1, row) && get(1, row) == get(2, row)
				if ((ret = get(0, row)) != BLANK)
					return ret
				end
			end
		end

		# Winner by vertical column
		for col in 0..2
			if get(col, 0) == get(col, 1) && get(col, 1) == get(col, 2)
				if ((ret = get(col, 0)) != BLANK)
					return ret
				end
			end
		end

		# Winner by descending diagonal
		if get(0, 0) == get(1, 1) && get(1, 1) == get(2, 2) 
			if ((ret = get(0, 0)) != BLANK)
				return ret
			end
		end

		# Winner by ascending diagonal
		if get(0, 2) == get(1, 1) && get(1, 1) == get(2, 0)
			if ((ret = get(0, 2)) != BLANK)
				return ret
			end
		end

		return BLANK
	end

	def gameOver?
		return true if getWinner != BLANK
		blankCount = 0
		for i in 0..2
			for j in 0..2
				if get(i, j) == BLANK
					blankCount += 1
				end
			end
		end
		return blankCount == 0
	end

	def to_db
		str = ""
		for i in 0..2
			for j in 0..2
				str = str + get(j, i)
			end
		end
		return str
	end

	def to_s
		str = ""
		str << " #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]} \n"
		str << "---|---|---\n"
		str << " #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]} \n"
		str << "---|---|---\n"
		str << " #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]} \n"
		return str
	end
end
