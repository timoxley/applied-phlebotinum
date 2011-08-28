Actor = require('./actor').Actor

class Zombie extends Actor
	type: 'Zombie'
	changeTarget: (@avatar) =>

module.exports = {Zombie}