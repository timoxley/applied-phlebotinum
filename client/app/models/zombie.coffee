Actor = require('./actor').Actor

class Zombie extends Actor
	type: 'Zombie'
	constructor: ->
		super
		
	###
	# Set the target avatar this zombie will attack
	#
	# @target The id of the avatar to target
	###
	setTarget: (@target) =>
		avatar = @world.getActor @target
		setInterval =>
			directionX = avatar.x - @.x
			directionY = avatar.y - @.y
			@x += directionX / @.max_speed
			@y += directionY / @.max_speed
		, 200
	eat: (damage) =>
		@health -= damage

		if @health <= 0
			@died.dispatch

	serialize: =>
		out = super()
		out.target = @target
		out

module.exports = {Zombie}