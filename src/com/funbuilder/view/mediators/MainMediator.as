package com.funbuilder.view.mediators {
	
	import away3d.containers.View3D;
	
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.DrawHandlesRequest;
	import com.funbuilder.controller.signals.GrabHandleRequest;
	import com.funbuilder.controller.signals.HideHandlesRequest;
	import com.funbuilder.controller.signals.KeyDownRequest;
	import com.funbuilder.controller.signals.KeyUpRequest;
	import com.funbuilder.controller.signals.MouseDownRequest;
	import com.funbuilder.controller.signals.MouseMoveRequest;
	import com.funbuilder.controller.signals.MouseUpRequest;
	import com.funbuilder.controller.signals.RightMouseDownRequest;
	import com.funbuilder.controller.signals.RightMouseUpRequest;
	import com.funbuilder.controller.signals.ScrollWheelRequest;
	import com.funbuilder.controller.signals.StageClickRequest;
	import com.funbuilder.view.components.MainView;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MainView;
		
		// Commands.
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var keyDownRequest:KeyDownRequest;
		
		[Inject]
		public var keyUpRequest:KeyUpRequest;
		
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
		
		[Inject]
		public var hideHandlesRequest:HideHandlesRequest;
		
		[Inject]
		public var drawHandlesRequest:DrawHandlesRequest;
		
		[Inject]
		public var grabHandleRequest:GrabHandleRequest;
		
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
			view.onHandleMouseDownSignal.add( onHandleMouseDown );
			addView3DRequest.add( onAddView3DRequested );
			hideHandlesRequest.add( onHideHandlesRequested );
			drawHandlesRequest.add( onDrawHandlesRequested );
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
		
		private function onHandleMouseDown( axis:String ):void {
			grabHandleRequest.dispatch( axis );
		}
		
		private function onAddView3DRequested( view3D:View3D ):void {
			this.view.view3D = view3D;
		}
		
		private function showLibrary( show:Boolean ):void {
			this.view.showLibrary( show );
		}
		
		private function onHideHandlesRequested():void {
			this.view.hideHandles();
		}
		
		private function onDrawHandlesRequested( originX:Point, arrowX:Point, colorX:uint,
											   originY:Point, arrowY:Point, colorY:uint, 
											   originZ:Point, arrowZ:Point, colorZ:uint ):void {
			this.view.drawHandles(
				originX, arrowX, colorX,
				originY, arrowY, colorY,
				originZ, arrowZ, colorZ );
		}
	}
}
