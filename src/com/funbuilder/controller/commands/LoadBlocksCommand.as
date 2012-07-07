package com.funbuilder.controller.commands {
	
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.OBJParser;
	
	import com.funbuilder.model.BlocksModel;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.vo.BlockVO;
	import com.funrun.services.JsonService;
	import com.funrun.services.parsers.BlocksParser;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class LoadBlocksCommand extends AsyncCommand {
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Private vars.
		
		private var _loader:URLLoader;
		private var _filePath:String = "blocks/";
		private var _countTotal:int;
		private var _countLoaded:int = 0;
		
		override public function execute():void {
			_loader = new URLLoader( new URLRequest( 'data/blocks.json' ) );
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onLoadComplete( e:Event ):void {
			var data:String = ( e.target as URLLoader ).data;
			// Parse object to give it meaning.
			var parsedBlocks:BlocksParser = new BlocksParser( new JsonService().readString( data ) );
			
			// Store a count so we know when we're done loading the block objs.
			var len:int = parsedBlocks.length;
			_countTotal = len * 2; // Assume one mtl and obj pair per block.
			if ( len == 0 ) {
				dispatchComplete( true );
			} else {
				// Set up loading context.
				var context:AssetLoaderContext = new AssetLoaderContext( true, _filePath );
				
				// Load the block objs.
				var blockData:BlockVO;
				for ( var i:int = 0; i < len; i++ ) {
					blockData = parsedBlocks.getAt( i );
					// Store in model.
					blocksModel.addBlock( blockData );
					// Load it.
					var token:AssetLoaderToken = AssetLibrary.load( new URLRequest( _filePath + blockData.filename ), context, blockData.id, new OBJParser() );
					token.addEventListener( AssetEvent.ASSET_COMPLETE, getOnAssetComplete( blockData ) );
				}
			}
		}
		
		/**
		 * Listener function for asset complete event on loader
		 */
		private function getOnAssetComplete( blockData:BlockVO ):Function {
			var completeCallback:Function = this.dispatchComplete;
			return function( event:AssetEvent ):void {
				if ( event.asset.assetType == AssetType.MESH ) {
					// Treat and assign mesh to block.
					var mesh:Mesh = event.asset as Mesh;
					mesh.geometry.scale( TrackConstants.BLOCK_SIZE ); // Note: scale cannot be performed on mesh when using sub-surface diffuse method.
					mesh.y = -50;
					mesh.rotationY = 180;
					blockData.mesh = mesh;
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
