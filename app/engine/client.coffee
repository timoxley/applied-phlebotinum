class Client
	constructor: (@socket) ->
		@id = @socket.id

module.exports = {Client}