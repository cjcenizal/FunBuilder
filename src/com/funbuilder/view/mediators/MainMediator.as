package com.funbuilder.view.mediators {
	
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddCameraTargetRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.view.components.MainView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MainView;
		
		// Commands.
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		[Inject]
		public var addCameraTargetRequest:AddCameraTargetRequest;
		
		override public function onRegister():void {
			addCameraTargetRequest.add( onAddCameraTargetRequested );
			addView3DRequest.add( onAddView3DRequested );
			showStatsRequest.add( onShowStatsRequested );
		}
		
		private function onAddCameraTargetRequested( target:Mesh ):void {
			this.view.target = target;
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		private function onShowStatsRequested( showStats:Boolean ):void {
			this.view.debug( showStats );
		}
	}
}
