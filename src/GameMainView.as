﻿package{	import com.bortignon.plantsvszombieclone.controller.GameLevelController;	import com.bortignon.plantsvszombieclone.view.GameLevelView;		import flash.display.Bitmap;		import fr.kouma.starling.utils.Stats;		import starling.core.Starling;	import starling.display.MovieClip;	import starling.display.Sprite;	import starling.events.Event;	import starling.textures.Texture;	import starling.textures.TextureAtlas;	import starling.utils.rad2deg;			public class GameMainView  extends Sprite {				/*private var _patches:Vector.<MovieClip>;		private var _mc:MovieClip;*/						// ASSETS 		[Embed(source="../assets/pvz.xml", mimeType="application/octet-stream")]		public static const SPRITESHEETXML:Class;				[Embed(source="../assets/pvz.png")]		private static const _SPRITESHEET:Class;				// END OF THE ASSETS				public var  gameLevelController:GameLevelController;		public var gameLevelView:GameLevelView;		public function GameMainView()		{			addEventListener(Event.ADDED_TO_STAGE, _init);		}				private function _init(evt:Event):void {						removeEventListener(Event.ADDED_TO_STAGE, _init);			debugHud();						gameLevelController = new GameLevelController();			gameLevelController.beginLevel(0);						gameLevelView = new GameLevelView(this);								/*				var bitmap:Bitmap = new _SPRITESHEET();			var texture:Texture = Texture.fromBitmap(bitmap);			var xml:XML = XML(new SPRITESHEETXML());			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);			var frames:Vector.<Texture> = sTextureAtlas.getTextures("patch_");						_patches = new Vector.<MovieClip>();						for (var i:uint = 0; i < 20; ++i) {				_mc = new MovieClip(frames, Math.random()*60);				addChild(_mc);					_mc.scaleX = -1;								_mc.x = stage.stageWidth * Math.random();				_mc.y = stage.stageHeight * Math.random();								// Keep the Stats visible											_patches.push(_mc);				Starling.juggler.add(_mc);			}						addEventListener(Event.ENTER_FRAME, _ef);*/		}				private function _ef(evt:Event):void {			/*			for each (var patch:MovieClip in _patches) {				patch.x -= 5;				if (patch.x < 0) patch.x = 1024;				patch.alpha = patch.x/1024;				//patch.rotation += rad2deg(Math.random());				//patch.alpha = Math.random();			}			*/		}				private function debugHud():void{			addChild(new Stats());		}	}}