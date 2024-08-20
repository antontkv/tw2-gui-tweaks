class CMenuList extends CSlot
{
   var m_mcHAContainer;
   var m_mcRowHighlighted;
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
   var m_pOnValueChangeCallback = null;
   function CMenuList()
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
      this.m_mcRowHighlighted = null;
      if(this.m_mcContainer != undefined && this.m_mcContainer != null)
      {
         this.m_mcContainer.removeMovieClip();
      }
      this.m_mcContainer = this.createEmptyMovieClip("mcContainer",this.getNextHighestDepth());
      var _loc2_ = undefined;
      var _loc4_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < iListSize - 1)
      {
         _loc2_ = this.m_mcContainer.attachMovie(this.m_sRowClassName,"mcRegularRow_" + _loc3_,this.m_mcContainer.getNextHighestDepth());
         this.m_iRegularOffset = _loc2_._height;
         _loc4_ = _loc3_ * this.m_iRegularOffset;
         _loc2_._y = _loc4_;
         this.m_aRowGraphics.push(_loc2_);
         if(_loc2_.m_mcHitArea)
         {
            _loc2_.hitArea = _loc2_.m_mcHitArea;
            _loc2_.m_mcHitArea._visible = false;
         }
         _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.RowRollOver);
         _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.RowRollOut);
         if(this.m_sRowClassName == "ListRowOptions")
         {
            _loc2_.m_mcSlider.m_mcSliderBar.hitArea = _loc2_.m_mcSlider.m_mcSliderBar.m_mcHitArea;
            _loc2_.m_mcSlider.m_mcSliderBar.m_mcHitArea._visible = false;
            _loc2_.m_mcSlider.mc_leftArrow.onPress = cx.utils.Delegate.create(this,this.OnSliderLeftArrow);
            _loc2_.m_mcSlider.mc_rightArrow.onPress = cx.utils.Delegate.create(this,this.OnSliderRightArrow);
            _loc2_.m_mcSlider.m_mcSliderBar.onPress = cx.utils.Delegate.create(this,this.OnSliderBarPress);
            _loc2_.m_mcSelector.mc_leftArrow.onPress = cx.utils.Delegate.create(this,this.OnSelectorLeftArrow);
            _loc2_.m_mcSelector.mc_rightArrow.onPress = cx.utils.Delegate.create(this,this.OnSelectorRightArrow);
         }
         _loc3_ = _loc3_ + 1;
      }
      _loc2_ = this.m_mcContainer.attachMovie(this.m_sSelectedRowClassname,"mcSelectedRow",this.m_mcContainer.getNextHighestDepth());
      this.m_iSelectedOffset = _loc2_._height;
      _loc2_._y = _loc4_ + this.m_iRegularOffset;
      _loc2_._visible = false;
      if(this.m_sSelectedRowClassname == "ListRowOptions")
      {
         _loc2_.m_mcSlider.m_mcSliderBar.hitArea = _loc2_.m_mcSlider.m_mcSliderBar.m_mcHitArea;
         _loc2_.m_mcSlider.m_mcSliderBar.m_mcHitArea._visible = false;
         _loc2_.m_mcSlider.mc_leftArrow.onPress = cx.utils.Delegate.create(this,this.OnSliderLeftArrow);
         _loc2_.m_mcSlider.mc_rightArrow.onPress = cx.utils.Delegate.create(this,this.OnSliderRightArrow);
         _loc2_.m_mcSlider.m_mcSliderBar.onPress = cx.utils.Delegate.create(this,this.OnSliderBarPress);
         _loc2_.m_mcSelector.mc_leftArrow.onPress = cx.utils.Delegate.create(this,this.OnSelectorLeftArrow);
         _loc2_.m_mcSelector.mc_rightArrow.onPress = cx.utils.Delegate.create(this,this.OnSelectorRightArrow);
         if(_loc2_.m_mcHitArea)
         {
            _loc2_.m_mcHitArea.hitArea = _loc2_.m_mcHitArea.m_mcHitArea;
            _loc2_.m_mcHitArea.m_mcHitArea._visible = false;
         }
         _loc2_.m_mcHitArea.onPress = cx.utils.Delegate.create(this,this.ActivateAction);
      }
      else
      {
         if(_loc2_.m_mcHitArea)
         {
            _loc2_.hitArea = _loc2_.m_mcHitArea;
            _loc2_.m_mcHitArea._visible = false;
         }
         _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.ActivateAction);
      }
      this.m_mcRowHighlighted = _loc2_;
      this.m_mcRowHighlighted.gotoAndPlay("Highlight");
      this.m_mcScroll.Initialize((iListSize - 1) * this.m_iRegularOffset + this.m_iSelectedOffset,15,iListSize,this.ScrollUsed,this);
      this.m_mcScroll._visible = false;
      this.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_WHEEL,this.WheelUsed);
      var _loc6_ = this.m_iRegularOffset * (iListSize - 1) + this.m_iSelectedOffset;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100 * _loc6_ / this.m_mcHAContainer.m_mcHitArea._height;
   }
   function ActivateAction(e)
   {
      var _loc2_ = this.m_aItemsData[this.m_iCurrentPosition];
      if(_loc2_.ItemType == gui.vo.voMenuItem.MM_ONOFF)
      {
         this.OnCheck();
      }
      else
      {
         this.m_pOnPressCallBack();
      }
   }
   function GetSliderValue()
   {
      var _loc2_ = this.m_mcRowHighlighted.ItemsShown;
      return _loc2_ / 39 * (this.m_mcRowHighlighted.MaxValue - this.m_mcRowHighlighted.MinValue) + this.m_mcRowHighlighted.MinValue;
   }
   function SetSliderValue(pRow, min, max, value)
   {
      pRow.MinValue = min;
      pRow.MaxValue = max;
      var _loc2_ = (value - min) / (max - min) * 39;
      pRow.ItemsShown = Math.round(_loc2_);
      var _loc1_ = undefined;
      _loc1_ = 0;
      while(_loc1_ <= 39)
      {
         pRow.m_mcSlider.m_mcSliderBar["mc_slider" + _loc1_]._visible = _loc1_ <= _loc2_;
         _loc1_ = _loc1_ + 1;
      }
      var _loc4_ = String(Math.round(10 * _loc2_ / 39));
      pRow.m_mcSlider.m_tfValue.text = _loc4_;
   }
   function IncreaseSliderValue()
   {
      var _loc3_ = undefined;
      trace("IncreaseSliderValue");
      if(!this.m_mcRowHighlighted.ItemsShown)
      {
         this.m_mcRowHighlighted.ItemsShown = 0;
      }
      if(this.m_mcRowHighlighted.ItemsShown == 39)
      {
         return undefined;
      }
      this.m_mcRowHighlighted.ItemsShown = this.m_mcRowHighlighted.ItemsShown + 1;
      _loc3_ = this.m_mcRowHighlighted.ItemsShown;
      var _loc2_ = 0;
      while(_loc2_ <= 39)
      {
         this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar["mc_slider" + _loc2_]._visible = _loc2_ <= _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      var _loc4_ = String(Math.round(10 * _loc3_ / 39));
      this.m_mcRowHighlighted.m_mcSlider.m_tfValue.text = _loc4_;
      this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = this.GetSliderValue();
      this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,this.GetSliderValue());
   }
   function DecreaseSliderValue()
   {
      var _loc3_ = undefined;
      trace("DecreaseSliderValue");
      if(!this.m_mcRowHighlighted.ItemsShown)
      {
         this.m_mcRowHighlighted.ItemsShown = 0;
      }
      if(this.m_mcRowHighlighted.ItemsShown == 0)
      {
         return undefined;
      }
      this.m_mcRowHighlighted.ItemsShown--;
      _loc3_ = this.m_mcRowHighlighted.ItemsShown;
      var _loc2_ = 0;
      while(_loc2_ <= 39)
      {
         this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar["mc_slider" + _loc2_]._visible = _loc2_ <= _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      var _loc4_ = String(Math.round(10 * _loc3_ / 39));
      this.m_mcRowHighlighted.m_mcSlider.m_tfValue.text = _loc4_;
      this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = this.GetSliderValue();
      this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,this.GetSliderValue());
   }
   function OnSliderLeftArrow()
   {
      this.DecreaseSliderValue();
   }
   function OnSliderRightArrow()
   {
      this.IncreaseSliderValue();
   }
   function OnSliderBarPress()
   {
      var _loc2_ = this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar;
      _loc2_.onMouseMove = cx.utils.Delegate.create(this,this.OnSliderMouseMove);
      _loc2_.onMouseUp = cx.utils.Delegate.create(this,this.OnSliderBarRelease);
      this.OnSliderMouseMove();
   }
   function OnSliderBarRelease()
   {
      var _loc2_ = this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar;
      delete _loc2_.onMouseMove;
      _loc2_.onMouseMove = null;
      delete _loc2_.onMouseUp;
      _loc2_.onMouseUp = null;
   }
   function OnSliderMouseMove()
   {
      var _loc8_ = this.m_mcRowHighlighted.MinValue;
      var _loc6_ = this.m_mcRowHighlighted.MaxValue;
      var _loc5_ = this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar;
      if(_loc8_ != undefined && _loc6_ != undefined)
      {
         var _loc4_ = _loc5_._xmouse / _loc5_._width;
         _loc4_ = Math.min(1,Math.max(0,_loc4_));
         var _loc3_ = _loc4_ * 39;
         this.m_mcRowHighlighted.ItemsShown = Math.round(_loc3_);
         var _loc2_ = undefined;
         _loc2_ = 0;
         while(_loc2_ <= 39)
         {
            this.m_mcRowHighlighted.m_mcSlider.m_mcSliderBar["mc_slider" + _loc2_]._visible = _loc2_ <= _loc3_;
            _loc2_ = _loc2_ + 1;
         }
         this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = this.GetSliderValue();
         this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,this.GetSliderValue());
         var _loc7_ = String(Math.round(10 * _loc3_ / 39));
         this.m_mcRowHighlighted.m_mcSlider.m_tfValue.text = _loc7_;
      }
   }
   function SetSelectorValue(pRow, pData)
   {
      pRow.ItemSelected = pData.CurrentValue;
      this.UpdateSelectorDisplay(pRow,pData);
   }
   function NextSelectorValue()
   {
      if(!this.m_mcRowHighlighted.ItemSelected)
      {
         this.m_mcRowHighlighted.ItemSelected = 0;
      }
      this.m_mcRowHighlighted.ItemSelected = (this.m_mcRowHighlighted.ItemSelected + 1) % this.m_aItemsData[this.m_iCurrentPosition].Values.length;
      trace("MCINEK: current item selected: " + this.m_mcRowHighlighted.ItemSelected);
      this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = this.m_mcRowHighlighted.ItemSelected;
      this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,this.m_mcRowHighlighted.ItemSelected);
      this.UpdateSelectorDisplay(this.m_mcRowHighlighted,this.m_aItemsData[this.m_iCurrentPosition]);
   }
   function PreviousSelectorValue()
   {
      if(!this.m_mcRowHighlighted.ItemSelected)
      {
         this.m_mcRowHighlighted.ItemSelected = 0;
      }
      this.m_mcRowHighlighted.ItemSelected = (this.m_mcRowHighlighted.ItemSelected - 1 + this.m_aItemsData[this.m_iCurrentPosition].Values.length) % this.m_aItemsData[this.m_iCurrentPosition].Values.length;
      trace("MCINEK: current item selected: " + this.m_mcRowHighlighted.ItemSelected);
      this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = this.m_mcRowHighlighted.ItemSelected;
      this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,this.m_mcRowHighlighted.ItemSelected);
      this.UpdateSelectorDisplay(this.m_mcRowHighlighted,this.m_aItemsData[this.m_iCurrentPosition]);
   }
   function UpdateSelectorDisplay(pRow, pData)
   {
      var _loc2_ = pData.Values[pRow.ItemSelected].toUpperCase();
      this.StrictSizeText(pRow.m_mcSelector.m_mcName.m_tfName,_loc2_);
   }
   function OnSelectorLeftArrow()
   {
      this.PreviousSelectorValue();
   }
   function OnSelectorRightArrow()
   {
      this.NextSelectorValue();
   }
   function OnCheck()
   {
      this.m_aItemsData[this.m_iCurrentPosition].CurrentValue = !this.m_aItemsData[this.m_iCurrentPosition].CurrentValue;
      var _loc2_ = undefined;
      if(this.m_aItemsData[this.m_iCurrentPosition].CurrentValue)
      {
         _loc2_ = 1;
      }
      else
      {
         _loc2_ = 0;
      }
      this.m_pOnValueChangeCallback(this,this.m_aItemsData[this.m_iCurrentPosition].ID,_loc2_);
      trace("MCINEK: OnCheck() value: " + this.m_aItemsData[this.m_iCurrentPosition].CurrentValue);
      this.UpdateChecker(this.m_mcRowHighlighted,this.m_aItemsData[this.m_iCurrentPosition]);
   }
   function UpdateChecker(pRow, pData)
   {
      pRow.m_mcCheck._visible = pData.CurrentValue;
      this.StrictSizeText(pRow.m_mcName.m_tfName,pData.Name.toUpperCase());
   }
   function SetFilter(pCFilter)
   {
      this.m_pCFilter = pCFilter;
      pCFilter.Initialize(cx.utils.Delegate.create(this,this.FilterChanged),-1);
   }
   function FilterChanged()
   {
      this.SetData(this.m_aNotFilteredItemsData);
   }
   function SetData(aData)
   {
      this.m_aNotFilteredItemsData = aData;
      if(this.m_pCFilter != null)
      {
         this.m_aItemsData = this.m_pCFilter.Filter(aData,CFilter.SOURCE_RAW_ITEMS);
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
         this.m_mcRowHighlighted._visible = false;
         var _loc2_ = 0;
         while(_loc2_ < this.m_aRowGraphics.length)
         {
            this.m_aRowGraphics[_loc2_]._visible = false;
            _loc2_ = _loc2_ + 1;
         }
         if(this.m_pSelectionChangedCallback != null)
         {
            this.m_pSelectionChangedCallback();
         }
         return undefined;
      }
      this.m_tfEmptyMessage._visible = false;
      this.m_mcRowHighlighted._visible = true;
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
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      trace("AttachData to " + pRow);
      if(pRow.m_tfName != undefined)
      {
         _loc5_ = pRow.m_tfName;
         _loc4_ = !pData.Name ? "" : pData.Name.toUpperCase();
         this.StrictSizeText(_loc5_,_loc4_);
      }
      else if(pRow.m_mcName != undefined && pRow.m_mcName.m_tfName != undefined)
      {
         _loc5_ = pRow.m_mcName.m_tfName;
         _loc4_ = !pData.Name ? "" : pData.Name.toUpperCase();
         this.StrictSizeText(_loc5_,_loc4_);
      }
      if(pRow.m_mcSlider != undefined)
      {
         pRow.m_mcSlider._visible = false;
         pRow.m_mcSelector._visible = false;
         pRow.m_mcCheck._visible = false;
         pRow.m_mcDescription._visible = false;
      }
      if(pData.ItemType == gui.vo.voMenuItem.MM_SLIDER)
      {
         if(pRow.m_mcSlider != undefined)
         {
            pRow.m_mcSlider._visible = true;
            this.SetSliderValue(pRow,pData.MinValue,pData.MaxValue,pData.CurrentValue);
         }
      }
      else if(pData.ItemType == gui.vo.voMenuItem.MM_SELECTOR)
      {
         if(pRow.m_mcSelector != undefined)
         {
            pRow.m_mcSelector._visible = true;
            this.SetSelectorValue(pRow,pData);
         }
      }
      else if(pData.ItemType == gui.vo.voMenuItem.MM_ONOFF)
      {
         if(pRow.m_mcCheck != undefined)
         {
            pRow.m_mcCheck._visible = true;
            this.UpdateChecker(pRow,pData);
         }
      }
      else if(pData.ItemType == gui.vo.voMenuItem.MM_BUTTON)
      {
         if(pRow.m_mcDescription != undefined && pRow.m_mcDescription.m_tfDescription != undefined)
         {
            _loc5_ = pRow.m_mcDescription.m_tfDescription;
            _loc4_ = !pData.Desc ? "" : pData.Desc.toUpperCase();
            this.StrictSizeText(_loc5_,_loc4_);
         }
      }
   }
   function UpdateListData()
   {
      trace("UpdateListData");
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this.m_iListSize)
      {
         if(this.m_iCurrentOffset + _loc2_ == this.m_iCurrentPosition)
         {
            if(this.m_pRowSelectedCurrentItem != this.m_aItemsData[this.m_iCurrentPosition])
            {
               this.m_mcRowHighlighted._visible = true;
               this.AttachData(this.m_mcRowHighlighted,this.m_aItemsData[this.m_iCurrentPosition]);
               this.m_pRowSelectedCurrentItem = this.m_aItemsData[this.m_iCurrentPosition];
            }
         }
         else
         {
            if(this.m_iCurrentOffset + _loc2_ > this.m_aItemsData.length)
            {
               this.m_aRowGraphics[_loc3_]._visible = false;
            }
            else
            {
               this.m_aRowGraphics[_loc3_]._visible = true;
               if(this.m_aRowCurrentItems[_loc3_] != this.m_aItemsData[this.m_iCurrentOffset + _loc2_])
               {
                  this.AttachData(this.m_aRowGraphics[_loc3_],this.m_aItemsData[this.m_iCurrentOffset + _loc2_]);
                  this.m_aRowCurrentItems[_loc3_] = this.m_aItemsData[this.m_iCurrentOffset + _loc2_];
               }
            }
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this.m_pSelectionChangedCallback != null)
      {
         this.m_pSelectionChangedCallback();
      }
   }
   function UpdateGraphic()
   {
      trace("UpdateGraphic with list size " + this.m_aItemsData.length);
      if(this.m_iCurrentVisiblePosition < 0)
      {
         this.m_iCurrentVisiblePosition = 0;
      }
      else if(this.m_iCurrentVisiblePosition >= this.m_iListSize)
      {
         this.m_iCurrentVisiblePosition = this.m_iListSize - 1;
      }
      var _loc4_ = 0;
      var _loc5_ = 0;
      var _loc2_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this.m_iListSize)
      {
         if(_loc3_ + this.m_iCurrentOffset < this.m_aItemsData.length)
         {
            if(_loc3_ != this.m_iCurrentVisiblePosition)
            {
               _loc2_ = this.m_aRowGraphics[_loc4_];
               _loc2_._y = _loc5_;
               _loc2_._visible = true;
               _loc5_ += this.m_iRegularOffset;
               _loc4_ = _loc4_ + 1;
            }
            else
            {
               _loc2_ = this.m_mcRowHighlighted;
               _loc2_._y = _loc5_;
               _loc2_._visible = true;
               _loc5_ += this.m_iSelectedOffset;
            }
         }
         else if(_loc3_ != this.m_iCurrentVisiblePosition)
         {
            _loc2_ = this.m_aRowGraphics[_loc4_];
            _loc2_._visible = false;
            _loc4_ = _loc4_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function RowRollOver(e)
   {
      trace("RowRollOver");
      this.m_mcRowHighlighted.gotoAndPlay("Highlight");
      var _loc2_ = this.GetIndex(e.m_pCaller);
      if(this.m_iCurrentVisiblePosition <= _loc2_)
      {
         _loc2_ = _loc2_ + 1;
      }
      this.SetVisiblePosition(_loc2_);
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
      var _loc2_ = 0;
      while(_loc2_ < this.m_aRowGraphics.length)
      {
         if(mc == this.m_aRowGraphics[_loc2_])
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return 0;
   }
   function SetPosition(iPosition)
   {
      this.m_iCurrentPosition = iPosition;
      // Rollover UP: Set every position to the last posable value
      if(this.m_iCurrentPosition < 0)
      {
         this.m_iCurrentPosition = this.m_aItemsData.length - 1;
         this.m_iCurrentVisiblePosition = this.m_iListSize - 1;
         this.m_iCurrentOffset = this.m_iCurrentPosition - this.m_iCurrentVisiblePosition;
      }
      // Rollover DOWN: Set every position to 0
      else if(this.m_iCurrentPosition > this.m_aItemsData.length - 1)
      {
         this.m_iCurrentPosition = 0;  // Selected item
         this.m_iCurrentVisiblePosition = 0;  // Selected position in inventory menu from 0 to 6
         this.m_iCurrentOffset = 0;  // Position of scrollbar
      }
      // Not Rollover: Update only visible position
      else
      {
         this.m_iCurrentVisiblePosition = this.m_iCurrentPosition - this.m_iCurrentOffset;
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
      trace("ScrollUsed");
      if(pProvider == null)
      {
         trace("Provider NULL");
         return undefined;
      }
      trace("1 is Visible " + pProvider.m_mcRowHighlighted._visible);
      var _loc2_ = pProvider.m_iCurrentPosition;
      pProvider.SetOffset(iOffset);
      if(_loc2_ != pProvider.m_iCurrentPosition)
      {
         pProvider.m_mcRowHighlighted.gotoAndPlay("Highlight");
      }
      trace("2 is Visible " + pProvider.m_mcRowHighlighted._visible);
      pProvider.UpdateListData();
      trace("3 is Visible " + pProvider.m_mcRowHighlighted._visible);
      pProvider.UpdateGraphic();
      trace("is Visible " + pProvider.m_mcRowHighlighted._visible);
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
      var _loc3_ = false;
      var _loc2_ = this.m_aItemsData[this.m_iCurrentPosition];
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
               // When m_iCurrentVisiblePosition and m_iCurrentOffset is 0, it means then we rollover down.
               else
               {
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition - 1);
                  this.ScrollUsed(this,this.m_iCurrentOffset);
                  this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
            }
            _loc3_ = true;
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
                  this.SetVisiblePosition(this.m_iCurrentVisiblePosition + 1);
                  // When m_iCurrentVisiblePosition is at the end and m_iCurrentPosition becomes 0, it means we rollover up.
                  if(this.m_iCurrentPosition == 0)
                  {
                     this.ScrollUsed(this,this.m_iCurrentOffset);
                     this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
                  }
                  else
                  {
                     this.ScrollUsed(this,this.m_iCurrentOffset + 1);
                     this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
                  }
                  this.UpdateListData();
                  this.UpdateGraphic();
               }
            }
            _loc3_ = true;
            break;
         case mh2lib.utils.MH2Key.ARROW_RIGHT:
            if(_loc2_.ItemType == gui.vo.voMenuItem.MM_SLIDER)
            {
               this.IncreaseSliderValue();
            }
            else if(_loc2_.ItemType == gui.vo.voMenuItem.MM_SELECTOR)
            {
               this.NextSelectorValue();
            }
            else if(_loc2_.ItemType == gui.vo.voMenuItem.MM_ONOFF)
            {
               this.OnCheck();
            }
            break;
         case mh2lib.utils.MH2Key.ARROW_LEFT:
            if(_loc2_.ItemType == gui.vo.voMenuItem.MM_SLIDER)
            {
               this.DecreaseSliderValue();
            }
            else if(_loc2_.ItemType == gui.vo.voMenuItem.MM_SELECTOR)
            {
               this.PreviousSelectorValue();
            }
            else if(_loc2_.ItemType == gui.vo.voMenuItem.MM_ONOFF)
            {
               this.OnCheck();
            }
            break;
         case mh2lib.utils.MH2Key.SPACE:
         case mh2lib.utils.MH2Key.ENTER:
         case mh2lib.utils.MH2Key.PAD_A_CROSS:
            if(_loc2_.ItemType == gui.vo.voMenuItem.MM_ONOFF)
            {
               this.OnCheck();
            }
            else
            {
               this.m_pOnPressCallBack();
            }
      }
      return _loc3_;
   }
   function AskForFocus(e)
   {
      mh2lib.display.MH2Flow.s_pInstance.SetFocus(this);
      this.m_bHaveFocus = true;
      if(this.m_mcRowHighlighted.m_mcFocus)
      {
         this.m_mcRowHighlighted.m_mcFocus._visible = true;
      }
      this.m_pOnFocusChangeCallBack(this,true);
   }
   function LoseDragTarget(e)
   {
      mh2lib.display.MH2Flow.s_pInstance.LoseDragTarget(this);
      this.m_bHaveFocus = false;
      if(this.m_mcRowHighlighted.m_mcFocus)
      {
         this.m_mcRowHighlighted.m_mcFocus._visible = false;
      }
      this.m_pOnFocusChangeCallBack(this,false);
   }
   function StrictSizeText(pTF, sText)
   {
      pTF.autoSize = false;
      pTF.text = sText;
      if(pTF.textWidth > pTF._width)
      {
         var _loc1_ = 1;
         while(_loc1_ <= sText.length + 1)
         {
            pTF.text = sText.substring(0,_loc1_);
            if(pTF.textWidth > pTF._width)
            {
               pTF.text = sText.substring(0,_loc1_ - 3) + "...";
               break;
            }
            _loc1_ += 1;
         }
      }
   }
}
