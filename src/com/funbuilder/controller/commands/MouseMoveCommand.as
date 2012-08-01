package com.funbuilder.controller.commands
{
	import com.funbuilder.model.MouseModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseMoveCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		override public function execute():void {
			mouseModel.moveMouse( contextView.stage.mouseX, contextView.stage.mouseY );
		}
	}
}