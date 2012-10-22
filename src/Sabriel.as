package
{
	import net.flashpunk.Entity; 				// Entity.as has a lot of handy game-making functionality
	import net.flashpunk.FP;					// Static catch-all class used to access global properties and functions.
	import net.flashpunk.graphics.Spritemap; 	// Performance-optimized animated Image.
	import net.flashpunk.utils.Input;	
	import net.flashpunk.utils.Key;

	public class Sabriel extends Entity
	{
		// ASSETS
		[Embed(source = 'res/sabriel.png')] private const SABRIEL:Class;
		
		// ANIMATION
		private var FRAME_WIDTH:int = 48;
		private var FRAME_HEIGHT:int = 32;
		public  var sprSabriel:Spritemap = new Spritemap(SABRIEL, FRAME_WIDTH, FRAME_HEIGHT);
		
		// MAGIC NUMBERS
		public  var xspeed:Number = 0.0; // Current X Speed
		public  var yspeed:Number = 0.0; // Current Y Speed
		private var accell:Number = 0.4; // Acceleration
		private var gspeed:Number = 0.2; // Gravity
		private var fspeed:Number = 0.4; // friction speed (force)
		private var mspeed:Number = 4.0; // max speed
		private var jspeed:Number = 7.0; // jump speed (impulse)
		
		public function Sabriel(_x:int, _y:int)
		{
			x = _x; y = _y;					// Constructor set's Sabriel's position
			setHitbox(32, 32, 0, 0);		// (width, height, originX, originY)
			
			// Define Key Mappings
			Input.define("right",	Key.RIGHT, 	Key.D);
			Input.define("left", 	Key.LEFT, 	Key.A);
			Input.define("jump", 	Key.UP, 	Key.W, 	Key.SPACE);
			
			// Create animations
			sprSabriel.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSabriel.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			graphic = sprSabriel;
		}
		
		override public function update():void 
		{
			// It's a smart idea to put code into cute functions:
			moveSabriel();
			//setAnimation(); // How do you think you would implement this function?
		}
		
		private function moveSabriel():void 
		{
			// Acclerate Sabriel's speed from key input
			if (Input.check("right"))
			{
				xspeed += accell;
			}
			if (Input.check("left"))
			{
				xspeed -= accell;
			}
			
			// If you're standing on the ground you can jump
			if (Input.pressed ("jump") && collide("Dirt", x, y + 1))
			{
				yspeed -= jspeed;
			}
			
			// Move in the xspeed one pixel at a time until you collide, then set xspeed 0
			for (var i:int = 0; i < Math.abs(xspeed); i += 1) 
			{
				if (!collide("Dirt", x + FP.sign(xspeed), y))
					{ x += FP.sign(xspeed); } else { xspeed = 0; break; }
			}

			// Move in the yspeed one pixel at a time until you collide, then set yspeed 0
			for (i = 0; i < Math.abs(yspeed); i += 1) {
				if (!collide("Dirt", x, y + FP.sign(yspeed))) 
					{ y += FP.sign(yspeed); } else { yspeed = 0; break; }
			}
			
			// Apply gravity to yspeed
			yspeed += gspeed;
			
			// If not moving, apply friction
			if (!Input.check("right") && !Input.check("left") || (Input.check("left") && Input.check("right"))) {
				xspeed -= FP.sign(xspeed) * fspeed;
				if (Math.abs(xspeed) <= 0.2) { xspeed = 0; }
			}
			
			// Cap speed to a maximum
			if (Math.abs(xspeed) > mspeed) 
				{ xspeed = FP.sign(xspeed) * mspeed; }
		
			// Letting of jump in the air will stop you from rising (Mario Style)
			if (!Input.check("jump") && yspeed < 0) {
				yspeed += gspeed;
			}
		}
	}
}