import com.GameInterface.Game.CharacterBase;
import com.GameInterface.UtilsBase;
import com.Utils.ID32;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.Friendless.Mod {

	private var SWLRP:MovieClip;
	
	public static function main(swfRoot:MovieClip):Void {
		var s_app = new Mod(swfRoot);
		swfRoot.onLoad = function() {
			s_app.Load();
		}
		swfRoot.onUnload = function() {
			s_app.Unload();
		}
	}

	public function Mod() {
	}

	public function Load() {
		SWLRP = _root["swlrp\\swlrp"];
		com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(_root.friendlymenu.SlotShowFriendlyMenu);
		com.Utils.GlobalSignal.SignalShowFriendlyMenu.Connect(SlotShowFriendlyMenu, this);
	}
	
	private function SlotShowFriendlyMenu(charID:ID32, name:String, showAtMouse ) {
		//Right click,proceed as normal
		if (showAtMouse) {
			if (!SWLRP){
				_root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
			}
		//F press,with Ctrl down,proceed as normalaw
		} else if (Key.isDown(Key.CONTROL)) {
			if (!SWLRP){
				_root.friendlymenu.SlotShowFriendlyMenu(charID, name, showAtMouse);
			}
		//F press,with Ctrl up, not calling the original function
		} else {
			//Setting player back to reticule mode after 1ms, the delay seems necessary
			//SWLRP users will still open friendlymenu, it just closes instantly
			setTimeout(
			Delegate.create(this, function() {
				CharacterBase.SetReticuleMode();
			}), 1);
		}
	}

	public function Unload() {
		com.Utils.GlobalSignal.SignalShowFriendlyMenu.Disconnect(SlotShowFriendlyMenu, this);
	}
}