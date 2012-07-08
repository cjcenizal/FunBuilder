package com.funbuilder
{
	import com.funbuilder.controller.commands.AddBlockToSegmentCommand;
	import com.funbuilder.controller.commands.AddObjectToSceneCommand;
	import com.funbuilder.controller.commands.CurrentBlockModel;
	import com.funbuilder.controller.commands.DeselectBlockCommand;
	import com.funbuilder.controller.commands.InitAppCommand;
	import com.funbuilder.controller.commands.NewFileCommand;
	import com.funbuilder.controller.commands.OpenFileCommand;
	import com.funbuilder.controller.commands.PressKeyCommand;
	import com.funbuilder.controller.commands.RedoEditCommand;
	import com.funbuilder.controller.commands.SaveFileCommand;
	import com.funbuilder.controller.commands.SelectBlockCommand;
	import com.funbuilder.controller.commands.UndoEditCommand;
	import com.funbuilder.controller.commands.UpdateTargetAppearanceCommand;
	import com.funbuilder.controller.signals.AddBlockToSegmentRequest;
	import com.funbuilder.controller.signals.AddCameraTargetRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.PressKeyRequest;
	import com.funbuilder.controller.signals.PressKeyToLookRequest;
	import com.funbuilder.controller.signals.RedoEditRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.controller.signals.UndoEditRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.CurrentSegmentModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3DModel;
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
			injector.mapSingleton( BlocksModel );
			injector.mapSingleton( CameraTargetModel );
			injector.mapSingleton( CurrentBlockModel );
			injector.mapSingleton( CurrentSegmentModel );
			injector.mapSingleton( EditingModeModel );
			injector.mapSingleton( FileModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( View3DModel );
			
			// Map services.
			//injector.mapSingleton( MatchmakingService );
			
			// Map signals.
			injector.mapSingleton( AddCameraTargetRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( PressKeyToLookRequest );
			injector.mapSingleton( SetEditingModeRequest );
			injector.mapSingleton( ShowStatsRequest );
			signalCommandMap.mapSignalClass( AddBlockToSegmentRequest,				AddBlockToSegmentCommand );
			signalCommandMap.mapSignalClass( AddObjectToSceneRequest,				AddObjectToSceneCommand );
			signalCommandMap.mapSignalClass( DeselectBlockRequest,					DeselectBlockCommand );
			signalCommandMap.mapSignalClass( NewFileRequest,						NewFileCommand );
			signalCommandMap.mapSignalClass( OpenFileRequest,						OpenFileCommand );
			signalCommandMap.mapSignalClass( PressKeyRequest,						PressKeyCommand );
			signalCommandMap.mapSignalClass( RedoEditRequest,						RedoEditCommand );
			signalCommandMap.mapSignalClass( SaveFileRequest,						SaveFileCommand );
			signalCommandMap.mapSignalClass( SelectBlockRequest,					SelectBlockCommand );
			signalCommandMap.mapSignalClass( UndoEditRequest,						UndoEditCommand );
			signalCommandMap.mapSignalClass( UpdateTargetAppearanceRequest,			UpdateTargetAppearanceCommand );
			
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
			commandMap.execute( InitAppCommand );
		}
	}
}
