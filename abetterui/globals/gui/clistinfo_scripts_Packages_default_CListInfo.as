class CListInfo extends CList
{
   var m_mcHAContainer;
   var m_mcRowSelected;
   var m_mcScroll;
   var m_tfEmptyMessage;
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
   function CListInfo()
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
      var _loc5_ = undefined;
      var _loc6_ = 0;
      var _loc7_ = 0;
      while(_loc7_ < iListSize - 1)
      {
         _loc5_ = this.m_mcContainer.attachMovie(this.m_sRowClassName,"mcRegularRow_" + _loc7_,this.m_mcContainer.getNextHighestDepth());
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
         _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.SelectOption);
         _loc7_ += 1;
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
      _loc5_.m_mcRunes.gotoAndStop(6);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.RowRollOverSelected);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.RowRollOutSelected);
      _loc5_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.CallbackClicks);
      this.m_mcRowSelected = _loc5_;
      this.m_mcScroll.Initialize((iListSize - 1) * this.m_iRegularOffset + this.m_iSelectedOffset,15,iListSize,this.ScrollUsed,this);
      this.m_mcScroll._visible = false;
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_WHEEL,this.WheelUsed);
   }
   function SetData(aData)
   {
      this.m_aNotFilteredItemsData = aData;
      if(this.m_pCFilter != null)
      {
         this.m_aItemsData = this.m_pCFilter.Filter(aData,CFilter.SOURCE_FILTERED);
      }
      else
      {
         this.m_aItemsData = aData;
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
         var _loc3_ = 0;
         while(_loc3_ < this.m_aRowGraphics.length)
         {
            this.m_aRowGraphics[_loc3_]._visible = false;
            _loc3_ += 1;
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
   function SetFilter(pCFilter)
   {
      this.m_pCFilter = pCFilter;
      pCFilter.Initialize(cx.utils.Delegate.create(this,this.FilterChanged),1);
   }
   function AttachData(pRow, pData)
   {
      var _loc4_ = undefined;
      var _loc5_ = undefined;
      trace("AttachData to " + pRow);
      if(pData.Head == true)
      {
         pRow.m_iType = 0;
         pRow.gotoAndStop("Header");
         if(pRow.m_tfName != undefined)
         {
            _loc4_ = pRow.m_tfName;
            _loc5_ = !pData.Name ? "" : String(flash.external.ExternalInterface.call("StringToUpper",pData.Name));
            this.StrictSizeText(_loc4_,_loc5_);
         }
         else if(pRow.m_mcName != undefined && pRow.m_mcName.m_tfName != undefined)
         {
            _loc4_ = pRow.m_mcName.m_tfName;
            _loc5_ = !pData.Name ? "" : String(flash.external.ExternalInterface.call("StringToUpper",pData.Name));
            this.StrictSizeText(_loc4_,_loc5_);
         }
      }
      else
      {
         pRow.m_iType = 1;
         pRow.gotoAndStop("Normal");
         if(pRow.m_tfName != undefined)
         {
            _loc4_ = pRow.m_tfName;
            _loc5_ = !pData.Name ? "" : String(flash.external.ExternalInterface.call("StringToUpper",pData.Name));
            this.StrictSizeText(_loc4_,_loc5_);
         }
         else if(pRow.m_mcName != undefined && pRow.m_mcName.m_tfName != undefined)
         {
            _loc4_ = pRow.m_mcName.m_tfName;
            _loc5_ = !pData.Name ? "" : String(flash.external.ExternalInterface.call("StringToUpper",pData.Name));
            this.StrictSizeText(_loc4_,_loc5_);
         }
         if(pRow.m_mcHighlite != undefined)
         {
            trace("Row seen: " + pData.Seen);
            if(pData.Seen == true)
            {
               pRow.m_mcHighlite._visible = false;
            }
            else
            {
               pRow.m_mcHighlite._visible = true;
            }
         }
         if(pRow.m_mcState != undefined)
         {
            if(pData.State != undefined)
            {
               var _loc6_ = pData.State;
               if(_loc6_ == "S")
               {
                  pRow.m_mcState._visible = true;
                  pRow.m_mcState.gotoAndStop("Succeed");
               }
               else if(_loc6_ == "F")
               {
                  pRow.m_mcState._visible = true;
                  pRow.m_mcState.gotoAndStop("Failure");
               }
               else if(_loc6_ == "T")
               {
                  pRow.m_mcState._visible = true;
                  pRow.m_mcState.gotoAndStop("Tracked");
               }
               else
               {
                  pRow.m_mcState._visible = false;
               }
            }
            else
            {
               pRow.m_mcState._visible = false;
            }
         }
         if(pRow.m_mcIsMain != undefined)
         {
            if(pData.IsMain != undefined && pData.IsMain == "true")
            {
               pRow.m_mcIsMain._visible = true;
            }
            else
            {
               pRow.m_mcIsMain._visible = false;
            }
         }
      }
   }
   function ForcedRefresh()
   {
      if(this.m_iListSize < 1)
      {
         this.m_mcRowSelected._visible = false;
         return undefined;
      }
      var _loc2_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < this.m_iListSize)
      {
         if(this.m_iCurrentOffset + _loc3_ == this.m_iCurrentPosition)
         {
            this.m_aItemsData[this.m_iCurrentPosition].Seen = true;
            this.AttachData(this.m_mcRowSelected,this.m_aItemsData[this.m_iCurrentPosition]);
            this.m_pRowSelectedCurrentItem = this.m_aItemsData[this.m_iCurrentPosition];
         }
         else
         {
            if(this.m_iCurrentOffset + _loc3_ >= this.m_aItemsData.length)
            {
               this.m_aRowGraphics[_loc2_]._visible = false;
            }
            else
            {
               this.m_aRowGraphics[_loc2_]._visible = true;
               this.AttachData(this.m_aRowGraphics[_loc2_],this.m_aItemsData[this.m_iCurrentOffset + _loc3_]);
               this.m_aRowCurrentItems[_loc2_] = this.m_aItemsData[this.m_iCurrentOffset + _loc3_];
            }
            _loc2_ += 1;
         }
         _loc3_ += 1;
      }
      if(this.m_pSelectionChangedCallback != null)
      {
         this.m_pSelectionChangedCallback();
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
               this.m_aItemsData[this.m_iCurrentPosition].Seen = true;
               this.AttachData(this.m_mcRowSelected,this.m_aItemsData[this.m_iCurrentPosition]);
               this.m_pRowSelectedCurrentItem = this.m_aItemsData[this.m_iCurrentPosition];
            }
         }
         else
         {
            if(this.m_iCurrentOffset + _loc3_ >= this.m_aItemsData.length)
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
            _loc2_ += 1;
         }
         _loc3_ += 1;
      }
      if(this.m_pSelectionChangedCallback != null)
      {
         this.m_pSelectionChangedCallback();
      }
   }
   function RowRollOver(e)
   {
      if(e.m_pCaller.m_iType == 1)
      {
         e.m_pCaller.gotoAndPlay("Focus");
      }
      this.AskForFocus(e);
   }
   function RowRollOverSelected(e)
   {
      if(e.m_pCaller.m_iType == 1)
      {
         e.m_pCaller.m_mcFocus._visible = true;
      }
      this.AskForFocus(e);
   }
   function RowRollOut(e)
   {
      if(e.m_pCaller.m_iType == 1)
      {
         e.m_pCaller.gotoAndPlay("Normal");
      }
      this.LoseDragTarget(e);
   }
   function RowRollOutSelected(e)
   {
      if(e.m_pCaller.m_iType == 1)
      {
         e.m_pCaller.m_mcFocus._visible = false;
      }
      this.LoseDragTarget(e);
   }
   function SelectOption(e)
   {
      var _loc3_ = this.GetIndex(e.m_pCaller);
      if(this.m_iCurrentVisiblePosition <= _loc3_)
      {
         _loc3_ += 1;
      }
      e.m_pCaller.gotoAndStop("Normal");
      this.SetVisiblePosition(_loc3_);
      this.UpdateListData();
      this.UpdateGraphic();
      this.CallbackClicks(e);
   }
   function GetContainedItem()
   {
      return null;
   }
   function CallbackClicks(e)
   {
      trace("DoubleClicks " + this.m_pOnDoubleClickCallBack);
      if(this.m_pOnDoubleClickCallBack != null)
      {
         var _loc3_ = getTimer();
         if(_loc3_ - this.m_iLastClick < CSlot.DOUBLE_CLICK_DELAY)
         {
            trace("m_pOnDoubleClickCallBack ");
            this.m_pOnDoubleClickCallBack(this);
            this.m_iLastClick = _loc3_ - CSlot.DOUBLE_CLICK_DELAY - 10;
         }
         else
         {
            trace("m_pOnPressCallBack ");
            this.m_pOnPressCallBack(this);
            this.m_iLastClick = _loc3_;
         }
      }
      else
      {
         this.m_pOnPressCallBack(this);
      }
   }
   function WheelUsed(e, iValue)
   {
      trace("_____m_bHaveFocus " + this.m_bHaveFocus);
      if(this.m_bHaveFocus)
      {
         this.ScrollUsed(this,this.m_iCurrentOffset + (- iValue));
         this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
      }
   }
   function SelectTracked()
   {
      var _loc2_ = 0;
      var _loc3_ = undefined;
      var _loc4_ = 0;
      while(_loc4_ < this.m_aItemsData.length)
      {
         _loc3_ = this.m_aItemsData[_loc4_];
         if(_loc3_.State == "T")
         {
            _loc2_ = _loc4_;
            break;
         }
         _loc4_ += 1;
      }
      this.SetPosition(_loc2_);
      this.UpdateListData();
      this.UpdateGraphic();
   }
}
