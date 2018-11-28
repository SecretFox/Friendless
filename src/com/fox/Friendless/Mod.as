import com.GameInterface.Game.CharacterBase;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.Friendless.Mod {

	private var SWLRP:MovieClip;

	public static function main(swfRoot:MovieClip):Void {
		var s_app = new Mod(swfRoot);
		swfRoot.onLoad = function() {s_app.Load();}
		swfRoot.onUnload = function() {s_app.Unload();}
	}

	public function Mod() {
	}

	public function Load() {
		if (_root.friendlymenu.SlotShowFriendlyMenu){
			SWLRP = _root["swlrp\\swlrp"];
			com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(_root.friendlymenu.SlotShowFriendlyMenu);
			com.Utils.GlobalSignal.SignalShowFriendlyMenu.Connect(SlotShowFriendlyMenu, this);
		}else{
			setTimeout(Delegate.create(this, Load), 50);
		}
	}

	private function SlotShowFriendlyMenu(charID, name, showAtMouse ) {
		//always right click?
		//proceed as normal
		if (showAtMouse) {
			if (!SWLRP) _root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
		} 
		//Interaction key with Ctrl down
		else if (Key.isDown(Key.CONTROL)) {
			if (!SWLRP)	_root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
		} 
		//Interaction key with CTRL up, not calling the original function
		//SWLRP users will still open friendlymenu, it just closes instantly
		else {
			//Setting player back to reticule mode after 1ms, the delay seems necessary
			setTimeout(	Delegate.create(this, function() {
				CharacterBase.SetReticuleMode();
			}), 1);
		}
	}

	public function Unload() {
		com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(SlotShowFriendlyMenu, this);
	}
}