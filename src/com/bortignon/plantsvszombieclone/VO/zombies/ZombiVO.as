package com.bortignon.plantsvszombieclone.VO.zombies
{
	import com.bortignon.plantsvszombieclone.VO.GfxItemValueObject;
	import com.bortignon.plantsvszombieclone.VO.tiles.TileVO;
	import com.bortignon.plantsvszombieclone.view.GUI;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class ZombiVO extends GfxItemValueObject
	{
		
		private var _startingTime:uint;
		public var tile:TileVO;
		private var _currentPosition:Number = 30;
		protected var _attackForce:Number = 1;  // NUMBER OF HIT per second
		protected var _walkingSpeed:Number = 30; // NUMBER OF X per second
		private var _totalLife:int;
		public var isDead:Boolean;
		
		public function ZombiVO()
		{
			_totalLife = uint(Math.random()*255);
		}
		
		
		
		// TIME ELAPSED from last tick
		public function act(timeElapsed:Number):void{
			if(tile != null)
			{
				
				
				if(tile.plant == null){  // no plants on the current tile ... letz walk!
					//trace("                "+tile.id);
					var moveDistance:Number = _walkingSpeed*timeElapsed;  //Time elapsed is in ms
				//GUI.setText(""+timeElapsedInSeconds+ " - "+moveDistance);
					graphicObject.x -= moveDistance;
					_currentPosition += moveDistance;
					if(_currentPosition>tile.width){
						_currentPosition = _currentPosition - tile.width;
						tile.removeZombie(this);
						tile = tile.ovestTile;
						if(tile != null){
							tile.addZombie(this);
						} else {
							trace("FINE CORSA");
							Starling.juggler.remove(this.graphicObject);
							this.graphicObject.removeFromParent(true);
							this.graphicObject.removeEventListeners();
						}
					}
				} else { // plant on the current tile ... it's dinner time!
					tile.plant.getInjury(_attackForce*timeElapsed);
				}
			}
		}
		public function get startingTime():uint
		{
			return _startingTime;
		}
		
		public function set startingTime(value:uint):void
		{
			_startingTime = value;
		}
		
		public function getInjury(value:int):Boolean{
			_totalLife -= value;
			//	graphicObject.color = (_totalLife<<16);
			graphicObject.alpha = _totalLife/255;
			if(_totalLife < 0){
				
				Starling.juggler.remove(this.graphicObject);
				this.graphicObject.removeEventListeners();
				this.graphicObject.removeFromParent(true);
				return true;
			}
			return false;
		}
		
		public function orderByTime(vo1:ZombiVO,vo2:ZombiVO):int{
			if(vo1.startingTime>vo2.startingTime) return 1
			else return -1;
		}
		
	}
}