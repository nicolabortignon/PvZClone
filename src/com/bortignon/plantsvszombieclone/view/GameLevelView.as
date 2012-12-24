
package com.bortignon.plantsvszombieclone.view
{
	import com.bortignon.plantsvszombieclone.VO.LevelValueObject;
	import com.bortignon.plantsvszombieclone.VO.plants.PlantVO;
	import com.bortignon.plantsvszombieclone.VO.plants.attacker.StupidPlantVO;
	import com.bortignon.plantsvszombieclone.VO.plants.explosive.Cherry;
	import com.bortignon.plantsvszombieclone.VO.plants.productive.SunFlower;
	import com.bortignon.plantsvszombieclone.VO.shots.ShotVO;
	import com.bortignon.plantsvszombieclone.VO.tiles.TileVO;
	import com.bortignon.plantsvszombieclone.VO.zombies.ZombiVO;
	
	import flash.utils.getTimer;
	
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class GameLevelView
	{
		private var stage:Sprite;
		private var assets:Assets;
		private var _zombies:Vector.<ZombiVO>;
		private var _plants:Vector.<PlantVO>;
		private var _shots:Vector.<ShotVO>;
		private var _tiles:Vector.<TileVO>;
		private var _startingTiles:Vector.<TileVO>;
		
		// CONSTANT SPACING
		public const NUMBER_OF_ROW:int = 6;
		public const NUMBER_OF_COLUMN:int = 11;
		public const GRID_STARTING_X:uint = 200;
		public const GRID_STARTING_Y:uint = 100;
		public const GRID_SIZE_WIDTH:uint = 70;
		public const GRID_SIZE_HEIGHT:uint = 100;
		public const GRID_WIDTH:int = GRID_SIZE_WIDTH*NUMBER_OF_COLUMN;
		public const STAGE_WIDTH:uint = 1024;
		public const STAGE_HEIGHT:uint = 768; 
		// HELPER 
		private var startingTime:Number;
		private var currentTime:Number;
		
		public static var istance:GameLevelView;
		
		public function GameLevelView(_stage:Sprite)
		{
			stage = _stage;
			assets = new Assets();
			renderLevel(null);
			startLevel();
			istance = this;
		}
		public function renderLevel(vo:LevelValueObject):void{
			
			var counterIndexJ:int;
			var counterIndexI:int;
			
			_tiles = new Vector.<TileVO>();
			for( counterIndexJ = 0; counterIndexJ<NUMBER_OF_ROW;counterIndexJ++){
				for( counterIndexI = 0; counterIndexI<NUMBER_OF_COLUMN; counterIndexI++){ // X Axes
					
					//	shape.graphics.beginFill(0xaaaaaa,Math.random()*.3);
					var tile:TileVO = new TileVO();
					tile.id = counterIndexI+counterIndexJ*NUMBER_OF_COLUMN;
					stage.addChild(tile);
					tile.x = counterIndexI*GRID_SIZE_WIDTH+GRID_STARTING_X;
					tile.y = counterIndexJ*GRID_SIZE_HEIGHT+GRID_STARTING_Y;
					_tiles.push(tile);
				}
			}
			
			
			
			
			// LINKAGE TILES
			for( counterIndexI = 0; counterIndexI<(NUMBER_OF_COLUMN*NUMBER_OF_ROW);counterIndexI++){
				_tiles[counterIndexI].estTile = (((counterIndexI+1)%NUMBER_OF_COLUMN)!=0 && counterIndexI<(NUMBER_OF_COLUMN*NUMBER_OF_ROW-1)) ? _tiles[(counterIndexI+1)] : null;
				_tiles[counterIndexI].nordTile = ((counterIndexI-NUMBER_OF_COLUMN)>=0) ? _tiles[(counterIndexI-NUMBER_OF_COLUMN)] : null;
				_tiles[counterIndexI].southTile = ((counterIndexI+NUMBER_OF_COLUMN)<(NUMBER_OF_COLUMN*(NUMBER_OF_ROW-1))) ? _tiles[(counterIndexI+NUMBER_OF_COLUMN)]: null;
				_tiles[counterIndexI].ovestTile = ((counterIndexI)%NUMBER_OF_COLUMN != 0) ? _tiles[counterIndexI-1] : null;
				
				/*	trace(" IL TILE ",i, " HA COME N:", (_tiles[i].nordTile == null) ? "Vuoto" : _tiles[i].nordTile.id,
				" E:",(_tiles[i].estTile == null) ? "Vuoto" : _tiles[i].estTile.id,
				" O:",(_tiles[i].ovestTile == null) ? "Vuoto" : _tiles[i].ovestTile.id,
				" S:",(_tiles[i].southTile == null) ? "Vuoto" : _tiles[i].southTile.id);*/
			}
			
			
			_startingTiles = new Vector.<TileVO>();
			// PRE ENTERING TILEs
			for( counterIndexJ = 0; counterIndexJ<NUMBER_OF_ROW;counterIndexJ++){
				var potTile:TileVO = new TileVO();
				potTile.renderTile(0x0ffcc);
				potTile.id = 9990+counterIndexJ;
				potTile.x = NUMBER_OF_COLUMN*GRID_SIZE_WIDTH+GRID_STARTING_X;
				potTile.y = counterIndexJ*GRID_SIZE_HEIGHT+GRID_STARTING_Y;
				stage.addChild(potTile);
				potTile.ovestTile = _tiles[(NUMBER_OF_COLUMN)+(counterIndexJ*NUMBER_OF_COLUMN)-1] // LINKAGE WITH THE STARTING TILES
				_startingTiles.push(potTile);
			}
			
			
			
			
			// ZOMBIES LOADING
			_zombies = new Vector.<ZombiVO>();
			var frames:Vector.<Texture> = assets.textures("zombie_");
			for( counterIndexI = 0; counterIndexI < 1;counterIndexI++){
				var enemyVO:ZombiVO = new ZombiVO();
				var _mc:MovieClip = new MovieClip(frames, 20);
				_mc.color = 0xffffff*Math.random();
				_mc.pivotY = 0;
				_mc.scaleX = -1;
				var _row:uint = uint(Math.random()*NUMBER_OF_ROW);
				enemyVO.tile = _startingTiles[_row];
				//	enemyVO.tile = ; // IL PRIMO TILE IN CUI ENTRA 
				_mc.x = enemyVO.tile.x+enemyVO.tile.width;
				_mc.y = GRID_STARTING_Y+(_row)*GRID_SIZE_HEIGHT;
				Starling.juggler.add(_mc);
				//_mc.addEventListener(TouchEvent.TOUCH, touchedStage);
				stage.addChild(_mc);
				enemyVO.graphicObject = _mc;
				enemyVO.startingTime = 250*uint(Math.random()*200);
				_zombies.push(enemyVO);
			}
			
			_zombies.sort(enemyVO.orderByTime);
			
			
			// LOADING PLANTS
			_plants = new Vector.<PlantVO>();
			frames = assets.textures("plant_");
			
			for( counterIndexJ = 0; counterIndexJ<2;counterIndexJ++){
				var plantVO:PlantVO = new StupidPlantVO();
				//	plantVO.controller = this;
				plantVO.controller = this;
				plantVO.tile = _tiles[uint(counterIndexJ/NUMBER_OF_ROW)+(counterIndexJ%NUMBER_OF_ROW)*NUMBER_OF_COLUMN];
				plantVO.tile.plant = plantVO;
				plantVO.row = counterIndexJ%NUMBER_OF_ROW;
				plantVO.column = uint(counterIndexJ/NUMBER_OF_ROW);
				var _mcPlant:MovieClip = new MovieClip(frames, 30);
				Starling.juggler.add(_mcPlant);
				plantVO.graphicObject = _mcPlant;
				_mcPlant.pivotY = -20;
				_mcPlant.x = plantVO.tile.x;
				_mcPlant.y =plantVO.tile.y;
				stage.addChild(_mcPlant);
				_plants.push(plantVO);
			}
			//_plants[0].graphicObject.addEventListener(TouchEvent.TOUCH, addZombie);
		}
		public function addPlant(x:int,y:int,id:int):void{
			var lookupX:int = Math.floor((x-GRID_STARTING_X)/GRID_SIZE_WIDTH);
			var lookupY:int = Math.floor((y-GRID_STARTING_Y)/GRID_SIZE_HEIGHT);
			
			var tileIndex:int =  ((lookupX)) + NUMBER_OF_COLUMN*(lookupY);
			trace(tileIndex, "PIANTA QUI");
			if(_tiles[tileIndex].plant == null){
				var frames:Vector.<Texture>;
				var plantVO:PlantVO;
				switch(id){
					case 0:
						frames = assets.textures("sunflower_");
						plantVO = new SunFlower();
						break;
					case 1:
						plantVO = new StupidPlantVO();
						frames = assets.textures("plant_");
						break;
					default:
						frames = assets.textures("cofee_");
						plantVO = new Cherry();
				}
				//	plantVO.controller = this;
				plantVO.controller = this;
				plantVO.tile = _tiles[tileIndex];
				plantVO.tile.plant = plantVO;
				plantVO.row = lookupY;
				plantVO.column = lookupX;
				var _mcPlant:MovieClip = new MovieClip(frames,30);
				Starling.juggler.add(_mcPlant);
				plantVO.graphicObject = _mcPlant;
				_mcPlant.pivotY = -20;
				_mcPlant.x = plantVO.tile.x;
				_mcPlant.y =plantVO.tile.y;
				stage.addChild(_mcPlant);
				_plants.push(plantVO);
			}
		}
		public function addZombie():void{
			var frames:Vector.<Texture> = assets.textures("zombie_");
			var enemyVO:ZombiVO = new ZombiVO();
			var _mc:MovieClip = new MovieClip(frames, 20);
			_mc.color = 0xffffff*Math.random();
			_mc.pivotY = 5;
			_mc.scaleX = -1;
			var _row:int = uint(Math.random()*NUMBER_OF_ROW);
			enemyVO.tile = _startingTiles[_row];
			//	enemyVO.tile = ; // IL PRIMO TILE IN CUI ENTRA 
			_mc.x = enemyVO.tile.x+enemyVO.tile.width;
			_mc.y = GRID_STARTING_Y+(_row)*GRID_SIZE_HEIGHT;
			Starling.juggler.add(_mc);
			//_mc.addEventListener(TouchEvent.TOUCH, touchedStage);
			stage.addChild(_mc);
			enemyVO.graphicObject = _mc;
			enemyVO.startingTime = 250+currentTime;
			_zombies.push(enemyVO);
			_zombies.sort(enemyVO.orderByTime);
		}
		private function startLevel():void{
			
			currentTime = startingTime = getTimer();
			
			_shots = new Vector.<ShotVO>();
			stage.addEventListener(Event.ENTER_FRAME, process);
		}
		
		private function process(e:Event):void{
			/* TICKETING FUNCTION (MAIN LOOP)
			@15fps = 66ms
			@30fps = 33ms
			@60fps = 17ms
			
			granulosità suggerita 100ms (1/10s)
			*/
			
			var shots:ShotVO;
			var gridFinished:uint = GRID_STARTING_X+GRID_WIDTH-6;
			var currentTileInt:int;
			var tileToInspect:int;
			var hittedZombieFound:Boolean;
			var shotIndex:int;
			var zombieIndex:int;
			var counterIndexI:int;
			var counterIndexJ:int;
			var getCurrentTimer:Number = getTimer();
			
			var timeElapsedFromLastTick:Number = (getCurrentTimer-currentTime); // TEMPO DALL'ULTIMO TICK in Secondi
			currentTime = getCurrentTimer; 
			var timeElapsedInSecond:Number = timeElapsedFromLastTick/1000;
			//GUI.setText(""+timeElapsedFromLastTick+ " - ");
			
			
			// Iterate over zombies list (within available range)
			for(counterIndexI = 0; ((counterIndexI<_zombies.length) && (_zombies[counterIndexI].startingTime < currentTime)); counterIndexI++){
				if(_zombies[counterIndexI].isDead == true){
					// CONTROLL IF there's zombie to remove.
					_zombies.splice(counterIndexI,1);
				} else {
					// Otherwise let him walk (passing time elapsed)
					_zombies[counterIndexI].act(timeElapsedInSecond);
				}
			}
			
			// Iterate over Plants list
			var counterPlants:int = 0;
			for each (var plant:PlantVO in _plants) 
			{
				if(plant.isDead == true)
					_plants.splice(counterPlants,1);
				else{
				plant.act(timeElapsedInSecond);
				}
				counterPlants++;
			}
			
			
			for( counterIndexJ = _shots.length-1; counterIndexJ >=0; counterIndexJ--){
				//for each (var shots:ShotVO in _shots){
				shots = _shots[counterIndexJ];
				shots.graphicObject.x += shots.velocity*timeElapsedInSecond;
				shots.graphicObject.rotation += timeElapsedInSecond ;
				if(shots.graphicObject.x > gridFinished){
					shots.graphicObject.visible = false;
					shots.graphicObject.removeEventListeners();
					shots.graphicObject.removeFromParent(true);
					_shots.splice(counterIndexJ,1);
				} else {
					// optimized version
					currentTileInt = Math.floor((shots.graphicObject.x-GRID_STARTING_X)/GRID_SIZE_WIDTH);
					tileToInspect = currentTileInt + shots.row*NUMBER_OF_COLUMN;
					if(_tiles[tileToInspect].hasMonster == true){
						var totalZombiesToIntercept:int = _tiles[tileToInspect].zombies.length;
						
						hittedZombieFound = false;
						for( counterIndexI = 0; hittedZombieFound == false && counterIndexI<totalZombiesToIntercept;counterIndexI++){
							if(_tiles[tileToInspect].zombies[counterIndexI].graphicObject.getBounds(stage).intersects(shots.graphicObject.getBounds(stage))){
								hittedZombieFound = true;
								var isDead:Boolean = _tiles[tileToInspect].zombies[0].getInjury(uint(20));
								if(isDead){
									_tiles[tileToInspect].zombies[0].isDead = true; // KILL THE ZOMBIE
									// REMOVE IT FROM THE CURRENT TILE
									_tiles[tileToInspect].removeZombieAt(0);
								}
								// remove the shot from the Vector
								_shots.splice(counterIndexJ,1);
								shots.graphicObject.visible = false;
								shots.graphicObject.removeFromParent(true);
								shots.graphicObject.removeEventListeners();
							}
						}
					}
					
				}
			}
			//stage.removeEventListener(Event.ENTER_FRAME, process);
		}
		
		public function shot(source:PlantVO):void{
			var frames:Vector.<Texture> = assets.textures("shot");	
			var shot:ShotVO = new ShotVO();
			shot.row = source.row;
			var _mc:MovieClip = new MovieClip(frames, 60);
			shot.graphicObject = _mc;
			_mc.scaleX = _mc.scaleY = 1;
			_mc.pivotX = 10;
			_mc.pivotY = 8;
			_mc.color = interpolateColor(0x4444cc,0x0000ff,Math.random());
			_mc.x = 30+source.graphicObject.x;
			_mc.y = 50+source.graphicObject.y;
			stage.addChild(_mc);
			//Starling.juggler.add(_mc);
			_shots.push(shot);
		}
		
		public function interpolateColor(fromColor:uint, toColor:uint, progress:Number):uint
		{
			var q:Number = 1-progress;
			var fromA:uint = (fromColor >> 24) & 0xFF;
			var fromR:uint = (fromColor >> 16) & 0xFF;
			var fromG:uint = (fromColor >>  8) & 0xFF;
			var fromB:uint =  fromColor        & 0xFF;
			
			var toA:uint = (toColor >> 24) & 0xFF;
			var toR:uint = (toColor >> 16) & 0xFF;
			var toG:uint = (toColor >>  8) & 0xFF;
			var toB:uint =  toColor        & 0xFF;
			
			var resultA:uint = fromA*q + toA*progress;
			var resultR:uint = fromR*q + toR*progress;
			var resultG:uint = fromG*q + toG*progress;
			var resultB:uint = fromB*q + toB*progress;
			var resultColor:uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
			return resultColor;  
		}
		
		
		private function touchedStage(e:TouchEvent):void{
		}
	}
}