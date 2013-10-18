require "colorize"
module RubiksCube
	class RubiksCube
		def initialize()
			@faces = {
				"up" => [["W", "W", "W"], ["W", "W", "W"],
					["W","W","W"]],
				"front" => [["R", "R", "R"], ["R", "R", "R"], 
						["R", "R", "R"]],
				"right" => [["B", "B", "B"], ["B", "B", "B"],
					["B", "B", "B"]],
				"left" => [["G", "G", "G"], ["G", "G", "G"],
					["G", "G", "G"]],
				"down" => [["Y", "Y", "Y"], ["Y", "Y", "Y"],
					["Y", "Y", "Y"]],
				"back" => [["O", "O", "O"], ["O", "O", "O"],
					["O", "O", "O"]]	
			}
		end
		def turn(move, attribute)
			# move is a char
			# attribute is an integer-
			# 1 = normal, 2 = 180, 3 = inverse
			temp = "" # define the temp var now
			side = side1 = side2 = side3 = side4 = ""			
			case move
			when " "
				return
			when "R"
				side = "right"; side1 = "up"; side2 = "front"
				side3 = "down"; side4 = "back"
			when "F"
				side = "front"; side1 = "up"; side2 = "left"
				side3 = "down"; side4 = "right"
			when "L"
				side = "left"; side1 = "up"; side2 = "back"
				side3 = "down"; side4 = "front"
			when "U"
				side = "up"; side1 = "front"; side2 = "right"
				side3 = "back"; side4 = "left";
			when "D"
				side = "down"; side1 = "front"; side2 = "left"
				side3 = "back"; side4 = "right"
			when "B"
				side = "back"; side1 = "up"; side2 = "right"
				side3 = "down"; side4 = "left"
			end
			# TODO write in code for XYZ turns

			# the attribute is actually the amount of times we need to turn it!
			attribute.times do
				# right face clockwise
				# corners
				temp = @faces[side][0][2]
				@faces[side][0][2] = @faces[side][0][0]
				@faces[side][0][0] = @faces[side][2][0]
				@faces[side][2][0] = @faces[side][2][2]
				@faces[side][2][2] = temp
				# edges
				temp = @faces[side][0][1]
				@faces[side][0][1] = @faces[side][1][0]
				@faces[side][1][0] = @faces[side][2][1]
				@faces[side][2][1] = @faces[side][1][2]
				@faces[side][1][2] = temp
				#other sides
				for i in 0..2
					temp = @faces[side1][i][2]
					@faces[side1][i][2] = @faces[side2][i][2]
					@faces[side2][i][2] = @faces[side3][i][2]
					@faces[side3][i][2] = @faces[side4][i][2]
					@faces[side4][i][2] = temp
				end
			end
		end
		def execute(moves)
			#TODO assert that moves is string
			moves.foreach do |m|
				valid = false
				valid_moves = "FRULDBxyz2' " # no middle slices
				valid_moves.foreach do |n|
					valid = true if m === n
				end
				raise "Invalid move sequence" if !valid
			end
			counter = 0
			while counter < moves.length
				move = moves[counter]
				attribute = 1
				if moves[counter + 1] == "2"
					attribute = 2
					counter = counter + 1
				end
				if moves[counter + 1] == "3"
					attribute = 3
					counter = counter + 1
				end
				turn(move, attribute)
				counter = counter + 1
			end
		end
		def print_facelet(facelet)
			case facelet
			when "G"
				putc facelet.colorize(:green)
			when "R"
				putc facelet.colorize(:red)
			when "B"
				putc facelet.colorize(:blue)
			when "Y"
				putc facelet.colorize(:yellow)
			when "O"
				putc facelet.colorize(:orange)
			when "W"
				putc facelet
			end
		end
		def prettyprint
			puts "Back: "
			for i in 0..2
				for j in 0..2
					putc @faces["back"][i][j]
					putc " "
				end
				puts
			end
			puts "Up: "
			for i in 0..2
				for j in 0..2
					putc @faces["up"][i][j]
					putc " "
				end
				puts
			end
			puts "Left: "
			for i in 0..2
				for j in 0..2
					putc @faces["left"][i][j]
					putc " "
				end
			end
			puts "Front: "
			for i in 0..2
				for j in 0..2
					puts @faces["front"][i][j]
					putc " "
				end
				puts
			end
			puts "Right: "
			for i in 0..2
				for j in 0..2
					puts @faces["right"][i][j]
					putc " "
				end
				puts
			end
			puts "Down: "
			for i in 0..2
				for j in 0..2
					puts @faces["down"][i][j]
					putc " "
				end
				puts
			end
		end
	end
end
