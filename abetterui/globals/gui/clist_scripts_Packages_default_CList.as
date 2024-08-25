class CList extends CSlot
{
   var m_mcHAContainer;
   var m_mcRowSelected;
   var m_mcScroll;
   var m_tfEmptyMessage;
   var m_mcRollOverEffect;
   var _sortDirection;
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
         _loc3_ = _loc3_ + 1;
      }
      _loc2_ = this.m_mcContainer.attachMovie(this.m_sSelectedRowClassname,"mcSelectedRow",this.m_mcContainer.getNextHighestDepth());
      this.m_iSelectedOffset = _loc2_._height;
      _loc2_._y = _loc4_ + this.m_iRegularOffset;
      if(_loc2_.m_mcHitArea)
      {
         _loc2_.hitArea = _loc2_.m_mcHitArea;
         _loc2_.m_mcHitArea._visible = false;
      }
      if(_loc2_.m_mcFocus)
      {
         _loc2_.m_mcFocus._visible = false;
      }
      _loc2_._visible = false;
      _loc2_.m_mcRunes.gotoAndStop(6);
      _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      _loc2_.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      this.m_mcRowSelected = _loc2_;
      this.m_mcScroll.Initialize((iListSize - 1) * this.m_iRegularOffset + this.m_iSelectedOffset,15,iListSize,this.ScrollUsed,this);
      this.m_mcScroll._visible = false;
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_PRESS,this.StartDrag);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OVER,this.AskForFocus);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_ROLL_OUT,this.LoseDragTarget);
      this.m_mcHAContainer.AddEventListener(this,mh2lib.utils.MH2Event.MOUSE_WHEEL,this.WheelUsed);
      var _loc6_ = this.m_iRegularOffset * (iListSize - 1) + this.m_iSelectedOffset;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100;
      this.m_mcHAContainer.m_mcHitArea._yScale = 100 * _loc6_ / this.m_mcHAContainer.m_mcHitArea._height;
   }
   function SetDefaultSortMethod(a_sortMethod)
   {
      if(isNaN(a_sortMethod))
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
         var _loc2_ = this.m_pCFilter.m_aFilters[0][1];
         if(_loc2_ == gui.vo.ItemEnum.TYPE_WEAPON)
         {
            this.AddSortPanel();
         }
      }
      pCFilter.Initialize(cx.utils.Delegate.create(this,this.FilterChanged),-1);
   }
   function FilterChanged()
   {
      this.ResetPosition();
      this.SetData(this.m_aNotFilteredItemsData);
   }
   function SortAlpabetically(a, b)
   {
      var _loc2_ = a.Name;
      var _loc1_ = b.Name;
      if(_loc2_ < _loc1_)
      {
         return -1;
      }
      if(_loc2_ > _loc1_)
      {
         return 1;
      }
      return 0;
   }
   function SortByAmount(a, b)
   {
      var _loc2_ = a.Count;
      var _loc1_ = b.Count;
      if(_loc2_ && _loc1_)
      {
         if(_loc2_ > _loc1_)
         {
            return -1;
         }
         if(_loc2_ < _loc1_)
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
      var _loc8_ = undefined;
      var _loc7_ = undefined;
      trace("AttachData to " + pRow);
      var _loc11_ = flash.external.ExternalInterface.call("StringToUpper",pData.Name);
      if(pRow.m_tfName != undefined)
      {
         _loc8_ = pRow.m_tfName;
         _loc7_ = !pData.Name ? "" : _loc11_;
         this.StrictSizeText(_loc8_,_loc7_);
      }
      else if(pRow.m_mcName != undefined && pRow.m_mcName.m_tfName != undefined)
      {
         _loc8_ = pRow.m_mcName.m_tfName;
         _loc7_ = !pData.Name ? "" : _loc11_;
         this.StrictSizeText(_loc8_,_loc7_);
      }
      var _loc12_ = flash.external.ExternalInterface.call("StringToUpper",pData.Desc);
      if(pRow.m_mcDescription != undefined && pRow.m_mcDescription.m_tfDescription != undefined)
      {
         _loc8_ = pRow.m_mcDescription.m_tfDescription;
         _loc7_ = !pData.Desc ? "" : _loc12_;
         this.StrictSizeText(_loc8_,_loc7_);
      }
      var _loc10_ = 1;
      if(pRow.m_tfQuantity != undefined)
      {
         if(pData.Count && pData.Count > 1)
         {
            pRow.m_tfQuantity.text = pData.Count;
            _loc10_ = Number(pData.Count);
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
            pRow.m_tfMass.text = _global.MassParser(Number(pData.Mass) * _loc10_);
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
            pRow.m_tfPrice.text = String(Number(pData.Price) * _loc10_);
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
         var _loc6_ = pRow.m_mcIcon._mcAlreadyReadIconOverlay;
         if(_loc6_ == null)
         {
            _loc6_ = pRow.createEmptyMovieClip("_mcAlreadyReadIconOverlay",pRow.getNextHighestDepth());
            _loc6_._x = pRow.m_mcIcon._x;
            _loc6_._y = pRow.m_mcIcon._y;
            _loc6_._alpha = 90;
         }
         if(pData._alreadyRead)
         {
            cx.utils.AssetLoader.loadAsset(_loc6_,"img://globals/gui/icons/tooltip/alreadyread_64x64.dds");
         }
         else
         {
            _loc6_.unloadMovie();
         }
      }
      else
      {
         var _loc9_ = null;
         if(pRow.m_tfName != null)
         {
            _loc9_ = pRow.m_tfName;
         }
         else if(pRow.m_mcName != null)
         {
            _loc9_ = pRow.m_mcName;
         }
         if(_loc9_ != null)
         {
            var _loc5_ = pRow._mcSmallAlreadyReadIconOverlay;
            if(_loc5_ == null)
            {
               _loc5_ = pRow.createEmptyMovieClip("_mcSmallAlreadyReadIconOverlay",pRow.getNextHighestDepth());
               _loc5_._x = pRow.m_tfQuantity._x - 15;
               _loc5_._y = _loc9_._y;
               _loc5_._y += 5;
               _loc5_._alpha = 90;
            }
            if(pData._alreadyRead)
            {
               cx.utils.AssetLoader.loadAsset(_loc5_,"img://globals/gui/icons/tooltip/alreadyread_15x15.dds");
            }
            else
            {
               _loc5_.unloadMovie();
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
      trace("UpdateListData");
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this.m_iListSize)
      {
         if(this.m_iCurrentOffset + _loc2_ == this.m_iCurrentPosition)
         {
            if(this.m_pRowSelectedCurrentItem != this.m_aItemsData[this.m_iCurrentPosition])
            {
               this.AttachData(this.m_mcRowSelected,this.m_aItemsData[this.m_iCurrentPosition]);
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
               _loc2_ = this.m_mcRowSelected;
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
      this.m_mcRowSelected.gotoAndPlay("Highlight");
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
   function ResetPosition()
   {
      this.m_iCurrentPosition = 0;
      this.m_iCurrentVisiblePosition = 0;
      this.m_iCurrentOffset = 0;
      this.m_mcScroll.SetNewPosition(this.m_iCurrentOffset);
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
      var _loc2_ = pProvider.m_iCurrentPosition;
      pProvider.SetOffset(iOffset);
      if(_loc2_ != pProvider.m_iCurrentPosition)
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
      trace("LIST: MH2Flow.GetKeyCode " + mh2lib.display.MH2Flow.GetKeyCode());
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
      var _loc3_ = a_mcParent.attachMovie("FilterButton","SortButton" + a_nEnumerator,a_mcParent.getNextHighestDepth());
      _loc3_.nOrd = a_nEnumerator;
      _loc3_.m_sTooltipText = a_sTooltipText;
      _loc3_._width = 30;
      _loc3_._height = 30;
      var _loc4_ = _loc3_.m_mcIcon;
      _loc4_._x += 8;
      _loc4_._y += 8;
      cx.utils.AssetLoader.loadAsset(_loc4_,"img://globals/gui/icons/tooltip/" + a_sIconName,15,15);
      _loc3_._x = a_xPos;
      _loc3_._y = a_yPos;
      _loc3_.m_mcRollOverEffect._visible = false;
      _loc3_.m_mcBackground._visible = false;
      _loc3_._sortDirection = 1;
      _loc3_.onRollOver = function()
      {
         this.m_mcRollOverEffect._visible = true;
      };
      _loc3_.onRollOut = function()
      {
         this.m_mcRollOverEffect._visible = false;
      };
      _loc3_.sort = function()
      {
         if(host.m_aItemsData.length < 1)
         {
            return undefined;
         }
         host[sSortFn](this._sortDirection);
         host.UpdateListData();
         host.UpdateGraphic();
      };
      _loc3_.onPress = function()
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
         var _loc2_ = Number(_global.MassParser(a.Mass));
         var _loc5_ = Number(_global.MassParser(b.Mass));
         var _loc7_ = 1;
         if(a.Count && a.Count > 1)
         {
            _loc7_ = Number(a.Count);
         }
         var _loc6_ = 1;
         if(b.Count && b.Count > 1)
         {
            _loc6_ = Number(b.Count);
         }
         if(_loc2_ * _loc7_ < _loc5_ * _loc6_)
         {
            return -1;
         }
         if(_loc2_ * _loc7_ > _loc5_ * _loc6_)
         {
            return 1;
         }
         if(_loc2_ < _loc5_)
         {
            return -1;
         }
         if(_loc2_ > _loc5_)
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
         var _loc3_ = Number(b.Price);
         var _loc6_ = 1;
         if(a.Count && a.Count > 1)
         {
            _loc6_ = Number(a.Count);
         }
         var _loc5_ = 1;
         if(b.Count && b.Count > 1)
         {
            _loc5_ = Number(b.Count);
         }
         if(_loc4_ * _loc6_ < _loc3_ * _loc5_)
         {
            return -1;
         }
         if(_loc4_ * _loc6_ > _loc3_ * _loc5_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(_loc4_ > _loc3_)
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
