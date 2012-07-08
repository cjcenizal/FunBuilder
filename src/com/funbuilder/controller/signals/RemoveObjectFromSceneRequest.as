package com.funbuilder.controller.signals {
	
	import org.osflash.signals.Signal;
	import away3d.containers.ObjectContainer3D;
	
	public class RemoveObjectFromSceneRequest extends Signal {
		
		public function RemoveObjectFromSceneRequest() {
			super( ObjectContainer3D );
		}
	}
}
