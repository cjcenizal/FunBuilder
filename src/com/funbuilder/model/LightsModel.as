package com.funbuilder.model
{
	import away3d.lights.LightBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FresnelSpecularMethod;
	
	import org.robotlegs.mvcs.Actor;
	
	public class LightsModel extends Actor
	{
		
		public var light:LightBase;
		public var lightPicker:StaticLightPicker;
		public var specularMethod:FresnelSpecularMethod;
		
		public function LightsModel()
		{
			super();
		}
	}
}