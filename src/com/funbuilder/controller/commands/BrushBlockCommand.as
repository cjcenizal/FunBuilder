package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.vo.AddBlockVO;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class BrushBlockCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void
		{
			if ( brushModel.preview && keysModel.contains( Keyboard.SPACE ) ) {
				addHistoryRequest.dispatch( false );
				// Add block.
				var block:Mesh = brushModel.preview.clone() as Mesh;
				block.scaleX = block.scaleY = block.scaleZ = 1;
				addBlockRequest.dispatch( new AddBlockVO( block ) );
				invalidateSavedFileRequest.dispatch();
			}
		}
	}
}