package com.funbuilder.controller.commands {

	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	
	import com.adobe.serialization.json.JSON;
	import com.funbuilder.controller.signals.AddBlockToSegmentRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.FileModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenFileCommand extends Command {

		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Commands.
		
		[Inject]
		public var addBlockToSegmentRequest:AddBlockToSegmentRequest;
		
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
			var list:Array = com.adobe.serialization.json.JSON.decode( json );
			var len:int = list.length;
			var dataItem:Object;
			var mesh:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				dataItem = list[ i ];
				mesh = blocksModel.getBlock( dataItem.id ).mesh.clone() as Mesh;
				mesh.x = dataItem.x * 100;
				mesh.y = dataItem.y * 100;
				mesh.z = dataItem.z * 100;
				addBlockToSegmentRequest.dispatch( mesh );
			}
		}
	}
}
