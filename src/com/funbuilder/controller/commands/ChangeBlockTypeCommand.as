package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeBlockTypeCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var changeBlockTypeData:ChangeBlockTypeVO;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		override public function execute():void
		{
			if ( selectedBlockModel.hasBlock() ) {
				var block:Mesh = selectedBlockModel.getBlock();
				block = blocksModel.getBlock( "002" ).mesh.clone() as Mesh;
			}
		}
	}
}