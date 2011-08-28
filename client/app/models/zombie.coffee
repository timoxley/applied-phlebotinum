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

	serialize: =>
		out =
			id: @id
			x: @x
			y: @y
			type: @type
			target: @target

module.exports = {Zombie}