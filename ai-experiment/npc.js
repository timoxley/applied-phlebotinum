(function () {
  var Npc = function (type, x, y, id, game) {
    this.type = type
    this.x = x
    this.y = y
    this.id = id
    this.velocity = 5
    this.game = game
    this.render()
    this.eating = null;
  }
  
  Npc.prototype.render = function () {
    var displayElement = this.game.canvas.display.rectangle({
      x: this.x,
      y: this.y,
      width: 5,
      height: 5,
      fill: "#F00"
    });
    this.element = displayElement;
    this.game.canvas.addChild(this.element);
  }
  
  Npc.prototype.moveTowardsNearest = function () {
    var original_x, original_y;
    original_x = this.x;
    original_y = this.y;
    
    var lowest_distance, lowest_avatar, distance;
    lowest_distance = 100000;
    
    // Locate the nearest avatar to this npc
    for (avatar in this.game.avatars) {
      distance = Math.pow(Math.pow(this.game.avatars[avatar].x - this.x, 2) + Math.pow(this.game.avatars[avatar].y - this.y, 2), (1/2));
      if (lowest_distance > distance) {
        lowest_distance = distance;
        lowest_avatar = avatar;
      }
    }
    
    // Move a certain number of units towards that avatar
    var change_x, change_y;
    change_x = this.x - this.game.avatars[lowest_avatar].x
    change_y = this.y - this.game.avatars[lowest_avatar].y
    
    if ( Math.abs(change_x) < 15 && Math.abs(change_y) < 15) {
      this.eating = this.game.avatars[lowest_avatar];
    } else {
      this.eating = null;
      if ( Math.abs(change_x) < 15 ) {                // Too close on x, only move y
        movement_y = this.velocity;
        if (change_y < 0) {
          this.y = this.y + movement_y;
        } else {
          this.y = this.y - movement_y;
        }
      } else if ( Math.abs(change_y) < 15 ) {         // Too close on y, only move x
        movement_x = this.velocity;
        if (change_x < 0) {
          this.x = this.x + movement_x;
        } else {
          this.x = this.x - movement_x;
        }        
      } else {
        movement_x = Math.cos(Math.atan(change_y/change_x))*this.velocity;
        movement_y = Math.sin(Math.atan(change_y/change_x))*this.velocity;

        if (change_x < 0) {
          this.x = this.x + movement_x;
        } else {
          this.x = this.x - movement_x;
        }

        if ( change_y < 0 && change_x < 0 ) {
          this.y = this.y + movement_y;
        } else if (change_y > 0 && change_x < 0 ){
          this.y = this.y + movement_y;
        } else {
          this.y = this.y - movement_y;
        }
      }
    } 
    this.element.move(this.x - original_x, this.y - original_y);
    this.element.redraw();
  }
  
  
  Game.prototype.Npc = Npc;
})()
