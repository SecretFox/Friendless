import com.GameInterface.Game.CharacterBase;
import com.Utils.ID32;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.Friendless.Mod {

	public static function main(swfRoot:MovieClip):Void {
		var s_app = new Mod(swfRoot);
		swfRoot.onLoad = function(){s_app.Load()}
		swfRoot.onUnload = function(){s_app.Unload()}
	}

	public function Mod(root) { 
		
	}
	
	public function Load() {
		if(_root.friendlymenu.SlotShowFriendlyMenu){
			com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(_root.friendlymenu.SlotShowFriendlyMenu, _root.friendlymenu);
			com.Utils.GlobalSignal.SignalShowFriendlyMenu.Connect(SlotShowFriendlyMenu, this);
		}else{
			setTimeout(Delegate.create(this, Load), 50);
		}
	}
	
	private function SlotShowFriendlyMenu(charID:ID32, name:String, showAtMouse ){
		//Right click,proceed as normal
		if (showAtMouse){
			_root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
		//F press,with Ctrl down,proceed as normal
		}else if (Key.isDown(Key.CONTROL)){
			_root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
		//F press,with Ctrl up, not calling the original function
		}else{
			//it still sets player to alt mode, setting player back to reticule mode after 1ms,which seems to be enough
			setTimeout(
			Delegate.create(this, function(){
			CharacterBase.SetReticuleMode();
			}), 1);
		}
	}

	public function Unload() {
		com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(SlotShowFriendlyMenu, this);
	}
}