(function () {
  var Avatar = function (x, y, id, game) {
    this.x = x
    this.y = y
    this.id = id
    this.game = game
    this.render()
  }
  
  Avatar.prototype.render = function () {
    var displayElement = this.game.canvas.display.rectangle({
      x: this.x,
      y: this.y,
      width: 10,
      height: 10,
      fill: "#0F0"
    });
    this.element = displayElement;
    this.game.canvas.addChild(displayElement);
    
  }
  
  Game.prototype.Avatar = Avatar;
})()
