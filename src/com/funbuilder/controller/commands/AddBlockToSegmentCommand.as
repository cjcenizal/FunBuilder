package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.CurrentSegmentModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddBlockToSegmentCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var currentSegmentModel:CurrentSegmentModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void
		{
			currentSegmentModel.add( block );
			block.mouseEnabled = true;
			block.addEventListener( MouseEvent3D.CLICK, onClick );
			addObjectToSceneRequest.dispatch( block );
		}
		
		
		private function onClick( e:MouseEvent3D ):void {
			trace("click " + currentSegmentModel.getAtPos( e.object.position ));
		}
	}
}