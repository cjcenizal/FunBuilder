package com.funbuilder.controller.commands {
	
	import away3d.containers.ObjectContainer3D;
	
	import com.funbuilder.model.View3dModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddObjectToSceneCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var object:ObjectContainer3D;
		
		// Models.
		
		[Inject]
		public var view3DModel:View3dModel;
		
		override public function execute():void {
			view3DModel.addToScene( object );
		}
	}
}
