Actor = require('./actor').Actor

class Zombie extends Actor
	type: 'Zombie'

	###
	# Target a new Zombie.
	#
	# @target The id of the avatar to target
	###
	changeTarget: (@target) =>

	serialize: =>
		out = super()
		out.target = @target
		out

module.exports = {Zombie}