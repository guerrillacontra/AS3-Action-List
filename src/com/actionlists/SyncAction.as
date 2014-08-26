package com.actionlists {
	import com.actionlists.Action;
	
	/**
	 * A special type of "utility" action that will
	 * block all actions AFTER this action within an action-list,
	 * until all previous actions before it have been finished.
	 * 
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public final class SyncAction extends Action 
	{
		
		public function SyncAction() 
		{
			super(0, 0xffffffff);
		}
		
		override protected function onUpdated():Boolean 
		{
			if (this != _parent._head)
			{
				isBlocking = true;
				return false;
			}
			
			isBlocking = false;
			
			return true;
		}
		
	}

}