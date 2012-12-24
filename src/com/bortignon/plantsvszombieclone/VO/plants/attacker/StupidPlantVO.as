package com.bortignon.plantsvszombieclone.VO.plants.attacker
{
	import com.bortignon.plantsvszombieclone.VO.plants.PlantVO;
	import com.bortignon.plantsvszombieclone.VO.tiles.TileVO;
	import com.bortignon.plantsvszombieclone.view.GUI;
	
	import starling.core.Starling;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	

	public class StupidPlantVO extends PlantVO
	{
		private var RECOVERING_TIME:int= 1;
		
		public function StupidPlantVO()
		{
			super();
			recoveringTimeLeft = RECOVERING_TIME;
		}
		override public function act(ticketTime:Number):void{
			if(!this.graphicObject.hasEventListener(TouchEvent.TOUCH)){
				GUI.setText("TOUCH EVT ADDED");
				this.graphicObject.addEventListener(TouchEvent.TOUCH, clock);
			}
			recoveringTimeLeft -= ticketTime;
			if(recoveringTimeLeft<0){
				
				var currentTile:TileVO = tile;
				var monsterFound:Boolean = false;
				while(currentTile != null){
					if(currentTile.hasMonster)
						monsterFound = true;
					currentTile = currentTile.estTile;	
				}
			//	trace("sono la pianta in posizione" + tile.id);
				if(monsterFound) shot();
				
				recoveringTimeLeft = RECOVERING_TIME;
			}
		}
		private function clock(e:TouchEvent):void{
			GUI.setText("TOUCHED " + tile.id);
		}
		private function shot():void{
			_controller.shot(this);
			
		}
	}
}