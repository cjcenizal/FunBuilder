package com.funbuilder.controller.commands
{
	import com.funbuilder.model.MouseModel;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class RightMouseDownCommand extends Command
	{
		[Inject]
		public var mouseModel:MouseModel;
		
		override public function execute():void {
			mouseModel.setRightMouseDown( contextView.stage.mouseX, contextView.stage.mouseY );
		}
	}
}