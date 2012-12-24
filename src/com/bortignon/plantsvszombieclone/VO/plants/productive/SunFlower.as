package com.bortignon.plantsvszombieclone.VO.plants.productive
{
	import com.bortignon.plantsvszombieclone.VO.plants.PlantVO;
	
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	
	public class SunFlower extends PlantVO
	{
		private var currentSun:Quad;
		private var RECOVERING_TIME:Number= 30;
		private var SUN_TIMING:Number = 10;
		public function SunFlower()
		{
			super();
			recoveringTimeLeft = RECOVERING_TIME;
		}
		override public function act(ticketTime:Number):void{
		//	trace(recoveringTimeLeft);
			recoveringTimeLeft -= ticketTime;
			if(recoveringTimeLeft<0){
				
				produceSun();
				
				recoveringTimeLeft = RECOVERING_TIME;
			}
			if(recoveringTimeLeft<SUN_TIMING && currentSun != null){
				currentSun.removeFromParent(true);
			}
		}
		// TODO REPLACE QUAD TO THE RIGHT SPRITE
		private function produceSun():void{
			
			
			var q:Quad = new Quad(20, 20);
			q.setVertexColor(0, 0xffffff);
			q.setVertexColor(1, 0xffffff);
			q.setVertexColor(2, 0xffffff);
			q.setVertexColor(3, 0xffffff);
			q.x = this.graphicObject.x + 20 + Math.random()*20;
			q.y = this.graphicObject.y - Math.random()*30;
			currentSun = q;
			this.graphicObject.parent.addChild( currentSun );
			q.addEventListener(TouchEvent.TOUCH, removeSun);
		}
		private function removeSun(e:TouchEvent):void{
			currentSun.removeEventListeners();
			currentSun.removeFromParent(true);
			currentSun = null;
		}
		
	}
}