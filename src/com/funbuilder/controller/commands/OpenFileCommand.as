package com.funbuilder.controller.commands {

	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	
	import com.adobe.serialization.json.JSON;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.FileModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenFileCommand extends Command {

		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		// Private vars.
		
		private var _file:File;
		
		override public function execute():void {
			_file = new File();
			_file.addEventListener( Event.SELECT, onSelectFileToOpen );
			_file.browseForOpen( "Select a Segment JSON file to open" );
		}
		
		private function onSelectFileToOpen( e:Event ):void {
			_file.removeEventListener( Event.SELECT, onSelectFileToOpen );
			fileModel.file = File( e.currentTarget );
			fileModel.file.addEventListener( Event.COMPLETE, onLoadComplete );
			fileModel.file.load();
		}
		
		private function onLoadComplete( e:Event ):void {
			fileModel.file.removeEventListener( Event.COMPLETE, onLoadComplete );
			loadSegment( String( fileModel.file.data ) );
		}
		
		private function loadSegment( json:String ):void {
			
			// Add lights to scene and apply lightpicker to materials.
			// Use correct blocks.
			// Add floor grid.
			// Refine camera control.
			// Add block selection.
			
			// Parse the JSON data.
			// Add blocks to the CurrentSegmentModel.
			// Add them to the view.
			var list:Array = com.adobe.serialization.json.JSON.decode( json );
			var len:int = list.length;
			var dataItem:Object;
			for ( var i:int = 0; i < len; i++ ) {
				dataItem = list[ i ];
				var block:CubeGeometry = new CubeGeometry();
				var mesh:Mesh = new Mesh( block, new ColorMaterial( 0x00ff00 ) );
				mesh.x = dataItem.x * 100;
				mesh.y = dataItem.y * 100;
				mesh.z = dataItem.z * 100;
				addObjectToSceneRequest.dispatch( mesh );
			}
		}
	}
}
