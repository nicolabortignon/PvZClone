package com.bortignon.plantsvszombieclone.VO.shots
{
	import com.bortignon.plantsvszombieclone.VO.GfxItemValueObject;
	
	public class ShotVO extends GfxItemValueObject
	{
		public var row:int;
		public var velocity:int = 400; //Pixels per second
		public function ShotVO()
		{
			super();
		}
	}
}