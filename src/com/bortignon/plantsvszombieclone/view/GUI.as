package com.bortignon.plantsvszombieclone.view
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	
	public class GUI extends MovieClip
	{
		private var _clickingAvailable:Boolean = false;
		private var _currentSelectedId:int = 0;
		private static var tf:TextField = new TextField();
		public function GUI()
		{
			super();
			
			renderTopButtons();
			renderDebugText();
		}
		private function renderDebugText():void{
			tf.x = 10;
			tf.y = 200;
			tf.text = "CIAO";
			this.addChild(tf);
		}
		private function enterFrameHandler(e:Event):void{
			 
			 tf.text = ""+getTimer();
			 
		}
		public static function setText(t:String):void{
			tf.text = t;
		}
		private function renderTopButtons():void{
			for(var i:int = 0; i<6;i++){
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0xff00ff*(i+1)*40);
				shape.graphics.drawRect(200+i*60,0,50,90);
				var mc:MovieClip = new MovieClip();
				mc.addChild(shape);
				mc.id = i;
				this.addChild(mc);
				mc.addEventListener(MouseEvent.CLICK, plantSelected);
			}
		}
		private function plantSelected(e:MouseEvent):void{
			_currentSelectedId = e.target.id;
			trace("SELEZIONATA PIANTA "+ e.target.id);
			e.stopImmediatePropagation();
			allowClicking();
		}
		
		private function allowClicking():void{
			_clickingAvailable = true;
			this.stage.addEventListener(MouseEvent.CLICK, stageClicked);
			
		}
		private function stageClicked(e:MouseEvent):void{
			trace("ho cliccato lo stage"+e);
			trace("coordinate :",e.stageX,e.stageY);
			GameLevelView.istance.addPlant(e.stageX,e.stageY,_currentSelectedId);
			deactivateClicking()
		}
		private function deactivateClicking():void{
			this.stage.removeEventListener(MouseEvent.CLICK, stageClicked);	
		}
	}
	
}