package com.funbuilder.view.mediators {
	
	import away3d.containers.View3D;
	
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
		
		override public function onRegister():void {
			addView3DRequest.add( onAddView3DRequested );
			showStatsRequest.add( onShowStatsRequested );
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		private function onShowStatsRequested( showStats:Boolean ):void {
			this.view.debug( showStats );
		}
	}
}
