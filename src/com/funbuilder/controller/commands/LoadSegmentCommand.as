package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.adobe.serialization.json.JSON;
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.vo.AddBlockVO;
	
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
			clearSegmentRequest.dispatch();
			
			var list:Array = com.adobe.serialization.json.JSON.decode( json );
			var len:int = list.length;
			var dataItem:Object;
			var refMesh:Mesh;
			var mesh:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				dataItem = list[ i ];
				refMesh = blocksModel.getBlock( dataItem.id ).mesh
				mesh = refMesh.clone() as Mesh;
				mesh.x = dataItem.x * 100;
				mesh.y = dataItem.y * 100;
				mesh.z = dataItem.z * 100;
				addBlockRequest.dispatch( new AddBlockVO( mesh, refMesh.assetNamespace ) );
			}
		}
	}
}