package
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.World;
	
	public class MazeWorld extends World
	{
		// ASSETS
		[Embed(source = "ogmo/TEST.oel", mimeType = "application/octet-stream")]
		private const TESTMAP:Class;
		
		private var sabriel:Sabriel;
		
		public function MazeWorld()
		{
			loadMap();

			sabriel = new Sabriel(32, 32);
			add(sabriel);
		}
		
		// 
		private function loadMap():void
		{
			var bytes:ByteArray = new TESTMAP;
			var xml:XML = new XML(bytes.readUTFBytes(bytes.length));
			
			// Dirt
			add (new Dirt(xml));
		}
		
		override public function update():void
		{
			super.update();
			
			moveCameraToSabriel();
		}
		
		// TODO: Make more natural where player can move around on screen without camera movement.
		private function moveCameraToSabriel():void 
		{	
			FP.camera.x = sabriel.x - FP.screen.width/2;
			FP.camera.y = sabriel.y - FP.screen.height/2;
			
			// TODO: This stuff sort of comes close to a good camera system - CP
			/*var desiredX:Number = 60 * FP.sign(sabriel.xspeed) + sabriel.x - FP.screen.width/2;
			var desiredY:Number = 40 * FP.sign(sabriel.yspeed) + sabriel.y - 80 - FP.screen.height/2;
			
			var MAX_CAMERA_SPEED:Number = 10;
			var CAMERA_ACCELERATION:Number = 0.5;
			
			if (Math.abs(FP.camera.x - desiredX) < 15)
			{
				FP.camera.x = desiredX;
				cameraXSpeed = 0;
			}
			else
			{
				var diffX:Number = desiredX - (camera.x);
				cameraXSpeed += FP.sign(diffX) * CAMERA_ACCELERATION;
				camera.x += cameraXSpeed;
				if (Math.abs(cameraXSpeed) > MAX_CAMERA_SPEED) cameraXSpeed = MAX_CAMERA_SPEED * FP.sign(cameraXSpeed);
			}
			
			if (Math.abs(FP.camera.y - desiredY) < 15)
			{
				FP.camera.y = desiredY;
				cameraYSpeed = 0;
			}
			else
			{
				var diffY:Number = desiredY - (camera.y);
				cameraYSpeed += FP.sign(diffY) * CAMERA_ACCELERATION;
				camera.y += cameraYSpeed;
				if (Math.abs(cameraYSpeed) > MAX_CAMERA_SPEED) cameraYSpeed = MAX_CAMERA_SPEED * FP.sign(cameraYSpeed);
			} */
		}
	}
}