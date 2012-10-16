package com.funbuilder.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.OBJParser;
	
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.BlockStyleVo;
	import com.funrun.model.vo.BlockTypeVo;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.BlockStylesParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import old.OBJParser;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadBlockStylesCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "blocks/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/block_styles.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse object to give it meaning.
			var parsedBlocks:BlockStylesParser = new BlockStylesParser( new JsonService().readString( data ) );
			var len:int = parsedBlocks.length;
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Set up loading context.
				var context:AssetLoaderContext = new AssetLoaderContext( true, _filePath );
				
				// Load the block objs.
				var style:BlockStyleVo, keys:Array, id:String, filename:String;
				for ( var i:int = 0; i < len; i++ ) {
					style = parsedBlocks.getAt( i );
					keys = style.getKeys();
					for ( var j:int = 0; j < keys.length; j++ ) {
						id = keys[ j ];
						filename = style.getFilename( id );
						// Store in model.
						blockStylesModel.add( style );
						// Load both mtl and an obj for each block style.
						_countTotal += 2;
						// Load it.
						var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( _filePath + filename ), context, id, new old.OBJParser() );
						token.addEventListener( AssetEvent.ASSET_COMPLETE, getOnAssetComplete( style, id ) );
					}
				}
			}
		}
		
		/**
		 * Listener function for asset complete event on loader
		 */
		private function getOnAssetComplete( style:BlockStyleVo, id:String ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( event:AssetEvent ):void {
				if ( event.asset.assetType == AssetType.MESH ) {
					// Treat mesh.
					var mesh:Mesh = event.asset as Mesh;
					mesh.name = style.id; // id and mesh.assetNamepsace are the same
					mesh.geometry.scale( TrackConstants.BLOCK_SIZE ); // Note: scale cannot be performed on mesh when using sub-surface diffuse method.
					mesh.rotationY = 180;
					// Store mesh.
					style.addMesh( id, mesh );
					// Increment complete count and check if we're done.
					_countLoaded++;
					if ( _countLoaded == _countTotal ) {
						completeCallback.call( null, true );
					}
				}
			}
		}
	}
}
