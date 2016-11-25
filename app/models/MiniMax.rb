require_relative "Board.rb"
require_relative "Move.rb"

class MiniMax
	SUCCESS = 100
	FAILURE = -100
	NEUTRAL = 0

	def evaluate(board, perspective)
		winner = board.getWinner
		# puts winner
		# puts perspective
		if perspective == winner
			retval = SUCCESS
		elsif winner == Board::BLANK
			retval = NEUTRAL
		else
			retval = FAILURE
		end
		return retval
	end

	def getPossibleMoves(board)
		empty = []
		for i in 0..2
			for j in 0..2
				if board.get(i, j) == Board::BLANK
					move = Move.new
					move.col = i
					move.row = j
					empty.push(move)
				end
			end
		end
		return empty
	end

	def getBestMove(board, perspective, layer)
		#puts "in getBestMove with perspective=#{perspective} board="
		#puts "#{board.to_s}"

		best = Move.new
		best.score = FAILURE * 2

		# Deal with case that the game has ended
		if board.gameOver?
			best.score = evaluate(board, perspective)
			# puts "evaluated score: #{best.score}"			
			# puts "gameover board=\n#{board.to_s}"
		else
			# Game hasn't ended yet
			if perspective == Board::X
				otherPerspective = Board::O
			else
				otherPerspective = Board::X
			end

			possibleMoves = getPossibleMoves(board)
			for move in possibleMoves
				# puts "layer: #{layer} move: #{move.to_s}"
				# puts "board=\n#{board.to_s}\n"
				# Bust a move
				board.place(move.col, move.row, perspective)

				# Make recursive call
				result = getBestMove(board, otherPerspective, layer + 1)
				
				#puts "layer: #{layer} move: #{move.to_s}"
				#puts "score: #{result.score * -1}"

				if result.score * -1 > best.score
					best.score = result.score * -1
					best.col = move.col
					best.row = move.row
				end

				# Roll back move just made
				board.place(move.col, move.row, Board::BLANK)
			end
		end

		return best
	end
end
