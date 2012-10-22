package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	import net.flashpunk.graphics.Spritemap;

	public class Dirt extends Entity
	{
		private const TILE_WIDTH:Number = 32;
		private const TILE_HEIGHT:Number = 32;
		private const RECT_WIDTH:Number = 32;
		private const RECT_HEIGHT:Number = 32;
		
		// ASSETS
		[Embed(source = 'res/tileset.png')]
		private const TILESET:Class;

		public var tileMap:Tilemap;	// For graphics
		public var grid:Grid;		// For collision
		
		public function Dirt(map:XML)
		{
			// Sabriel checks collision for this
			type = "Dirt";
			
			// Parse graphic tiling info from OGMO
			graphic = tileMap = new Tilemap(TILESET,map.@width,map.@height,TILE_WIDTH, TILE_HEIGHT);
			for each (var tile:XML in map.dirt.tile)
			{
				tileMap.setTile(tile.@x,
								tile.@y,
								tileMap.getIndex(tile.@tx , tile.@ty));
			}

			// Set collision mask from OGMO			
			mask = grid = new Grid(map.@width, map.@height, TILE_WIDTH, TILE_HEIGHT);
			for each (tile in map.dirt.tile)
			{
				grid.setRect(tile.@x,
							 tile.@y,
							 1,
							 1);
			}
		}
	}
}