require "Board.rb"
require "MiniMax.rb"

class GamesController < ApplicationController
	def index
		game = Game.new
		game.save
	end

	def display

	end

	def receiveClick
		current_game = Game.last

		x = params[:x_loc].to_i
		y = params[:y_loc].to_i

		@board = Board.new(current_game.board)

		# Test for invalid input situations
		if (@board.get(x, y) == Board::X) || (@board.get(x, y) == Board::O) || @board.gameOver?
			puts "Invalid input"
		else
			@board.place(x, y, "X")

			# If game isn't over, computer makes move
			if !@board.gameOver?
				solver = MiniMax.new
				bestMove = solver.getBestMove(@board, "O", 0)
				@board.place(bestMove.col, bestMove.row, "O")
			end

			current_game.board = @board.to_db
			current_game.save
		end
	end
end
