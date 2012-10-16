package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	import com.funrun.controller.commands.LoadBlockStylesCommand;
	import com.funrun.controller.commands.LoadBlockTypesCommand;
	
	public class InitAppCommand extends SequenceCommand
	{
		public function InitAppCommand()
		{
			addCommand( LoadBlockTypesCommand );
			addCommand( LoadBlockStylesCommand );
			addCommand( BuildViewCommand );
			addCommand( BuildLibraryCommand );
			addCommand( InitViewCommand );
		}
	}
}