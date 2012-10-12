package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.adobe.serialization.json.JSON;
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funrun.model.BlocksModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.AddBlockVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadSegmentCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var json:String;
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Commands.
		
		[Inject]
		public var clearSegmentRequest:ClearSegmentRequest;
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void
		{
			
			// Clear old stuff.
			clearSegmentRequest.dispatch();
			
			// Add new stuff.
			var list:Array = com.adobe.serialization.json.JSON.decode( json );
			var len:int = list.length;
			var dataItem:Object;
			var refMesh:Mesh;
			var mesh:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				dataItem = list[ i ];
				refMesh = blocksModel.getWithId( dataItem.id ).mesh;
				mesh = refMesh.clone() as Mesh;
				mesh.x = dataItem.x * SegmentConstants.BLOCK_SIZE;
				mesh.y = dataItem.y * SegmentConstants.BLOCK_SIZE;
				mesh.z = dataItem.z * SegmentConstants.BLOCK_SIZE;
				addBlockRequest.dispatch( new AddBlockVo( mesh, dataItem.key ) );
			}
		}
	}
}