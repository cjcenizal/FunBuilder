package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.CurrentSegmentModel;
	import com.funbuilder.model.EditingModeModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var currentSegmentModel:CurrentSegmentModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void
		{
			currentSegmentModel.add( block );
			block.mouseEnabled = true;
			block.addEventListener( MouseEvent3D.CLICK, onClick );
			addObjectToSceneRequest.dispatch( block );
		}
		
		private function onClick( e:MouseEvent3D ):void {
			if ( editingModeModel.mode == EditingModeModel.BUILD ) {
				selectBlockRequest.dispatch( e.object as Mesh );
			}
		}
	}
}