package com.open
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;



	public class FBSSO extends EventDispatcher
	{
		public var extContext:ExtensionContext;
		
		public function FBSSO()
		{
			extContext = ExtensionContext.createExtensionContext("com.open.FBSSONE","type");
			extContext.addEventListener(StatusEvent.STATUS,eventMethod);

		}
		
		public function eventMethod(event:StatusEvent):void
		{
			if((event.level == "status") && (event.code == "validLogin")) 
				dispatchEvent(new StatusEvent("validLogin",false,false,event.code,event.level));
			else if((event.level == "status") && (event.code == "invalidLogin")) 
				dispatchEvent(new StatusEvent("invalidLogin",false,false,event.code,event.level));
			
		}

		
		public function initSSO(): void
		{
			extContext.call("initSSO") ;
		}
		
		
		
		public function disposeNative():void
		{
			extContext.dispose();	
		}
	}
}