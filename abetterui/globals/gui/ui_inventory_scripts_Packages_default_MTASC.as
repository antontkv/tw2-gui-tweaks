class mh2lib.utils.MH2Key
{
   static var BACKSPACE = 8;
   static var TAB = 9;
   static var ENTER = 13;
   static var SHIFT = 16;
   static var CONTROL_L = 162;
   static var CONTROL_R = 163;
   static var ALT = 18;
   static var CAPSLOCK = 20;
   static var ESC = 27;
   static var SPACE = 32;
   static var PGUP = 33;
   static var PGDN = 34;
   static var END = 35;
   static var HOME = 36;
   static var INSERT = 45;
   static var DELETEKEY = 46;
   static var ARROW_LEFT = 37;
   static var ARROW_UP = 38;
   static var ARROW_RIGHT = 39;
   static var ARROW_DOWN = 40;
   static var ARROW_LEFT_SMOOTH = 1037;
   static var ARROW_UP_SMOOTH = 1038;
   static var ARROW_RIGHT_SMOOTH = 1039;
   static var ARROW_DOWN_SMOOTH = 1040;
   static var A = 65;
   static var B = 66;
   static var C = 67;
   static var D = 68;
   static var E = 69;
   static var F = 70;
   static var G = 71;
   static var H = 72;
   static var I = 73;
   static var J = 74;
   static var K = 75;
   static var L = 76;
   static var M = 77;
   static var N = 78;
   static var O = 79;
   static var P = 80;
   static var Q = 81;
   static var R = 82;
   static var S = 83;
   static var T = 84;
   static var U = 85;
   static var V = 86;
   static var W = 87;
   static var X = 88;
   static var Y = 89;
   static var Z = 90;
   static var PAD_A_CROSS = 136;
   static var PAD_B_CIRCLE = 137;
   static var PAD_X_SQUARE = 138;
   static var PAD_Y_TRIANGLE = 139;
   static var PAD_START = 140;
   static var PAD_BACK_SELECT = 141;
   static var PAD_DIGIT_UP = 142;
   static var PAD_DIGIT_DN = 143;
   static var PAD_DIGIT_LEFT = 144;
   static var PAD_DIGIT_RIGHT = 145;
   static var PAD_L3 = 146;
   static var PAD_R3 = 147;
   static var PAD_LB = 148;
   static var PAD_RB = 149;
   static var PAD_LT = 150;
   static var PAD_RT = 151;
   static var PAD_L_AXIS_X = 152;
   static var PAD_L_AXIS_Y = 153;
   static var PAD_R_AXIS_X = 154;
   static var PAD_R_AXIS_Y = 155;
   static var PAD_R_STICK_UP = 201;
   static var PAD_R_STICK_DN = 202;
   static var PAD_R_STICK_LEFT = 203;
   static var PAD_R_STICK_RIGHT = 204;
   function MH2Key()
   {
   }
}
class com.greensock.plugins.TweenPlugin
{
   var _tweens;
   var _changeFactor;
   var propName;
   var round;
   var overwriteProps;
   static var VERSION = 1.3;
   static var API = 1;
   var priority = 0;
   function TweenPlugin()
   {
      this._tweens = [];
      this._changeFactor = 0;
   }
   function onInitTween(target, value, tween)
   {
      this.addTween(target,this.propName,target[this.propName],value,this.propName);
      return true;
   }
   function addTween(object, propName, start, end, overwriteProp)
   {
      if(end != undefined)
      {
         var _loc7_ = typeof end != "number" ? Number(end) : Number(end) - start;
         if(_loc7_ != 0)
         {
            this._tweens[this._tweens.length] = new com.greensock.core.PropTween(object,propName,start,_loc7_,overwriteProp || propName);
         }
      }
   }
   function updateTweens(changeFactor)
   {
      var _loc3_ = this._tweens.length;
      if(this.round)
      {
         while(_loc3_--)
         {
            var _loc4_ = this._tweens[_loc3_];
            _loc4_.target[_loc4_.property] = Math.round(_loc4_.start + _loc4_.change * changeFactor);
         }
      }
      else
      {
         while(_loc3_--)
         {
            _loc4_ = this._tweens[_loc3_];
            _loc4_.target[_loc4_.property] = _loc4_.start + _loc4_.change * changeFactor;
         }
      }
   }
   function get changeFactor()
   {
      return this._changeFactor;
   }
   function set changeFactor(n)
   {
      this.updateTweens(n);
      this._changeFactor = n;
   }
   function killProps(lookup)
   {
      var _loc3_ = this.overwriteProps.length;
      while(_loc3_--)
      {
         if(lookup[this.overwriteProps[_loc3_]])
         {
            this.overwriteProps.splice(_loc3_,1);
         }
      }
      _loc3_ = this._tweens.length;
      while(_loc3_--)
      {
         if(lookup[this._tweens[_loc3_].name])
         {
            this._tweens.splice(_loc3_,1);
         }
      }
   }
   static function onTweenEvent(type, tween)
   {
      var _loc4_ = tween.cachedPT1;
      if(type == "onInit")
      {
         var _loc6_ = [];
         while(_loc4_)
         {
            _loc6_[_loc6_.length] = _loc4_;
            _loc4_ = _loc4_.nextNode;
         }
         _loc6_.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
         var _loc7_ = _loc6_.length;
         while(_loc7_--)
         {
            _loc6_[_loc7_].nextNode = _loc6_[_loc7_ + 1];
            _loc6_[_loc7_].prevNode = _loc6_[_loc7_ - 1];
         }
         tween.cachedPT1 = _loc6_[0];
      }
      else
      {
         while(_loc4_)
         {
            if(_loc4_.isPlugin && _loc4_.target[type])
            {
               if(_loc4_.target.activeDisable)
               {
                  var _loc5_ = true;
               }
               _loc4_.target[type]();
            }
            _loc4_ = _loc4_.nextNode;
         }
      }
      return _loc5_;
   }
   static function activate(plugins)
   {
      com.greensock.TweenLite.onPluginEvent = com.greensock.plugins.TweenPlugin.onTweenEvent;
      var _loc3_ = plugins.length;
      while(_loc3_--)
      {
         if(plugins[_loc3_].API == 1)
         {
            var _loc4_ = new plugins[_loc3_]();
            com.greensock.TweenLite.plugins[_loc4_.propName] = plugins[_loc3_];
         }
      }
      return true;
   }
}
if(!com.greensock.plugins.FilterPlugin)
{
   _global.com.greensock.plugins.FilterPlugin = function()
   {
      super();
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.FilterPlugin = function()
   {
      super();
   }.prototype;
   _loc1_.initFilter = function(props, defaultFilter, propNames)
   {
      var _loc5_ = this._target.filters;
      var _loc9_ = !(props instanceof flash.filters.BitmapFilter) ? props : {};
      this._index = -1;
      if(_loc9_.index != undefined)
      {
         this._index = _loc9_.index;
      }
      else
      {
         var _loc7_ = _loc5_.length;
         while(_loc7_--)
         {
            if(_loc5_[_loc7_] instanceof this._type)
            {
               this._index = _loc7_;
               break;
            }
         }
      }
      if(this._index == -1 || (_loc5_[this._index] == undefined || _loc9_.addFilter == true))
      {
         this._index = _loc9_.index == undefined ? _loc5_.length : _loc9_.index;
         _loc5_[this._index] = defaultFilter;
         this._target.filters = _loc5_;
      }
      this._filter = _loc5_[this._index];
      if(_loc9_.remove == true)
      {
         this._remove = true;
         this.onComplete = this.onCompleteTween;
      }
      _loc7_ = propNames.length;
      while(_loc7_--)
      {
         var _loc6_ = propNames[_loc7_];
         if(props[_loc6_] != undefined && this._filter[_loc6_] != props[_loc6_])
         {
            if(_loc6_ == "color" || (_loc6_ == "highlightColor" || _loc6_ == "shadowColor"))
            {
               var _loc8_ = new com.greensock.plugins.HexColorsPlugin();
               _loc8_.initColor(this._filter,_loc6_,this._filter[_loc6_],props[_loc6_]);
               this._tweens[this._tweens.length] = new com.greensock.core.PropTween(_loc8_,"changeFactor",0,1,this.propName);
            }
            else if(_loc6_ == "quality" || (_loc6_ == "inner" || (_loc6_ == "knockout" || _loc6_ == "hideObject")))
            {
               this._filter[_loc6_] = props[_loc6_];
            }
            else
            {
               this.addTween(this._filter,_loc6_,this._filter[_loc6_],props[_loc6_],this.propName);
            }
         }
      }
   };
   _loc1_.onCompleteTween = function()
   {
      if(this._remove)
      {
         var _loc2_ = this._target.filters;
         if(!(_loc2_[this._index] instanceof this._type))
         {
            var _loc3_ = _loc2_.length;
            while(_loc3_--)
            {
               if(_loc2_[_loc3_] instanceof this._type)
               {
                  _loc2_.splice(_loc3_,1);
                  break;
               }
            }
         }
         else
         {
            _loc2_.splice(this._index,1);
         }
         this._target.filters = _loc2_;
      }
   };
   _loc1_.__set__changeFactor = function(n)
   {
      var _loc3_ = this._tweens.length;
      var _loc5_ = this._target.filters;
      while(_loc3_--)
      {
         var _loc4_ = this._tweens[_loc3_];
         _loc4_.target[_loc4_.property] = _loc4_.start + _loc4_.change * n;
      }
      if(!(_loc5_[this._index] instanceof this._type))
      {
         var _loc0_ = null;
         _loc3_ = this._index = _loc5_.length;
         while(_loc3_--)
         {
            if(_loc5_[_loc3_] instanceof this._type)
            {
               this._index = _loc3_;
               break;
            }
         }
      }
      _loc5_[this._index] = this._filter;
      this._target.filters = _loc5_;
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.FilterPlugin = function()
   {
      super();
   }.VERSION = 2.03;
   _global.com.greensock.plugins.FilterPlugin = function()
   {
      super();
   }.API = 1;
}
class gui.vo.voGameObject
{
   function voGameObject(v)
   {
      for(var i in v)
      {
         this[i] = v[i];
      }
   }
   function toString()
   {
      var _loc2_ = ":: vo";
      for(var i in this)
      {
         _loc2_ += "\n\t" + i + " : " + this[i];
      }
      return _loc2_;
   }
}
if(!gui.vo.voAbility)
{
   _global.gui.vo.voAbility = function(v)
   {
      super(v);
   } extends gui.vo.voGameObject;
   _loc1_ = _global.gui.vo.voAbility = function(v)
   {
      super(v);
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
}
class cx.utils.BitMaskUtils
{
   function BitMaskUtils()
   {
   }
   static function filter(data, field, bit, rm)
   {
      var _loc6_ = new Array();
      var _loc7_ = 0;
      while(_loc7_ < data.length)
      {
         if((Number(_global.parseInt(data[_loc7_][field])) & Number(bit)) == Number(bit))
         {
            if(!rm || !!(Number(_global.parseInt(data[_loc7_][field])) & Number(rm)) != Number(rm))
            {
               _loc6_.push(data[_loc7_]);
            }
         }
         _loc7_ = _loc7_ + 1;
      }
      return _loc6_;
   }
}
if(!mh2lib.utils.MH2Event)
{
   _loc1_ = _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_PRESS = "Mouse Press";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_RELEASE = "Mouse Release";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_ROLL_OVER = "Mouse Roll Over";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_ROLL_OUT = "Mouse Roll Out";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_DOWN_ANYWHERE = "Mouse Down";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_UP_ANYWHERE = "Mouse Up";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_MOVE = "Mouse Move";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOUSE_WHEEL = "Mouse Wheel";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOVIECLIP_CONSTRUCTED = "MC Constructed";
   _global.mh2lib.utils.MH2Event = function(caller, event)
   {
      this.m_pCaller = caller;
      this.m_pObjCaller = caller;
      this.m_sType = event;
   }.MOVIECLIP_DESTROYED = "MC Constructed";
   _loc1_.m_sInfo = "info test";
   _loc1_.m_sType = "UNDEFINED_EVENT";
}
if(!mh2lib.utils.MH2State)
{
   _loc1_ = _global.mh2lib.utils.MH2State = function()
   {
   }.prototype;
   _loc1_.State = function()
   {
   };
   _loc1_.Init = function(ownerMachine)
   {
      this.m_pStateMachine = ownerMachine;
   };
   _loc1_.EnterState = function()
   {
   };
   _loc1_.Execution = function()
   {
   };
   _loc1_.ExitState = function()
   {
   };
   _loc1_.StateEvent = function(type)
   {
      return false;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.utils.MH2State = function()
   {
   }.NAME = "Need inheritance: Virtual";
}
class mh2lib.display.FCState extends mh2lib.utils.MH2State
{
   var m_pStateMachine;
   function FCState()
   {
      super();
   }
   function Owner()
   {
      return this.m_pStateMachine.m_pOwner;
   }
}
class mh2lib.display.flowstates.FCGraphicLoadOnly extends mh2lib.display.FCState
{
   var m_sStateName;
   function FCGraphicLoadOnly()
   {
      super();
      this.m_sStateName = "FCGraphicLoadOnly";
   }
   function EnterState()
   {
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = new Object();
      _loc3_.onLoadComplete = cx.utils.Delegate.create(this,this.GraphicReady,[this]);
      _loc2_.addListener(_loc3_);
      _loc2_.loadClip(this.Owner().m_sPath,this.Owner().m_mcGraphic);
   }
   function GraphicReady(pState)
   {
      pState.Owner().m_mcGraphic._visible = true;
      pState.Owner().m_mcGraphic._alpha = 0;
      _global.pPanelClass = pState.Owner().m_mcGraphic;
      flash.external.ExternalInterface.call("FillData");
      pState.Owner().m_pTween = com.greensock.TweenLite.to(pState.Owner().m_mcGraphic,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:100,onComplete:this.GraphicVisible,onCompleteParams:[pState]});
   }
   function GraphicVisible(pState)
   {
      if(pState.Owner().m_pFlow.m_bFadeToNewScreen)
      {
         pState.Owner().m_pFlow.m_bFadeToNewScreen = false;
         pState.Owner().m_pFlow.RemoveOtherInstantly(pState.Owner());
         pState.Owner().m_pFlow.EnableRendering(true);
      }
      pState.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCScreenReady());
   }
}
if(!com.greensock.plugins.BlurFilterPlugin)
{
   _global.com.greensock.plugins.BlurFilterPlugin = function()
   {
      super();
      this.propName = "blurFilter";
      this.overwriteProps = ["blurFilter"];
   } extends com.greensock.plugins.FilterPlugin;
   _loc1_ = _global.com.greensock.plugins.BlurFilterPlugin = function()
   {
      super();
      this.propName = "blurFilter";
      this.overwriteProps = ["blurFilter"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      this._target = target;
      this._type = flash.filters.BlurFilter;
      this.initFilter(value,new flash.filters.BlurFilter(0,0,value.quality || 2),com.greensock.plugins.BlurFilterPlugin._propNames);
      return true;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.BlurFilterPlugin = function()
   {
      super();
      this.propName = "blurFilter";
      this.overwriteProps = ["blurFilter"];
   }.API = 1;
   _global.com.greensock.plugins.BlurFilterPlugin = function()
   {
      super();
      this.propName = "blurFilter";
      this.overwriteProps = ["blurFilter"];
   }._propNames = ["blurX","blurY","quality"];
}
if(!gui.vo.voSimpleItem)
{
   _global.gui.vo.voSimpleItem = function(v)
   {
      super(v);
   } extends gui.vo.voGameObject;
   _loc1_ = _global.gui.vo.voSimpleItem = function(v)
   {
      super(v);
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
}
if(!gui.vo.voItem)
{
   _global.gui.vo.voItem = function(data)
   {
      super(data);
   } extends gui.vo.voSimpleItem;
   _loc1_ = _global.gui.vo.voItem = function(data)
   {
      super(data);
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
}
class com.greensock.core.PropTween
{
   var target;
   var property;
   var start;
   var change;
   var name;
   var isPlugin;
   var nextNode;
   var priority;
   function PropTween(target, property, start, change, name, isPlugin, nextNode, priority)
   {
      this.target = target;
      this.property = property;
      this.start = start;
      this.change = change;
      this.name = name;
      this.isPlugin = isPlugin;
      if(nextNode)
      {
         nextNode.prevNode = this;
         this.nextNode = nextNode;
      }
      this.priority = priority || 0;
   }
}
if(!com.greensock.plugins.ScrollRectPlugin)
{
   _global.com.greensock.plugins.ScrollRectPlugin = function()
   {
      super();
      this.propName = "scrollRect";
      this.overwriteProps = ["scrollRect"];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.ScrollRectPlugin = function()
   {
      super();
      this.propName = "scrollRect";
      this.overwriteProps = ["scrollRect"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      if(typeof target != "movieclip")
      {
         return false;
      }
      this._target = MovieClip(target);
      if(this._target.scrollRect != undefined)
      {
         this._rect = flash.geom.Rectangle(this._target.scrollRect);
      }
      else
      {
         var _loc5_ = this._target.getBounds(this._target);
         this._rect = new flash.geom.Rectangle(0,0,_loc5_.xMax,_loc5_.yMax);
      }
      for(var p in value)
      {
         this.addTween(this._rect,p,this._rect[p],value[p],p);
      }
      return true;
   };
   _loc1_.__set__changeFactor = function(n)
   {
      this.updateTweens(n);
      this._target.scrollRect = this._rect;
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.ScrollRectPlugin = function()
   {
      super();
      this.propName = "scrollRect";
      this.overwriteProps = ["scrollRect"];
   }.API = 1;
}
if(!com.greensock.plugins.VisiblePlugin)
{
   _global.com.greensock.plugins.VisiblePlugin = function()
   {
      super();
      this.propName = "_visible";
      this.overwriteProps = ["_visible"];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.VisiblePlugin = function()
   {
      super();
      this.propName = "_visible";
      this.overwriteProps = ["_visible"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      this._target = target;
      this._tween = tween;
      this._initVal = !!this._target._visible;
      this._visible = !!value;
      return true;
   };
   _loc1_.__set__changeFactor = function(n)
   {
      if(n == 1 && (this._tween.cachedDuration == this._tween.cachedTime || this._tween.cachedTime == 0))
      {
         this._target._visible = this._visible;
      }
      else
      {
         this._target._visible = this._initVal;
      }
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.VisiblePlugin = function()
   {
      super();
      this.propName = "_visible";
      this.overwriteProps = ["_visible"];
   }.API = 1;
}
if(!cx.utils.Delegate)
{
   _loc1_ = _global.cx.utils.Delegate = function()
   {
   }.prototype;
   _global.cx.utils.Delegate = function()
   {
   }.create = function(o, f, e)
   {
      return function()
      {
         return f.apply(o,!e ? arguments : [].concat(e,arguments));
      };
   };
   _global.cx.utils.Delegate = function()
   {
   }.create2 = function(o, f, e)
   {
      return function(pParams)
      {
         return f.apply(o,!e ? [].concat(arguments,pParams) : [].concat(e,arguments,pParams));
      };
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!mh2lib.display.MH2Flow)
{
   _loc1_ = _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.prototype;
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.GetKeyCode = function()
   {
      if(mh2lib.display.MH2Flow.s_bUseSmoothMode)
      {
         return mh2lib.display.MH2Flow.s_iCurrentKey + 1000;
      }
      return mh2lib.display.MH2Flow.s_iCurrentKey;
   };
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.SetKeyCode = function(value)
   {
      mh2lib.display.MH2Flow.s_iCurrentKey = value;
      mh2lib.display.MH2Flow.s_iLastKeyDownEvent = getTimer();
   };
   _loc1_.FrameUpdate = function()
   {
      var _loc2_ = mh2lib.display.MH2Flow.GetKeyCode();
      if(_loc2_ != -1)
      {
         var _loc3_ = getTimer();
         var _loc4_ = mh2lib.display.MH2Flow.BUTTON_REPETATION;
         if(this.m_bFirstDelay)
         {
            _loc4_ = mh2lib.display.MH2Flow.BUTTON_FIRST_REPETATION;
         }
         if(_loc3_ - mh2lib.display.MH2Flow.s_iLastKeyDownEvent > _loc4_)
         {
            this.m_bFirstDelay = false;
            mh2lib.display.MH2Flow.s_iLastKeyDownEvent = _loc3_;
            this.onKeyDown();
         }
         if(_loc2_ == mh2lib.utils.MH2Key.ARROW_UP || (_loc2_ == mh2lib.utils.MH2Key.ARROW_DOWN || (_loc2_ == mh2lib.utils.MH2Key.ARROW_LEFT || _loc2_ == mh2lib.utils.MH2Key.ARROW_RIGHT)))
         {
            mh2lib.display.MH2Flow.s_bUseSmoothMode = true;
            this.onKeyDown();
            mh2lib.display.MH2Flow.s_bUseSmoothMode = false;
         }
      }
   };
   _loc1_.ForcedInclude = function()
   {
      var _loc2_ = new mh2lib.display.MH2Panel();
      var _loc3_ = new CSlot();
   };
   _loc1_.OpenPanelInFlow = function(sPath, sFade, sVideoName, bControlRender, bControlPause, bControlHUD)
   {
      if(this.m_bFlowBussy)
      {
         this.m_aOrderQueue.push([sPath,sFade,sVideoName,bControlRender,this.m_bControlPause,bControlHUD]);
         return undefined;
      }
      var _loc8_ = "";
      if(this.m_aPanels.length > 0)
      {
         _loc8_ = this.m_aPanels[this.m_aPanels.length - 1].m_sPath;
      }
      this.RefreshButtons();
      this.SetFlowBussy(true);
      if(sPath != undefined && (sPath != "" && sPath != "undefined"))
      {
         if(this.m_aPanels.length > 0)
         {
            this.m_bFadeToNewScreen = true;
            if(!bControlHUD)
            {
               _global.pHUD.Init(_global.mHUD);
            }
            else
            {
               _global.pHUD.Finalize();
            }
         }
         else if(bControlHUD)
         {
            _global.pHUD.Finalize();
         }
         this.m_bControlRender = bControlRender;
         this.m_bControlPause = bControlPause;
         this.m_bDoBitmapOrBlackFadeInOut = bControlRender;
         this.SetGamePause(true);
         var _loc9_ = new mh2lib.display.MH2FlowChild(this);
         _loc9_.LoadPanel(sPath,sFade,sVideoName);
         this.m_aPanels.push(_loc9_);
      }
      else
      {
         this.m_bControlRender = false;
         this.m_bControlPause = false;
         if(this.m_aPanels.length > 0)
         {
            this.Finalize();
         }
         else
         {
            this.SetFlowBussy(false);
         }
      }
   };
   _loc1_.SetFlowBussy = function(value)
   {
      this.StopDrag();
      this.onKeyUp();
      if(this.m_bFlowBussy != value)
      {
         this.m_bFlowBussy = value;
         if(value == false && this.m_bControlPause == false)
         {
            this.SetGamePause(false);
         }
         if(value == false && this.m_aOrderQueue.length > 0)
         {
            var _loc3_ = Array(this.m_aOrderQueue.shift());
            this.OpenPanelInFlow(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5]);
         }
         else
         {
            flash.external.ExternalInterface.call("FlowBusy",value);
         }
      }
   };
   _loc1_.EnableRendering = function(bValue)
   {
      if(this.m_bControlRender)
      {
         if(bValue == false)
         {
            this.m_bRenderNeedRecover = true;
         }
         flash.external.ExternalInterface.call("EnableWorldRendering",bValue);
      }
      else if(bValue == true && this.m_bRenderNeedRecover == true)
      {
         flash.external.ExternalInterface.call("EnableWorldRendering",bValue);
      }
      if(bValue == true)
      {
         this.m_bRenderNeedRecover = false;
      }
   };
   _loc1_.SetGamePause = function(bValue)
   {
      if(this.m_bControlPause)
      {
         if(bValue == true)
         {
            this.m_bPauseNeedRecover = true;
         }
         flash.external.ExternalInterface.call("SetGamePause",bValue);
      }
      else if(bValue == false && this.m_bPauseNeedRecover == true)
      {
         flash.external.ExternalInterface.call("SetGamePause",bValue);
      }
      if(bValue == false)
      {
         this.m_bPauseNeedRecover = false;
      }
   };
   _loc1_.Finalize = function()
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aPanels.length)
      {
         var _loc2_ = this.m_aPanels[_loc3_];
         _loc2_.Finalize();
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.RemoveChild = function(pFC)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aPanels.length)
      {
         if(this.m_aPanels[_loc3_] == pFC)
         {
            if(this.m_aPanels.length < 2)
            {
               this.m_aPanels = [];
            }
            else
            {
               this.m_aPanels.splice(_loc3_,1);
            }
            break;
         }
         _loc3_ = _loc3_ + 1;
      }
      if(this.m_aPanels.length == 0)
      {
         this.SetFlowBussy(false);
         if(this.m_aPanels.length == 0)
         {
            _global.pHUD.Init(_global.mHUD);
            _global.vPanel.unloadMovie();
         }
      }
   };
   _loc1_.RemoveOtherInstantly = function(pFC)
   {
      if(pFC != null)
      {
         var _loc3_ = 0;
         while(_loc3_ < this.m_aPanels.length)
         {
            if(this.m_aPanels[_loc3_] != pFC)
            {
               this.m_aPanels[_loc3_].m_mcGraphic._visible = false;
               this.m_aPanels[_loc3_].Finalize();
            }
            _loc3_ = _loc3_ + 1;
         }
         this.m_aPanels = [pFC];
         if(pFC.m_sVideoName == "")
         {
            _global.vCustomPanel.loadMovie("ui_panelbg.swf");
         }
      }
   };
   _loc1_.GetIndex = function(pFC)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aPanels.length)
      {
         if(this.m_aPanels[_loc3_] == pFC)
         {
            return _loc3_;
         }
         _loc3_ = _loc3_ + 1;
      }
      return -1;
   };
   _loc1_.onKeyDown = function()
   {
      if(mh2lib.display.MH2Flow.GetKeyCode() == -1)
      {
         this.m_bFirstDelay = true;
         mh2lib.display.MH2Flow.SetKeyCode(Key.getCode());
      }
      if(_global.pGUI.m_mcConfirmationBox._visible)
      {
         _global.pGUI.m_mcConfirmationBox.onIK();
      }
      else if(_global.pGUI.m_mcPopupInfo._visible)
      {
         _global.pGUI.m_mcPopupInfo.onIK();
      }
      else if(_global.pHUD.uiConfirmationGO._visible)
      {
         _global.pHUD.onGameOverConfirmationBoxIK();
      }
      else if(_global.pHUD.m_mcInsaneGO._visible)
      {
         _global.pHUD.m_mcInsaneGO.onIK();
      }
      else if(_global.pHUD._uFastMenu.fx._visible)
      {
         _global.pHUD._uFastMenu.onIK();
      }
      else if(!this.m_bFlowBussy && this.m_aPanels.length > 0)
      {
         if(mh2lib.display.MH2Flow.GetKeyCode() > 3)
         {
            this.KeyMode(true);
         }
         this.m_aPanels[this.m_aPanels.length - 1].onIK();
      }
      if(mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.SPACE || (mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.ENTER || (mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.PAD_A_CROSS || (mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.PAD_B_CIRCLE || (mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.PAD_Y_TRIANGLE || (mh2lib.display.MH2Flow.GetKeyCode() == mh2lib.utils.MH2Key.PAD_X_SQUARE || mh2lib.display.MH2Flow.GetKeyCode() < 3))))))
      {
         this.m_bFirstDelay = false;
         mh2lib.display.MH2Flow.SetKeyCode(-1);
      }
   };
   _loc1_.onKeyUp = function()
   {
      this.m_bFirstDelay = false;
      mh2lib.display.MH2Flow.SetKeyCode(-1);
   };
   _loc1_.onMouseWheel = function(iValue)
   {
      if(_global.pGUI.m_mcConfirmationBox._visible || (_global.pGUI.m_mcPopupInfo._visible || (_global.pHUD.uiConfirmationGO._visible || _global.pHUD._uFastMenu.fx._visible)))
      {
         return undefined;
      }
      var _loc3_ = 0;
      while(_loc3_ < this.m_aMouseWheelListners.length)
      {
         this.m_aMouseWheelListners[_loc3_].OnMouseWheel(iValue);
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.MouseWheelRegister = function(pMC)
   {
      this.MouseWheelUnRegister(pMC);
      this.m_aMouseWheelListners.push(pMC);
   };
   _loc1_.MouseWheelUnRegister = function(pMC)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aMouseWheelListners.length)
      {
         if(this.m_aMouseWheelListners[_loc3_] == pMC)
         {
            this.m_aMouseWheelListners.splice(_loc3_,1);
            return undefined;
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.CallButtonModeChange = function()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_aButtonsModeListners.length)
      {
         if(this.m_aButtonsModeListners[_loc2_])
         {
            this.m_aButtonsModeListners[_loc2_].ButtonModeChanged();
         }
         _loc2_ = _loc2_ + 1;
      }
   };
   _loc1_.RefreshButtons = function()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_aButtonsModeListners.length)
      {
         if(this.m_aButtonsModeListners[_loc2_])
         {
            this.m_aButtonsModeListners[_loc2_].RollOut();
         }
         _loc2_ = _loc2_ + 1;
      }
   };
   _loc1_.RegisterButton = function(pMC)
   {
      this.UnRegisterButton(pMC);
      this.m_aButtonsModeListners.push(pMC);
   };
   _loc1_.UnRegisterButton = function(pMC)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aButtonsModeListners.length)
      {
         if(this.m_aButtonsModeListners[_loc3_] == pMC)
         {
            this.m_aButtonsModeListners.splice(_loc3_,1);
            return undefined;
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.SetFocus = function(mc)
   {
      if(this.m_mcFocusedComponent != null)
      {
         this.m_mcFocusedComponent.LoseFocus();
      }
      this.m_mcFocusedComponent = mc;
      this.m_mcDraggingTarget = CSlot(mc);
      this.m_aPanels[this.m_aPanels.length - 1].SetFocus(mc);
   };
   _loc1_.LoseDragTarget = function(mc)
   {
      if(this.m_mcDraggingTarget == mc)
      {
         this.m_mcDraggingTarget = null;
      }
   };
   _loc1_.UpdateDragContainer = function()
   {
      if(this.m_pDraggedItem != null)
      {
         if(_global.pGUI.fxMouseCursor.m_mcIconContainer._width < 5)
         {
            cx.utils.AssetLoader.loadAsset(_global.pGUI.fxMouseCursor.m_mcIconContainer,this.m_pDraggedItem.Icon,50,50);
         }
      }
      else
      {
         _global.pGUI.fxMouseCursor.m_mcIconContainer.unloadMovie();
      }
   };
   _loc1_.StartDrag = function(pSlot)
   {
      if(pSlot != null)
      {
         flash.external.ExternalInterface.call("StartDrag");
         if(pSlot.GetContainedItem() != null)
         {
            this.m_pDraggedItem = pSlot.GetContainedItem();
            this.m_mcDraggingSource = pSlot;
            this.UpdateDragContainer();
            flash.external.ExternalInterface.call("PlaySound","gui/slot/startdrag");
         }
      }
   };
   _loc1_.StopDrag = function()
   {
      if(this.m_pDraggedItem != null)
      {
         if(this.m_mcDraggingTarget != null && this.m_mcDraggingSource != this.m_mcDraggingTarget)
         {
            var _loc2_ = this.m_mcDraggingTarget.TestItemAsUpgrade(this.m_pDraggedItem);
            var _loc3_ = this.m_mcDraggingTarget.ReceiveItem(this.m_pDraggedItem);
            if(_loc3_ != this.m_pDraggedItem)
            {
               if(_loc3_ != null)
               {
                  var _loc4_ = this.m_mcDraggingSource.ReceiveItem(_loc3_);
                  if(_loc4_ == _loc3_)
                  {
                     this.m_mcDraggingTarget.LoseItem(this.m_pDraggedItem);
                     this.m_mcDraggingTarget.ReceiveItem(_loc3_);
                     this.m_mcDraggingSource.ReceiveItem(this.m_pDraggedItem);
                     if(this.m_aPanels[this.m_aPanels.length - 1].m_mcGraphic.DragTargetRefused != undefined)
                     {
                        this.m_aPanels[this.m_aPanels.length - 1].m_mcGraphic.DragTargetRefused();
                     }
                     flash.external.ExternalInterface.call("PlaySound","gui/other/denied");
                  }
                  else
                  {
                     this.m_mcDraggingTarget.LoseItem(_loc3_);
                     this.m_mcDraggingSource.LoseItem(this.m_pDraggedItem);
                     flash.external.ExternalInterface.call("PlaySound","gui/slot/stopdrag");
                  }
               }
               else
               {
                  this.m_mcDraggingSource.ReceiveItem(null);
                  this.m_mcDraggingSource.LoseItem(this.m_pDraggedItem);
                  flash.external.ExternalInterface.call("PlaySound","gui/slot/stopdrag");
               }
            }
            else
            {
               if(!_loc2_ && this.m_aPanels[this.m_aPanels.length - 1].m_mcGraphic.DragTargetRefused != undefined)
               {
                  this.m_aPanels[this.m_aPanels.length - 1].m_mcGraphic.DragTargetRefused();
               }
               flash.external.ExternalInterface.call("PlaySound","gui/other/denied");
            }
         }
         this.m_mcDraggingSource = null;
         this.m_pDraggedItem = null;
         this.UpdateDragContainer();
      }
   };
   _loc1_.KeyMode = function(bActive)
   {
      if(bActive)
      {
         _global.vPanel.onPress = function()
         {
         };
         _global.vPanel.onMouseMove = cx.utils.Delegate.create(this,this.MouseActive);
      }
      else
      {
         this.MouseActive();
      }
   };
   _loc1_.MouseActive = function()
   {
      delete _global.vPanel.onPress;
      delete _global.vPanel.onMouseMove;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.BUTTON_REPETATION = 100;
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.BUTTON_FIRST_REPETATION = 1000;
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.s_iCurrentKey = -1;
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.s_iLastKeyDownEvent = 0;
   _global.mh2lib.display.MH2Flow = function()
   {
      this.ForcedInclude();
      mh2lib.display.MH2Flow.s_pInstance = this;
      this.m_bFlowBussy = false;
      this.m_bControlRender = false;
      this.m_bControlPause = false;
      this.m_bDoBitmapOrBlackFadeInOut = false;
      this.m_bFadeToNewScreen = false;
      this.m_bRenderNeedRecover = false;
      this.m_bPauseNeedRecover = false;
      _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      Key.addListener(this);
      mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator = cx.utils.Delegate.create2(this,this.MouseWheelRegister);
      mh2lib.display.MH2MovieClip.s_pMouseEventUnregister = cx.utils.Delegate.create2(this,this.MouseWheelUnRegister);
      this.m_mcEmptyEventCatcher = _global.pGUI.createEmptyMovieClip("EmptyEventCatcher",_global.pGUI.getNextHighestDepth());
      this.m_iInterval = _global.setInterval(this,"FrameUpdate",30);
   }.s_bUseSmoothMode = false;
   _loc1_.m_aPanels = [];
   _loc1_.m_aOrderQueue = [];
   _loc1_.m_aMouseWheelListners = [];
   _loc1_.m_aButtonsModeListners = [];
   _loc1_.m_iFreeIDForChilds = 0;
   _loc1_.m_pDraggedItem = null;
   _loc1_.m_mcFocusedComponent = null;
   _loc1_.m_mcDraggingTarget = null;
   _loc1_.m_mcDraggingSource = null;
   _loc1_.m_aButton = -1;
   _loc1_.m_iInterval = -1;
   _loc1_.m_bFirstDelay = false;
}
if(!mh2lib.display.MH2MovieClip)
{
   _global.mh2lib.display.MH2MovieClip = function()
   {
      super();
      this.onUnload = cx.utils.Delegate.create(this,this.ClearOnDestroy);
   } extends MovieClip;
   _loc1_ = _global.mh2lib.display.MH2MovieClip = function()
   {
      super();
      this.onUnload = cx.utils.Delegate.create(this,this.ClearOnDestroy);
   }.prototype;
   _loc1_.AddEventListener = function(creationPlace, event, func)
   {
      switch(event)
      {
         case mh2lib.utils.MH2Event.MOUSE_PRESS:
            this.onPress = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_RELEASE:
            this.onRelease = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_ROLL_OVER:
            this.onRollOver = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_ROLL_OUT:
            this.onRollOut = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_DOWN_ANYWHERE:
            this.onMouseDown = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_UP_ANYWHERE:
            this.onMouseUp = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_MOVE:
            this.onMouseMove = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOUSE_WHEEL:
            if(mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator != null)
            {
               this.m_bWheelEventAttached = true;
               this.m_pMouseWheel = cx.utils.Delegate.create2(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
               mh2lib.display.MH2MovieClip.s_pMouseEventRegistrator(this);
            }
         case mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED:
            this.onLoad = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
            break;
         case mh2lib.utils.MH2Event.MOVIECLIP_DESTROYED:
            this.m_pDestructorCallBack = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
      }
   };
   _loc1_.RemoveEventListener = function(event)
   {
      switch(event)
      {
         case mh2lib.utils.MH2Event.MOUSE_PRESS:
            if(this.onPress != null && this.onPress != undefined)
            {
               delete this.onPress;
               this.onPress = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_RELEASE:
            if(this.onRelease != null && this.onRelease != undefined)
            {
               delete this.onRelease;
               this.onRelease = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_ROLL_OVER:
            if(this.onRollOver != null && this.onRollOver != undefined)
            {
               delete this.onRollOver;
               this.onRollOver = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_ROLL_OUT:
            if(this.onRollOut != null && this.onRollOut != undefined)
            {
               delete this.onRollOut;
               this.onRollOut = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_DOWN_ANYWHERE:
            if(this.onMouseDown != null && this.onMouseDown != undefined)
            {
               delete this.onMouseDown;
               this.onMouseDown = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_UP_ANYWHERE:
            if(this.onMouseUp != null && this.onMouseUp != undefined)
            {
               delete this.onMouseUp;
               this.onMouseUp = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_MOVE:
            if(this.onMouseMove != null && this.onMouseMove != undefined)
            {
               delete this.onMouseMove;
               this.onMouseMove = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOUSE_WHEEL:
            if(mh2lib.display.MH2MovieClip.s_pMouseEventUnregister != null)
            {
               this.m_bWheelEventAttached = false;
               mh2lib.display.MH2MovieClip.s_pMouseEventUnregister(this);
            }
            break;
         case mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED:
            if(this.onLoad != null && this.onLoad != undefined)
            {
               delete this.onLoad;
               this.onLoad = null;
            }
            break;
         case mh2lib.utils.MH2Event.MOVIECLIP_DESTROYED:
            if(this.onUnload != null && this.onUnload != undefined)
            {
               delete this.onUnload;
               this.onUnload = null;
            }
      }
   };
   _loc1_.ClearOnDestroy = function()
   {
      if(this.m_bWheelEventAttached)
      {
         this.RemoveEventListener(mh2lib.utils.MH2Event.MOUSE_WHEEL);
      }
      this.m_pDestructorCallBack();
   };
   _loc1_.OnMouseWheel = function(fValue)
   {
      this.m_pMouseWheel(fValue);
   };
   _loc1_.Finalize = function()
   {
   };
   _loc1_.onIK = function()
   {
      return false;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.display.MH2MovieClip = function()
   {
      super();
      this.onUnload = cx.utils.Delegate.create(this,this.ClearOnDestroy);
   }.s_pMouseEventRegistrator = null;
   _global.mh2lib.display.MH2MovieClip = function()
   {
      super();
      this.onUnload = cx.utils.Delegate.create(this,this.ClearOnDestroy);
   }.s_pMouseEventUnregister = null;
   _loc1_.m_pMouseWheel = null;
   _loc1_.m_pDestructorCallBack = null;
   _loc1_.m_aCurrentLabels = null;
   _loc1_.m_sName = "MH2MovieClip";
   _loc1_.m_iID = 0;
   _loc1_.m_bWheelEventAttached = false;
}
if(!mh2lib.display.MH2Component)
{
   _global.mh2lib.display.MH2Component = function()
   {
      super();
   } extends mh2lib.display.MH2MovieClip;
   _loc1_ = _global.mh2lib.display.MH2Component = function()
   {
      super();
   }.prototype;
   _loc1_.HandleEvent = function(type)
   {
      return false;
   };
   _loc1_.HandleInput = function(value)
   {
      return value;
   };
   _loc1_.LoseFocus = function()
   {
      this.m_bHaveFocus = false;
      if(this.m_mcFocus)
      {
         this.m_mcFocus._visible = false;
      }
   };
   _loc1_.GainFocus = function()
   {
      this.m_bHaveFocus = true;
      if(this.m_mcFocus)
      {
         this.m_mcFocus._visible = true;
      }
   };
   ASSetPropFlags(_loc1_,null,1);
   _loc1_.m_bHaveFocus = false;
}
if(!mh2lib.display.MH2Panel)
{
   _global.mh2lib.display.MH2Panel = function()
   {
      super();
   } extends mh2lib.display.MH2Component;
   _loc1_ = _global.mh2lib.display.MH2Panel = function()
   {
      super();
   }.prototype;
   _loc1_.FitClipToScreen = function(mc)
   {
      var _loc3_ = 1280;
      var _loc4_ = 720;
      var _loc5_ = 100 * _global.pGUI.m_Width / _loc3_;
      var _loc6_ = 100 * _global.pGUI.m_Height / _loc4_;
      if(mc)
      {
         mc._x = (- (_global.pGUI.m_Width - _loc3_)) / 2;
         mc._y = (- (_global.pGUI.m_Height - _loc4_)) / 2;
         mc._xscale = _loc5_;
         mc._yscale = _loc6_;
      }
   };
   _loc1_.FitBackground = function()
   {
      var _loc2_ = 1280;
      var _loc3_ = 720;
      var _loc4_ = 100 * _global.pGUI.m_Width / _loc2_;
      var _loc5_ = 100 * _global.pGUI.m_Height / _loc3_;
      if(this.m_mcBackground)
      {
         this.m_mcBackground._x = (- (_global.pGUI.m_Width - _loc2_)) / 2;
         this.m_mcBackground._y = (- (_global.pGUI.m_Height - _loc3_)) / 2;
         this.m_mcBackground._xscale = _loc4_;
         this.m_mcBackground._yscale = _loc5_;
      }
      if(this.m_mcCover)
      {
         this.m_mcCover._x = (- (_global.pGUI.m_Width - _loc2_)) / 2;
         this.m_mcCover._y = (- (_global.pGUI.m_Height - _loc3_)) / 2;
         this.m_mcCover._xscale = this.m_mcCover._xscale * _loc4_ / 100;
         this.m_mcCover._yscale = this.m_mcCover._yscale * _loc5_ / 100;
      }
   };
   _loc1_.OnKeyActive = function()
   {
      if(Key.getCode() > 3 && (this.m_mcKeyFocusedSlot == null && this.m_mcLastKeyFocusedSlot != null))
      {
         this.m_mcKeyFocusedSlot = this.m_mcLastKeyFocusedSlot;
         this.m_mcKeyFocusedSlot.AskForFocus(null);
      }
   };
   _loc1_.GetKeyFocuesedSlot = function()
   {
      return this.m_mcKeyFocusedSlot;
   };
   _loc1_.SetKeyFocuesedSlot = function(pCSlot)
   {
      if(pCSlot != null)
      {
         this.m_mcLastKeyFocusedSlot = pCSlot;
      }
      this.m_mcKeyFocusedSlot = pCSlot;
   };
   _loc1_.ExitPanel = function(pCSlot)
   {
      flash.external.ExternalInterface.call("ClosePanel");
   };
   ASSetPropFlags(_loc1_,null,1);
   _loc1_.m_mcLastKeyFocusedSlot = null;
   _loc1_.m_mcKeyFocusedSlot = null;
}
if(!com.greensock.plugins.ScalePlugin)
{
   _global.com.greensock.plugins.ScalePlugin = function()
   {
      super();
      this.propName = "scale";
      this.overwriteProps = ["scaleX","scaleY","width","height"];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.ScalePlugin = function()
   {
      super();
      this.propName = "scale";
      this.overwriteProps = ["scaleX","scaleY","width","height"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      if(target._xscale == undefined)
      {
         return false;
      }
      this._target = target;
      this._startX = this._target._xscale;
      this._startY = this._target._yscale;
      if(typeof value == "number")
      {
         this._changeX = Number(value) - this._startX;
         this._changeY = Number(value) - this._startY;
      }
      else
      {
         this._changeX = this._changeY = Number(value);
      }
      return true;
   };
   _loc1_.killProps = function(lookup)
   {
      var _loc3_ = this.overwriteProps.length;
      while(_loc3_--)
      {
         if(lookup[this.overwriteProps[_loc3_]] != undefined)
         {
            this.overwriteProps = [];
            return undefined;
         }
      }
   };
   _loc1_.__set__changeFactor = function(n)
   {
      this._target._xscale = this._startX + n * this._changeX;
      this._target._yscale = this._startY + n * this._changeY;
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.ScalePlugin = function()
   {
      super();
      this.propName = "scale";
      this.overwriteProps = ["scaleX","scaleY","width","height"];
   }.API = 1;
}
if(!com.greensock.core.TweenCore)
{
   _loc1_ = _global.com.greensock.core.TweenCore = function(duration, vars)
   {
      this.vars = vars || {};
      this.cachedDuration = this.cachedTotalDuration = duration || 0;
      this._delay = Number(this.vars.after) || 0;
      this.cachedTimeScale = this.vars.timeScale || 1;
      this.active = duration == 0 && (this._delay == 0 && this.vars.immediateRender != false);
      this.cachedTotalTime = this.cachedTime = 0;
      this.data = this.vars.data;
      this.gc = this.initted = this.cacheIsDirty = this.cachedPaused = this.cachedReversed = false;
      this._rawPrevTime = -1;
      if(!com.greensock.core.TweenCore._classInitted)
      {
         if(!(com.greensock.TweenLite.rootFrame == undefined && com.greensock.TweenLite.initClass != undefined))
         {
            return undefined;
         }
         com.greensock.TweenLite.initClass();
         com.greensock.core.TweenCore._classInitted = true;
      }
      var _loc4_ = !(this.vars.timeline instanceof com.greensock.core.SimpleTimeline) ? (this.vars.useFrames != true ? com.greensock.TweenLite.rootTimeline : com.greensock.TweenLite.rootFramesTimeline) : this.vars.timeline;
      this.cachedStartTime = _loc4_.cachedTotalTime + this._delay;
      _loc4_.addChild(this);
      if(this.vars.reversed)
      {
         this.cachedReversed = true;
      }
      if(this.vars.paused)
      {
         this.paused = true;
      }
   }.prototype;
   _loc1_.play = function()
   {
      this.reversed = false;
      this.paused = false;
   };
   _loc1_.pause = function()
   {
      this.paused = true;
   };
   _loc1_.resume = function()
   {
      this.paused = false;
   };
   _loc1_.restart = function(includeDelay, suppressEvents)
   {
      this.reversed = false;
      this.paused = false;
      this.setTotalTime(!includeDelay ? 0 : - this._delay,suppressEvents != false);
   };
   _loc1_.reverse = function(forceResume)
   {
      this.reversed = true;
      if(forceResume != false)
      {
         this.paused = false;
      }
      else if(this.gc)
      {
         this.setEnabled(true,false);
      }
   };
   _loc1_.renderTime = function(time, suppressEvents, force)
   {
   };
   _loc1_.complete = function(skipRender, suppressEvents)
   {
      if(!skipRender)
      {
         this.renderTime(this.totalDuration,suppressEvents,false);
         return undefined;
      }
      if(this.timeline.autoRemoveChildren)
      {
         this.setEnabled(false,false);
      }
      else
      {
         this.active = false;
      }
      if(!suppressEvents)
      {
         if(this.vars.onComplete && (this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed))
         {
            this.vars.onComplete.apply(this.vars.onCompleteScope,this.vars.onCompleteParams);
         }
         else if(this.cachedReversed && (this.cachedTotalTime == 0 && this.vars.onReverseComplete))
         {
            this.vars.onReverseComplete.apply(this.vars.onReverseCompleteScope,this.vars.onReverseCompleteParams);
         }
      }
   };
   _loc1_.invalidate = function()
   {
   };
   _loc1_.setEnabled = function(enabled, ignoreTimeline)
   {
      this.gc = !enabled;
      if(enabled)
      {
         this.active = !this.cachedPaused && (this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
         if(ignoreTimeline != true && this.cachedOrphan)
         {
            this.timeline.addChild(this);
         }
      }
      else
      {
         this.active = false;
         if(ignoreTimeline != true)
         {
            this.timeline.remove(this,true);
         }
      }
      return false;
   };
   _loc1_.kill = function()
   {
      this.setEnabled(false,false);
   };
   _loc1_.setDirtyCache = function(includeSelf)
   {
      var _loc3_ = includeSelf == false ? this.timeline : this;
      while(_loc3_)
      {
         _loc3_.cacheIsDirty = true;
         _loc3_ = _loc3_.timeline;
      }
   };
   _loc1_.setTotalTime = function(time, suppressEvents)
   {
      if(this.timeline)
      {
         var _loc4_ = !(this._pauseTime || this._pauseTime == 0) ? this.timeline.cachedTotalTime : this._pauseTime;
         if(this.cachedReversed)
         {
            var _loc5_ = !this.cacheIsDirty ? this.cachedTotalDuration : this.totalDuration;
            this.cachedStartTime = _loc4_ - (_loc5_ - time) / this.cachedTimeScale;
         }
         else
         {
            this.cachedStartTime = _loc4_ - time / this.cachedTimeScale;
         }
         if(!this.timeline.cacheIsDirty)
         {
            this.setDirtyCache(false);
         }
         if(this.cachedTotalTime != time)
         {
            this.renderTime(time,suppressEvents,false);
         }
      }
   };
   _loc1_.__get__delay = function()
   {
      return this._delay;
   };
   _loc1_.__set__delay = function(n)
   {
      this.startTime += n - this._delay;
      this._delay = n;
      return this.delay;
   };
   _loc1_.__get__duration = function()
   {
      return this.cachedDuration;
   };
   _loc1_.__set__duration = function(n)
   {
      this.cachedDuration = this.cachedTotalDuration = n;
      this.setDirtyCache(false);
      return this.duration;
   };
   _loc1_.__get__totalDuration = function()
   {
      return this.cachedTotalDuration;
   };
   _loc1_.__set__totalDuration = function(n)
   {
      this.duration = n;
      return this.totalDuration;
   };
   _loc1_.__get__currentTime = function()
   {
      return this.cachedTime;
   };
   _loc1_.__set__currentTime = function(n)
   {
      this.setTotalTime(n,false);
      return this.currentTime;
   };
   _loc1_.__get__totalTime = function()
   {
      return this.cachedTotalTime;
   };
   _loc1_.__set__totalTime = function(n)
   {
      this.setTotalTime(n,false);
      return this.totalTime;
   };
   _loc1_.__get__startTime = function()
   {
      return this.cachedStartTime;
   };
   _loc1_.__set__startTime = function(n)
   {
      var _loc3_ = this.timeline != undefined && (n != this.cachedStartTime || this.gc);
      this.cachedStartTime = n;
      if(_loc3_)
      {
         this.timeline.addChild(this);
      }
      return this.startTime;
   };
   _loc1_.__get__reversed = function()
   {
      return this.cachedReversed;
   };
   _loc1_.__set__reversed = function(b)
   {
      if(b != this.cachedReversed)
      {
         this.cachedReversed = b;
         this.setTotalTime(this.cachedTotalTime,true);
      }
      return this.reversed;
   };
   _loc1_.__get__paused = function()
   {
      return this.cachedPaused;
   };
   _loc1_.__set__paused = function(b)
   {
      if(b != this.cachedPaused && this.timeline)
      {
         if(b)
         {
            this._pauseTime = this.timeline.rawTime;
         }
         else
         {
            this.cachedStartTime += this.timeline.rawTime - this._pauseTime;
            this._pauseTime = _global.NaN;
            this.setDirtyCache(false);
         }
         this.cachedPaused = b;
         this.active = !this.cachedPaused && (this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
      }
      if(!b && this.gc)
      {
         this.setTotalTime(this.cachedTotalTime,false);
         this.setEnabled(true,false);
      }
      return this.paused;
   };
   _loc1_.addProperty("delay",_loc1_.__get__delay,_loc1_.__set__delay);
   _loc1_.addProperty("totalTime",_loc1_.__get__totalTime,_loc1_.__set__totalTime);
   _loc1_.addProperty("reversed",_loc1_.__get__reversed,_loc1_.__set__reversed);
   _loc1_.addProperty("currentTime",_loc1_.__get__currentTime,_loc1_.__set__currentTime);
   _loc1_.addProperty("totalDuration",_loc1_.__get__totalDuration,_loc1_.__set__totalDuration);
   _loc1_.addProperty("duration",_loc1_.__get__duration,_loc1_.__set__duration);
   _loc1_.addProperty("startTime",_loc1_.__get__startTime,_loc1_.__set__startTime);
   _loc1_.addProperty("paused",_loc1_.__get__paused,_loc1_.__set__paused);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.core.TweenCore = function(duration, vars)
   {
      this.vars = vars || {};
      this.cachedDuration = this.cachedTotalDuration = duration || 0;
      this._delay = Number(this.vars.after) || 0;
      this.cachedTimeScale = this.vars.timeScale || 1;
      this.active = duration == 0 && (this._delay == 0 && this.vars.immediateRender != false);
      this.cachedTotalTime = this.cachedTime = 0;
      this.data = this.vars.data;
      this.gc = this.initted = this.cacheIsDirty = this.cachedPaused = this.cachedReversed = false;
      this._rawPrevTime = -1;
      if(!com.greensock.core.TweenCore._classInitted)
      {
         if(!(com.greensock.TweenLite.rootFrame == undefined && com.greensock.TweenLite.initClass != undefined))
         {
            return undefined;
         }
         com.greensock.TweenLite.initClass();
         com.greensock.core.TweenCore._classInitted = true;
      }
      var _loc4_ = !(this.vars.timeline instanceof com.greensock.core.SimpleTimeline) ? (this.vars.useFrames != true ? com.greensock.TweenLite.rootTimeline : com.greensock.TweenLite.rootFramesTimeline) : this.vars.timeline;
      this.cachedStartTime = _loc4_.cachedTotalTime + this._delay;
      _loc4_.addChild(this);
      if(this.vars.reversed)
      {
         this.cachedReversed = true;
      }
      if(this.vars.paused)
      {
         this.paused = true;
      }
   }.version = 1.382;
}
class CSlot extends mh2lib.display.MH2Component
{
   var AddEventListener;
   var m_mcFocus;
   var m_mcHitArea;
   var hitArea;
   var m_tfName;
   var GainFocus;
   var LoseFocus;
   var m_mcRunes;
   var m_mcIcon;
   var m_tfAmount;
   var m_mcHighlite;
   static var DOUBLE_CLICK_DELAY = 500;
   static var DOUBLE_CLICK_MIN_MARGIN = 80;
   var m_iLastClick = 0;
   var m_pSlotUser = null;
   var m_aAcceptorMasks = [];
   var m_aRefuseMasks = [];
   var m_aMergeMasks = [];
   var m_pOnPressCallBack = null;
   var m_pOnFocusChangeCallBack = null;
   var m_pOnAcceptedItemCallBack = null;
   var m_pOnLostItemCallBack = null;
   var m_pOnDoubleClickCallBack = null;
   var m_iCollectionID = 0;
   var m_iID = 0;
   var m_bDragAndDropAllowed = true;
   var m_sAcceptorMaskName = "Mask";
   var m_sRefuseMaskName = "Mask";
   var m_sItemIdentifier = "";
   var m_bShowAmount = false;
   function CSlot()
   {
      super();
   }
   function Initialize()
   {
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      if(this.m_mcFocus)
      {
         this.m_mcFocus._visible = false;
      }
      if(this.m_mcHitArea)
      {
         this.hitArea = this.m_mcHitArea;
         this.m_mcHitArea._visible = false;
      }
      this.HighliteSelf(false);
      this.UpdateSlotGraphic();
   }
   function SetName(sName, aAcceptorMask, aMergeMask, aRefuseMask)
   {
      if(this.m_tfName)
      {
         this.m_tfName.text = sName;
      }
      this.m_aAcceptorMasks = aAcceptorMask;
      this.m_aMergeMasks = aMergeMask;
      this.m_aRefuseMasks = aRefuseMask;
   }
   function AddHitArea(mc)
   {
      this.hitArea = mc;
      mc._visible = false;
   }
   function GetContainedItem()
   {
      return this.m_pSlotUser;
   }
   function StartDrag(e)
   {
      if(this.m_pOnDoubleClickCallBack != null)
      {
         var _loc3_ = getTimer();
         if(this.m_iLastClick != 0 && (_loc3_ - this.m_iLastClick < CSlot.DOUBLE_CLICK_DELAY && _loc3_ - this.m_iLastClick > CSlot.DOUBLE_CLICK_MIN_MARGIN))
         {
            this.m_pOnDoubleClickCallBack(this);
            this.m_iLastClick = _loc3_ - CSlot.DOUBLE_CLICK_DELAY - 10;
         }
         else
         {
            if(this.m_bDragAndDropAllowed)
            {
               mh2lib.display.MH2Flow.s_pInstance.StartDrag(this);
            }
            this.m_pOnPressCallBack(this);
            this.m_iLastClick = _loc3_;
         }
      }
      else
      {
         if(this.m_bDragAndDropAllowed)
         {
            mh2lib.display.MH2Flow.s_pInstance.StartDrag(this);
         }
         this.m_pOnPressCallBack(this);
      }
   }
   function TestItemForSlot(pSimpleItem)
   {
      var _loc3_ = false;
      var _loc4_ = false;
      if(this.m_sItemIdentifier != "")
      {
         if(pSimpleItem.Name == this.m_sItemIdentifier)
         {
            _loc3_ = true;
         }
      }
      else if(this.m_aAcceptorMasks.length == 0)
      {
         _loc3_ = true;
      }
      else
      {
         var _loc5_ = 0;
         while(_loc5_ < this.m_aAcceptorMasks.length)
         {
            if(Number(Number(pSimpleItem[this.m_sAcceptorMaskName]) & Number(this.m_aAcceptorMasks[_loc5_])) == Number(this.m_aAcceptorMasks[_loc5_]))
            {
               _loc3_ = true;
               break;
            }
            _loc5_ = _loc5_ + 1;
         }
      }
      if(this.m_aRefuseMasks.length > 0)
      {
         var _loc6_ = 0;
         while(_loc6_ < this.m_aRefuseMasks.length)
         {
            if(Number(Number(pSimpleItem[this.m_sRefuseMaskName]) & Number(this.m_aRefuseMasks[_loc6_])) == Number(this.m_aRefuseMasks[_loc6_]))
            {
               _loc4_ = true;
               break;
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      return _loc3_ && !_loc4_;
   }
   function TestItemAsUpgrade(pSimpleItem)
   {
      var _loc3_ = Number(Number(pSimpleItem[this.m_sAcceptorMaskName]) & gui.vo.ItemEnum.SPECIAL_OIL) == gui.vo.ItemEnum.SPECIAL_OIL;
      if(this.GetContainedItem() != null && ((_loc3_ || this.m_pSlotUser.RuneSlotsAvail > 0) && this.m_aMergeMasks.length > 0))
      {
         var _loc4_ = 0;
         while(_loc4_ < this.m_aMergeMasks.length)
         {
            if(Number(Number(pSimpleItem[this.m_sAcceptorMaskName]) & Number(this.m_aMergeMasks[_loc4_])) == Number(this.m_aMergeMasks[_loc4_]))
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return false;
   }
   function AssignNewItem(pSimpleItem)
   {
      var _loc3_ = null;
      if(pSimpleItem == null)
      {
         _loc3_ = this.m_pSlotUser;
         this.m_pSlotUser = null;
         this.UpdateSlotGraphic();
         return _loc3_;
      }
      if(this.TestItemForSlot(pSimpleItem))
      {
         if(this.m_pSlotUser != null)
         {
            _loc3_ = this.m_pSlotUser;
         }
         this.m_pSlotUser = pSimpleItem;
         this.m_pOnAcceptedItemCallBack(this,pSimpleItem);
         this.UpdateSlotGraphic();
         return _loc3_;
      }
      if(this.TestItemAsUpgrade(pSimpleItem))
      {
         flash.external.ExternalInterface.call("UpgradeItem",this.m_pSlotUser.ID,pSimpleItem.ID);
         return pSimpleItem;
      }
      return pSimpleItem;
   }
   function ReceiveItem(pSimpleItem)
   {
      if(!this.m_bDragAndDropAllowed)
      {
         return pSimpleItem;
      }
      return this.AssignNewItem(pSimpleItem);
   }
   function LoseItem(pSimpleItem)
   {
      if(this.m_pOnLostItemCallBack != null)
      {
         this.m_pOnLostItemCallBack(this,pSimpleItem);
      }
   }
   function AskForFocus(e)
   {
      if(this.m_bDragAndDropAllowed)
      {
         mh2lib.display.MH2Flow.s_pInstance.SetFocus(this);
      }
      this.GainFocus();
      this.m_pOnFocusChangeCallBack(this,true);
   }
   function LoseDragTarget(e)
   {
      if(this.m_bDragAndDropAllowed)
      {
         mh2lib.display.MH2Flow.s_pInstance.LoseDragTarget(this);
      }
      this.LoseFocus();
      this.m_pOnFocusChangeCallBack(this,false);
   }
   function UpdateSlotGraphic()
   {
      if(this.m_pSlotUser != null)
      {
         if(this.m_mcRunes != undefined)
         {
            if(this.m_pSlotUser.RuneSlotsNum && this.m_pSlotUser.RuneSlotsNum > 0)
            {
               this.m_mcRunes._visible = true;
               this.m_mcRunes.gotoAndStop(1 + this.m_pSlotUser.RuneSlotsNum * this.m_pSlotUser.RuneSlotsNum + this.m_pSlotUser.RuneSlotsNum - this.m_pSlotUser.RuneSlotsAvail);
            }
            else
            {
               this.m_mcRunes._visible = false;
            }
         }
         if(this.m_mcIcon != undefined)
         {
            if(this.m_pSlotUser.Icon)
            {
               cx.utils.AssetLoader.loadAsset(this.m_mcIcon,this.m_pSlotUser.Icon);
            }
            else
            {
               this.m_mcIcon.unloadMovie();
            }
         }
         if(this.m_bShowAmount && this.m_tfAmount != undefined)
         {
            var _loc2_ = this.m_pSlotUser.Count;
            this.m_tfAmount.text = String(_loc2_);
         }
      }
      else
      {
         if(this.m_mcRunes != undefined)
         {
            this.m_mcRunes._visible = false;
         }
         if(this.m_mcIcon != undefined)
         {
            this.m_mcIcon.unloadMovie();
         }
         if(this.m_tfAmount != undefined)
         {
            this.m_tfAmount.text = "";
         }
      }
   }
   function HighliteSelf(bVisible)
   {
      if(this.m_mcHighlite)
      {
         this.m_mcHighlite._visible = bVisible;
      }
   }
}
class CList extends CSlot
{
   var m_mcHAContainer;
   var m_mcRowSelected;
   var createEmptyMovieClip;
   var getNextHighestDepth;
   var m_mcScroll;
   var m_tfEmptyMessage;
   var m_bHaveFocus;
   var m_mcRollOverEffect;
   var _sortDirection;
   var _parent;
   var m_mcBackground;
   var sort;
   static var SORT_ALPHA = 0;
   static var SORT_TIME = 1;
   static var SORT_PRICE = 2;
   static var SORT_WEIGHT = 3;
   static var _DEFAULT_SORT_METHOD = CList.SORT_TIME;
   var m_iCurrentVisiblePosition = 0;
   var m_iCurrentPosition = 0;
   var m_iCurrentOffset = 0;
   var m_iListSize = 0;
   var m_aNotFilteredItemsData = [];
   var m_aItemsData = [];
   var m_aRowGraphics = [];
   var m_aRowCurrentItems = [];
   var m_pRowSelectedCurrentItem = null;
   var m_sRowClassName = "";
   var m_sSelectedRowClassname = "";
   var m_mcContainer = null;
   var m_iRegularOffset = 0;
   var m_iSelectedOffset = 0;
   var m_fAccumulatedScrollOffset = 0;
   var m_pCFilter = null;
   var m_pSelectionChangedCallback = null;
   var _sortMethod = CList.SORT_TIME;
   function CList()
   {
      super();
      this.m_mcHAContainer.hitArea = this.m_mcHAContainer.m_mcHitArea;
      this.m_mcHAContainer.m_mcHitArea._visible = false;
   }
   function Initialize(sRowClassName, sSelectedRowClassname, iListSize)
   {
      this.m_sRowClassName = sRowClassName;
      this.m_sSelectedRowClassname = sSelectedRowClassname;
      this.m_iListSize = iListSize;
      this.m_iCurrentOffset = 0;
      this.m_iCurrentPosition = 0;
      this.m_iCurrentVisiblePosition = 0;
      this.m_aRowGraphics = [];
      this.m_mcRowSelected = null;
      this.m_mcContainer = this.createEmptyMovieClip("mcContainer",this.getNextHighestDepth());
      var _loc6_ = 0;
      var _loc7_ = 0;
      while(_loc7_ < iListSize - 1)
      {
         var _loc5_ = this.m_mcContainer.attachMovie(this.m_sRowClassName,"mcRegularRow_" + _loc7_,this.m_mcContainer.getNextHighestDepth());
         this.m_iRegularOffset = _loc5_._height;
         _loc6_ = _loc7_ * this.m_iRegularOffset;
         _loc5_._y = _loc6_;
         this.m_aRowGraphics.push(_loc5_);
         if(_loc5_.m_mcHitArea)
         {
            _loc5_.hitArea = _loc5_.m_mcHitArea;
            _loc5_.m_mcHitArea._visible = false;
         }
         _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.RowRollOver);
         _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.RowRollOut);
         _loc7_ = _loc7_ + 1;
      }
      _loc5_ = this.m_mcContainer.attachMovie(this.m_sSelectedRowClassname,"mcSelectedRow",this.m_mcContainer.getNextHighestDepth());
      this.m_iSelectedOffset = _loc5_._height;
      _loc5_._y = _loc6_ + this.m_iRegularOffset;
      if(_loc5_.m_mcHitArea)
      {
         _loc5_.hitArea = _loc5_.m_mcHitArea;
         _loc5_.m_mcHitArea._visible = false;
      }
      if(_loc5_.m_mcFocus)
      {
         _loc5_.m_mcFocus._visible = false;
      }
      _loc5_._visible = false;
      _loc5_.m_mcRunes.gotoAndStop(6);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      this.m_mcRowSelected = _loc5_;
      this.m_mcScroll.Initialize((iListSize - 1) * this.m_iRegularOffset + this.m_iSelectedOffset,15,iListSize,this.ScrollUsed,this);
      this.m_mcScroll._visible = false;
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_WHEEL,this.WheelUsed);
      var _loc8_ = this.m_iRegularOffset * (iListSize - 1) + this.m_iSelectedOffset;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100 * _loc8_ / this.m_mcHAContainer.m_mcHitArea._height;
   }
   function SetDefaultSortMethod(a_sortMethod)
   {
      if(_global.isNaN(a_sortMethod))
      {
         a_sortMethod = CList._DEFAULT_SORT_METHOD;
      }
      if(a_sortMethod < CList.SORT_ALPHA)
      {
         a_sortMethod = CList.SORT_ALPHA;
      }
      if(a_sortMethod > CList.SORT_WEIGHT)
      {
         a_sortMethod = CList.SORT_WEIGHT;
      }
      this._sortMethod = a_sortMethod;
   }
   function SetFilter(pCFilter)
   {
      this.m_pCFilter = pCFilter;
      if(this.m_pCFilter != null)
      {
         var _loc3_ = this.m_pCFilter.m_aFilters[0][1];
         if(_loc3_ == gui.vo.ItemEnum.TYPE_WEAPON)
         {
            this.AddSortPanel();
         }
      }
      pCFilter.Initialize(cx.utils.Delegate.create(this,this.FilterChanged),-1);
   }
   function FilterChanged()
   {
      this.SetData(this.m_aNotFilteredItemsData);
   }
   function SortAlpabetically(a, b)
   {
      var _loc4_ = a.Name;
      var _loc5_ = b.Name;
      if(_loc4_ < _loc5_)
      {
         return -1;
      }
      if(_loc4_ > _loc5_)
      {
         return 1;
      }
      return 0;
   }
   function SortByAmount(a, b)
   {
      var _loc4_ = a.Count;
      var _loc5_ = b.Count;
      if(_loc4_ && _loc5_)
      {
         if(_loc4_ > _loc5_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return 1;
         }
      }
      return 0;
   }
   function SetData(aData)
   {
      this.m_aNotFilteredItemsData = aData;
      if(this.m_pCFilter != null)
      {
         this.m_aItemsData = this.m_pCFilter.Filter(aData,CFilter.SOURCE_RAW_ITEMS);
         if(this.m_pCFilter != null && this.m_pCFilter._sortPanel != null)
         {
            var _loc3_ = this.m_pCFilter._sortPanel._selectedButton;
            if(_loc3_ != null)
            {
               _loc3_.sort();
            }
         }
         if(this.m_pCFilter.m_aFilters[0][1] == gui.vo.ItemEnum.TYPE_ELIXIR)
         {
            this.SortInventoryByName(1);
         }
         if(this.m_pCFilter.m_aFilters[0][1] == gui.vo.ElementsEnum.TYPE_VITRIOL)
         {
         }
      }
      else
      {
         this.m_aItemsData = aData;
         if(this._sortMethod == CList.SORT_ALPHA)
         {
            this.SortInventoryByName(1);
         }
      }
      if(this.m_aItemsData.length <= this.m_iListSize)
      {
         this.m_mcScroll._visible = false;
      }
      else
      {
         this.m_mcScroll._visible = true;
         this.m_mcScroll.SetNewMaxElements(this.m_aItemsData.length);
         this.m_mcScroll.UpdateGraphic();
      }
      if(this.m_aItemsData.length == 0)
      {
         this.m_tfEmptyMessage._visible = true;
         this.m_mcRowSelected._visible = false;
         var _loc4_ = 0;
         while(_loc4_ < this.m_aRowGraphics.length)
         {
            this.m_aRowGraphics[_loc4_]._visible = false;
            _loc4_ = _loc4_ + 1;
         }
         if(this.m_pSelectionChangedCallback != null)
         {
            this.m_pSelectionChangedCallback();
         }
         return undefined;
      }
      this.m_tfEmptyMessage._visible = false;
      this.m_mcRowSelected._visible = true;
      this.SetOffset(this.m_iCurrentOffset);
      if(this.m_iCurrentPosition >= this.m_aItemsData.length)
      {
         this.SetPosition(this.m_aItemsData.length - 1);
      }
      this.UpdateListData();
      this.UpdateGraphic();
   }
   function AttachData(pRow, pData)
   {
      var _loc6_ = flash.external.ExternalInterface.call("StringToUpper",pData.Name);
      if(pRow.m_tfName != undefined)
      {
         var _loc4_ = pRow.m_tfName;
         var _loc5_ = !pData.Name ? "" : _loc6_;
         this.StrictSizeText(_loc4_,_loc5_);
      }
      else if(pRow.m_mcName != undefined && pRow.m_mcName.m_tfName != undefined)
      {
         _loc4_ = pRow.m_mcName.m_tfName;
         _loc5_ = !pData.Name ? "" : _loc6_;
         this.StrictSizeText(_loc4_,_loc5_);
      }
      var _loc7_ = flash.external.ExternalInterface.call("StringToUpper",pData.Desc);
      if(pRow.m_mcDescription != undefined && pRow.m_mcDescription.m_tfDescription != undefined)
      {
         _loc4_ = pRow.m_mcDescription.m_tfDescription;
         _loc5_ = !pData.Desc ? "" : _loc7_;
         this.StrictSizeText(_loc4_,_loc5_);
      }
      var _loc8_ = 1;
      if(pRow.m_tfQuantity != undefined)
      {
         if(pData.Count && pData.Count > 1)
         {
            pRow.m_tfQuantity.text = pData.Count;
            _loc8_ = Number(pData.Count);
         }
         else
         {
            pRow.m_tfQuantity.text = "";
         }
      }
      if(pRow.m_tfMass != undefined)
      {
         if(pData.Mass)
         {
            pRow.m_tfMass.text = _global.MassParser(Number(pData.Mass) * _loc8_);
            pRow.m_mcIconMass._visible = true;
         }
         else
         {
            pRow.m_tfMass.text = "";
            pRow.m_mcIconMass._visible = false;
         }
      }
      if(pRow.m_tfPrice != undefined)
      {
         if(pData.Price)
         {
            pRow.m_tfPrice.text = String(Number(pData.Price) * _loc8_);
            pRow.m_mcIconPrice._visible = true;
         }
         else
         {
            pRow.m_tfPrice.text = "";
            pRow.m_mcIconPrice._visible = false;
         }
      }
      if(pRow.m_mcIcon != undefined)
      {
         if(pData.Icon)
         {
            cx.utils.AssetLoader.loadAsset(pRow.m_mcIcon,pData.Icon);
         }
         else
         {
            pRow.m_mcIcon.unloadMovie();
         }
         var _loc9_ = pRow.m_mcIcon._mcAlreadyReadIconOverlay;
         if(_loc9_ == null)
         {
            _loc9_ = pRow.createEmptyMovieClip("_mcAlreadyReadIconOverlay",pRow.getNextHighestDepth());
            _loc9_._x = pRow.m_mcIcon._x;
            _loc9_._y = pRow.m_mcIcon._y;
            _loc9_._alpha = 90;
         }
         if(pData._alreadyRead)
         {
            cx.utils.AssetLoader.loadAsset(_loc9_,"img://globals/gui/icons/tooltip/alreadyread_64x64.dds");
         }
         else
         {
            _loc9_.unloadMovie();
         }
      }
      else
      {
         var _loc10_ = null;
         if(pRow.m_tfName != null)
         {
            _loc10_ = pRow.m_tfName;
         }
         else if(pRow.m_mcName != null)
         {
            _loc10_ = pRow.m_mcName;
         }
         if(_loc10_ != null)
         {
            var _loc11_ = pRow._mcSmallAlreadyReadIconOverlay;
            if(_loc11_ == null)
            {
               _loc11_ = pRow.createEmptyMovieClip("_mcSmallAlreadyReadIconOverlay",pRow.getNextHighestDepth());
               _loc11_._x = pRow.m_tfQuantity._x - 15;
               _loc11_._y = _loc10_._y;
               _loc11_._y += 5;
               _loc11_._alpha = 90;
            }
            if(pData._alreadyRead)
            {
               cx.utils.AssetLoader.loadAsset(_loc11_,"img://globals/gui/icons/tooltip/alreadyread_15x15.dds");
            }
            else
            {
               _loc11_.unloadMovie();
            }
         }
      }
      if(pRow.m_mcRunes != undefined)
      {
         if(pData.RuneSlotsNum && pData.RuneSlotsNum > 0)
         {
            pRow.m_mcRunes._visible = true;
            pRow.m_mcRunes.gotoAndStop(1 + pData.RuneSlotsNum * pData.RuneSlotsNum + pData.RuneSlotsNum - pData.RuneSlotsAvail);
         }
         else
         {
            pRow.m_mcRunes._visible = false;
         }
      }
   }
   function UpdateListData()
   {
      var _loc2_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < this.m_iListSize)
      {
         if(this.m_iCurrentOffset + _loc3_ == this.m_iCurrentPosition)
         {
            if(this.m_pRowSelectedCurrentItem != this.m_aItemsData[this.m_iCurrentPosition])
            {
               this.AttachData(this.m_mcRowSelected,this.m_aItemsData[this.m_iCurrentPosition]);
               this.m_pRowSelectedCurrentItem = this.m_aItemsData[this.m_iCurrentPosition];
            }
         }
         else
         {
            if(this.m_iCurrentOffset + _loc3_ > this.m_aItemsData.length)
            {
               this.m_aRowGraphics[_loc2_]._visible = false;
            }
            else
            {
               this.m_aRowGraphics[_loc2_]._visible = true;
               if(this.m_aRowCurrentItems[_loc2_] != this.m_aItemsData[this.m_iCurrentOffset + _loc3_])
               {
                  this.AttachData(this.m_aRowGraphics[_loc2_],this.m_aItemsData[this.m_iCurrentOffset + _loc3_]);
                  this.m_aRowCurrentItems[_loc2_] = this.m_aItemsData[this.m_iCurrentOffset + _loc3_];
               }
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      if(this.m_pSelectionChangedCallback != null)
      {
         this.m_pSelectionChangedCallback();
      }
   }
   function UpdateGraphic()
   {
      if(this.m_iCurrentVisiblePosition < 0)
      {
         this.m_iCurrentVisiblePosition = 0;
      }
      else if(this.m_iCurrentVisiblePosition >= this.m_iListSize)
      {
         this.m_iCurrentVisiblePosition = this.m_iListSize - 1;
      }
      var _loc2_ = 0;
      var _loc3_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < this.m_iListSize)
      {
         if(_loc5_ + this.m_iCurrentOffset < this.m_aItemsData.length)
         {
            if(_loc5_ != this.m_iCurrentVisiblePosition)
            {
               var _loc4_ = this.m_aRowGraphics[_loc2_];
               _loc4_._y = _loc3_;
               _loc4_._visible = true;
               _loc3_ += this.m_iRegularOffset;
               _loc2_ = _loc2_ + 1;
            }
            else
            {
               _loc4_ = this.m_mcRowSelected;
               _loc4_._y = _loc3_;
               _loc4_._visible = true;
               _loc3_ += this.m_iSelectedOffset;
            }
         }
         else if(_loc5_ != this.m_iCurrentVisiblePosition)
         {
            _loc4_ = this.m_aRowGraphics[_loc2_];
            _loc4_._visible = false;
            _loc2_ = _loc2_ + 1;
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function RowRollOver(e)
   {
      this.m_mcRowSelected.gotoAndPlay("Highlight");
      var _loc3_ = this.GetIndex(e.m_pCaller);
      if(this.m_iCurrentVisiblePosition <= _loc3_)
      {
         _loc3_ = _loc3_ + 1;
      }
      this.SetVisiblePosition(_loc3_);
      this.UpdateListData();
      this.UpdateGraphic();
      this.AskForFocus(e);
   }
   function RowRollOut(e)
   {
      e.m_pCaller.gotoAndPlay("Normal");
   }
   function HandleInput(value)
   {
      return value;
   }
   function GetIndex(mc)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.m_aRowGraphics.length)
      {
         if(mc == this.m_aRowGraphics[_loc3_])
         {
            return _loc3_;
         }
         _loc3_ = _loc3_ + 1;
      }
      return 0;
   }
   function SetPosition(iPosition)
   {
      this.m_iCurrentPosition = iPosition;
      if(this.m_iCurrentPosition < 0)
      {
         this.m_iCurrentPosition = 0;
      }
      else if(this.m_iCurrentPosition > this.m_aItemsData.length - 1)
      {
         this.m_iCurrentPosition = this.m_aItemsData.length - 1;
      }
      this.m_iCurrentVisiblePosition = this.m_iCurrentPosition - this.m_iCurrentOffset;
      if(this.m_iCurrentVisiblePosition < 0)
      {
         this.m_iCurrentOffset += this.m_iCurrentVisiblePosition;
         this.m_iCurrentVisiblePosition = 0;
      }
      else if(this.m_iCurrentVisiblePosition > this.m_iListSize)
      {
         this.m_iCurrentOffset += this.m_iCurrentVisiblePosition - this.m_iListSize;
         this.m_iCurrentVisiblePosition = 0;
      }
   }
   function SetVisiblePosition(iPosition)
   {
      this.m_iCurrentVisiblePosition = iPosition;
      this.SetPosition(this.m_iCurrentOffset + this.m_iCurrentVisiblePosition);
   }
   function SetOffset(iOffset)
   {
      this.m_iCurrentOffset = iOffset;
      if(this.m_iCurrentOffset + this.m_iListSize > this.m_aItemsData.length)
      {
         if(this.m_aItemsData.length <= this.m_iListSize)
         {
            this.m_iCurrentOffset = 0;
         }
         else
         {
            this.m_iCurrentOffset = this.m_aItemsData.length - this.m_iListSize;
         }
      }
      if(this.m_iCurrentOffset < 0)
      {
         this.m_iCurrentOffset = 0;
      }
      this.m_iCurrentVisiblePosition = this.m_iCurrentPosition - this.m_iCurrentOffset;
      if(this.m_iCurrentVisiblePosition < 0)
      {
         this.m_iCurrentPosition -= this.m_iCurrentVisiblePosition;
         this.m_iCurrentVisiblePosition = 0;
      }
      else if(this.m_iCurrentVisiblePosition > this.m_iListSize - 1)
      {
         this.m_iCurrentPosition -= this.m_iCurrentVisiblePosition - this.m_iListSize + 1;
         this.m_iCurrentVisiblePosition = this.m_iListSize - 1;
      }
   }
   function ScrollUsed(pProvider, iOffset)
   {
      if(pProvider == null)
      {
         return undefined;
      }
      var _loc4_ = pProvider.m_iCurrentPosition;
      pProvider.SetOffset(iOffset);
      if(_loc4_ != pProvider.m_iCurrentPosition)
      {
         pProvider.m_mcRowSelected.gotoAndPlay("Highlight");
      }
      pProvider.UpdateListData();
      pProvider.UpdateGraphic();
   }
   function WheelUsed(e, iValue)
   {
      if(this.m_bHaveFocus)
      {
         this.ScrollUsed(this,this.m_iCurrentOffset + (- iValue));
         this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
      }
   }
   function GetContainedItem()
   {
      return this.m_aItemsData[this.m_iCurrentPosition];
   }
   function onIK()
   {
      var _loc2_ = false;
      switch(mh2lib.display.MH2Flow.GetKeyCode())
      {
         case mh2lib.utils.MH2Key.ARROW_UP:
            if(this.m_aItemsData.length != 0)
            {
               if(this.m_iCurrentVisiblePosition > 0)
               {
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition - 1);
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
               else if(this.m_iCurrentOffset > 0)
               {
                  this.ScrollUsed(this,this.m_iCurrentOffset - 1);
                  this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition - 1);
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
            }
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.ARROW_DOWN:
            if(this.m_aItemsData.length != 0)
            {
               if(this.m_iCurrentVisiblePosition < this.m_iListSize - 1)
               {
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition + 1);
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
               else
               {
                  this.ScrollUsed(this,this.m_iCurrentOffset + 1);
                  this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition + 1);
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
            }
            _loc2_ = true;
      }
      return _loc2_;
   }
   function AskForFocus(e)
   {
      mh2lib.display.MH2Flow.s_pInstance.SetFocus(this);
      this.m_bHaveFocus = true;
      if(this.m_mcRowSelected.m_mcFocus)
      {
         this.m_mcRowSelected.m_mcFocus._visible = true;
      }
      this.m_pOnFocusChangeCallBack(this,true);
   }
   function LoseDragTarget(e)
   {
      mh2lib.display.MH2Flow.s_pInstance.LoseDragTarget(this);
      this.m_bHaveFocus = false;
      if(this.m_mcRowSelected.m_mcFocus)
      {
         this.m_mcRowSelected.m_mcFocus._visible = false;
      }
      this.m_pOnFocusChangeCallBack(this,false);
   }
   function StrictSizeText(pTF, sText)
   {
      pTF.autoSize = false;
      sText += " ";
      pTF.text = sText;
      if(pTF.textWidth > pTF._width)
      {
         var _loc4_ = 1;
         while(_loc4_ <= sText.length + 1)
         {
            pTF.text = sText.substring(0,_loc4_);
            if(pTF.textWidth > pTF._width)
            {
               pTF.text = sText.substring(0,_loc4_ - 3) + "...";
               break;
            }
            _loc4_ += 1;
         }
      }
   }
   function AddSortPanel()
   {
      if(!this.m_pCFilter)
      {
         return undefined;
      }
      var _loc2_ = this.m_pCFilter.createEmptyMovieClip("_sortPanel",this.m_pCFilter.getNextHighestDepth());
      _loc2_._x = this.m_pCFilter.m_mcKindIcon0._x - 30;
      _loc2_._y = this.m_pCFilter.m_mcKindIcon0._y + this.m_pCFilter.m_mcKindIcon0._height - 5;
      this.CreateSortButton(_loc2_,1,0,0,"alpha_15x15.dds","SortInventoryByName","Sort by name");
      this.CreateSortButton(_loc2_,2,30,0,"time_15x15.dds","SortInventoryByOriginalOrder","Sort by time acquired");
      this.CreateSortButton(_loc2_,3,0,30,"waga_15x15.dds","SortInventoryByWeight","Sort by individual weight");
      this.CreateSortButton(_loc2_,4,30,30,"orens_15x15.dds","SortInventoryByOrens","Sort by individual price");
      _loc2_["SortButton" + (this._sortMethod + 1)].onPress();
   }
   function CreateSortButton(a_mcParent, a_nEnumerator, a_xPos, a_yPos, a_sIconName, a_sSortFn, a_sTooltipText)
   {
      var host = this;
      var sSortFn = a_sSortFn;
      var _loc9_ = a_mcParent.attachMovie("FilterButton","SortButton" + a_nEnumerator,a_mcParent.getNextHighestDepth());
      _loc9_.nOrd = a_nEnumerator;
      _loc9_.m_sTooltipText = a_sTooltipText;
      _loc9_._width = 30;
      _loc9_._height = 30;
      var _loc10_ = _loc9_.m_mcIcon;
      _loc10_._x += 8;
      _loc10_._y += 8;
      cx.utils.AssetLoader.loadAsset(_loc10_,"img://globals/gui/icons/tooltip/" + a_sIconName,15,15);
      _loc9_._x = a_xPos;
      _loc9_._y = a_yPos;
      _loc9_.m_mcRollOverEffect._visible = false;
      _loc9_.m_mcBackground._visible = false;
      _loc9_._sortDirection = 1;
      _loc9_.onRollOver = function()
      {
         this.m_mcRollOverEffect._visible = true;
      };
      _loc9_.onRollOut = function()
      {
         this.m_mcRollOverEffect._visible = false;
      };
      _loc9_.sort = function()
      {
         if(host.m_aItemsData.length < 1)
         {
            return undefined;
         }
         host[sSortFn](this._sortDirection);
         host.UpdateListData();
         host.UpdateGraphic();
      };
      _loc9_.onPress = function()
      {
         if(this._parent._selectedButton != this)
         {
            var _loc2_ = 1;
            this._sortDirection = 1;
            while(this._parent["SortButton" + _loc2_] != null)
            {
               this._parent["SortButton" + _loc2_].m_mcBackground._visible = false;
               _loc2_ = _loc2_ + 1;
            }
            this._parent._selectedButton = this;
            this.m_mcBackground._visible = true;
         }
         else
         {
            this._sortDirection *= -1;
         }
         if(this._sortDirection < 0)
         {
            this.m_mcBackground.transform.colorTransform = new flash.geom.ColorTransform(2,1,1,1,0,0,0,0);
         }
         else
         {
            this.m_mcBackground.transform.colorTransform = new flash.geom.ColorTransform(1,1,1,1,0,0,0,0);
         }
         this.sort();
      };
   }
   function SortInventoryWithComparator(fnSortFunc, _sortDirection)
   {
      if(this.m_aItemsData.length < 1)
      {
         return undefined;
      }
      if(_sortDirection > 0)
      {
         this.m_aItemsData.sort(fnSortFunc,Array.NUMERIC);
      }
      else
      {
         this.m_aItemsData.sort(fnSortFunc,Array.NUMERIC | Array.DESCENDING);
      }
   }
   function SortOnInventoryWithField(sField, _sortDirection)
   {
      if(this.m_aItemsData.length < 1)
      {
         return undefined;
      }
      this.m_aItemsData.sortOn([sField,"ID"],_sortDirection <= 0 ? Array.NUMERIC | Array.DESCENDING : Array.NUMERIC);
   }
   function SortInventoryByName(_sortDirection)
   {
      if(this.m_aItemsData.length < 1)
      {
         return undefined;
      }
      var _loc3_ = _global.gfxExtensions;
      _global.gfxExtensions = true;
      this.m_aItemsData.sortOn("Name",_sortDirection <= 0 ? Array.LOCALE | Array.CASEINSENSITIVE | Array.DESCENDING : Array.LOCALE | Array.CASEINSENSITIVE);
      _global.gfxExtensions = _loc3_;
   }
   function SortInventoryByOriginalOrder(_sortDirection)
   {
      _sortDirection *= -1;
      this.SortOnInventoryWithField("_OrigIndex",_sortDirection);
   }
   function SortInventoryByWeight(_sortDirection)
   {
      _sortDirection *= -1;
      this.SortInventoryWithComparator(function(a, b)
      {
         var _loc4_ = Number(_global.MassParser(a.Mass));
         var _loc5_ = Number(_global.MassParser(b.Mass));
         var _loc6_ = 1;
         if(a.Count && a.Count > 1)
         {
            _loc6_ = Number(a.Count);
         }
         var _loc7_ = 1;
         if(b.Count && b.Count > 1)
         {
            _loc7_ = Number(b.Count);
         }
         if(_loc4_ * _loc6_ < _loc5_ * _loc7_)
         {
            return -1;
         }
         if(_loc4_ * _loc6_ > _loc5_ * _loc7_)
         {
            return 1;
         }
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         if(a.ID < b.ID)
         {
            return -1;
         }
         if(a.ID > b.ID)
         {
            return 1;
         }
         return 0;
      }
      ,_sortDirection);
   }
   function SortInventoryByOrens(_sortDirection)
   {
      _sortDirection *= -1;
      this.SortInventoryWithComparator(function(a, b)
      {
         var _loc4_ = Number(a.Price);
         var _loc5_ = Number(b.Price);
         var _loc6_ = 1;
         if(a.Count && a.Count > 1)
         {
            _loc6_ = Number(a.Count);
         }
         var _loc7_ = 1;
         if(b.Count && b.Count > 1)
         {
            _loc7_ = Number(b.Count);
         }
         if(_loc4_ * _loc6_ < _loc5_ * _loc7_)
         {
            return -1;
         }
         if(_loc4_ * _loc6_ > _loc5_ * _loc7_)
         {
            return 1;
         }
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         if(a.ID < b.ID)
         {
            return -1;
         }
         if(a.ID > b.ID)
         {
            return 1;
         }
         return 0;
      }
      ,_sortDirection);
   }
}
if(!gui.vo.ItemClassEnum)
{
   _loc1_ = _global.gui.vo.ItemClassEnum = function()
   {
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
   _global.gui.vo.ItemClassEnum = function()
   {
   }.COMMON = 1;
   _global.gui.vo.ItemClassEnum = function()
   {
   }.MAGIC = 2;
   _global.gui.vo.ItemClassEnum = function()
   {
   }.RARE = 3;
   _global.gui.vo.ItemClassEnum = function()
   {
   }.EPIC = 4;
}
if(!com.greensock.core.SimpleTimeline)
{
   _global.com.greensock.core.SimpleTimeline = function(vars)
   {
      super(0,vars);
   } extends com.greensock.core.TweenCore;
   _loc1_ = _global.com.greensock.core.SimpleTimeline = function(vars)
   {
      super(0,vars);
   }.prototype;
   _loc1_.addChild = function(tween)
   {
      if(!tween.cachedOrphan && tween.timeline != undefined)
      {
         tween.timeline.remove(tween,true);
      }
      tween.timeline = this;
      if(tween.gc)
      {
         tween.setEnabled(true,true);
      }
      if(this._firstChild)
      {
         this._firstChild.prevNode = tween;
      }
      tween.nextNode = this._firstChild;
      this._firstChild = tween;
      tween.prevNode = undefined;
      tween.cachedOrphan = false;
   };
   _loc1_.remove = function(tween, skipDisable)
   {
      if(tween.cachedOrphan)
      {
         return undefined;
      }
      if(skipDisable != true)
      {
         tween.setEnabled(false,true);
      }
      if(tween.nextNode)
      {
         tween.nextNode.prevNode = tween.prevNode;
      }
      else if(this._lastChild == tween)
      {
         this._lastChild = tween.prevNode;
      }
      if(tween.prevNode)
      {
         tween.prevNode.nextNode = tween.nextNode;
      }
      else if(this._firstChild == tween)
      {
         this._firstChild = tween.nextNode;
      }
      tween.cachedOrphan = true;
   };
   _loc1_.renderTime = function(time, suppressEvents, force)
   {
      var _loc5_ = this._firstChild;
      this.cachedTotalTime = time;
      this.cachedTime = time;
      while(_loc5_)
      {
         var _loc7_ = _loc5_.nextNode;
         if(_loc5_.active || time >= _loc5_.cachedStartTime && (!_loc5_.cachedPaused && !_loc5_.gc))
         {
            if(!_loc5_.cachedReversed)
            {
               _loc5_.renderTime((time - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,suppressEvents,false);
            }
            else
            {
               var _loc6_ = !_loc5_.cacheIsDirty ? _loc5_.cachedTotalDuration : _loc5_.totalDuration;
               _loc5_.renderTime(_loc6_ - (time - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,suppressEvents,false);
            }
         }
         _loc5_ = _loc7_;
      }
   };
   _loc1_.__get__rawTime = function()
   {
      return this.cachedTotalTime;
   };
   _loc1_.addProperty("rawTime",_loc1_.__get__rawTime,function()
   {
   }
   );
   ASSetPropFlags(_loc1_,null,1);
}
class CAmountController extends mh2lib.display.MH2Component
{
   var AddEventListener;
   var m_btLeft;
   var m_btRight;
   var fxPointer;
   var fxScrollArrowLeft;
   var fxScrollArrowRight;
   var m_tfMainInfo;
   var m_tfValueMin;
   var m_tfValueMax;
   var m_mcMaxGuide;
   var m_mcMinGuide;
   var m_tfValueCurrent;
   var _xmouse;
   var m_iMinValue = 0;
   var m_iMaxValue = 1;
   var m_iCurrentValue = 0;
   var m_iScrollingOffset = 0;
   var m_iScrollingLength = 0;
   var m_iScrollingStartOffset = 0;
   var m_pLeftCallBack = null;
   var m_pRightCallBack = null;
   function CAmountController()
   {
      super();
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED,this.CreateEvents);
   }
   function CreateEvents(e)
   {
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_WHEEL,this.WheelUsed);
      this.m_btLeft.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.LeftCallBack);
      this.m_btLeft.SetGraphic(CNormalButton.ACTION_NO);
      this.m_btRight.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.RightCallBack);
      this.m_btRight.SetGraphic(CNormalButton.ACTION_YES);
      this.fxPointer.onPress = cx.utils.Delegate.create(this,this.ScrollDragStart);
      this.m_btRight.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_UP_ANYWHERE,this.StopDrag);
      this.fxScrollArrowLeft.onPress = cx.utils.Delegate.create(this,this.ArrowPressed,[-1]);
      this.fxScrollArrowRight.onPress = cx.utils.Delegate.create(this,this.ArrowPressed,[1]);
      this.fxScrollArrowLeft.onRollOver = cx.utils.Delegate.create(this,this.ButtonStateChange,[this.fxScrollArrowLeft,true]);
      this.fxScrollArrowRight.onRollOver = cx.utils.Delegate.create(this,this.ButtonStateChange,[this.fxScrollArrowRight,true]);
      this.fxScrollArrowLeft.onRollOut = cx.utils.Delegate.create(this,this.ButtonStateChange,[this.fxScrollArrowLeft,false]);
      this.fxScrollArrowRight.onRollOut = cx.utils.Delegate.create(this,this.ButtonStateChange,[this.fxScrollArrowRight,false]);
   }
   function Initialize(sTitle, sLeftAnswer, pLeftCallBack, sRightAnswer, pRightCallBack, iMinimum, iMaximum)
   {
      if(iMinimum > iMaximum)
      {
         iMaximum = iMinimum;
      }
      this.m_tfMainInfo.text = sTitle;
      this.m_btLeft.SetText(sLeftAnswer,"");
      this.m_btRight.SetText("",sRightAnswer);
      this.m_btLeft.SetBacgroundVisibility(false);
      this.m_btRight.SetBacgroundVisibility(false);
      this.m_tfValueMin.text = String(iMinimum);
      this.m_tfValueMax.text = String(iMaximum);
      this.m_pLeftCallBack = pLeftCallBack;
      this.m_pRightCallBack = pRightCallBack;
      this.m_iMinValue = iMinimum;
      this.m_iMaxValue = iMaximum;
      this.m_iCurrentValue = iMinimum;
      this.m_iScrollingLength = this.m_mcMaxGuide._x - this.m_mcMinGuide._x;
      this.m_iScrollingOffset = this.m_mcMinGuide._x;
      this.UpdateGraphic();
   }
   function UpdateGraphic()
   {
      this.m_iCurrentValue = Math.max(this.m_iMinValue,Math.min(this.m_iCurrentValue,this.m_iMaxValue));
      if(this.m_iMaxValue == this.m_iMinValue)
      {
         var _loc2_ = 1;
      }
      else
      {
         _loc2_ = 100 * (this.m_iCurrentValue - this.m_iMinValue) / (this.m_iMaxValue - this.m_iMinValue);
      }
      if(_loc2_ <= 0)
      {
         _loc2_ = 1;
      }
      else if(_loc2_ > 100)
      {
         _loc2_ = 100;
      }
      this.fxPointer.gotoAndStop(Math.round(_loc2_));
      this.m_tfValueCurrent.text = String(this.m_iCurrentValue);
   }
   function WheelUsed(fValue)
   {
      this.m_iCurrentValue = Math.max(this.m_iMinValue,Math.min(this.m_iCurrentValue + fValue,this.m_iMaxValue));
      this.UpdateGraphic();
   }
   function LeftCallBack(e)
   {
      this.m_pLeftCallBack(this.m_iCurrentValue);
   }
   function RightCallBack(e)
   {
      this.m_pRightCallBack(this.m_iCurrentValue);
   }
   function ScrollDragStart(e)
   {
      this.fxPointer.onMouseMove = cx.utils.Delegate.create(this,this.ScrollMove);
      this.m_iScrollingStartOffset = this.m_iScrollingOffset;
   }
   function ScrollMove(e)
   {
      var _loc4_ = this.m_iMaxValue - this.m_iMinValue;
      if(_loc4_ != 0)
      {
         var _loc3_ = this.m_iScrollingLength / _loc4_;
         this.m_iCurrentValue = Math.floor(0.5 + (this._xmouse - this.m_iScrollingOffset) / _loc3_) + this.m_iMinValue;
      }
      else
      {
         this.m_iCurrentValue = this.m_iMinValue;
      }
      this.UpdateGraphic();
   }
   function StopDrag(e)
   {
      this.fxPointer.onMouseMove = null;
   }
   function ArrowPressed(iValue)
   {
      this.m_iCurrentValue += iValue;
      this.UpdateGraphic();
   }
   function ButtonStateChange(mc, bOver)
   {
      if(bOver)
      {
         mc.gotoAndStop("over");
      }
      else
      {
         mc.gotoAndStop("idle");
      }
   }
   function onIK()
   {
      var _loc2_ = false;
      switch(mh2lib.display.MH2Flow.GetKeyCode())
      {
         case mh2lib.utils.MH2Key.ESC:
         case mh2lib.utils.MH2Key.PAD_B_CIRCLE:
            this.LeftCallBack();
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.SPACE:
         case mh2lib.utils.MH2Key.ENTER:
         case mh2lib.utils.MH2Key.PAD_A_CROSS:
         case mh2lib.utils.MH2Key.PAD_Y_TRIANGLE:
            this.RightCallBack();
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.ARROW_UP:
         case mh2lib.utils.MH2Key.ARROW_RIGHT:
            this.ArrowPressed(1);
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.PAD_RB:
            this.ArrowPressed(10);
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.PAD_RT:
            this.ArrowPressed(100);
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.ARROW_DOWN:
         case mh2lib.utils.MH2Key.ARROW_LEFT:
            this.ArrowPressed(-1);
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.PAD_LB:
            this.ArrowPressed(-10);
            _loc2_ = true;
            break;
         case mh2lib.utils.MH2Key.PAD_LT:
            this.ArrowPressed(-100);
            _loc2_ = true;
      }
      return _loc2_;
   }
}
if(!com.greensock.plugins.AutoAlphaPlugin)
{
   _global.com.greensock.plugins.AutoAlphaPlugin = function()
   {
      super();
      this.propName = "autoAlpha";
      this.overwriteProps = ["_alpha","_visible"];
   } extends com.greensock.plugins.VisiblePlugin;
   _loc1_ = _global.com.greensock.plugins.AutoAlphaPlugin = function()
   {
      super();
      this.propName = "autoAlpha";
      this.overwriteProps = ["_alpha","_visible"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      this._target = target;
      this.addTween(target,"_alpha",target._alpha,value,"_alpha");
      return true;
   };
   _loc1_.killProps = function(lookup)
   {
      super.killProps(lookup);
      this._ignoreVisible = lookup._visible != undefined;
   };
   _loc1_.__set__changeFactor = function(n)
   {
      this.updateTweens(n);
      if(!this._ignoreVisible)
      {
         this._target._visible = this._target._alpha != 0;
      }
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.AutoAlphaPlugin = function()
   {
      super();
      this.propName = "autoAlpha";
      this.overwriteProps = ["_alpha","_visible"];
   }.API = 1;
}
class gui.PanelInvPlus extends mh2lib.display.MH2Panel
{
   var FitBackground;
   var fxPath;
   var lbMassLabel;
   var lbOrensLabel;
   var m_btExit;
   var ExitPanel;
   var m_mcBook;
   var m_tfQuickSlotName;
   var m_mcFilter;
   var m_mcItemList;
   var m_mcSlot1;
   var m_mcSlot2;
   var m_mcSlot3;
   var m_mcSlot4;
   var m_mcSlot5;
   var m_mcSlot6;
   var m_mcSlot7;
   var m_mcTrash;
   var m_mcTrashCover;
   var m_mcCover;
   var m_mcAmountController;
   var m_mcPopupInfo;
   var bTrashTutorial;
   var m_mcTrashPadIcon;
   var m_mcFirstSwordIcon;
   var m_mcSecondSwordIcon;
   var lbMassValue;
   var GetKeyFocuesedSlot;
   var SetKeyFocuesedSlot;
   var m_mcRItemData;
   var m_mcLItemData;
   var m_mcCurrentlySelectedSlot;
   var lbOrensValue;
   var hitArea;
   var m_mcQSlot1;
   var m_mcQSlot5;
   var SetData;
   var m_aNotFilteredItemsData;
   static var COLLECTION_LIST = 0;
   static var COLLECTION_EQUIPMENT = 1;
   static var COLLECTION_QUICKSLOT = 2;
   function PanelInvPlus()
   {
      super();
   }
   function Construct()
   {
      this.FitBackground();
      this.fxPath.fxIcon.gotoAndStop("PanelInv");
      this.fxPath.lbPath.text = "[[locale.PanelInv]]";
      this.lbMassLabel.text = "[[locale.inv.MassLabel]]";
      this.lbOrensLabel.text = "[[locale.inv.PriceLabel]]";
      this.m_btExit.SetGraphic(CNormalButton.ESCAPE);
      this.m_btExit.SetText("","[[locale.elixirs.ActionExit]]");
      this.m_btExit.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.ExitPanel);
      this.m_mcBook.m_btExit.SetGraphic(CNormalButton.ESCAPE);
      this.m_mcBook.m_btExit.SetText("","[[locale.elixirs.ActionExit]]");
      this.m_mcBook.m_btExit.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StopReading);
      this.m_tfQuickSlotName.text = "[[locale.inv.lbQuickSlots]]";
      this.m_mcFilter.ConfigureFilter([["[[locale.inv.ListMelee]]",gui.vo.ItemEnum.TYPE_WEAPON],["[[locale.inv.ListRange]]",gui.vo.ItemEnum.TYPE_RANGE],["[[locale.inv.ListArmor]]",gui.vo.ItemEnum.TYPE_ARMOR],["[[locale.inv.ListUpgrade]]",gui.vo.ItemEnum.TYPE_ARMOR_UPGRADES | gui.vo.ItemEnum.TYPE_WEAPON_UPGRADES],["[[locale.inv.ListElixir]]",gui.vo.ItemEnum.TYPE_ELIXIR],["[[locale.inv.ListTrap]]",gui.vo.ItemEnum.TYPE_TRAPS],["[[locale.inv.ListPetard]]",gui.vo.ItemEnum.TYPE_PETARD],["[[locale.inv.ListBook]]",gui.vo.ItemEnum.TYPE_BOOK],["[[locale.inv.ListTrophy]]",gui.vo.ItemEnum.TYPE_TROPHY],["[[locale.inv.ListMutagen]]",gui.vo.ItemEnum.TYPE_MUTAGEN],["[[locale.inv.ListMultemyIngredients]]",gui.vo.ItemEnum.TYPE_ALCHEMY_INGREDIENTS],["[[locale.inv.ListCraftingIngredients]]",gui.vo.ItemEnum.TYPE_CRAFTING_INGREDIENTS],["[[locale.inv.ListCraftingSchematics]]",gui.vo.ItemEnum.TYPE_CRAFTING_SCHEMATICS],["[[locale.Lures]]",gui.vo.ItemEnum.TYPE_LURES],["[[locale.inv.ListQuest]]",gui.vo.ItemEnum.QUEST],["[[locale.inv.JUNK]]",gui.vo.ItemEnum.TYPE_JUNK],["[[locale.inv.ListAll]]",gui.vo.ItemEnum.ALL]],gui.vo.ItemEnum.ACTIVE);
      this.m_mcItemList.Initialize("ListRowNormal","ListRowSelected",7);
      this.m_mcItemList.SetFilter(this.m_mcFilter);
      this.m_mcItemList.m_iID = 1;
      this.m_mcItemList.m_iCollectionID = gui.PanelInvPlus.COLLECTION_LIST;
      this.m_mcItemList.m_pOnDoubleClickCallBack = cx.utils.Delegate.create2(this,this.OnDoubleClick);
      this.m_mcItemList.m_pOnFocusChangeCallBack = cx.utils.Delegate.create2(this,this.OnListGainFocus);
      this.m_mcItemList.m_pSelectionChangedCallback = cx.utils.Delegate.create(this,this.ListChanged);
      this.m_mcItemList.ReceiveItem = cx.utils.Delegate.create2(this.m_mcItemList,this.ReceiveItem);
      this.m_mcItemList.LoseItem = cx.utils.Delegate.create2(this.m_mcItemList,this.LoseItem);
      this.m_mcSlot1.SetName("[[locale.inv.lbSteelSword]]",[gui.vo.ItemEnum.SLOT_STEEL],[gui.vo.ItemEnum.TYPE_WEAPON_UPGRADES],[]);
      this.m_mcSlot2.SetName("[[locale.inv.lbSilverSword]]",[gui.vo.ItemEnum.SLOT_SILVER],[gui.vo.ItemEnum.TYPE_WEAPON_UPGRADES],[]);
      this.m_mcSlot3.SetName("[[locale.inv.lbArmor]]",[gui.vo.ItemEnum.SLOT_ARMOR],[gui.vo.ItemEnum.TYPE_ARMOR_UPGRADES],[]);
      this.m_mcSlot4.SetName("[[locale.inv.lbTrophy]]",[gui.vo.ItemEnum.SLOT_TROPHY],[],[]);
      this.m_mcSlot5.SetName("[[locale.inv.lbBoots]]",[gui.vo.ItemEnum.SLOT_BOOTS],[gui.vo.ItemEnum.TYPE_ARMOR_UPGRADES],[]);
      this.m_mcSlot6.SetName("[[locale.inv.lbPants]]",[gui.vo.ItemEnum.SLOT_PANTS],[gui.vo.ItemEnum.TYPE_ARMOR_UPGRADES],[]);
      this.m_mcSlot7.SetName("[[locale.inv.lbGauntlets]]",[gui.vo.ItemEnum.SLOT_GAUNTLETS],[gui.vo.ItemEnum.TYPE_ARMOR_UPGRADES],[]);
      var _loc3_ = null;
      var _loc2_ = 1;
      while(_loc2_ <= 7)
      {
         _loc3_ = this["m_mcSlot" + _loc2_];
         _loc3_.gotoAndStop("Normal");
         _loc3_.Initialize();
         _loc3_.m_pOnPressCallBack = cx.utils.Delegate.create2(this,this.SlotPressed);
         _loc3_.m_pOnFocusChangeCallBack = cx.utils.Delegate.create2(this,this.SlotFocusChanged);
         _loc3_.m_pOnDoubleClickCallBack = cx.utils.Delegate.create2(this,this.OnDoubleClick);
         _loc3_.m_pOnLostItemCallBack = cx.utils.Delegate.create2(this,this.ItemUnEquipped);
         _loc3_.m_iID = _loc2_;
         _loc3_.m_iCollectionID = gui.PanelInvPlus.COLLECTION_EQUIPMENT;
         _loc3_.HighliteSelf(false);
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 1;
      while(_loc2_ <= 5)
      {
         _loc3_ = this["m_mcQSlot" + _loc2_];
         _loc3_.gotoAndStop("Normal");
         _loc3_.m_bShowAmount = true;
         _loc3_.m_aAcceptorMasks = [gui.vo.ItemEnum.SLOT_QUICK,gui.vo.ItemEnum.SLOT_RANGE,gui.vo.ItemEnum.TYPE_LURES];
         _loc3_.Initialize();
         _loc3_.m_pOnPressCallBack = cx.utils.Delegate.create2(this,this.SlotPressed);
         _loc3_.m_pOnFocusChangeCallBack = cx.utils.Delegate.create2(this,this.SlotFocusChanged);
         _loc3_.m_pOnDoubleClickCallBack = cx.utils.Delegate.create2(this,this.OnDoubleClick);
         _loc3_.m_pOnAcceptedItemCallBack = cx.utils.Delegate.create2(this,this.AttachItemDataQuickSlots);
         _loc3_.m_pOnLostItemCallBack = cx.utils.Delegate.create2(this,this.LostItemDataQuickSlots);
         _loc3_.m_iID = _loc2_;
         _loc3_.m_iCollectionID = gui.PanelInvPlus.COLLECTION_QUICKSLOT;
         _loc3_.HighliteSelf(false);
         _loc2_ = _loc2_ + 1;
      }
      this.m_mcTrash.SetName("[[locale.inv.lbTrash]]",[],[],[gui.vo.ItemEnum.QUEST]);
      this.m_mcTrash.gotoAndStop("Normal");
      this.m_mcTrash.Initialize();
      this.m_mcTrash.m_pOnAcceptedItemCallBack = cx.utils.Delegate.create(this,this.TrashItems);
      this.m_mcTrashCover._visible = false;
      this.m_mcCover._visible = false;
      this.m_mcCover.onRollOver = function()
      {
      };
      this.m_mcAmountController._visible = false;
      this.m_mcAmountController.Initialize("XXX","XXX",null,"XXX",null,0,1);
      this.m_mcBook._visible = false;
      this.m_mcBook.up.onPress = cx.utils.Delegate.create(this,this.ScrollBook,[-1]);
      this.m_mcBook.down.onPress = cx.utils.Delegate.create(this,this.ScrollBook,[1]);
      this.m_mcBook.m_mcScroll.Initialize(514.75,10,5,this.ScrollBookByScroll,this);
      this.m_mcPopupInfo._visible = false;
      this.m_mcPopupInfo.Initialize("","",null,"");
      this.bTrashTutorial = null;
      this.Init(_global.mInv);
      _global.GameControls.addListener(this);
      _global.mInv.onData = cx.utils.Delegate.create(this,this.Init);
      _global.mInv.onBookText = cx.utils.Delegate.create(this,this.SetBookText);
      _global.mInv.LastSelectedSlotArray = [];
      this.m_mcTrashPadIcon._visible = _global.pGUI.m_bUseXboxpad;
      this.m_mcFirstSwordIcon._visible = false;
      this.m_mcSecondSwordIcon._visible = false;
   }
   function ItemEquipped()
   {
      flash.external.ExternalInterface.call("OnEquipmentChanged");
   }
   function ItemUnEquipped()
   {
      flash.external.ExternalInterface.call("OnEquipmentChanged");
   }
   function UpdateMass()
   {
      var _loc2_ = _global.mInv;
      var _loc3_ = _loc2_.Mass;
      this.lbMassValue.text = _loc3_;
   }
   function UpdateSlotsFromInvData()
   {
      var _loc2_ = 1;
      while(_loc2_ <= 7)
      {
         var _loc3_ = this.FindItem(Number(this["m_mcSlot" + _loc2_].m_aAcceptorMasks[0]) | gui.vo.ItemEnum.ACTIVE,-1);
         if(_loc3_ != null)
         {
            this["m_mcSlot" + _loc2_].ReceiveItem(_loc3_);
         }
         else
         {
            this["m_mcSlot" + _loc2_].ReceiveItem(null);
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 1;
      while(_loc2_ <= 5)
      {
         var _loc4_ = _global.mInv.findQuickSlotItem(_loc2_);
         if(_loc4_ != undefined && _loc4_ != null)
         {
            this["m_mcQSlot" + _loc2_].ReceiveItem(_loc4_);
         }
         else
         {
            this["m_mcQSlot" + _loc2_].ReceiveItem(null);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function AttachItemDataQuickSlots(pCSlot)
   {
      _global.mInv.AddQuickSlotItem(pCSlot.m_iID,pCSlot.GetContainedItem().ID);
   }
   function LostItemDataQuickSlots(pCSlot, vItem)
   {
      if(vItem != undefined && vItem != null)
      {
         _global.mInv.RemoveQuickSlotItemID(vItem.ID);
      }
      else
      {
         _global.mInv.RemoveQuickSlotID(pCSlot.m_iID);
      }
      var _loc4_ = 1;
      while(_loc4_ <= 5)
      {
         if(this["m_mcQSlot" + _loc4_].GetContainedItem() != null)
         {
            _global.mInv.Slots[_loc4_ - 1] = this["m_mcQSlot" + _loc4_].GetContainedItem().ID;
         }
         else
         {
            _global.mInv.Slots[_loc4_ - 1] = undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function FindItem(iFilter, iRFilter)
   {
      var _loc4_ = new Array();
      var _loc5_ = _global.mInv.Items;
      var _loc6_ = 0;
      while(_loc6_ < _loc5_.length)
      {
         if(Number(Number(_loc5_[_loc6_].Mask) & iFilter) == Number(iFilter))
         {
            if(iRFilter == -1 || Number(Number(_loc5_[_loc6_].Mask) & iRFilter) != Number(iRFilter))
            {
               return _loc5_[_loc6_];
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return null;
   }
   function SelectSlotGraphicaly(pCSlot)
   {
      return undefined;
   }
   function SlotPressed(pCSlot)
   {
      var _loc3_ = pCSlot.GetContainedItem();
      this.m_mcFilter.SetFilterBasedOnItem(_loc3_);
   }
   function OnDoubleClick(pCSlot)
   {
      if(this.GetKeyFocuesedSlot() == null)
      {
         return undefined;
      }
      if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_QUICKSLOT || this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
      {
         this.SlotPressed(this.GetKeyFocuesedSlot());
         var _loc3_ = this.GetKeyFocuesedSlot().GetContainedItem();
         if(_loc3_ != null)
         {
            this.m_mcItemList.ReceiveItem(_loc3_);
            this.GetKeyFocuesedSlot().ReceiveItem(null);
            this.GetKeyFocuesedSlot().LoseItem(_loc3_);
            flash.external.ExternalInterface.call("PlaySound","gui/slot/use");
         }
      }
      else
      {
         this.SelectSlot(false);
      }
   }
   function SlotFocusChanged(pCSlot, bState)
   {
      if(bState)
      {
         this.SetKeyFocuesedSlot(pCSlot);
         this.m_mcRItemData.SetNote(pCSlot.GetContainedItem());
      }
   }
   function OnListGainFocus(pCSlot, bState)
   {
      if(bState)
      {
         this.SetKeyFocuesedSlot(pCSlot);
         this.FindSutableSlotFor(this.m_mcItemList.GetContainedItem(),true);
         this.TryShowRelateItemAgainstListSelection();
         var _loc4_ = this.m_mcItemList.GetContainedItem();
      }
      else
      {
         this.ClearHighlights();
      }
      this.UpdateUpgradeIcons();
   }
   function ListChanged(pCSlot, bState)
   {
      if(this.m_mcItemList.m_aItemsData.length > 0)
      {
         this.m_mcLItemData.SetNote(this.m_mcItemList.GetContainedItem());
         if(this.GetKeyFocuesedSlot() == this.m_mcItemList)
         {
            this.FindSutableSlotFor(this.m_mcItemList.GetContainedItem(),true);
         }
         this.TryShowRelateItemAgainstListSelection();
      }
      else
      {
         this.m_mcLItemData.SetNote(null);
      }
      this.UpdateUpgradeIcons();
   }
   function TryShowRelateItemAgainstListSelection()
   {
      if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST)
      {
         var _loc2_ = null;
         var _loc3_ = this.m_mcItemList.GetContainedItem();
         var _loc4_ = 1;
         while(_loc4_ <= 7)
         {
            if(this["m_mcSlot" + _loc4_].TestItemForSlot(_loc3_))
            {
               _loc2_ = this["m_mcSlot" + _loc4_];
               break;
            }
            _loc4_ = _loc4_ + 1;
         }
         if(_loc2_ == null && _loc2_.GetContainedItem() != null)
         {
            this.m_mcRItemData.SetNote(this.m_mcCurrentlySelectedSlot.GetContainedItem());
         }
         else
         {
            this.m_mcRItemData.SetNote(_loc2_.GetContainedItem());
         }
      }
   }
   function UpdateUpgradeIcons()
   {
      var _loc2_ = this.m_mcItemList.GetContainedItem();
      if(_global.pGUI.m_bUseXboxpad && (this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST && (this.m_mcSlot1.TestItemAsUpgrade(_loc2_) && this.m_mcSlot2.TestItemAsUpgrade(_loc2_))))
      {
         this.m_mcFirstSwordIcon._visible = true;
         this.m_mcSecondSwordIcon._visible = true;
      }
      else
      {
         this.m_mcFirstSwordIcon._visible = false;
         this.m_mcSecondSwordIcon._visible = false;
      }
   }
   function DropToTrash()
   {
      this.m_mcTrash.ReceiveItem(this.GetKeyFocuesedSlot().GetContainedItem());
   }
   function TrashItems(pCSlot)
   {
      if(Number(pCSlot.GetContainedItem().Count) < 2)
      {
         this.ConfirmTrashing(Number(pCSlot.GetContainedItem().Count));
      }
      else
      {
         this.m_mcCover._visible = true;
         this.m_mcCover.onRollOver = function()
         {
         };
         this.m_mcAmountController._visible = true;
         this.m_mcAmountController.Initialize("[[locale.TrashItem]]","[[locale.Cancel]]",cx.utils.Delegate.create(this,this.CancelTrashing),"[[locale.Confirm]]",cx.utils.Delegate.create(this,this.ConfirmTrashing),1,Number(pCSlot.GetContainedItem().Count));
      }
   }
   function CancelTrashing(fAmount)
   {
      this.m_mcCover._visible = false;
      this.m_mcAmountController._visible = false;
      var _loc3_ = this.m_mcTrash.GetContainedItem();
      _loc3_.Mask = Number(_loc3_.Mask) & (gui.vo.ItemEnum.ACTIVE ^ -1);
      this.m_mcTrash.ReceiveItem(null);
      _global.mInv.Commit();
   }
   function ConfirmTrashing(iAmount)
   {
      this.m_mcCover._visible = false;
      this.m_mcAmountController._visible = false;
      var _loc3_ = this.m_mcTrash.GetContainedItem();
      this.m_mcTrash.ReceiveItem(null);
      if((Number(_loc3_.Mask) & gui.vo.ItemEnum.TYPE_WEAPON) > 0 && !this.CanLostSword())
      {
         _global.mHUD.onInformationBox("[[locale.YouCantDropLastSword]]");
         _global.mInv.Commit();
      }
      else if(iAmount > 0)
      {
         _loc3_.Mask = Number(_loc3_.Mask) & (gui.vo.ItemEnum.ACTIVE ^ -1);
         _global.mInv.Commit();
         flash.external.ExternalInterface.call("RemoveItem",_loc3_.ID,iAmount);
      }
   }
   function SetBookText()
   {
      var _loc2_ = 23;
      this.m_mcBook.m_tfText.htmlText = String(_global.mInv.m_sBookText);
      this.m_mcBook.m_tfText.scroll = 0;
      this.m_mcBook.m_mcScroll.Initialize(514.75,this.m_mcBook.m_tfText.maxscroll - 1 + _loc2_,_loc2_,this.ScrollBookByScroll,this);
      this.m_mcBook.m_mcScroll.UpdateGraphic();
   }
   function StopReading()
   {
      this.m_mcCover._visible = false;
      this.m_mcBook._visible = false;
   }
   function ScrollBookByScroll(mcParrent, iValue)
   {
      mcParrent.m_mcBook.m_tfText.scroll = iValue + 1;
   }
   function ScrollBook(iDirection)
   {
      this.m_mcBook.m_tfText.scroll += iDirection;
      this.m_mcBook.m_mcScroll.SetNewPosition(this.m_mcBook.m_tfText.scroll - 1);
   }
   function Init(o)
   {
      var _loc3_ = 0;
      while(_loc3_ < _global.mInv.length)
      {
         _global.mInv[_loc3_]._OrigIndex = _loc3_;
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = _global.mInv;
      _loc4_.runSanityCheck();
      this.bTrashTutorial = o.bTrash;
      var _loc5_ = _loc4_.Mass;
      this.lbMassValue.text = _loc5_;
      this.lbOrensValue.text = (_loc4_.Orens || 0).toString();
      this.UpdateSlotsFromInvData();
      this.m_mcItemList.SetData(_loc4_.Items);
      this.m_mcRItemData.SetNote(this.m_mcCurrentlySelectedSlot.GetContainedItem());
      this.m_mcItemList.SetPosition(0);
      if(this.bTrashTutorial == true)
      {
         this.hitArea = this.m_mcTrashCover;
         this.m_mcTrashCover.onPress = function()
         {
         };
         this.m_mcTrashCover._visible = true;
      }
      else if(this.bTrashTutorial == false || (this.bTrashTutorial == null || this.bTrashTutorial == undefined))
      {
         this.hitArea = null;
         this.m_mcTrashCover._visible = false;
      }
   }
   function Finalize()
   {
      delete _global.mInv.onData;
      _global.mInv.onData = null;
      _global.GameControls.removeListener(this);
   }
   function onIK(v)
   {
      var _loc3_ = false;
      var _loc4_ = this.GetKeyFocuesedSlot();
      if(this.m_mcCover._visible == true)
      {
         if(this.m_mcPopupInfo._visible == true)
         {
            _loc3_ = this.m_mcPopupInfo.onIK();
         }
         else if(this.m_mcBook._visible == true)
         {
            switch(mh2lib.display.MH2Flow.GetKeyCode())
            {
               case mh2lib.utils.MH2Key.ESC:
               case mh2lib.utils.MH2Key.PAD_B_CIRCLE:
                  this.StopReading();
                  _loc3_ = true;
                  break;
               case mh2lib.utils.MH2Key.ARROW_UP:
                  this.ScrollBook(-1);
                  _loc3_ = true;
                  break;
               case mh2lib.utils.MH2Key.ARROW_DOWN:
                  this.ScrollBook(1);
                  _loc3_ = true;
            }
         }
         else if(this.m_mcAmountController._visible == true)
         {
            _loc3_ = this.m_mcAmountController.onIK();
         }
      }
      else
      {
         switch(mh2lib.display.MH2Flow.GetKeyCode())
         {
            case mh2lib.utils.MH2Key.ESC:
            case mh2lib.utils.MH2Key.PAD_B_CIRCLE:
            case mh2lib.utils.MH2Key.I:
               this.ExitPanel();
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.TAB:
            case mh2lib.utils.MH2Key.PAD_RB:
               this.m_mcFilter.SetNextFilter();
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.PAD_LB:
               this.m_mcFilter.SetPrevFilter();
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.PAD_LT:
               this.m_mcFilter.GamepadNextSorter();
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.PAD_RT:
               this.m_mcFilter.GamepadInvertSort();
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.ARROW_RIGHT:
               this.ArrowHorizontalMain(true);
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.ARROW_LEFT:
               this.ArrowHorizontalMain(false);
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.ARROW_UP:
               if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST)
               {
                  _loc3_ = this.m_mcItemList.onIK();
                  this.FindSutableSlotFor(this.m_mcItemList.GetContainedItem(),true);
               }
               else
               {
                  this.ArrowVerticalMain(true);
                  _loc3_ = true;
               }
               break;
            case mh2lib.utils.MH2Key.ARROW_DOWN:
               if(this.GetKeyFocuesedSlot() == this.m_mcItemList)
               {
                  _loc3_ = this.m_mcItemList.onIK();
                  this.FindSutableSlotFor(this.m_mcItemList.GetContainedItem(),true);
               }
               else
               {
                  this.ArrowVerticalMain(false);
                  _loc3_ = true;
               }
               break;
            case mh2lib.utils.MH2Key.ENTER:
            case mh2lib.utils.MH2Key.SPACE:
            case mh2lib.utils.MH2Key.PAD_A_CROSS:
               this.SelectSlot(true);
               _loc3_ = true;
               break;
            case mh2lib.utils.MH2Key.PAD_X_SQUARE:
               if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST)
               {
                  this.TryUpgradeSecondSword();
                  _loc3_ = true;
               }
         }
         if(this.bTrashTutorial == false || (this.bTrashTutorial == null || this.bTrashTutorial == undefined))
         {
            switch(mh2lib.display.MH2Flow.GetKeyCode())
            {
               case mh2lib.utils.MH2Key.PAD_Y_TRIANGLE:
               case mh2lib.utils.MH2Key.DELETEKEY:
                  this.DropToTrash();
                  _loc3_ = true;
            }
         }
      }
      if(_loc4_ != this.GetKeyFocuesedSlot())
      {
         _loc4_.LoseDragTarget(null);
         this.GetKeyFocuesedSlot().AskForFocus(null);
      }
      return _loc3_;
   }
   function ArrowHorizontalMain(bRight)
   {
      if(this.GetKeyFocuesedSlot() == null)
      {
         this.SetKeyFocuesedSlot(this.m_mcItemList);
      }
      else if(bRight)
      {
         if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST)
         {
            this.SetKeyFocuesedSlot(this.m_mcSlot1);
         }
         else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
         {
            if(this.GetKeyFocuesedSlot().m_iID == 1 || (this.GetKeyFocuesedSlot().m_iID == 3 || this.GetKeyFocuesedSlot().m_iID == 5))
            {
               this.SetKeyFocuesedSlot(this["m_mcSlot" + Number(this.GetKeyFocuesedSlot().m_iID + 1)]);
            }
            else if(this.GetKeyFocuesedSlot().m_iID == 7)
            {
               this.SetKeyFocuesedSlot(this.m_mcSlot6);
            }
         }
         else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_QUICKSLOT)
         {
            if(this.GetKeyFocuesedSlot().m_iID < 5)
            {
               this.SetKeyFocuesedSlot(this["m_mcQSlot" + Number(this.GetKeyFocuesedSlot().m_iID + 1)]);
            }
            else
            {
               this.SetKeyFocuesedSlot(this.m_mcQSlot1);
            }
         }
      }
      else if(this.GetKeyFocuesedSlot().m_iCollectionID != gui.PanelInvPlus.COLLECTION_LIST)
      {
         if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
         {
            if(this.GetKeyFocuesedSlot().m_iID == 2 || (this.GetKeyFocuesedSlot().m_iID == 4 || this.GetKeyFocuesedSlot().m_iID == 6))
            {
               this.SetKeyFocuesedSlot(this["m_mcSlot" + Number(this.GetKeyFocuesedSlot().m_iID - 1)]);
            }
            else
            {
               this.SetKeyFocuesedSlot(this.m_mcItemList);
            }
         }
         else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_QUICKSLOT)
         {
            if(this.GetKeyFocuesedSlot().m_iID > 1)
            {
               this.SetKeyFocuesedSlot(this["m_mcQSlot" + Number(this.GetKeyFocuesedSlot().m_iID - 1)]);
            }
            else
            {
               this.SetKeyFocuesedSlot(this.m_mcQSlot5);
            }
         }
      }
   }
   function ArrowVerticalMain(bUp)
   {
      if(this.GetKeyFocuesedSlot() == null)
      {
         this.SetKeyFocuesedSlot(this.m_mcItemList);
      }
      else if(bUp)
      {
         if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
         {
            if(this.GetKeyFocuesedSlot().m_iID == 1 || this.GetKeyFocuesedSlot().m_iID == 2)
            {
               this.SetKeyFocuesedSlot(this.m_mcQSlot1);
            }
            else
            {
               this.SetKeyFocuesedSlot(this["m_mcSlot" + Number(this.GetKeyFocuesedSlot().m_iID - 2)]);
            }
         }
      }
      else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
      {
         if(!(this.GetKeyFocuesedSlot().m_iID == 6 || this.GetKeyFocuesedSlot().m_iID == 7))
         {
            this.SetKeyFocuesedSlot(this["m_mcSlot" + Number(this.GetKeyFocuesedSlot().m_iID + 2)]);
         }
      }
      else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_QUICKSLOT)
      {
         this.SetKeyFocuesedSlot(this.m_mcSlot1);
      }
   }
   function TryUpgradeSecondSword()
   {
      var _loc3_ = this.m_mcItemList.GetContainedItem();
      if(this.m_mcSlot2.TestItemAsUpgrade(_loc3_))
      {
         var _loc2_ = this.m_mcSlot2;
      }
      if(_loc2_ != null)
      {
         var _loc4_ = _loc2_.ReceiveItem(_loc3_);
         if(_loc3_ != _loc4_)
         {
            this.m_mcItemList.LoseItem(_loc3_);
            this.m_mcItemList.ReceiveItem(_loc4_);
            flash.external.ExternalInterface.call("PlaySound","gui/slot/use");
         }
      }
   }
   function SelectSlot(keyControl)
   {
      if(this.GetKeyFocuesedSlot() == null)
      {
         return undefined;
      }
      if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_QUICKSLOT || this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_EQUIPMENT)
      {
         if(keyControl)
         {
            this.SlotPressed(this.GetKeyFocuesedSlot());
            var _loc3_ = this.GetKeyFocuesedSlot().GetContainedItem();
            if(_loc3_ != null)
            {
               this.m_mcItemList.ReceiveItem(_loc3_);
               this.GetKeyFocuesedSlot().ReceiveItem(null);
               this.GetKeyFocuesedSlot().LoseItem(_loc3_);
               flash.external.ExternalInterface.call("PlaySound","gui/slot/use");
            }
         }
      }
      else if(this.GetKeyFocuesedSlot().m_iCollectionID == gui.PanelInvPlus.COLLECTION_LIST)
      {
         _loc3_ = this.m_mcItemList.GetContainedItem();
         if(_loc3_ != null)
         {
            if(Number(Number(_loc3_.Mask) & gui.vo.ItemEnum.EXAMINE) == gui.vo.ItemEnum.EXAMINE)
            {
               flash.external.ExternalInterface.call("ExamineItem",_loc3_.ID);
               this.m_mcCover._visible = true;
               this.m_mcBook._visible = true;
            }
            else
            {
               var _loc4_ = this.FindSutableSlotFor(_loc3_,true);
               if(_loc4_ != null)
               {
                  var _loc5_ = _loc4_.ReceiveItem(_loc3_);
                  if(_loc3_ != _loc5_)
                  {
                     this.m_mcItemList.LoseItem(_loc3_);
                     this.m_mcItemList.ReceiveItem(_loc5_);
                     flash.external.ExternalInterface.call("PlaySound","gui/slot/use");
                  }
               }
               else if(Number(Number(_loc3_.Mask) & gui.vo.ItemEnum.TYPE_ELIXIR) == gui.vo.ItemEnum.TYPE_ELIXIR)
               {
                  this.ShowWarningElixirs();
               }
               else
               {
                  this.ShowWarningMessage();
               }
            }
         }
      }
   }
   function ClearHighlights()
   {
      var _loc2_ = 1;
      _loc2_ = 1;
      while(_loc2_ <= 7)
      {
         this["m_mcSlot" + _loc2_].HighliteSelf(false);
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 1;
      while(_loc2_ <= 5)
      {
         this["m_mcQSlot" + _loc2_].HighliteSelf(false);
         _loc2_ = _loc2_ + 1;
      }
   }
   function FindSutableSlotFor(pItem, bHighliteIt)
   {
      if(bHighliteIt)
      {
         this.ClearHighlights();
      }
      if(pItem == null)
      {
         return null;
      }
      var _loc4_ = 1;
      var _loc5_ = null;
      _loc4_ = 1;
      while(_loc4_ <= 7)
      {
         if(this["m_mcSlot" + _loc4_].TestItemForSlot(pItem) || this["m_mcSlot" + _loc4_].TestItemAsUpgrade(pItem))
         {
            if(_loc5_ == null)
            {
               _loc5_ = this["m_mcSlot" + _loc4_];
            }
            if(bHighliteIt)
            {
               this["m_mcSlot" + _loc4_].HighliteSelf(true);
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      _loc4_ = 1;
      while(_loc4_ <= 5)
      {
         if(this["m_mcQSlot" + _loc4_].TestItemForSlot(pItem))
         {
            if(_loc5_ == null)
            {
               _loc5_ = this["m_mcQSlot" + _loc4_];
            }
            else if(_loc5_.GetContainedItem() != null && this["m_mcQSlot" + _loc4_].GetContainedItem() == null)
            {
               _loc5_ = this["m_mcQSlot" + _loc4_];
            }
            if(bHighliteIt)
            {
               this["m_mcQSlot" + _loc4_].HighliteSelf(true);
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc5_;
   }
   function ReceiveItem(pSimpleItem)
   {
      if(pSimpleItem)
      {
         pSimpleItem.Mask = Number(pSimpleItem.Mask) & (gui.vo.ItemEnum.ACTIVE ^ -1);
         this.SetData(this.m_aNotFilteredItemsData);
      }
      return null;
   }
   function LoseItem(pSimpleItem)
   {
      if(pSimpleItem)
      {
         pSimpleItem.Mask = Number(pSimpleItem.Mask) | gui.vo.ItemEnum.ACTIVE;
         this.SetData(this.m_aNotFilteredItemsData);
      }
      flash.external.ExternalInterface.call("OnEquipmentChanged");
   }
   function CanLostSword()
   {
      var _loc2_ = 0;
      var _loc3_ = this.m_mcItemList.m_aNotFilteredItemsData;
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc4_ = _loc3_[_loc5_];
         if(Number(Number(_loc4_.Mask) & gui.vo.ItemEnum.TYPE_WEAPON) > 0)
         {
            _loc2_ = _loc2_ + 1;
            if(_loc2_ > 1)
            {
               return true;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      return false;
   }
   function ShowWarningMessage()
   {
      this.m_mcPopupInfo._visible = true;
      this.m_mcCover._visible = true;
      this.m_mcPopupInfo.Initialize("[[locale.YouCantDoThisWithItem]]","[[locale.Confirm]]",cx.utils.Delegate.create(this,this.HideWarningMessage),"");
   }
   function ShowWarningElixirs()
   {
      this.m_mcPopupInfo._visible = true;
      this.m_mcCover._visible = true;
      this.m_mcPopupInfo.Initialize("[[elixir_drink]]","[[locale.Confirm]]",cx.utils.Delegate.create(this,this.HideWarningMessage),"");
   }
   function HideWarningMessage()
   {
      this.m_mcPopupInfo._visible = false;
      this.m_mcCover._visible = false;
   }
   function DragTargetRefused()
   {
      this.ShowWarningMessage();
   }
}
class CPopupInfo extends mh2lib.display.MH2Component
{
   var AddEventListener;
   var m_btOk;
   var m_mcCover;
   var gotoAndStop;
   var m_tfMessage;
   var m_pCallBack;
   var _visible;
   function CPopupInfo()
   {
      super();
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED,this.CreateEvents);
   }
   function CreateEvents(e)
   {
      this.m_btOk.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.HidePopup);
      this.m_btOk.SetGraphic(CNormalButton.ENTER);
      this.m_mcCover.hitArea = this.m_mcCover.m_mcHitArea;
      this.m_mcCover.m_mcHitArea._visible = false;
      this.m_mcCover.onPress = function()
      {
      };
   }
   function Initialize(sMessage, sOk, pOkCallBack, sGraphic)
   {
      if(false && (sGraphic != undefined && sGraphic != ""))
      {
         this.gotoAndStop("Icon");
      }
      else
      {
         this.gotoAndStop("NoIcon");
      }
      this.m_tfMessage.text = sMessage;
      this.m_btOk.SetText("",sOk);
      this.m_btOk.SetBacgroundVisibility(true);
      if(pOkCallBack != undefined && pOkCallBack != null)
      {
         this.m_pCallBack = pOkCallBack;
      }
      else
      {
         this.m_pCallBack = this.HidePopup;
      }
      this.m_btOk.RemoveEventListener(mh2lib.utils.MH2Event.MOUSE_PRESS);
      this.m_btOk.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.m_pCallBack);
   }
   function HidePopup(e)
   {
      this._visible = false;
   }
   function onIK()
   {
      var _loc2_ = false;
      switch(Key.getCode())
      {
         case mh2lib.utils.MH2Key.SPACE:
         case mh2lib.utils.MH2Key.ENTER:
         case mh2lib.utils.MH2Key.ESC:
         case mh2lib.utils.MH2Key.PAD_A_CROSS:
         case mh2lib.utils.MH2Key.PAD_B_CIRCLE:
            this.m_pCallBack();
            _loc2_ = true;
      }
      return _loc2_;
   }
}
if(!mh2lib.display.flowstates.FCExit)
{
   _global.mh2lib.display.flowstates.FCExit = function()
   {
      super();
      this.m_sStateName = "FCExit";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCExit = function()
   {
      super();
      this.m_sStateName = "FCExit";
   }.prototype;
   _loc1_.EnterState = function()
   {
      _global.pFlow.RemoveChild(this.Owner());
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!cx.utils.AssetLoader)
{
   _loc1_ = _global.cx.utils.AssetLoader = function()
   {
   }.prototype;
   _global.cx.utils.AssetLoader = function()
   {
   }.loadAsset = function(o, filePath, sizeX, sizeY, f)
   {
      o.unloadMovie();
      o.forceSmoothing = true;
      with(new MovieClipLoader())
      {
         loadClip(filePath,o);
         addListener({onLoadInit:cx.utils.Delegate.create(cx.utils.AssetLoader,cx.utils.AssetLoader.scaleAsset,[o,sizeX,sizeY,f])});
      }
   };
   _global.cx.utils.AssetLoader = function()
   {
   }.scaleAsset = function(o, sizeX, sizeY, f)
   {
      if(sizeX && sizeY)
      {
         o._width = sizeX;
         o._height = sizeY;
         if(o._xscale > o._yscale)
         {
            o._yscale = o._xscale;
         }
         if(o._xscale < o._yscale)
         {
            o._xscale = o._yscale;
         }
      }
      if(f)
      {
         f(o);
      }
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!mh2lib.display.flowstates.FCEnter)
{
   _global.mh2lib.display.flowstates.FCEnter = function()
   {
      super();
      this.m_sStateName = "FCEnter";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCEnter = function()
   {
      super();
      this.m_sStateName = "FCEnter";
   }.prototype;
   _loc1_.EnterState = function()
   {
      if(this.Owner().m_pFlow.m_bDoBitmapOrBlackFadeInOut)
      {
         this.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCFadeLoad());
      }
      else
      {
         this.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCGraphicLoadOnly());
      }
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!mh2lib.display.MH2FlowChild)
{
   _loc1_ = _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.prototype;
   _loc1_.LoadPanel = function(sPath, sFade, sVideoName)
   {
      this.m_sPath = sPath;
      this.m_sFade = sFade;
      this.m_sVideoName = sVideoName;
      this.m_iID = this.m_pFlow.m_iFreeIDForChilds++;
      this.m_mcParrent = _global.vPanel.createEmptyMovieClip("mcFlowChild" + _global.vPanel.getNextHighestDepth(),_global.vPanel.getNextHighestDepth());
      this.m_mcGraphic = this.m_mcParrent.createEmptyMovieClip("mcGraphic",this.m_mcParrent.getNextHighestDepth());
      this.m_mcFade = this.m_mcParrent.createEmptyMovieClip("mcFade",this.m_mcParrent.getNextHighestDepth());
      _global.PositionClip([this.m_mcGraphic,0,0],1,1);
      this.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCEnter());
   };
   _loc1_.Finalize = function()
   {
      if(this.m_pFlow.m_bDoBitmapOrBlackFadeInOut)
      {
         this.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCFadeOut());
      }
      else
      {
         this.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCGraphicOutOnly());
      }
   };
   _loc1_.onIK = function()
   {
      return this.m_mcGraphic.onIK();
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_ENTER = 0;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_FADE_IN = 1;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_ON = 2;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_WAITING_FOR_FADE_OUT = 3;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_FADE_OUT = 4;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.STATE_EXIT = 5;
   _global.mh2lib.display.MH2FlowChild = function(pFlow)
   {
      this.m_pFlow = pFlow;
      this.m_pStateMachine = new mh2lib.display.FCStateMachine(this);
   }.FADE_TIME = 0.5;
   _loc1_.m_pStateMachine = null;
   _loc1_.m_mcGraphic = null;
   _loc1_.m_mcFade = null;
   _loc1_.m_mcParrent = null;
   _loc1_.m_pTween = null;
   _loc1_.m_sPath = "";
   _loc1_.m_sFade = "";
   _loc1_.m_sVideoName = "";
   _loc1_.m_iID = -1;
}
class gui.utils.ItemNameFormatter
{
   static var CLASS_COMMON = 1;
   static var CLASS_MAGIC = 2;
   static var CLASS_RARE = 3;
   static var CLASS_EPIC = 4;
   function ItemNameFormatter()
   {
   }
   static function formatName(itemName, itemClass)
   {
      switch(itemClass)
      {
         case 1:
            return "<font color=\"#F59535\">" + itemName + "</font>";
         case 2:
            return "<font color=\"#608095\">" + itemName + "</font>";
         case 3:
            return "<font color=\"#BBC3A0\">" + itemName + "</font>";
         case 4:
            return "<font color=\"#963B2C\">" + itemName + "</font>";
         default:
            return itemName;
      }
   }
}
if(!mh2lib.utils.MH2StateMachine)
{
   _loc1_ = _global.mh2lib.utils.MH2StateMachine = function()
   {
   }.prototype;
   _loc1_.StateMachine = function()
   {
   };
   _loc1_.Update = function()
   {
      this.m_pCurrentState.Execution();
   };
   _loc1_.ChangeState = function(newState)
   {
      if(this.m_pCurrentState != null)
      {
         this.m_pCurrentState.ExitState();
         this.m_pCurrentState = null;
      }
      if(newState != null)
      {
         newState.Init(this);
         this.m_pCurrentState = newState;
         this.m_pCurrentState.EnterState();
      }
   };
   _loc1_.PostEvent = function(type)
   {
      if(this.m_pCurrentState.StateEvent(type) == true)
      {
         return true;
      }
      return false;
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!com.greensock.plugins.TintPlugin)
{
   _global.com.greensock.plugins.TintPlugin = function()
   {
      super();
      this.propName = "tint";
      this.overwriteProps = ["tint"];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.TintPlugin = function()
   {
      super();
      this.propName = "tint";
      this.overwriteProps = ["tint"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      if(typeof target != "movieclip" && !(target instanceof TextField))
      {
         return false;
      }
      var _loc5_ = tween.vars._alpha == undefined ? (tween.vars.autoAlpha == undefined ? target._alpha : tween.vars.autoAlpha) : tween.vars._alpha;
      var _loc6_ = Number(value);
      var _loc7_ = !(value == null || tween.vars.removeTint == true) ? {rb:_loc6_ >> 16,gb:_loc6_ >> 8 & 0xFF,bb:_loc6_ & 0xFF,ra:0,ga:0,ba:0,aa:_loc5_} : {rb:0,gb:0,bb:0,ab:0,ra:_loc5_,ga:_loc5_,ba:_loc5_,aa:_loc5_};
      this._ignoreAlpha = true;
      this.init(target,_loc7_);
      return true;
   };
   _loc1_.init = function(target, end)
   {
      this._color = new Color(target);
      this._ct = this._color.getTransform();
      for(var _loc5_ in end)
      {
         if(this._ct[_loc5_] != end[_loc5_])
         {
            this._tweens[this._tweens.length] = new com.greensock.core.PropTween(this._ct,_loc5_,this._ct[_loc5_],end[_loc5_] - this._ct[_loc5_],"tint",false);
         }
      }
   };
   _loc1_.__set__changeFactor = function(n)
   {
      var _loc3_ = this._tweens.length;
      while(_loc3_--)
      {
         var _loc4_ = this._tweens[_loc3_];
         _loc4_.target[_loc4_.property] = _loc4_.start + _loc4_.change * n;
      }
      if(this._ignoreAlpha)
      {
         var _loc5_ = this._color.getTransform();
         this._ct.aa = _loc5_.aa;
         this._ct.ab = _loc5_.ab;
      }
      this._color.setTransform(this._ct);
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.TintPlugin = function()
   {
      super();
      this.propName = "tint";
      this.overwriteProps = ["tint"];
   }.API = 1;
}
if(!mh2lib.display.flowstates.FCFadeIn)
{
   _global.mh2lib.display.flowstates.FCFadeIn = function()
   {
      super();
      this.m_sStateName = "FCFadeIn";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCFadeIn = function()
   {
      super();
      this.m_sStateName = "FCFadeIn";
   }.prototype;
   _loc1_.EnterState = function()
   {
      this.m_bGraphicReady = false;
      this.m_bFadeReady = false;
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = new Object();
      _loc3_.onLoadComplete = cx.utils.Delegate.create(this,this.GraphicReady,[this]);
      _loc2_.addListener(_loc3_);
      _loc2_.loadClip(this.Owner().m_sPath,this.Owner().m_mcGraphic);
      this.Owner().m_pTween = com.greensock.TweenLite.to(this.Owner().m_mcFade,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:100,onComplete:this.FadeFull,onCompleteParams:[this]});
   };
   _loc1_.FadeFull = function(pState)
   {
      pState.m_bFadeReady = true;
      pState.Owner().m_pFlow.EnableRendering(false);
      if(pState.Owner().m_pFlow.m_bFadeToNewScreen)
      {
         pState.Owner().m_pFlow.m_bFadeToNewScreen = false;
         pState.Owner().m_pFlow.RemoveOtherInstantly(pState.Owner());
      }
      if(pState.Owner().m_sVideoName != "")
      {
         _global.vCustomPanel.PlayVideo(pState.Owner().m_sVideoName,true);
         if(_global.vCustomPanel)
         {
            var _loc3_ = 640;
            var _loc4_ = 360;
            var _loc5_ = 100 * _global.pGUI.m_Width / (2 * _loc3_);
            var _loc6_ = 100 * _global.pGUI.m_Height / (2 * _loc4_);
            _global.vCustomPanel._x = - (_global.pGUI.m_Width / 2 - _loc3_);
            _global.vCustomPanel._y = - (_global.pGUI.m_Height / 2 - _loc4_);
            _global.vCustomPanel._xscale = _loc5_;
            _global.vCustomPanel._yscale = _loc6_;
         }
      }
      if(pState.m_bGraphicReady == true)
      {
         pState.ShowGraphic();
      }
   };
   _loc1_.GraphicReady = function(pState)
   {
      pState.Owner().m_mcGraphic._visible = false;
      pState.m_bGraphicReady = true;
      _global.pPanelClass = this.Owner().m_mcGraphic;
      flash.external.ExternalInterface.call("FillData");
      if(pState.m_bFadeReady == true)
      {
         pState.ShowGraphic();
      }
   };
   _loc1_.ShowGraphic = function()
   {
      this.Owner().m_mcGraphic._visible = true;
      this.Owner().m_pTween = com.greensock.TweenLite.to(this.Owner().m_mcFade,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:0,onComplete:this.Advance,onCompleteParams:[this]});
   };
   _loc1_.Advance = function(pState)
   {
      pState.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCScreenReady());
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!gui.vo.ElementsEnum)
{
   _loc1_ = _global.gui.vo.ElementsEnum = function()
   {
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_VITRIOL = 65536;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_REBIS = 131072;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_VERMILION = 262144;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_AETHER = 524288;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_HYDRAGENUM = 1048576;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_CAELUM = 2097152;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_QUEBRITH = 4194304;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_SOL = 8388608;
   _global.gui.vo.ElementsEnum = function()
   {
   }.TYPE_FULGUR = 16777216;
}
class CTooltip extends mh2lib.display.MH2Component
{
   var lbMassIconLabel;
   var lbPriceIconLabel;
   var AddEventListener;
   var m_mcDescription;
   var _visible;
   var m_iMode;
   var gotoAndStop;
   var lbName;
   var lbMass;
   var lbPrice;
   var fxAbIcon;
   var lbAbLabel;
   var lbAbValue;
   var lbClass;
   static var LITE = 0;
   static var ARMOR = 1;
   static var DAMAGE = 2;
   static var TEXT_IDDLE = 0;
   static var TEXT_SCROLLING = 1;
   static var TEXT_IDDLE_OUT = 2;
   static var TEXT_FADE_OUT = 3;
   static var TEXT_FADE_IN = 4;
   static var VISIBLE_TEXT_MASK_HIGHT = 110;
   static var DEFAULT_TEXT_Y_VALUE = 72;
   static var SCROLLING_SPEED = 21;
   var m_sAcceptorMask = "ID";
   var m_sRefuseMask = "ID";
   var m_iCurrentTweenMode = CTooltip.TEXT_IDDLE;
   var m_pTween = null;
   var m_sItemText = "";
   function CTooltip()
   {
      super();
      this.lbMassIconLabel.text = "[[locale.inv.MassLabel]]";
      this.lbPriceIconLabel.text = "[[locale.inv.PriceLabel]]";
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED,this.AttachEvents);
   }
   function AttachEvents(e)
   {
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_DESTROYED,this.FinalizeObject);
   }
   function FinalizeObject(e)
   {
      if(this.m_pTween != null)
      {
         this.m_pTween.kill();
         delete this.m_pTween;
         this.m_pTween = null;
      }
   }
   static function EaseNone(t, b, c, d, p_params)
   {
      return c * t / d + b;
   }
   function UpdateTweenState()
   {
      if(this.m_iCurrentTweenMode > CTooltip.TEXT_FADE_IN)
      {
         this.m_iCurrentTweenMode = CTooltip.TEXT_IDDLE;
      }
      switch(this.m_iCurrentTweenMode)
      {
         case CTooltip.TEXT_IDDLE:
            this.FinalizeObject(null);
            this.m_pTween = new com.greensock.TweenLite(this,0.1,{_alpha:100,onComplete:cx.utils.Delegate.create(this,this.AdvanceTween)});
            break;
         case CTooltip.TEXT_SCROLLING:
            this.FinalizeObject(null);
            var _loc2_ = this.m_mcDescription.m_tfDescription._height - this.m_mcDescription.m_mcMask._height;
            this.m_pTween = new com.greensock.TweenLite(this.m_mcDescription.m_tfDescription,_loc2_ / CTooltip.SCROLLING_SPEED,{_y:Number(- _loc2_),ease:CTooltip.EaseNone,onComplete:cx.utils.Delegate.create(this,this.AdvanceTween)});
            break;
         case CTooltip.TEXT_IDDLE_OUT:
            this.FinalizeObject(null);
            this.m_pTween = new com.greensock.TweenLite(this,5,{_alpha:100,onComplete:cx.utils.Delegate.create(this,this.AdvanceTween)});
            break;
         case CTooltip.TEXT_FADE_OUT:
            this.FinalizeObject(null);
            this.m_pTween = new com.greensock.TweenLite(this.m_mcDescription.m_tfDescription,0.4,{_alpha:0,onComplete:cx.utils.Delegate.create(this,this.AdvanceTween)});
            break;
         case CTooltip.TEXT_FADE_IN:
            this.FinalizeObject(null);
            this.m_mcDescription.m_tfDescription._y = 0;
            this.m_pTween = new com.greensock.TweenLite(this.m_mcDescription.m_tfDescription,0.4,{_alpha:100,onComplete:cx.utils.Delegate.create(this,this.AdvanceTween)});
      }
   }
   function AdvanceTween()
   {
      this.m_iCurrentTweenMode = this.m_iCurrentTweenMode + 1;
      this.UpdateTweenState();
   }
   function FindAbilityWithFlag(aSource, iFilter, iRFilter)
   {
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < aSource.length)
      {
         if(Number(Number(aSource[_loc6_][this.m_sAcceptorMask]) & iFilter) > 0)
         {
            if(iRFilter == -1 || Number(Number(aSource[_loc6_][this.m_sRefuseMask]) & iRFilter) == 0)
            {
               return aSource[_loc6_];
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return null;
   }
   function SetNote(voItem)
   {
      var _loc3_ = String(voItem.ID) + String(voItem.DescFull);
      if(this.m_sItemText == _loc3_)
      {
         return undefined;
      }
      this.m_sItemText = _loc3_;
      this.FinalizeObject(null);
      if(voItem == undefined || voItem == null)
      {
         this._visible = !!0;
      }
      else
      {
         this._visible = !!1;
         var _loc4_ = this.FindAbilityWithFlag(voItem.Abilities,gui.vo.AbilityEnum.TYPE_ARMOR,-1);
         if(_loc4_ == null)
         {
            this.m_iMode = CTooltip.DAMAGE;
            _loc4_ = this.FindAbilityWithFlag(voItem.Abilities,gui.vo.AbilityEnum.TYPE_DAMAGE,-1);
         }
         else
         {
            this.m_iMode = CTooltip.ARMOR;
         }
         if(_loc4_ == null)
         {
            this.m_iMode = CTooltip.LITE;
            this.gotoAndStop("LITE");
         }
         else
         {
            this.gotoAndStop("FULL");
         }
         var _loc5_ = flash.external.ExternalInterface.call("StringToUpper",voItem.Name);
         this.lbName.text = _loc5_ || "";
         this.lbMass.text = _global.MassParser(voItem.Mass);
         this.lbPrice.text = voItem.Price || "0";
         if(this.m_iMode == CTooltip.ARMOR)
         {
            this.fxAbIcon.gotoAndStop("ARMOR");
            this.lbAbLabel.text = "[[locale.inv.Armor]]";
            this.lbAbValue.text = _loc4_.Value || "";
         }
         else
         {
            this.fxAbIcon.gotoAndStop("DAMAGE");
            this.lbAbLabel.text = "[[locale.inv.Damage]]";
            this.lbAbValue.text = _loc4_.Value || "";
         }
         if(this.lbName.textHeight < 20)
         {
            this.lbName.text = "\n" + this.lbName.text;
         }
         if(voItem.Class == gui.vo.ItemClassEnum.COMMON)
         {
            this.lbClass.htmlText = gui.utils.ItemNameFormatter.formatName("[[locale.inv.lbClassCommon]]",gui.vo.ItemClassEnum.COMMON);
         }
         if(voItem.Class == gui.vo.ItemClassEnum.MAGIC)
         {
            this.lbClass.htmlText = gui.utils.ItemNameFormatter.formatName("[[locale.inv.lbClassMagic]]",gui.vo.ItemClassEnum.MAGIC);
         }
         if(voItem.Class == gui.vo.ItemClassEnum.RARE)
         {
            this.lbClass.htmlText = gui.utils.ItemNameFormatter.formatName("[[locale.inv.lbClassRare]]",gui.vo.ItemClassEnum.RARE);
         }
         if(voItem.Class == gui.vo.ItemClassEnum.EPIC)
         {
            this.lbClass.htmlText = gui.utils.ItemNameFormatter.formatName("[[locale.inv.lbClassEpic]]",gui.vo.ItemClassEnum.EPIC);
         }
         this.m_mcDescription.m_tfDescription.text = "";
         this.m_mcDescription.m_tfDescription.autoSize = true;
         if(voItem.DescFull != undefined && voItem.DescFull != "")
         {
            this.m_mcDescription.m_tfDescription.htmlText += "<font color=\"#959580\">" + voItem.DescFull + "</font>";
         }
         CTooltip.absTextBlockPlus(this.m_mcDescription.m_tfDescription,cx.utils.BitMaskUtils.filter(voItem.Abilities,"ID",0,gui.vo.AbilityEnum.BASIC),12800080);
         CTooltip.absTextBlockPlus(this.m_mcDescription.m_tfDescription,voItem.Bonuses,10274149);
         this.lbAbValue._x = this.lbAbLabel.textWidth + 32;
         this.m_mcDescription.m_tfDescription._y = 0;
         this.m_mcDescription.m_tfDescription._alpha = 100;
         this.m_iCurrentTweenMode = CTooltip.TEXT_IDDLE;
         if(this.m_mcDescription.m_tfDescription._height > this.m_mcDescription.m_mcMask._height + 4)
         {
            this.UpdateTweenState();
         }
      }
   }
   static function absTextBlockPlus(absBlock, absList, absColor)
   {
      var _loc5_ = "";
      var _loc6_ = 0;
      while(_loc6_ < absList.length)
      {
         if(_loc6_ != 0)
         {
            _loc5_ += "<br/>";
         }
         _loc5_ += "<font color=\"#" + absColor.toString(16) + "\">" + absList[_loc6_].Name + "</font>";
         _loc5_ += "&nbsp;";
         if(absList[_loc6_].Value != undefined && absList[_loc6_].Value != null)
         {
            _loc5_ += "<font color=\"#FFFFFF\">" + absList[_loc6_].Value + "</font>";
         }
         else if(absList[_loc6_].Duration != undefined && absList[_loc6_].Duration != null)
         {
            _loc5_ += "<font color=\"#FFFFFF\">" + absList[_loc6_].Duration + "</font>";
         }
         _loc6_ = _loc6_ + 1;
      }
      absBlock.htmlText += _loc5_;
   }
}
class CScroll extends CSlot
{
   var AddEventListener;
   var m_mcScroll;
   var m_mcScrollBcg;
   var m_iMaxElements;
   var m_iVisibleElements;
   var _visible;
   var m_fDragYScrollStart;
   var m_fDragYMouseStart;
   var _ymouse;
   static var MINIMUM_LENGTH = 5;
   var m_fLength = 1;
   var m_fScrollerLength = 1;
   var m_iCurrentIndex = 0;
   var m_bIsLockedToSteps = true;
   var m_pCallBack = null;
   var m_pParrent = null;
   function CScroll()
   {
      super();
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED,this.AddCallBacks);
   }
   function AddCallBacks(e)
   {
      this.m_mcScroll.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      this.m_mcScroll.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_UP_ANYWHERE,this.StopDrag);
      this.m_mcScrollBcg.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.JumpGO);
   }
   function Initialize(fLength, iMaxElements, iVisibleElements, pCallBack, pParrent)
   {
      this.m_fLength = fLength;
      this.m_iMaxElements = iMaxElements;
      this.m_iVisibleElements = iVisibleElements;
      this.m_pCallBack = pCallBack;
      this.m_pParrent = !pParrent ? null : pParrent;
      this.m_iCurrentIndex = 0;
      if(this.m_mcScrollBcg != undefined && this.m_mcScrollBcg != null)
      {
         this.m_mcScrollBcg._yscale = 100;
         this.m_mcScrollBcg._yscale = 100 * fLength / this.m_mcScrollBcg._height;
      }
      if(this.m_mcScroll != undefined && this.m_mcScroll != null)
      {
         this.m_fScrollerLength = 1;
         if(iMaxElements > 0 && iVisibleElements > 0)
         {
            this.m_fScrollerLength = fLength * iVisibleElements / iMaxElements;
            if(this.m_fScrollerLength > fLength)
            {
               this.m_fScrollerLength = fLength;
            }
            else if(this.m_fScrollerLength < CScroll.MINIMUM_LENGTH)
            {
               this.m_fScrollerLength = CScroll.MINIMUM_LENGTH;
            }
            this.m_mcScroll._yscale = 100;
            this.m_mcScroll._yscale = 100 * this.m_fScrollerLength / this.m_mcScroll._height;
         }
      }
      if(iMaxElements > iVisibleElements)
      {
         this._visible = true;
      }
      else
      {
         this._visible = false;
      }
      this.UpdateGraphic();
   }
   function StartDrag(e)
   {
      this.m_fDragYScrollStart = this.m_mcScroll._y;
      this.m_fDragYMouseStart = this._ymouse;
      this.m_mcScroll.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_MOVE,this.MoveDrag);
   }
   function StopDrag(e)
   {
      this.m_mcScroll.RemoveEventListener(mh2lib.utils.MH2Event.MOUSE_MOVE);
   }
   function MoveDrag(e)
   {
      var _loc3_ = this.m_fDragYMouseStart - this._ymouse;
      if(this.m_iMaxElements - this.m_iVisibleElements > 0)
      {
         var _loc4_ = this.m_iMaxElements - this.m_iVisibleElements;
         var _loc5_ = (this.m_fLength - this.m_fScrollerLength) / _loc4_;
         if(this.m_bIsLockedToSteps)
         {
            this.m_iCurrentIndex = Math.floor(0.5 + (this._ymouse - (this.m_fDragYMouseStart - this.m_fDragYScrollStart)) / _loc5_);
         }
         else
         {
            this.m_iCurrentIndex = (this._ymouse - (this.m_fDragYMouseStart - this.m_fDragYScrollStart)) / _loc5_;
         }
         this.m_iCurrentIndex = Math.max(Math.min(this.m_iCurrentIndex,_loc4_),0);
         if(this.m_pCallBack != null)
         {
            this.m_pCallBack(this.m_pParrent,this.m_iCurrentIndex);
         }
         this.UpdateGraphic();
      }
   }
   function UpdateGraphic()
   {
      if(this.m_iMaxElements - this.m_iVisibleElements > 0)
      {
         var _loc2_ = this.m_iMaxElements - this.m_iVisibleElements;
         var _loc3_ = (this.m_fLength - this.m_fScrollerLength) / _loc2_;
         this.m_mcScroll._y = this.m_iCurrentIndex * _loc3_;
      }
   }
   function SetNewPosition(iScrollIndexOffset)
   {
      if(this._visible)
      {
         var _loc3_ = this.m_iMaxElements - this.m_iVisibleElements;
         this.m_iCurrentIndex = Math.max(Math.min(iScrollIndexOffset,_loc3_),0);
         this.UpdateGraphic();
      }
   }
   function ScrollOffsetDown(iValue)
   {
      this.SetNewPosition(this.m_iCurrentIndex + iValue);
      if(this.m_pCallBack != null)
      {
         this.m_pCallBack(this.m_pParrent,this.m_iCurrentIndex);
      }
   }
   function ScrollOffsetUp(iValue)
   {
      this.SetNewPosition(this.m_iCurrentIndex - iValue);
      if(this.m_pCallBack != null)
      {
         this.m_pCallBack(this.m_pParrent,this.m_iCurrentIndex);
      }
   }
   function JumpGO(e)
   {
      this.m_fDragYScrollStart = this.m_mcScroll._y;
      this.m_fDragYMouseStart = this.m_mcScroll._y + this.m_fScrollerLength / 2;
      this.MoveDrag(e);
      this.m_mcScroll.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_MOVE,this.MoveDrag);
   }
   function SetNewMaxElements(iCount)
   {
      this.m_iMaxElements = iCount;
      var _loc3_ = this.m_iMaxElements - this.m_iVisibleElements;
      this.m_iCurrentIndex = Math.max(Math.min(this.m_iCurrentIndex,_loc3_),0);
      if(this.m_mcScroll != undefined && this.m_mcScroll != null)
      {
         this.m_fScrollerLength = 1;
         this.m_mcScroll._yscale = 100;
         if(this.m_iMaxElements > 0 && this.m_iVisibleElements > 0)
         {
            this.m_fScrollerLength = this.m_fLength * this.m_iVisibleElements / this.m_iMaxElements;
            if(this.m_fScrollerLength > this.m_fLength)
            {
               this.m_fScrollerLength = this.m_fLength;
            }
            else if(this.m_fScrollerLength < CScroll.MINIMUM_LENGTH)
            {
               this.m_fScrollerLength = CScroll.MINIMUM_LENGTH;
            }
            this.m_mcScroll._yscale = 100 * this.m_fScrollerLength / this.m_mcScroll._height;
         }
      }
   }
}
class CNormalButton extends mh2lib.display.MH2Component
{
   var m_mcTextField;
   var hitArea;
   var m_mcHitArea;
   var onPress;
   var gotoAndStop;
   var m_mcBackground;
   var fxFrame;
   var m_mcStates;
   static var TAB = "TAB";
   static var ESCAPE = "ESCAPE";
   static var ENTER = "ENTER";
   static var SPACE = "SPACE";
   static var BACKSPACE = "BACKSPACE";
   static var ALT = "ALT";
   static var LSHIFT = "LSHIFT";
   static var RSHIFT = "RSHIFT";
   static var LCONTROL = "LCONTROL";
   static var RCONTROL = "RCONTROL";
   static var DIR_N = "DIR_N";
   static var DIR_E = "DIR_E";
   static var DIR_S = "DIR_S";
   static var DIR_W = "DIR_W";
   static var XBOX_DIR_N = "XBOX_DIR_N";
   static var XBOX_DIR_E = "XBOX_DIR_E";
   static var XBOX_DIR_S = "XBOX_DIR_S";
   static var XBOX_DIR_W = "XBOX_DIR_W";
   static var MOUSE_LMB = "MOUSE_LMB";
   static var MOUSE_MMB = "MOUSE_MMB";
   static var MOUSE_RMB = "MOUSE_RMB";
   static var MOUSEZ = "MOUSEZ";
   static var XBOX_L = "XBOX_L";
   static var XBOX_R = "XBOX_R";
   static var XBOX_LT = "XBOX_LT";
   static var XBOX_RT = "XBOX_RT";
   static var XBOX_LB = "XBOX_LB";
   static var XBOX_RB = "XBOX_RB";
   static var XBOX_A = "XBOX_A";
   static var XBOX_B = "XBOX_B";
   static var XBOX_X = "XBOX_X";
   static var XBOX_Y = "XBOX_Y";
   static var ACTION_NO = "ACTION_NO";
   static var ACTION_YES = "ACTION_YES";
   static var PAD_DIGITUP = "PAD_DIGITUP";
   static var XBOX_START = "XBOX_START";
   static var XBOX_BACK = "XBOX_BACK";
   var m_sPCModeIcon = "";
   var m_sXBoxModeIcon = "";
   var realOnPress = null;
   function CNormalButton()
   {
      super();
      this.m_mcTextField.m_tfLeft._visible = false;
      this.m_mcTextField.m_tfRight._visible = false;
      this.hitArea = this.m_mcHitArea;
      this.m_mcHitArea._visible = false;
      _global.pFlow.RegisterButton(this);
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_CONSTRUCTED,this.AddEventsAfterLoad);
   }
   function AddEventsAfterLoad()
   {
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOVIECLIP_DESTROYED,this.RemoveButtonRegistration);
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.RollOver);
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.RollOut);
      this.RollOut();
   }
   function AddEventListener(creationPlace, event, func)
   {
      if(event == mh2lib.utils.MH2Event.MOUSE_PRESS)
      {
         this.onPress = cx.utils.Delegate.create(this,this.OnClick);
         this.realOnPress = cx.utils.Delegate.create(creationPlace,func,[new mh2lib.utils.MH2Event(this,event)]);
      }
      else
      {
         super.AddEventListener(creationPlace,event,func);
      }
   }
   function RemoveButtonRegistration()
   {
      _global.pFlow.UnRegisterButton(this);
   }
   function OnClick()
   {
      flash.external.ExternalInterface.call("PlaySound","gui/button/use");
      this.realOnPress();
   }
   function RollOver(e)
   {
      this.gotoAndStop("Highlight");
      this.UpdateGraphic();
   }
   function RollOut(e)
   {
      this.gotoAndStop("Normal");
      this.UpdateGraphic();
   }
   function SetBacgroundVisibility(bVisible)
   {
      this.m_mcBackground._visible = bVisible;
   }
   function SetText(sLeft, sRight)
   {
      if(sLeft != "")
      {
         this.m_mcTextField.m_tfLeft._visible = true;
         this.m_mcTextField.m_tfLeft.text = sLeft;
         this.m_mcTextField.m_tfLeft.text = flash.external.ExternalInterface.call("StringToUpper",this.m_mcTextField.m_tfLeft.text);
      }
      else
      {
         this.m_mcTextField.m_tfLeft._visible = false;
      }
      if(sRight != "")
      {
         this.m_mcTextField.m_tfRight._visible = true;
         this.m_mcTextField.m_tfRight.text = sRight;
         this.m_mcTextField.m_tfRight.text = flash.external.ExternalInterface.call("StringToUpper",this.m_mcTextField.m_tfRight.text);
      }
      else
      {
         this.m_mcTextField.m_tfRight._visible = false;
      }
   }
   function SetGraphicsMode(sPCMode, sXboxMode)
   {
      this.m_sPCModeIcon = sPCMode;
      this.m_sXBoxModeIcon = sXboxMode;
      this.UpdateGraphic();
   }
   function ButtonModeChanged()
   {
      this.UpdateGraphic();
   }
   function UpdateGraphic()
   {
      if(_global.pGUI.m_bUseXboxpad)
      {
         this.SetCurrentIcon(this.m_sXBoxModeIcon);
      }
      else
      {
         this.SetCurrentIcon(this.m_sPCModeIcon);
      }
   }
   function SetGraphic(sIconName)
   {
      switch(sIconName)
      {
         case CNormalButton.XBOX_RB:
         case CNormalButton.TAB:
            this.SetGraphicsMode(CNormalButton.TAB,CNormalButton.XBOX_RB);
            break;
         case CNormalButton.XBOX_B:
         case CNormalButton.ESCAPE:
            this.SetGraphicsMode(CNormalButton.ESCAPE,CNormalButton.XBOX_B);
            break;
         case CNormalButton.ENTER:
            this.SetGraphicsMode(CNormalButton.ENTER,CNormalButton.XBOX_A);
            break;
         case CNormalButton.XBOX_A:
         case CNormalButton.SPACE:
            this.SetGraphicsMode(CNormalButton.SPACE,CNormalButton.XBOX_A);
            break;
         case CNormalButton.XBOX_DIR_N:
         case CNormalButton.DIR_N:
         case CNormalButton.PAD_DIGITUP:
            this.SetGraphicsMode(CNormalButton.DIR_N,CNormalButton.XBOX_DIR_N);
            break;
         case CNormalButton.XBOX_DIR_E:
         case CNormalButton.DIR_E:
            this.SetGraphicsMode(CNormalButton.DIR_E,CNormalButton.XBOX_DIR_E);
            break;
         case CNormalButton.XBOX_DIR_S:
         case CNormalButton.DIR_S:
            this.SetGraphicsMode(CNormalButton.DIR_S,CNormalButton.XBOX_DIR_S);
            break;
         case CNormalButton.XBOX_DIR_W:
         case CNormalButton.DIR_W:
            this.SetGraphicsMode(CNormalButton.DIR_W,CNormalButton.XBOX_DIR_W);
            break;
         case CNormalButton.MOUSE_LMB:
            this.SetGraphicsMode(CNormalButton.MOUSE_LMB,CNormalButton.XBOX_A);
            break;
         case CNormalButton.MOUSE_MMB:
            this.SetGraphicsMode(CNormalButton.MOUSE_MMB,CNormalButton.XBOX_A);
            break;
         case CNormalButton.MOUSE_RMB:
            this.SetGraphicsMode(CNormalButton.MOUSE_RMB,CNormalButton.XBOX_A);
            break;
         case CNormalButton.ACTION_NO:
            this.SetGraphicsMode(CNormalButton.ACTION_NO,CNormalButton.XBOX_B);
            break;
         case CNormalButton.ACTION_YES:
            this.SetGraphicsMode(CNormalButton.ACTION_YES,CNormalButton.XBOX_A);
            break;
         default:
            this.SetGraphicsMode(sIconName,sIconName);
      }
   }
   function SetCurrentIcon(sIconName)
   {
      this.fxFrame._visible = !!1;
      var _loc3_ = _global.m_sLangPrefix.toUpperCase();
      if(_loc3_ == undefined || _loc3_.length != 2)
      {
         _loc3_ = String(flash.external.ExternalInterface.call("GetLanguage")).toUpperCase();
      }
      switch(sIconName)
      {
         case "TAB":
            this.m_mcStates.gotoAndStop("KB_TAB");
            break;
         case "ESCAPE":
            this.m_mcStates.gotoAndStop("ESC_" + _loc3_);
            break;
         case "ENTER":
            this.m_mcStates.gotoAndStop("ENTER_" + _loc3_);
            break;
         case "SPACE":
            this.m_mcStates.gotoAndStop("SPACE_" + _loc3_);
            break;
         case "BACKSPACE":
            this.m_mcStates.gotoAndStop("KB_BKSPC");
            break;
         case "ALT":
            this.m_mcStates.gotoAndStop("KB_ALT");
            break;
         case "LALT":
            this.m_mcStates.gotoAndStop("KB_ALT_L");
            break;
         case "RALT":
            this.m_mcStates.gotoAndStop("KB_ALT_R");
            break;
         case "LSHIFT":
            this.m_mcStates.gotoAndStop("KB_SHIFT_L");
            break;
         case "RSHIFT":
            this.m_mcStates.gotoAndStop("KB_SHIFT_R");
            break;
         case "LCONTROL":
            this.m_mcStates.gotoAndStop("KB_CTRL_L");
            break;
         case "RCONTROL":
            this.m_mcStates.gotoAndStop("KB_CTRL_R");
            break;
         case "DIR_N":
            this.m_mcStates.gotoAndStop("DIR_N");
            break;
         case "DIR_E":
            this.m_mcStates.gotoAndStop("DIR_E");
            break;
         case "DIR_S":
            this.m_mcStates.gotoAndStop("DIR_S");
            break;
         case "DIR_W":
            this.m_mcStates.gotoAndStop("DIR_W");
            break;
         case "XBOX_START":
            this.m_mcStates.gotoAndStop("XBOX_START");
            break;
         case "XBOX_BACK":
            this.m_mcStates.gotoAndStop("XBOX_BACK");
            break;
         case "XBOX_DIR_N":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_DIR_N");
            break;
         case "XBOX_DIR_E":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_DIR_E");
            break;
         case "XBOX_DIR_S":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_DIR_S");
            break;
         case "XBOX_DIR_W":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_DIR_W");
            break;
         case "MOUSE_LMB":
         case "LEFTMOUSE":
            this.m_mcStates.gotoAndStop("MOUSE_LMB");
            break;
         case "MOUSE_MMB":
         case "MIDDLEMOUSE":
            this.m_mcStates.gotoAndStop("MOUSE_MMB");
            break;
         case "MOUSE_RMB":
         case "RIGHTMOUSE":
            this.m_mcStates.gotoAndStop("MOUSE_RMB");
            break;
         case "MOUSEZ":
            this.m_mcStates.gotoAndStop("MOUSE_SCROLL");
            break;
         case "XBOX_L":
         case "PAD_LEFTTHUMB":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_L");
            break;
         case "XBOX_R":
         case "PAD_RIGHTTHUMB":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_R");
            break;
         case "XBOX_LT":
         case "PAD_LEFTTRIGGER":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_LT");
            break;
         case "XBOX_RT":
         case "PAD_RIGHTTRIGGER":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_RT");
            break;
         case "XBOX_LB":
         case "PAD_LEFTSHOULDER":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_LB");
            break;
         case "XBOX_RB":
         case "PAD_RIGHTSHOULDER":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_RB");
            break;
         case "XBOX_A":
         case "PAD_A_CROSS":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_A");
            break;
         case "XBOX_B":
         case "PAD_B_CIRCLE":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_B");
            break;
         case "XBOX_X":
         case "PAD_X_SQUARE":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_X");
            break;
         case "XBOX_Y":
         case "PAD_Y_TRIANGLE":
            this.fxFrame._visible = !!0;
            this.m_mcStates.gotoAndStop("XBOX_Y");
            break;
         case "ACTION_NO":
            this.m_mcStates.gotoAndStop("ACTION_NO");
            break;
         case "ACTION_YES":
            this.m_mcStates.gotoAndStop("ACTION_YES");
            break;
         default:
            this.m_mcStates.gotoAndStop(1);
            this.m_mcStates.iconLabel.text = sIconName;
      }
   }
}
if(!mh2lib.display.flowstates.FCGraphicOutOnly)
{
   _global.mh2lib.display.flowstates.FCGraphicOutOnly = function()
   {
      super();
      this.m_sStateName = "FCGraphicOutOnly";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCGraphicOutOnly = function()
   {
      super();
      this.m_sStateName = "FCGraphicOutOnly";
   }.prototype;
   _loc1_.EnterState = function()
   {
      this.Owner().m_pTween = com.greensock.TweenLite.to(this.Owner().m_mcGraphic,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:0,onComplete:this.FadeComplete,onCompleteParams:[this]});
      if(!_global.pFlow.m_bFadeToNewScreen || _global.pFlow.m_bControlRender)
      {
         this.Owner().m_pFlow.EnableRendering(true);
      }
   };
   _loc1_.FadeComplete = function(pState)
   {
      pState.Owner().m_mcGraphic._visible = false;
      pState.Owner().m_mcGraphic.Finalize();
      pState.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCExit());
   };
   ASSetPropFlags(_loc1_,null,1);
}
if(!gui.vo.ItemEnum)
{
   _loc1_ = _global.gui.vo.ItemEnum = function()
   {
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
   _global.gui.vo.ItemEnum = function()
   {
   }.ALL = 1;
   _global.gui.vo.ItemEnum = function()
   {
   }.QUEST = 2;
   _global.gui.vo.ItemEnum = function()
   {
   }.ACTIVE = 4;
   _global.gui.vo.ItemEnum = function()
   {
   }.EXAMINE = 8;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_ARMOR = 16;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_GLOVES = 32;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_GAUNTLETS = 32;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_PANTS = 64;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_BOOTS = 128;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_TROPHY = 256;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_SILVER = 512;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_STEEL = 1024;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_RANGE = 2048;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK = 4096;
   _global.gui.vo.ItemEnum = function()
   {
   }.SPECIAL_OIL = 8192;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK_1 = 4368;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK_2 = 4384;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK_3 = 4416;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK_4 = 4480;
   _global.gui.vo.ItemEnum = function()
   {
   }.SLOT_QUICK_5 = 4608;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_ARMOR = 65536;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_ARMOR_UPGRADES = 131072;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_RANGE = 262144;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_WEAPON = 524288;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_WEAPON_UPGRADES = 1048576;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_PETARD = 2097152;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_TRAPS = 4194304;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_ALCHEMY_INGREDIENTS = 8388608;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_CRAFTING_INGREDIENTS = 16777216;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_CRAFTING_SCHEMATICS = 33554432;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_LURES = 67108864;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_ELIXIR = 134217728;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_BOOK = 268435456;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_TROPHY = 536870912;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_MUTAGEN = 1073741824;
   _global.gui.vo.ItemEnum = function()
   {
   }.TYPE_JUNK = 16384;
}
if(!com.greensock.plugins.FramePlugin)
{
   _global.com.greensock.plugins.FramePlugin = function()
   {
      super();
      this.propName = "frame";
      this.overwriteProps = ["frame"];
      this.round = true;
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.FramePlugin = function()
   {
      super();
      this.propName = "frame";
      this.overwriteProps = ["frame"];
      this.round = true;
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      if(typeof target != "movieclip" || _global.isNaN(value))
      {
         return false;
      }
      this._target = MovieClip(target);
      this.frame = this._target._currentframe;
      this.addTween(this,"frame",this.frame,value,"frame");
      return true;
   };
   _loc1_.__set__changeFactor = function(n)
   {
      this.updateTweens(n);
      this._target.gotoAndStop(this.frame);
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.FramePlugin = function()
   {
      super();
      this.propName = "frame";
      this.overwriteProps = ["frame"];
      this.round = true;
   }.API = 1;
}
if(!com.greensock.plugins.HexColorsPlugin)
{
   _global.com.greensock.plugins.HexColorsPlugin = function()
   {
      super();
      this.propName = "hexColors";
      this.overwriteProps = [];
      this._colors = [];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.HexColorsPlugin = function()
   {
      super();
      this.propName = "hexColors";
      this.overwriteProps = [];
      this._colors = [];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      for(var p in value)
      {
         this.initColor(target,p,Number(target[p]),Number(value[p]));
      }
      return true;
   };
   _loc1_.initColor = function(target, propName, start, end)
   {
      if(start != end)
      {
         var _loc6_ = start >> 16;
         var _loc7_ = start >> 8 & 0xFF;
         var _loc8_ = start & 0xFF;
         this._colors[this._colors.length] = [target,propName,_loc6_,(end >> 16) - _loc6_,_loc7_,(end >> 8 & 0xFF) - _loc7_,_loc8_,(end & 0xFF) - _loc8_];
         this.overwriteProps[this.overwriteProps.length] = propName;
      }
   };
   _loc1_.killProps = function(lookup)
   {
      var _loc4_ = this._colors.length;
      while(_loc4_--)
      {
         if(lookup[this._colors[_loc4_][1]] != undefined)
         {
            this._colors.splice(_loc4_,1);
         }
      }
      super.killProps(lookup);
   };
   _loc1_.__set__changeFactor = function(n)
   {
      var _loc3_ = this._colors.length;
      while(_loc3_--)
      {
         var _loc4_ = this._colors[_loc3_];
         _loc4_[0][_loc4_[1]] = _loc4_[2] + n * _loc4_[3] << 16 | _loc4_[4] + n * _loc4_[5] << 8 | _loc4_[6] + n * _loc4_[7];
      }
      return this.changeFactor;
   };
   _loc1_.addProperty("changeFactor",function()
   {
   }
   ,_loc1_.__set__changeFactor);
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.HexColorsPlugin = function()
   {
      super();
      this.propName = "hexColors";
      this.overwriteProps = [];
      this._colors = [];
   }.API = 1;
}
if(!mh2lib.display.flowstates.FCFadeOut)
{
   _global.mh2lib.display.flowstates.FCFadeOut = function()
   {
      super();
      this.m_sStateName = "FCFadeOut";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCFadeOut = function()
   {
      super();
      this.m_sStateName = "FCFadeOut";
   }.prototype;
   _loc1_.EnterState = function()
   {
      this.Owner().m_pTween = com.greensock.TweenLite.to(this.Owner().m_mcFade,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:100,onComplete:this.FadeFull,onCompleteParams:[this]});
   };
   _loc1_.FadeFull = function(pState)
   {
      pState.Owner().m_mcGraphic._visible = false;
      pState.Owner().m_mcGraphic.Finalize();
      if(!_global.pFlow.m_bFadeToNewScreen || _global.pFlow.m_bControlRender)
      {
         pState.Owner().m_pFlow.EnableRendering(true);
      }
      if(pState.Owner().m_sVideoName != "")
      {
         _global.vCustomPanel.loadMovie("ui_panelbg.swf");
      }
      pState.Owner().m_pTween = com.greensock.TweenLite.to(pState.Owner().m_mcFade,mh2lib.display.MH2FlowChild.FADE_TIME,{_alpha:0,onComplete:pState.FadeEnd,onCompleteParams:[pState]});
   };
   _loc1_.FadeEnd = function(pState)
   {
      pState.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCExit());
   };
   ASSetPropFlags(_loc1_,null,1);
}
class CFilter extends mh2lib.display.MH2Component
{
   var m_tfName;
   var m_mcKindIcon0;
   var _sortPanel;
   static var SOURCE_RAW_ITEMS = 0;
   static var SOURCE_FILTERED = 1;
   var m_aFilters = [];
   var m_pCallbackFunction = null;
   var m_iCurrentIndex = 1;
   var m_iCurrentRollovered = -1;
   var m_iFiltersCount = 0;
   var m_iRMFilter = -1;
   var m_mcFocusedMC = null;
   var m_iSourceFormat = 0;
   var m_sAcceptorMaskName = "Mask";
   var m_sRefuseMaskName = "Mask";
   function CFilter()
   {
      super();
   }
   function ConfigureFilter(aFilters, iRMFilter)
   {
      this.m_aFilters = aFilters;
      this.m_iRMFilter = iRMFilter;
      this.m_iFiltersCount = aFilters.length;
   }
   function Initialize(pCallBack, iStartingIndex)
   {
      this.m_pCallbackFunction = pCallBack;
      if(iStartingIndex == -1)
      {
         iStartingIndex = this.m_aFilters.length;
      }
      this.m_iCurrentIndex = iStartingIndex;
      var _loc4_ = 0;
      while(_loc4_ <= this.m_iFiltersCount)
      {
         if(_loc4_ == 0)
         {
            this["m_mcKindIcon" + _loc4_].m_mcIcon.gotoAndStop(this.m_iCurrentIndex);
         }
         else
         {
            this["m_mcKindIcon" + _loc4_].m_mcIcon.gotoAndStop(_loc4_);
            this["m_mcKindIcon" + _loc4_].m_iID = _loc4_;
            this["m_mcKindIcon" + _loc4_].AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.OnRollOver);
            this["m_mcKindIcon" + _loc4_].AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.OnRollOut);
            this["m_mcKindIcon" + _loc4_].AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.OnPress);
         }
         this["m_mcKindIcon" + _loc4_].m_mcRollOverEffect._visible = false;
         _loc4_ = _loc4_ + 1;
      }
      this.UpdateGraphic();
   }
   function UpdateCapability(aSourceData)
   {
      if(this.m_iSourceFormat == CFilter.SOURCE_RAW_ITEMS)
      {
         var _loc3_ = 1;
         while(_loc3_ <= this.m_iFiltersCount)
         {
            if(this.BiteFilterAnyInType(aSourceData,this.m_aFilters[_loc3_ - 1][1],this.m_iRMFilter))
            {
               this["m_mcKindIcon" + _loc3_].gotoAndStop("Normal");
            }
            else
            {
               this["m_mcKindIcon" + _loc3_].gotoAndStop("Empty");
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      else
      {
         var _loc4_ = 1;
         while(_loc4_ <= this.m_iFiltersCount)
         {
            if(aSourceData[_loc4_ - 1].length > 0)
            {
               this["m_mcKindIcon" + _loc4_].gotoAndStop("Normal");
            }
            else
            {
               this["m_mcKindIcon" + _loc4_].gotoAndStop("Empty");
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      this.UpdateGraphic();
   }
   function Filter(aSourceData, sourceFormat)
   {
      this.m_iSourceFormat = sourceFormat;
      this.UpdateCapability(aSourceData);
      if(this.m_iSourceFormat == CFilter.SOURCE_RAW_ITEMS)
      {
         return this.BiteFilter(aSourceData,this.m_aFilters[this.m_iCurrentIndex - 1][1],this.m_iRMFilter);
      }
      return aSourceData[this.m_iCurrentIndex - 1];
   }
   function BiteFilter(aSource, iFilter, iRFilter)
   {
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < aSource.length)
      {
         if(Number(Number(aSource[_loc6_][this.m_sAcceptorMaskName]) & iFilter) > 0)
         {
            if(iRFilter == -1 || Number(Number(aSource[_loc6_][this.m_sRefuseMaskName]) & iRFilter) == 0)
            {
               _loc5_.push(aSource[_loc6_]);
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return _loc5_;
   }
   function BiteFilterAnyInType(aSource, iFilter, iRFilter)
   {
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < aSource.length)
      {
         if(Number(Number(aSource[_loc6_][this.m_sAcceptorMaskName]) & iFilter) > 0)
         {
            if(iRFilter == -1 || Number(Number(aSource[_loc6_][this.m_sRefuseMaskName]) & iRFilter) == 0)
            {
               return true;
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return false;
   }
   function BiteFilterIsType(pItem, iFilter, iRFilter)
   {
      if(Number(Number(pItem[this.m_sAcceptorMaskName]) & iFilter) > 0)
      {
         if(iRFilter == -1 || Number(Number(pItem[this.m_sRefuseMaskName]) & iRFilter) == 0)
         {
            return true;
         }
      }
      return false;
   }
   function UpdateGraphic()
   {
      var _loc2_ = 0;
      while(_loc2_ <= this.m_iFiltersCount)
      {
         if(_loc2_ == 0)
         {
            if(this.m_iCurrentRollovered > 0)
            {
               this["m_mcKindIcon" + _loc2_].m_mcIcon.gotoAndStop(this.m_iCurrentRollovered);
               this.m_tfName.text = this.m_aFilters[this.m_iCurrentRollovered - 1][0];
            }
            else
            {
               this["m_mcKindIcon" + _loc2_].m_mcIcon.gotoAndStop(this.m_iCurrentIndex);
               this.m_tfName.text = this.m_aFilters[this.m_iCurrentIndex - 1][0];
            }
         }
         if(this.m_iCurrentIndex == _loc2_)
         {
            this["m_mcKindIcon" + _loc2_].m_mcRollOverEffect._visible = false;
            this["m_mcKindIcon" + _loc2_].m_mcBackground._visible = true;
         }
         else
         {
            this["m_mcKindIcon" + _loc2_].m_mcBackground._visible = false;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function OnRollOver(e)
   {
      var _loc3_ = e.m_pCaller;
      if(_loc3_.m_iID != this.m_iCurrentIndex)
      {
         this.m_iCurrentRollovered = _loc3_.m_iID;
         _loc3_.m_mcRollOverEffect._visible = true;
         if(this.m_mcFocusedMC != null)
         {
            this.m_mcFocusedMC.m_mcRollOverEffect._visible = false;
         }
         this.m_mcFocusedMC = _loc3_;
         if(this.m_iCurrentIndex == this.m_mcFocusedMC.m_iID)
         {
            this.m_mcFocusedMC.m_mcRollOverEffect._visible = false;
         }
         else
         {
            this.m_mcFocusedMC.m_mcRollOverEffect._visible = true;
         }
         this.m_mcKindIcon0.m_mcIcon.gotoAndStop(this.m_iCurrentRollovered);
         this.m_tfName.text = this.m_aFilters[this.m_iCurrentRollovered - 1][0];
      }
   }
   function OnRollOut(e)
   {
      var _loc3_ = e.m_pCaller;
      _loc3_.m_mcRollOverEffect._visible = false;
      if(this.m_mcFocusedMC != null)
      {
         this.m_mcFocusedMC.m_mcRollOverEffect._visible = false;
      }
      this.m_mcKindIcon0.m_mcIcon.gotoAndStop(this.m_iCurrentIndex);
      this.m_tfName.text = this.m_aFilters[this.m_iCurrentIndex - 1][0];
      this.m_iCurrentRollovered = -1;
   }
   function OnPress(e)
   {
      var _loc3_ = e.m_pCaller;
      if(_loc3_.m_iID != this.m_iCurrentIndex)
      {
         this.m_iCurrentIndex = _loc3_.m_iID;
         _loc3_.m_mcRollOverEffect._visible = false;
         this.UpdateGraphic();
         this.m_pCallbackFunction();
      }
   }
   function SetFilterBasedOnItem(pItem)
   {
      var _loc3_ = 1;
      while(_loc3_ <= this.m_iFiltersCount)
      {
         if(this.BiteFilterIsType(pItem,this.m_aFilters[_loc3_ - 1][1],-1))
         {
            if(_loc3_ != this.m_iCurrentIndex)
            {
               this.m_iCurrentIndex = _loc3_;
               this["m_mcKindIcon" + _loc3_].m_mcRollOverEffect._visible = false;
               this.UpdateGraphic();
               this.m_pCallbackFunction();
            }
            return undefined;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function SetNextFilter()
   {
      this.m_iCurrentIndex = this.m_iCurrentIndex + 1;
      if(this.m_iCurrentIndex > this.m_iFiltersCount)
      {
         this.m_iCurrentIndex = 1;
      }
      this["m_mcKindIcon" + this.m_iCurrentIndex].m_mcRollOverEffect._visible = false;
      this.UpdateGraphic();
      this.m_pCallbackFunction();
   }
   function SetPrevFilter()
   {
      this.m_iCurrentIndex = this.m_iCurrentIndex - 1;
      if(this.m_iCurrentIndex < 1)
      {
         this.m_iCurrentIndex = this.m_iFiltersCount;
      }
      this["m_mcKindIcon" + this.m_iCurrentIndex].m_mcRollOverEffect._visible = false;
      this.UpdateGraphic();
      this.m_pCallbackFunction();
   }
   function GamepadNextSorter()
   {
      var _loc2_ = this._sortPanel;
      if(_loc2_ != null)
      {
         var _loc3_ = this._sortPanel._selectedButton;
         var _loc4_ = _loc3_.nOrd;
         _loc4_ = _loc4_ + 1;
         if(_loc4_ > 4)
         {
            _loc4_ = 1;
         }
         _loc2_["SortButton" + _loc4_].onPress();
      }
   }
   function GamepadInvertSort()
   {
      var _loc2_ = this._sortPanel;
      if(_loc2_ != null)
      {
         var _loc3_ = this._sortPanel._selectedButton;
         var _loc4_ = _loc3_.nOrd;
         _loc2_["SortButton" + _loc4_].onPress();
      }
   }
}
class MH2MovieClipLinker extends mh2lib.display.MH2MovieClip
{
   function MH2MovieClipLinker()
   {
      super();
   }
}
if(!com.greensock.plugins.DropShadowFilterPlugin)
{
   _global.com.greensock.plugins.DropShadowFilterPlugin = function()
   {
      super();
      this.propName = "dropShadowFilter";
      this.overwriteProps = ["dropShadowFilter"];
   } extends com.greensock.plugins.FilterPlugin;
   _loc1_ = _global.com.greensock.plugins.DropShadowFilterPlugin = function()
   {
      super();
      this.propName = "dropShadowFilter";
      this.overwriteProps = ["dropShadowFilter"];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      this._target = target;
      this._type = flash.filters.DropShadowFilter;
      this.initFilter(value,new flash.filters.DropShadowFilter(0,45,0,0,0,0,1,value.quality || 2,value.inner,value.knockout,value.hideObject),com.greensock.plugins.DropShadowFilterPlugin._propNames);
      return true;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.DropShadowFilterPlugin = function()
   {
      super();
      this.propName = "dropShadowFilter";
      this.overwriteProps = ["dropShadowFilter"];
   }.API = 1;
   _global.com.greensock.plugins.DropShadowFilterPlugin = function()
   {
      super();
      this.propName = "dropShadowFilter";
      this.overwriteProps = ["dropShadowFilter"];
   }._propNames = ["distance","angle","color","alpha","blurX","blurY","strength","quality","inner","knockout","hideObject"];
}
if(!com.greensock.plugins.ShortRotationPlugin)
{
   _global.com.greensock.plugins.ShortRotationPlugin = function()
   {
      super();
      this.propName = "shortRotation";
      this.overwriteProps = [];
   } extends com.greensock.plugins.TweenPlugin;
   _loc1_ = _global.com.greensock.plugins.ShortRotationPlugin = function()
   {
      super();
      this.propName = "shortRotation";
      this.overwriteProps = [];
   }.prototype;
   _loc1_.onInitTween = function(target, value, tween)
   {
      if(typeof value == "number")
      {
         return false;
      }
      for(var p in value)
      {
         this.initRotation(target,p,target[p],typeof value[p] != "number" ? target[p] + Number(value[p]) : Number(value[p]));
      }
      return true;
   };
   _loc1_.initRotation = function(target, propName, start, end)
   {
      var _loc6_ = (end - start) % 360;
      if(_loc6_ != _loc6_ % 180)
      {
         _loc6_ = _loc6_ >= 0 ? _loc6_ - 360 : _loc6_ + 360;
      }
      this.addTween(target,propName,start,start + _loc6_,propName);
      this.overwriteProps[this.overwriteProps.length] = propName;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.com.greensock.plugins.ShortRotationPlugin = function()
   {
      super();
      this.propName = "shortRotation";
      this.overwriteProps = [];
   }.API = 1;
}
class com.greensock.TweenLite extends com.greensock.core.TweenCore
{
   var cachedStartTime;
   var _delay;
   var ratio;
   var target;
   var _targetID;
   var vars;
   var cachedTimeScale;
   var propTweenLookup;
   var _ease;
   var _overwrite;
   var active;
   var cachedPT1;
   var _notifyPluginsOfEnabled;
   var _hasPlugins;
   var _hasUpdate;
   var _overwrittenProps;
   var initted;
   var cachedTime;
   var cachedDuration;
   var cachedTotalTime;
   var _rawPrevTime;
   var cachedReversed;
   var cachedPaused;
   var complete;
   static var onPluginEvent;
   static var rootFrame;
   static var rootTimeline;
   static var rootFramesTimeline;
   static var _timingClip;
   static var overwriteManager;
   static var version = 11.35;
   static var plugins = {};
   static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
   static var defaultEase = com.greensock.TweenLite.easeOut;
   static var masterList = {};
   static var _cnt = -16000;
   static var _reservedProps = {ease:1,delay:1,overwrite:1,onComplete:1,onCompleteParams:1,useFrames:1,runBackwards:1,startAt:1,onUpdate:1,onUpdateParams:1,roundProps:1,onStart:1,onStartParams:1,onReverseComplete:1,onReverseCompleteParams:1,onRepeat:1,onRepeatParams:1,proxiedEase:1,easeParams:1,yoyo:1,onCompleteListener:1,onUpdateListener:1,onStartListener:1,orientToBezier:1,timeScale:1,immediateRender:1,repeat:1,repeatDelay:1,timeline:1,data:1,paused:1};
   function TweenLite(target, duration, vars)
   {
      super(duration,vars);
      if(com.greensock.TweenLite._timingClip.onEnterFrame != com.greensock.TweenLite.updateAll)
      {
         var _loc6_ = _root.getBytesLoaded() != undefined ? _root : com.greensock.TweenLite.findSubloadedSWF(_root);
         var _loc7_ = 999;
         while(_loc6_.getInstanceAtDepth(_loc7_) != undefined)
         {
            _loc7_ = _loc7_ + 1;
         }
         com.greensock.TweenLite._timingClip = _loc6_.createEmptyMovieClip("__tweenLite" + String(com.greensock.TweenLite.version).split(".").join("_"),_loc7_);
         com.greensock.TweenLite._timingClip = _root;
         com.greensock.TweenLite._timingClip.onEnterFrame = com.greensock.TweenLite.updateAll;
         com.greensock.TweenLite.rootTimeline.cachedStartTime = getTimer() * 0.001;
         com.greensock.TweenLite.rootTimeline.cachedTotalTime = com.greensock.TweenLite.rootFramesTimeline.cachedTotalTime = 0;
         this.cachedStartTime = this._delay;
         com.greensock.TweenLite.rootFramesTimeline.cachedStartTime = com.greensock.TweenLite.rootFrame;
      }
      this.ratio = 0;
      this.target = target;
      this._targetID = com.greensock.TweenLite.getID(target,true);
      if(this.vars.timeScale != undefined && this.target instanceof com.greensock.core.TweenCore)
      {
         this.cachedTimeScale = 1;
      }
      this.propTweenLookup = {};
      this._ease = com.greensock.TweenLite.defaultEase;
      this._overwrite = !(vars.overwrite == undefined || !com.greensock.TweenLite.overwriteManager.enabled && vars.overwrite > 1) ? Number(vars.overwrite) : com.greensock.TweenLite.overwriteManager.mode;
      var _loc8_ = com.greensock.TweenLite.masterList[this._targetID].tweens;
      if(_loc8_.length == 0)
      {
         _loc8_[0] = this;
      }
      else if(this._overwrite == 1)
      {
         var _loc9_ = _loc8_.length;
         while((_loc9_ = _loc9_ - 1) > -1)
         {
            if(!_loc8_[_loc9_].gc)
            {
               _loc8_[_loc9_].setEnabled(false,false);
            }
         }
         com.greensock.TweenLite.masterList[this._targetID].tweens = [this];
      }
      else
      {
         _loc8_[_loc8_.length] = this;
      }
      if(this.active || this.vars.immediateRender)
      {
         this.renderTime(0,false,true);
      }
   }
   static function initClass()
   {
      com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.TintPlugin,com.greensock.plugins.ScalePlugin,com.greensock.plugins.FramePlugin,com.greensock.plugins.ShortRotationPlugin,com.greensock.plugins.BlurFilterPlugin,com.greensock.plugins.ScrollRectPlugin,com.greensock.plugins.DropShadowFilterPlugin,com.greensock.plugins.AutoAlphaPlugin]);
      com.greensock.TweenLite.rootFrame = 0;
      com.greensock.TweenLite.rootTimeline = new com.greensock.core.SimpleTimeline(null);
      com.greensock.TweenLite.rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
      com.greensock.TweenLite.rootTimeline.autoRemoveChildren = com.greensock.TweenLite.rootFramesTimeline.autoRemoveChildren = true;
      if(com.greensock.TweenLite.overwriteManager == undefined)
      {
         com.greensock.TweenLite.overwriteManager = {mode:1,enabled:false};
      }
   }
   function init()
   {
      if(this.vars.onInit)
      {
         this.vars.onInit.apply(null,this.vars.onInitParams);
      }
      if(typeof this.vars.ease == "function")
      {
         this._ease = this.vars.ease;
      }
      if(this.vars.easeParams != undefined)
      {
         this.vars.proxiedEase = this._ease;
         this._ease = this.easeProxy;
      }
      this.cachedPT1 = undefined;
      this.propTweenLookup = {};
      for(var _loc2_ in this.vars)
      {
         if(!(com.greensock.TweenLite._reservedProps[_loc2_] && !(_loc2_ == "timeScale" && this.target instanceof com.greensock.core.TweenCore)))
         {
            var _loc4_ = null;
            if(com.greensock.TweenLite.plugins[_loc2_] && (_loc4_ = new com.greensock.TweenLite.plugins[_loc2_]()).onInitTween(this.target,this.vars[_loc2_],this))
            {
               this.cachedPT1 = new com.greensock.core.PropTween(_loc4_,"changeFactor",0,1,_loc4_.overwriteProps.length != 1 ? "_MULTIPLE_" : _loc4_.overwriteProps[0],true,this.cachedPT1);
               if(this.cachedPT1.name == "_MULTIPLE_")
               {
                  var _loc3_ = _loc4_.overwriteProps.length;
                  while((_loc3_ = _loc3_ - 1) > -1)
                  {
                     this.propTweenLookup[_loc4_.overwriteProps[_loc3_]] = this.cachedPT1;
                  }
               }
               else
               {
                  this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
               }
               if(_loc4_.priority)
               {
                  this.cachedPT1.priority = _loc4_.priority;
                  var _loc5_ = true;
               }
               if(_loc4_.onDisable || _loc4_.onEnable)
               {
                  this._notifyPluginsOfEnabled = true;
               }
               this._hasPlugins = true;
            }
            else
            {
               this.cachedPT1 = new com.greensock.core.PropTween(this.target,_loc2_,Number(this.target[_loc2_]),typeof this.vars[_loc2_] != "number" ? Number(this.vars[_loc2_]) : Number(this.vars[_loc2_]) - this.target[_loc2_],_loc2_,false,this.cachedPT1);
               this.propTweenLookup[_loc2_] = this.cachedPT1;
            }
         }
      }
      if(_loc5_)
      {
         com.greensock.TweenLite.onPluginEvent("onInit",this);
      }
      if(this.vars.runBackwards)
      {
         var _loc7_ = this.cachedPT1;
         while(_loc7_)
         {
            _loc7_.start += _loc7_.change;
            _loc7_.change = - _loc7_.change;
            _loc7_ = _loc7_.nextNode;
         }
      }
      this._hasUpdate = typeof this.vars.onUpdate == "function";
      if(this._overwrittenProps)
      {
         this.killVars(this._overwrittenProps);
         if(this.cachedPT1 == undefined)
         {
            this.setEnabled(false,false);
         }
      }
      var _loc6_ = null;
      if(this._overwrite > 1 && (this.cachedPT1 && ((_loc6_ = com.greensock.TweenLite.masterList[this._targetID].tweens) && _loc6_.length > 1)))
      {
         if(com.greensock.TweenLite.overwriteManager.manageOverwrites(this,this.propTweenLookup,_loc6_,this._overwrite))
         {
            this.init();
         }
      }
      this.initted = true;
   }
   function renderTime(time, suppressEvents, force)
   {
      var _loc6_ = this.cachedTime;
      if(time >= this.cachedDuration)
      {
         this.cachedTotalTime = this.cachedTime = this.cachedDuration;
         this.ratio = 1;
         var _loc5_ = true;
         if(this.cachedDuration == 0)
         {
            if((time == 0 || this._rawPrevTime < 0) && this._rawPrevTime != time)
            {
               force = true;
            }
            this._rawPrevTime = time;
         }
      }
      else if(time <= 0)
      {
         this.cachedTotalTime = this.cachedTime = this.ratio = 0;
         if(time < 0)
         {
            this.active = false;
            if(this.cachedDuration == 0)
            {
               if(this._rawPrevTime > 0)
               {
                  force = true;
                  _loc5_ = true;
               }
               this._rawPrevTime = time;
            }
         }
         if(this.cachedReversed && _loc6_ != 0)
         {
            _loc5_ = true;
         }
      }
      else
      {
         this.cachedTotalTime = this.cachedTime = time;
         this.ratio = this._ease(time,0,1,this.cachedDuration);
      }
      if(this.cachedTime == _loc6_ && !force)
      {
         return undefined;
      }
      if(!this.initted)
      {
         this.init();
         if(!_loc5_ && this.cachedTime)
         {
            this.ratio = this._ease(this.cachedTime,0,1,this.cachedDuration);
         }
      }
      if(!this.active && !this.cachedPaused)
      {
         this.active = true;
      }
      if(_loc6_ == 0 && (this.vars.onStart && (this.cachedTime != 0 && !suppressEvents)))
      {
         this.vars.onStart.apply(this.vars.onStartScope,this.vars.onStartParams);
      }
      var _loc7_ = this.cachedPT1;
      while(_loc7_)
      {
         _loc7_.target[_loc7_.property] = _loc7_.start + this.ratio * _loc7_.change;
         _loc7_ = _loc7_.nextNode;
      }
      if(this._hasUpdate && !suppressEvents)
      {
         this.vars.onUpdate.apply(this.vars.onUpdateScope,this.vars.onUpdateParams);
      }
      if(_loc5_)
      {
         if(this._hasPlugins && this.cachedPT1)
         {
            com.greensock.TweenLite.onPluginEvent("onComplete",this);
         }
         this.complete(true,suppressEvents);
      }
   }
   function killVars(vars, permanent)
   {
      if(this._overwrittenProps == undefined)
      {
         this._overwrittenProps = {};
      }
      for(var _loc4_ in vars)
      {
         if(this.propTweenLookup[_loc4_])
         {
            var _loc5_ = this.propTweenLookup[_loc4_];
            if(_loc5_.isPlugin && _loc5_.name == "_MULTIPLE_")
            {
               _loc5_.target.killProps(vars);
               if(_loc5_.target.overwriteProps.length == 0)
               {
                  _loc5_.name = "";
               }
            }
            if(_loc5_.name != "_MULTIPLE_")
            {
               if(_loc5_.nextNode)
               {
                  _loc5_.nextNode.prevNode = _loc5_.prevNode;
               }
               if(_loc5_.prevNode)
               {
                  _loc5_.prevNode.nextNode = _loc5_.nextNode;
               }
               else if(this.cachedPT1 == _loc5_)
               {
                  this.cachedPT1 = _loc5_.nextNode;
               }
               if(_loc5_.isPlugin && _loc5_.target.onDisable)
               {
                  _loc5_.target.onDisable();
                  if(_loc5_.target.activeDisable)
                  {
                     var _loc6_ = true;
                  }
               }
               delete this.propTweenLookup[_loc4_];
            }
         }
         if(permanent != false && vars != this._overwrittenProps)
         {
            this._overwrittenProps[_loc4_] = 1;
         }
      }
      return _loc6_;
   }
   function invalidate()
   {
      if(this._notifyPluginsOfEnabled)
      {
         com.greensock.TweenLite.onPluginEvent("onDisable",this);
      }
      this.cachedPT1 = undefined;
      this._overwrittenProps = undefined;
      this._hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
      this.propTweenLookup = {};
   }
   function setEnabled(enabled, ignoreTimeline)
   {
      if(enabled)
      {
         var _loc5_ = com.greensock.TweenLite.masterList[this._targetID].tweens;
         if(_loc5_)
         {
            _loc5_[_loc5_.length] = this;
         }
         else
         {
            com.greensock.TweenLite.masterList[this._targetID] = {target:this.target,tweens:[this]};
         }
      }
      super.setEnabled(enabled,ignoreTimeline);
      if(this._notifyPluginsOfEnabled && this.cachedPT1)
      {
         return com.greensock.TweenLite.onPluginEvent(!enabled ? "onDisable" : "onEnable",this);
      }
      return false;
   }
   function easeProxy(t, b, c, d)
   {
      return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
   }
   static function to(target, duration, vars)
   {
      return new com.greensock.TweenLite(target,duration,vars);
   }
   static function from(target, duration, vars)
   {
      vars.runBackwards = true;
      if(vars.immediateRender != false)
      {
         vars.immediateRender = true;
      }
      return new com.greensock.TweenLite(target,duration,vars);
   }
   static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
   {
      return new com.greensock.TweenLite(onComplete,0,{delay:delay,onComplete:onComplete,onCompleteParams:onCompleteParams,onCompleteScope:onCompleteScope,immediateRender:false,useFrames:useFrames,overwrite:0});
   }
   static function updateAll()
   {
      com.greensock.TweenLite.rootTimeline.renderTime((getTimer() * 0.001 - com.greensock.TweenLite.rootTimeline.cachedStartTime) * com.greensock.TweenLite.rootTimeline.cachedTimeScale,false,false);
      com.greensock.TweenLite.rootFrame = com.greensock.TweenLite.rootFrame + 1;
      com.greensock.TweenLite.rootFramesTimeline.renderTime((com.greensock.TweenLite.rootFrame - com.greensock.TweenLite.rootFramesTimeline.cachedStartTime) * com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale,false,false);
      if(!(com.greensock.TweenLite.rootFrame % 60))
      {
         var _loc2_ = com.greensock.TweenLite.masterList;
         for(var p in _loc2_)
         {
            var _loc4_ = _loc2_[p].tweens;
            var _loc3_ = _loc4_.length;
            while((_loc3_ = _loc3_ - 1) > -1)
            {
               if(_loc4_[_loc3_].gc)
               {
                  _loc4_.splice(_loc3_,1);
               }
            }
            if(_loc4_.length == 0)
            {
               delete _loc2_[p];
            }
         }
      }
   }
   static function killTweensOf(target, complete, vars)
   {
      var _loc5_ = com.greensock.TweenLite.getID(target,true);
      var _loc6_ = com.greensock.TweenLite.masterList[_loc5_].tweens;
      if(_loc6_ != undefined)
      {
         var _loc7_ = _loc6_.length;
         while((_loc7_ = _loc7_ - 1) > -1)
         {
            var _loc8_ = _loc6_[_loc7_];
            if(!_loc8_.gc)
            {
               if(complete == true)
               {
                  _loc8_.complete(false,false);
               }
               if(vars != undefined)
               {
                  _loc8_.killVars(vars);
               }
               if(vars == undefined || _loc8_.cachedPT1 == undefined && _loc8_.initted)
               {
                  _loc8_.setEnabled(false,false);
               }
            }
         }
         if(vars == undefined)
         {
            delete com.greensock.TweenLite.masterList[_loc5_];
         }
      }
   }
   static function getID(target, lookup)
   {
      if(lookup)
      {
         var _loc5_ = com.greensock.TweenLite.masterList;
         if(typeof target == "movieclip")
         {
            if(_loc5_[String(target)] != undefined)
            {
               return String(target);
            }
            var _loc4_ = String(target);
            com.greensock.TweenLite.masterList[_loc4_] = {target:target,tweens:[]};
            return _loc4_;
         }
         for(var p in _loc5_)
         {
            if(_loc5_[p].target == target)
            {
               return p;
            }
         }
      }
      com.greensock.TweenLite._cnt = com.greensock.TweenLite._cnt + 1;
      _loc4_ = "t" + com.greensock.TweenLite._cnt;
      com.greensock.TweenLite.masterList[_loc4_] = {target:target,tweens:[]};
      return _loc4_;
   }
   static function easeOut(t, b, c, d)
   {
      return -1 * (t /= d) * (t - 2);
   }
   static function findSubloadedSWF(mc)
   {
      for(var p in mc)
      {
         if(typeof mc[p] == "movieclip")
         {
            if(mc[p]._url != _root._url && mc[p].getBytesLoaded() != undefined)
            {
               return mc[p];
            }
            if(com.greensock.TweenLite.findSubloadedSWF(mc[p]) != undefined)
            {
               return com.greensock.TweenLite.findSubloadedSWF(mc[p]);
            }
         }
      }
      return undefined;
   }
}
if(!mh2lib.display.FCStateMachine)
{
   _global.mh2lib.display.FCStateMachine = function(owner)
   {
      super();
      this.m_pOwner = owner;
   } extends mh2lib.utils.MH2StateMachine;
   _loc1_ = _global.mh2lib.display.FCStateMachine = function(owner)
   {
      super();
      this.m_pOwner = owner;
   }.prototype;
   _loc1_.PostEvent = function(type)
   {
      if(super.PostEvent(type))
      {
         return true;
      }
      return false;
   };
   ASSetPropFlags(_loc1_,null,1);
   _global.mh2lib.display.FCStateMachine = function(owner)
   {
      super();
      this.m_pOwner = owner;
   }.FINALIZE = "Finalize";
}
if(!mh2lib.display.flowstates.FCScreenReady)
{
   _global.mh2lib.display.flowstates.FCScreenReady = function()
   {
      super();
      this.m_sStateName = "FCScreenReady";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCScreenReady = function()
   {
      super();
      this.m_sStateName = "FCScreenReady";
   }.prototype;
   _loc1_.EnterState = function()
   {
      _global.pFlow.SetFlowBussy(false);
   };
   ASSetPropFlags(_loc1_,null,1);
}
class gui.feed.IStaticData
{
   function IStaticData()
   {
   }
}
if(!gui.feed.InvData)
{
   _loc1_ = _global.gui.feed.InvData = function()
   {
      this.Items = [];
      this.Slots = [];
      this.LastSelectedSlotArray = [];
      this.bTrash = null;
      this.Orens = 0;
   }.prototype;
   _loc1_.Commit = function()
   {
      this.onData(null);
   };
   _loc1_.SetBookText = function(sText)
   {
      this.m_sBookText = sText;
      if(this.onBookText != null)
      {
         this.onBookText();
      }
   };
   _loc1_.UpdateStringMasks = function()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.Items.length)
      {
         this.Items[_loc2_].m_sMask = String(this.Items[_loc2_].Mask);
         _loc2_ = _loc2_ + 1;
      }
   };
   _loc1_.runSanityCheck = function()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.Items.length)
      {
         this.Items[_loc2_].Mask = _global.parseInt(this.Items[_loc2_].Mask);
         _loc2_ = _loc2_ + 1;
      }
   };
   _loc1_._qsAddItem = function(index, itm)
   {
      this.Slots[index - 1] = itm;
   };
   _loc1_._qsRemItem = function(index)
   {
      this.Slots[index - 1] = undefined;
   };
   _loc1_._qsFindItem = function(index)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.Items.length)
      {
         if(this.Items[_loc3_].ID == this.Slots[index - 1])
         {
            return this.Items[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.RemoveQuickSlotItemID = function(ID)
   {
      var _loc3_ = 0;
      _loc3_ = 0;
      while(_loc3_ < this.Slots.length)
      {
         if(this.Slots[_loc3_] == ID)
         {
            this.Slots[_loc3_] = undefined;
            var _loc4_ = 0;
            while(_loc4_ < this.LastSelectedSlotArray.length)
            {
               if(this.LastSelectedSlotArray[_loc4_] == _loc3_)
               {
                  this.LastSelectedSlotArray.splice(_loc4_,1);
                  break;
               }
               _loc4_ = _loc4_ + 1;
            }
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.RemoveQuickSlotID = function(ID)
   {
      this.Slots[ID - 1] = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this.LastSelectedSlotArray.length)
      {
         if(this.LastSelectedSlotArray[_loc3_] == ID - 1)
         {
            this.LastSelectedSlotArray.splice(_loc3_,1);
            break;
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.AddQuickSlotItem = function(iSlotNr, iItemID)
   {
      this.RemoveQuickSlotItemID(iItemID);
      this.Slots[iSlotNr - 1] = iItemID;
      this.LastSelectedSlotArray.push(iSlotNr - 1);
   };
   _loc1_.findQuickSlotItem = function(index)
   {
      var _loc3_ = 0;
      while(_loc3_ < this.Items.length)
      {
         if(this.Items[_loc3_].ID == this.Slots[index - 1])
         {
            return this.Items[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
   };
   _loc1_.GetMass = function()
   {
      return String(this.Mass);
   };
   _global.gui.feed.InvData = function()
   {
      this.Items = [];
      this.Slots = [];
      this.LastSelectedSlotArray = [];
      this.bTrash = null;
      this.Orens = 0;
   } implements gui.feed.IStaticData;
   ASSetPropFlags(_loc1_,null,1);
   _loc1_.m_sBookText = "";
   _loc1_.onBookText = null;
}
if(!gui.vo.AbilityEnum)
{
   _loc1_ = _global.gui.vo.AbilityEnum = function()
   {
   }.prototype;
   ASSetPropFlags(_loc1_,null,1);
   _global.gui.vo.AbilityEnum = function()
   {
   }.BASIC = 1;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_ARMOR = 16;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_ARMOR_ON_BLOCK = 32;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_DAMAGE = 64;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_DAMAGE_FOO_BAR = 128;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_HEALTH = 256;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_STAMINA = 512;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_REGENERATION = 1024;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_RESISTANCE = 4096;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_CRITICAL = 8192;
   _global.gui.vo.AbilityEnum = function()
   {
   }.TYPE_BONUS = 16384;
}
if(!mh2lib.display.flowstates.FCFadeLoad)
{
   _global.mh2lib.display.flowstates.FCFadeLoad = function()
   {
      super();
      this.m_sStateName = "FCFadeLoad";
   } extends mh2lib.display.FCState;
   _loc1_ = _global.mh2lib.display.flowstates.FCFadeLoad = function()
   {
      super();
      this.m_sStateName = "FCFadeLoad";
   }.prototype;
   _loc1_.EnterState = function()
   {
      if(this.Owner().m_sFade != "")
      {
         var _loc2_ = new MovieClipLoader();
         var _loc3_ = new Object();
         _loc3_.onLoadComplete = cx.utils.Delegate.create(this,this.Advance,[this]);
         _loc2_.addListener(_loc3_);
         _loc2_.loadClip(this.Owner().m_sFade,this.Owner().m_mcFade);
      }
      else
      {
         var _loc4_ = this.Owner().m_mcFade;
         _loc4_.attachMovie("GUI_BlackFade","fade" + _loc4_.getNextHighestDepth(),_loc4_.getNextHighestDepth());
         this.Advance(this);
      }
   };
   _loc1_.Advance = function(pState)
   {
      pState.Owner().m_mcFade._alpha = 0;
      if(pState.Owner().m_mcFade)
      {
         var _loc3_ = 640;
         var _loc4_ = 360;
         var _loc5_ = 100 * _global.pGUI.m_Width / (2 * _loc3_);
         var _loc6_ = 100 * _global.pGUI.m_Height / (2 * _loc4_);
         pState.Owner().m_mcFade._x = - (_global.pGUI.m_Width / 2 - _loc3_);
         pState.Owner().m_mcFade._y = - (_global.pGUI.m_Height / 2 - _loc4_);
         pState.Owner().m_mcFade._xscale = _loc5_;
         pState.Owner().m_mcFade._yscale = _loc6_;
      }
      pState.m_pStateMachine.ChangeState(new mh2lib.display.flowstates.FCFadeIn());
   };
   ASSetPropFlags(_loc1_,null,1);
}
