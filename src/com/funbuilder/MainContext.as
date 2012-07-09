package com.funbuilder
{
	import com.funbuilder.controller.commands.AddBlockCommand;
	import com.funbuilder.controller.commands.AddBlockFromLibraryCommand;
	import com.funbuilder.controller.commands.AddHistoryCommand;
	import com.funbuilder.controller.commands.AddObjectToSceneCommand;
	import com.funbuilder.controller.commands.ChangeBlockTypeCommand;
	import com.funbuilder.controller.commands.ClearHistoryCommand;
	import com.funbuilder.controller.commands.ClearSegmentCommand;
	import com.funbuilder.controller.commands.DeleteBlockCommand;
	import com.funbuilder.controller.commands.DeselectBlockCommand;
	import com.funbuilder.controller.commands.InitAppCommand;
	import com.funbuilder.controller.commands.InvalidateSavedFileCommand;
	import com.funbuilder.controller.commands.KeyDownCommand;
	import com.funbuilder.controller.commands.KeyUpCommand;
	import com.funbuilder.controller.commands.LoadSegmentCommand;
	import com.funbuilder.controller.commands.MoveBlockCommand;
	import com.funbuilder.controller.commands.NewFileCommand;
	import com.funbuilder.controller.commands.OpenFileCommand;
	import com.funbuilder.controller.commands.RedoEditCommand;
	import com.funbuilder.controller.commands.RemoveBlockCommand;
	import com.funbuilder.controller.commands.RemoveObjectFromSceneCommand;
	import com.funbuilder.controller.commands.SaveFileCommand;
	import com.funbuilder.controller.commands.SelectBlockCommand;
	import com.funbuilder.controller.commands.SetEditingModeCommand;
	import com.funbuilder.controller.commands.UndoEditCommand;
	import com.funbuilder.controller.commands.UpdateTargetAppearanceCommand;
	import com.funbuilder.controller.signals.AddBlockFromLibraryRequest;
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddCameraTargetRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.KeyDownRequest;
	import com.funbuilder.controller.signals.KeyUpRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.RedoEditRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.controller.signals.ShowSelectionIndicatorRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.controller.signals.UndoEditRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.view.components.LibraryView;
	import com.funbuilder.view.components.MainView;
	import com.funbuilder.view.components.MenuBarView;
	import com.funbuilder.view.mediators.AppMediator;
	import com.funbuilder.view.mediators.LibraryMediator;
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
			injector.mapSingleton( EditingModeModel );
			injector.mapSingleton( FileModel );
			injector.mapSingleton( HistoryModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( SegmentModel );
			injector.mapSingleton( SelectedBlockModel );
			injector.mapSingleton( View3DModel );
			
			// Map services.
			//injector.mapSingleton( MatchmakingService );
			
			// Map signals.
			injector.mapSingleton( AddCameraTargetRequest );
			injector.mapSingleton( AddItemToLibraryRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( ShowFileNameRequest );
			injector.mapSingleton( ShowSelectionIndicatorRequest );
			injector.mapSingleton( ShowStatsRequest );
			signalCommandMap.mapSignalClass( AddBlockRequest,						AddBlockCommand );
			signalCommandMap.mapSignalClass( AddBlockFromLibraryRequest,			AddBlockFromLibraryCommand );
			signalCommandMap.mapSignalClass( AddHistoryRequest,						AddHistoryCommand );
			signalCommandMap.mapSignalClass( AddObjectToSceneRequest,				AddObjectToSceneCommand );
			signalCommandMap.mapSignalClass( ChangeBlockTypeRequest,				ChangeBlockTypeCommand );
			signalCommandMap.mapSignalClass( ClearHistoryRequest,					ClearHistoryCommand );
			signalCommandMap.mapSignalClass( ClearSegmentRequest,					ClearSegmentCommand );
			signalCommandMap.mapSignalClass( DeselectBlockRequest,					DeselectBlockCommand );
			signalCommandMap.mapSignalClass( DeleteBlockRequest,					DeleteBlockCommand );
			signalCommandMap.mapSignalClass( InvalidateSavedFileRequest,			InvalidateSavedFileCommand );
			signalCommandMap.mapSignalClass( KeyDownRequest,						KeyDownCommand );
			signalCommandMap.mapSignalClass( KeyUpRequest,							KeyUpCommand );
			signalCommandMap.mapSignalClass( LoadSegmentRequest,					LoadSegmentCommand );
			signalCommandMap.mapSignalClass( MoveBlockRequest,						MoveBlockCommand );
			signalCommandMap.mapSignalClass( NewFileRequest,						NewFileCommand );
			signalCommandMap.mapSignalClass( OpenFileRequest,						OpenFileCommand );
			signalCommandMap.mapSignalClass( RedoEditRequest,						RedoEditCommand );
			signalCommandMap.mapSignalClass( RemoveBlockRequest,					RemoveBlockCommand );
			signalCommandMap.mapSignalClass( RemoveObjectFromSceneRequest,			RemoveObjectFromSceneCommand );
			signalCommandMap.mapSignalClass( SaveFileRequest,						SaveFileCommand );
			signalCommandMap.mapSignalClass( SelectBlockRequest,					SelectBlockCommand );
			signalCommandMap.mapSignalClass( SetEditingModeRequest,					SetEditingModeCommand );
			signalCommandMap.mapSignalClass( UndoEditRequest,						UndoEditCommand );
			signalCommandMap.mapSignalClass( UpdateTargetAppearanceRequest,			UpdateTargetAppearanceCommand );
			
			// Map views to mediators.
			mediatorMap.mapView( LibraryView, 					LibraryMediator );
			mediatorMap.mapView( MainView, 						MainMediator );
			mediatorMap.mapView( MenuBarView,					MenuBarMediator );
			
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
