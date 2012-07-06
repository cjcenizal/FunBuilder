package com.funbuilder
{
	import com.funbuilder.controller.commands.NewFileCommand;
	import com.funbuilder.controller.commands.OpenFileCommand;
	import com.funbuilder.controller.commands.SaveFileCommand;
	import com.funbuilder.controller.commands.UndoEditCommand;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.UndoEditRequest;
	import com.funbuilder.view.components.MainView;
	import com.funbuilder.view.components.MenuBarView;
	import com.funbuilder.view.mediators.AppMediator;
	import com.funbuilder.view.mediators.MainMediator;
	import com.funbuilder.view.mediators.MenuBarMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.SignalContext;
	
	public class MainContext extends SignalContext {
		
		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}
		
		override public function startup():void {
			
			// Map models.
			//injector.mapSingleton( BlocksModel );
			
			// Map services.
			//injector.mapSingleton( MatchmakingService );
			
			// Map signals.
			//injector.mapSingleton( AddNametagRequest );
			signalCommandMap.mapSignalClass( NewFileRequest,				NewFileCommand );
			signalCommandMap.mapSignalClass( OpenFileRequest,				OpenFileCommand );
			signalCommandMap.mapSignalClass( SaveFileRequest,				SaveFileCommand );
			signalCommandMap.mapSignalClass( UndoEditRequest,				UndoEditCommand );
			
			// Map views to mediators.
			mediatorMap.mapView( MenuBarView,					MenuBarMediator );
			mediatorMap.mapView( MainView, 						MainMediator );
			
			// Do this last, since it causes our entire view system to be built.
			mediatorMap.mapView( FunBuilder, 					AppMediator );
			
			// Kick everything off one frame later.
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			super.startup();
		}
		
		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			//commandMap.execute( InitAppCommand );
		}
	}
}
