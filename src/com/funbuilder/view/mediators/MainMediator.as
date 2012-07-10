package com.funbuilder.view.mediators {
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	
	import com.funbuilder.controller.signals.AddCameraControllerRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.KeyDownRequest;
	import com.funbuilder.controller.signals.KeyUpRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.model.EditingModeModel;
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
		public var addCameraControllerRequest:AddCameraControllerRequest;
		
		[Inject]
		public var keyDownRequest:KeyDownRequest;
		
		[Inject]
		public var keyUpRequest:KeyUpRequest;
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		override public function onRegister():void {
			this.view.onKeyDownSignal.add( onKeyDown );
			this.view.onKeyUpSignal.add( onKeyUp );
			this.view.onScrollWheelSignal.add( onScrollWheel );
			addView3DRequest.add( onAddView3DRequested );
			addCameraControllerRequest.add( onAddCameraControllerRequested );
			showStatsRequest.add( onShowStatsRequested );
			setEditingModeRequest.add( onSetEditingModeRequested );
		}
		
		private function onKeyDown( code:int ):void {
			keyDownRequest.dispatch( code );
		}
		
		private function onKeyUp( code:int ):void {
			keyUpRequest.dispatch( code );
		}
		
		private function onScrollWheel( delta:int ):void {
			
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		private function onAddCameraControllerRequested( controller:HoverController ):void {
			this.view.cameraController = controller;
		}
		
		private function onShowStatsRequested( showStats:Boolean ):void {
			this.view.debug( showStats );
		}
		
		private function onSetEditingModeRequested( mode:String ):void {
			if ( mode == EditingModeModel.LOOK ) {
				this.view.enableCameraControl( true );
				this.view.showLibrary( false );
			} else if ( mode == EditingModeModel.BUILD ) {
				this.view.enableCameraControl( false );
				this.view.showLibrary( true );
			}
		}
	}
}
