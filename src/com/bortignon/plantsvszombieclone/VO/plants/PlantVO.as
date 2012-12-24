package com.bortignon.plantsvszombieclone.VO.plants
{
	import com.bortignon.plantsvszombieclone.VO.GfxItemValueObject;
	import com.bortignon.plantsvszombieclone.VO.tiles.TileVO;
	
	import starling.core.Starling;

	public class PlantVO extends GfxItemValueObject
	{
		public var tile:TileVO;
		public var row:int;
		public var column:int;
		public var isDead:Boolean;
		protected var _totalLife:Number = 250;
		protected var recoveringTimeLeft:Number;
		public function PlantVO()
		{
		}
		public function act(ticketTime:Number):void{
			
		}
		public function getInjury(value:Number):Boolean{
			trace(_totalLife);
			_totalLife -= value;
			graphicObject.alpha = _totalLife/255;
			if(_totalLife <= 0){
				isDead = true;
				this.tile.plant = null;
				Starling.juggler.remove(this.graphicObject);
				this.graphicObject.removeEventListeners();
				this.graphicObject.removeFromParent(true);
				return true;
			}
			return false;
		}
		
	}
}