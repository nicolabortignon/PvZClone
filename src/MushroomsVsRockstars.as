package
{
	
	import com.bortignon.plantsvszombieclone.view.GUI;
	import com.bortignon.plantsvszombieclone.view.GameLevelView;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	
	
	[SWF(backgroundColor="#ddffcc", frameRate="60", width="1024", height="768")]
	public class MushroomsVsRockstars extends Sprite
	{
		private var _starling:Starling;
		private var _gui:GUI;
		
		public function MushroomsVsRockstars()
		{
			
			Starling.multitouchEnabled = true;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_starling = new Starling(GameMainView, stage);
			
			_starling.antiAliasing = 0;
			_starling.start();
			renderGui();
			renderGrid();
		}
		private function renderGui():void{
			if(_gui == null){
				_gui = new GUI();o
				stage.addChild(_gui);
			}
		}
		private function renderGrid():void{
			var originX:int = 100;
			var originY:int = 80;
			var cellHeight:int = 105;
			var cellWidth:int = 80;
			var shape:Shape = new Shape();
			/*for(var i:int = 0; i<11; i++){ // X Axes
			for(var j:int = 0; j<6;j++){
			//	shape.graphics.beginFill(0xaaaaaa,Math.random()*.3);
			shape.graphics.lineStyle(1,0,1);
			shape.graphics.drawRect(i*cellWidth+originX,j*cellHeight+originY, cellWidth,cellHeight);
			shape.graphics.endFill();
			
			}
			}*/
			var s:Shape = new Shape();
			s.graphics.beginFill(0xfcc00f);
			s.graphics.drawRect(900,0,80,30);
			s.graphics.endFill();
			var mc:MovieClip = new MovieClip();
			mc.addChild(s);
			this.addChild(mc);
			mc.addEventListener(MouseEvent.CLICK,process);		
			this.stage.addChild(shape);
			
		}
		private function process(e:MouseEvent):void{
			trace("YA");
			GameLevelView.istance.addZombie();
		}
	}
}