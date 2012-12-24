package com.bortignon.plantsvszombieclone.view
{
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="/../assets/pvz.xml", mimeType="application/octet-stream")]
		public static const SPRITESHEETXML:Class;
		
		[Embed(source="/../assets/pvz.png")]
		private static const _SPRITESHEET:Class;
		
		[Embed(source="/../assets/sprite_sheet.xml", mimeType="application/octet-stream")]
		public static const SPRITESHEETXML2:Class;
		
		[Embed(source="/../assets/sprite_sheet.png")]
		private static const _SPRITESHEET2:Class;
		
		
		private var sTextureAtlas:TextureAtlas
		private var stexture:TextureAtlas;
		public function Assets()
		{
			var bitmap:Bitmap = new _SPRITESHEET();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new SPRITESHEETXML());
			var bitmap1:Bitmap = new _SPRITESHEET2();
			var texture1:Texture = Texture.fromBitmap(bitmap1);
			var xml1:XML = XML(new SPRITESHEETXML2());
			stexture = new TextureAtlas(texture1, xml1);
			sTextureAtlas = new TextureAtlas(texture, xml);
		}
		public function texturesGoodies(name:String):Vector.<Texture>{
			return stexture.getTextures(name);
		}
		public function textures(name:String):Vector.<Texture>{
			return sTextureAtlas.getTextures(name);
		}
	}
}