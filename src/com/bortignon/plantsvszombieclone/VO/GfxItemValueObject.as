package com.bortignon.plantsvszombieclone.VO
{
	import com.bortignon.plantsvszombieclone.view.GameLevelView;
	
	import starling.display.MovieClip;

	public class GfxItemValueObject
	{
		public var graphicObject:MovieClip;
		protected var _controller:GameLevelView;
		
		public function GfxItemValueObject()
		{
		}
		
		public function set controller(value:GameLevelView):void
		{
			_controller = value;
		}

	}
}