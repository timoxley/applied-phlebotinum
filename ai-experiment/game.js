(function() {
  Game = function (canvas) {
    that = this;
    this.avatars = [];
    this.zombies = [];
    this.canvas = canvas;
    this.creation_speed = 1;
    var new_zombie, id;

    // Initial zombies
    for ( i = 0; i < 10; i++ ) {
      id = "npc" + Math.floor(Math.random()*100000);
      new_zombie = new this.Npc("zombie", Math.floor(Math.random()*this.canvas.width), Math.floor(Math.random()*this.canvas.height), id, this);
      this.zombies[id] = new_zombie;
    }
    
    this.avatars["a1"] = new this.Avatar(Math.floor(Math.random()*this.canvas.width), Math.floor(Math.random()*this.canvas.height), "a1", this);
    this.avatars["a2"] = new this.Avatar(Math.floor(Math.random()*this.canvas.width), Math.floor(Math.random()*this.canvas.height), "a2", this);
    this.avatars["a3"] = new this.Avatar(Math.floor(Math.random()*this.canvas.width), Math.floor(Math.random()*this.canvas.height), "a3", this);
    this.avatars["a4"] = new this.Avatar(Math.floor(Math.random()*this.canvas.width), Math.floor(Math.random()*this.canvas.height), "a4", this);
    
    $(document).bind('click', function(e) {});
    
    GameTick = setInterval(function () {
      for (zombie in that.zombies) {
        that.zombies[zombie].moveTowardsNearest();
      }
      
      for (i = 0; i < that.creation_speed; i++) {
        var new_zombie;
        id = "npc" + Math.floor(Math.random()*100000);
        new_zombie = new that.Npc("zombie", Math.floor(Math.random()*that.canvas.width), Math.floor(Math.random()*that.canvas.height), id, that);
        that.zombies[id] = new_zombie;
      }
      that.creation_speed + 0.1;
      
    }, 500);

      
  }
})();

$(document).ready(function() {
  var canvas = oCanvas.create({
    canvas: "#canvas",
    background: "#bbb",
    fps: 30
  });
  
  my_game = new Game(canvas);

});