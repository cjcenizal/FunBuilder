package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.model.constants.Grid;
	import com.funbuilder.model.vo.AddBlockVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.constants.Block;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadSegmentCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var json:String;
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
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
			var list:Array = JSON.parse( json ) as Array;
			var len:int = list.length;
			var dataItem:Object;
			var mesh:Mesh;
			for ( var i:int = 0; i < len; i++ ) {
				dataItem = list[ i ];
				mesh = blockStylesModel.getMeshCloneForBlock( dataItem.id.type );
				mesh.x = dataItem.x * Block.SIZE;
				mesh.y = dataItem.y * Block.SIZE;
				mesh.z = dataItem.z * Block.SIZE;
				addBlockRequest.dispatch( new AddBlockVo( mesh, dataItem.key ) );
			}
		}
	}
}