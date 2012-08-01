package com.funbuilder.view.mediators {
	
	import away3d.containers.View3D;
	
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.KeyDownRequest;
	import com.funbuilder.controller.signals.KeyUpRequest;
	import com.funbuilder.controller.signals.MouseDownRequest;
	import com.funbuilder.controller.signals.MouseMoveRequest;
	import com.funbuilder.controller.signals.MouseUpRequest;
	import com.funbuilder.controller.signals.RightMouseDownRequest;
	import com.funbuilder.controller.signals.RightMouseUpRequest;
	import com.funbuilder.controller.signals.ScrollWheelRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.controller.signals.StageClickRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.view.components.MainView;
	
	import flash.events.KeyboardEvent;
	
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
		public var keyDownRequest:KeyDownRequest;
		
		[Inject]
		public var keyUpRequest:KeyUpRequest;
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var stageClickRequest:StageClickRequest;
		
		[Inject]
		public var scrollWheelRequest:ScrollWheelRequest;
		
		[Inject]
		public var mouseDownRequest:MouseDownRequest;
		
		[Inject]
		public var mouseUpRequest:MouseUpRequest;
		
		[Inject]
		public var rightMouseDownRequest:RightMouseDownRequest;
		
		[Inject]
		public var rightMouseUpRequest:RightMouseUpRequest;
		
		[Inject]
		public var mouseMoveRequest:MouseMoveRequest;
		
		override public function onRegister():void {
			// Add view listeners.
			view.onKeyDownSignal.add( onKeyDown );
			view.onKeyUpSignal.add( onKeyUp );
			view.onScrollWheelSignal.add( onScrollWheel );
			view.onStageClickSignal.add( onStageClick );
			view.onMouseDownSignal.add( onMouseDown );
			view.onMouseUpSignal.add( onMouseUp );
			view.onRightMouseDownSignal.add( onRightMouseDown );
			view.onRightMouseUpSignal.add( onRightMouseUp );
			view.onMouseMoveSignal.add( onMouseMove );
			addView3DRequest.add( onAddView3DRequested );
			showStatsRequest.add( onShowStatsRequested );
			setEditingModeRequest.add( onSetEditingModeRequested );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			keyDownRequest.dispatch( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			keyUpRequest.dispatch( e );
		}
		
		private function onScrollWheel( delta:int ):void {
			scrollWheelRequest.dispatch( delta );
		}
		
		private function onStageClick():void {
			stageClickRequest.dispatch();
		}
		
		private function onMouseDown():void {
			mouseDownRequest.dispatch();
		}
		
		private function onMouseUp():void {
			mouseUpRequest.dispatch();
		}
		
		private function onRightMouseDown():void {
			rightMouseDownRequest.dispatch();
		}
		
		private function onRightMouseUp():void {
			rightMouseUpRequest.dispatch();
		}
		
		private function onMouseMove():void {
			mouseMoveRequest.dispatch();
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		private function onShowStatsRequested( showStats:Boolean ):void {
			this.view.debug( showStats );
		}
		
		private function onSetEditingModeRequested( mode:String ):void {
			if ( mode == EditingModeModel.LOOK ) {
				this.view.showLibrary( false );
			} else if ( mode == EditingModeModel.BUILD ) {
				this.view.showLibrary( true );
			}
		}
	}
}
