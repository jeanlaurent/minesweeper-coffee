class InputReader
	read: (callback) ->
		inputData = ""
		process.stdin.resume()
		process.stdin.setEncoding('utf8')
		process.stdin.on('data', (chunk) -> inputData = "#{inputData}#{chunk}")
		process.stdin.on('end', -> 
			dataByLine = inputData.split('\n')
			firstLine = dataByLine[0].split(" ")
			callback(new MineField(firstLine[0],firstLine[1],dataByLine[1..]) )
		)

class MineField
	constructor : (@width, @height, @minefield) ->
		@solution = []
		for i in [0..3]
			@solution[i] = []

	compute: ->
		for x in [0...@width]
			for y in [0...@height] 
				current = @minefield[x].charAt(y)
				if (current == '*')
					@solution[x][y] = '#'
				else 
					@solution[x][y] = this.findNeighbourMine(x,y)
		console.log(@solution)
		
	findNeighbourMine: (x,y) ->
		numberOfMine=0
		console.log("")
		console.log(x + " " + y)
		console.log("")
		for xx in [x-1..x+1]
			for yy in [y-1..y+1]
				if this.isValidX(xx,yy) && !( (xx == x) && (yy == y) ) 
					if @minefield[xx].charAt(yy) == '*'
						numberOfMine++
		return numberOfMine

	isValidX: (x,y) ->
		return (x >= 0) && (x < @width) && (y >= 0) && (y < @height)
			
		
new InputReader().read( (someData) ->
	console.log(someData)
	someData.compute()
	
)


