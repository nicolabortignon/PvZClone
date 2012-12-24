package com.bortignon.plantsvszombieclone.VO.plants.explosive
{
	import com.bortignon.plantsvszombieclone.VO.plants.PlantVO;
	
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	
	public class Cherry extends PlantVO
	{
		private var DELAY_BEFORE_EXPLOSION:int= 1; // 10.000 = 1s
		private var EXPLOSION_FORCE:int = 100;
		public function Cherry()
		{
			super();
			recoveringTimeLeft = DELAY_BEFORE_EXPLOSION;
		}
		override public function act(ticketTime:Number):void{
			recoveringTimeLeft -= ticketTime;
			if(recoveringTimeLeft<0){
				
				explode();
				getInjury(_totalLife);
			}
		}
		private function explode():void{
			var i:int =0;
			
			for( i = 0; i<tile.zombies.length;i++){
				tile.zombies[i].getInjury(EXPLOSION_FORCE);
			}
			
			if(tile.nordTile != null){
				for( i = 0; i<tile.nordTile.zombies.length;i++){
					tile.nordTile.zombies[i].getInjury(EXPLOSION_FORCE);
				}
			}
			if(tile.southTile != null){
				for( i = 0; i<tile.southTile.zombies.length;i++){
					tile.southTile.zombies[i].getInjury(EXPLOSION_FORCE);
				}
			}
			if(tile.estTile != null){
				for( i = 0; i<tile.estTile.zombies.length;i++){
					tile.estTile.zombies[i].getInjury(EXPLOSION_FORCE);
				}
			}
			if(tile.ovestTile != null){
				for( i = 0; i<tile.ovestTile.zombies.length;i++){
					tile.ovestTile.zombies[i].getInjury(EXPLOSION_FORCE);
				}
			}
			
			// DA RIMUOVERE IL VALUE OBJECT DALL'ARRAY
		}
		
	}
}