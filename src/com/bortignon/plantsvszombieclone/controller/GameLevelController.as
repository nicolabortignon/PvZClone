package com.bortignon.plantsvszombieclone.controller
{
	import starling.core.Starling;

	public class GameLevelController
	{
		[Embed(source="/../assets/level/0.xml", mimeType="application/octet-stream")]
		public static const Level0:Class;
		
		
		private var _levelXML:Vector.<Class>;
		public function GameLevelController()
		{
			// LOADING PROCEDURES
			_levelXML = new  Vector.<Class>();
			_levelXML.push(Level0);
			
		}
		public function beginLevel(id:int):void{
			var xml:XML = XML(new _levelXML[id]());
			drawLevel(xml);
		}
		
		private function drawLevel(xml:XML):void{
			drawBackground(xml..background);
		}
		private function drawBackground(xml:XMLList):void{
		
		}
	}
}