//*******************************************************************************************
//
//  dotJ Javascript Library
//
//  Copyright(c) 2001-2004 DotJ Software Inc
//  ALL RIGHTS RESERVED
//
//  The contents of this file is protected by U.S. and International Copyright Laws.
//  Unauthorized use of the code contained in this file is strictly prohibited unless
//  permission is explicitly granted by DotJ Software.
//
//  JavaScript library to support all of the dotJ tags.
//  This library contains code that needs to match with the equivalent Java code.
//  Therefore, edit this code at your own risk!
//
//  author: dotJ Software
//  since: version 2.0
//
//*******************************************************************************************

var DotJ_JSVersion = "2.0.2";

// See http://www.webreference.com/tools/browser/javascript.html
var DotJ_agt            = navigator.userAgent.toLowerCase();
var DotJ_appVer         = navigator.appVersion.toLowerCase();
var DotJ_is_minor       = parseFloat(DotJ_appVer);
var DotJ_is_major       = parseInt(DotJ_is_minor,10);

var DotJ_is_opera       = (DotJ_agt.indexOf("opera") != -1);
var DotJ_is_opera2      = (DotJ_agt.indexOf("opera 2") != -1 || DotJ_agt.indexOf("opera/2") != -1);
var DotJ_is_opera3      = (DotJ_agt.indexOf("opera 3") != -1 || DotJ_agt.indexOf("opera/3") != -1);
var DotJ_is_opera4      = (DotJ_agt.indexOf("opera 4") != -1 || DotJ_agt.indexOf("opera/4") != -1);
var DotJ_is_opera5      = (DotJ_agt.indexOf("opera 5") != -1 || DotJ_agt.indexOf("opera/5") != -1);
var DotJ_is_opera6      = (DotJ_agt.indexOf("opera 6") != -1 || DotJ_agt.indexOf("opera/6") != -1);
var DotJ_is_opera7      = (DotJ_agt.indexOf("opera 7") != -1 || DotJ_agt.indexOf("opera/7") != -1);
var DotJ_is_opera5up    = (DotJ_is_opera && !DotJ_is_opera2 && !DotJ_is_opera3 && !DotJ_is_opera4);
var DotJ_is_opera6up    = (DotJ_is_opera && !DotJ_is_opera2 && !DotJ_is_opera3 && !DotJ_is_opera4 && !DotJ_is_opera5);
var DotJ_is_opera7up    = (DotJ_is_opera && !DotJ_is_opera2 && !DotJ_is_opera3 && !DotJ_is_opera4 && !DotJ_is_opera5 && !DotJ_is_opera6);

var DotJ_iePos  = DotJ_appVer.indexOf('msie');
if (DotJ_iePos !=-1) {
	DotJ_is_minor = parseFloat(DotJ_appVer.substring(DotJ_iePos+5,DotJ_appVer.indexOf(';',DotJ_iePos)))
	DotJ_is_major = parseInt(DotJ_is_minor,10);
}

var DotJ_is_konq = false;
var DotJ_kqPos   = DotJ_agt.indexOf('konqueror');
if (DotJ_kqPos !=-1) {
	DotJ_is_konq  = true;
	DotJ_is_minor = parseFloat(DotJ_agt.substring(DotJ_kqPos+10,DotJ_agt.indexOf(';',DotJ_kqPos)));
	DotJ_is_major = parseInt(DotJ_is_minor,10);
}

var DotJ_is_safari = ((DotJ_agt.indexOf('safari')!=-1)&&(DotJ_agt.indexOf('mac')!=-1))?true:false;
var DotJ_is_khtml  = (DotJ_is_safari || DotJ_is_konq);

var DotJ_is_gecko  = ((!DotJ_is_khtml)&&(navigator.product)&&(navigator.product.toLowerCase()=="gecko"))?true:false;
var DotJ_is_gver = 0;
if (DotJ_is_gecko) DotJ_is_gver = navigator.productSub;

var DotJ_is_moz   = ((DotJ_agt.indexOf('mozilla/5')!=-1) && (DotJ_agt.indexOf('spoofer')==-1) &&
				(DotJ_agt.indexOf('compatible')==-1) && (DotJ_agt.indexOf('opera')==-1)  &&
				(DotJ_agt.indexOf('webtv')==-1) && (DotJ_agt.indexOf('hotjava')==-1)     &&
				(DotJ_is_gecko) &&
				((navigator.vendor=="")||(navigator.vendor=="Mozilla")||(navigator.vendor=="Debian")));
var DotJ_is_fb = ((DotJ_agt.indexOf('mozilla/5')!=-1) && (DotJ_agt.indexOf('spoofer')==-1) &&
                 (DotJ_agt.indexOf('compatible')==-1) && (DotJ_agt.indexOf('opera')==-1)  &&
                 (DotJ_agt.indexOf('webtv')==-1) && (DotJ_agt.indexOf('hotjava')==-1)     &&
                 (DotJ_is_gecko) && (navigator.vendor=="Firebird"));
var DotJ_is_fx = ((DotJ_agt.indexOf('mozilla/5')!=-1) && (DotJ_agt.indexOf('spoofer')==-1) &&
                 (DotJ_agt.indexOf('compatible')==-1) && (DotJ_agt.indexOf('opera')==-1)  &&
                 (DotJ_agt.indexOf('webtv')==-1) && (DotJ_agt.indexOf('hotjava')==-1)     &&
                 (DotJ_is_gecko) && (navigator.vendor=="Firefox"));
if ((DotJ_is_moz)||(DotJ_is_fb)||(DotJ_is_fx)) {
	var DotJ_is_moz_ver = (navigator.vendorSub)?navigator.vendorSub:0;
	if (!(DotJ_is_moz_ver)) {
		DotJ_is_moz_ver = DotJ_agt.indexOf('rv:');
		DotJ_is_moz_ver = DotJ_agt.substring(DotJ_is_moz_ver+3);
		DotJ_is_paren   = DotJ_is_moz_ver.indexOf(')');
		DotJ_is_moz_ver = DotJ_is_moz_ver.substring(0,DotJ_is_paren);
	}
	DotJ_is_minor = DotJ_is_moz_ver;
	DotJ_is_major = parseInt(DotJ_is_moz_ver,10);
}
var DotJ_is_fb_ver = DotJ_is_moz_ver;
var DotJ_is_fx_ver = DotJ_is_moz_ver;

var DotJ_is_nav = ((DotJ_agt.indexOf('mozilla')!=-1) && (DotJ_agt.indexOf('spoofer')==-1) &&
				   (DotJ_agt.indexOf('compatible') == -1) && (DotJ_agt.indexOf('opera')==-1) &&
				   (DotJ_agt.indexOf('webtv')==-1) && (DotJ_agt.indexOf('hotjava')==-1) &&
				   (!DotJ_is_khtml) && (!(DotJ_is_moz)) && (!DotJ_is_fb) && (!DotJ_is_fx));

if ((navigator.vendor) && ((navigator.vendor=="Netscape6")||(navigator.vendor=="Netscape"))&& (DotJ_is_nav)) {
	DotJ_is_major = parseInt(navigator.vendorSub,10);
	DotJ_is_minor = parseFloat(navigator.vendorSub);
}

var DotJ_is_nav2        = (DotJ_is_nav && (DotJ_is_major == 2));
var DotJ_is_nav3        = (DotJ_is_nav && (DotJ_is_major == 3));
var DotJ_is_nav4        = (DotJ_is_nav && (DotJ_is_major == 4));
var DotJ_is_nav4up      = (DotJ_is_nav && (DotJ_is_minor >= 4));
var DotJ_is_navonly     = (DotJ_is_nav && ((DotJ_agt.indexOf(";nav") != -1) || (DotJ_agt.indexOf("; nav") != -1)) );
var DotJ_is_nav6        = (DotJ_is_nav && (DotJ_is_major == 6));
var DotJ_is_nav6up      = (DotJ_is_nav && (DotJ_is_minor >= 6));
var DotJ_is_nav5        = (DotJ_is_nav && (DotJ_is_major == 5) && !DotJ_is_nav6);
var DotJ_is_nav5up      = (DotJ_is_nav && (DotJ_is_minor >= 5));
var DotJ_is_nav7        = (DotJ_is_nav && (DotJ_is_major == 7));
var DotJ_is_nav7up      = (DotJ_is_nav && (DotJ_is_minor >= 7));

var DotJ_is_ie   = ((DotJ_iePos!=-1) && (!DotJ_is_opera) && (!DotJ_is_khtml));
var DotJ_is_ie3  = (DotJ_is_ie && (DotJ_is_major < 4));

var DotJ_is_ie4   = (DotJ_is_ie && DotJ_is_major == 4);
var DotJ_is_ie4up = (DotJ_is_ie && DotJ_is_minor >= 4);
var DotJ_is_ie5   = (DotJ_is_ie && DotJ_is_major == 5);
var DotJ_is_ie5up = (DotJ_is_ie && DotJ_is_minor >= 5);

var DotJ_is_ie5_5  = (DotJ_is_ie && (DotJ_agt.indexOf("msie 5.5") !=-1));
var DotJ_is_ie5_5up =(DotJ_is_ie && DotJ_is_minor >= 5.5);

var DotJ_is_ie6   = (DotJ_is_ie && DotJ_is_major == 6);
var DotJ_is_ie6up = (DotJ_is_ie && DotJ_is_minor >= 6);

var DotJ_is_hotjava = (DotJ_agt.indexOf("hotjava") != -1);
var DotJ_is_hotjava3 = (DotJ_is_hotjava && (DotJ_is_major == 3));
var DotJ_is_hotjava3up = (DotJ_is_hotjava && (DotJ_is_major >= 3));

var DotJ_js;
if (DotJ_is_nav2 || DotJ_is_ie3) DotJ_js = 1.0;
else if (DotJ_is_nav3) DotJ_js = 1.1;
else if ((DotJ_is_opera5)||(DotJ_is_opera6)) DotJ_js = 1.3;
else if (DotJ_is_opera7up) DotJ_js = 1.5;
else if (DotJ_is_khtml) DotJ_js = 1.5;
else if (DotJ_is_opera) DotJ_js = 1.1;
else if ((DotJ_is_nav4 && (DotJ_is_minor <= 4.05)) || DotJ_is_ie4) DotJ_js = 1.2;
else if ((DotJ_is_nav4 && (DotJ_is_minor > 4.05)) || DotJ_is_ie5) DotJ_js = 1.3;
else if (DotJ_is_nav5 && !(DotJ_is_nav6)) DotJ_js = 1.4;
else if (DotJ_is_hotjava3up) DotJ_js = 1.4;
else if (DotJ_is_nav6 || DotJ_is_gecko) DotJ_js = 1.5;
else if (DotJ_is_nav && (DotJ_is_major > 5)) DotJ_js = 1.4;
else if (DotJ_is_ie && (DotJ_is_major > 5)) DotJ_js = 1.3;
else if (DotJ_is_moz) DotJ_js = 1.5;
else if (DotJ_is_fb||DotJ_is_fx) DotJ_is_js = 1.5;
else DotJ_js = 0.0;
if ((DotJ_agt.indexOf("mac")!=-1) && DotJ_is_ie5up) DotJ_js = 1.4;
if (DotJ_is_nav6up) {
	DotJ_is_minor = navigator.vendorSub;
}

// The following three key definitions can be customized to your liking.  It is okay to change these values.
// The mouse click is just an arbitrary constant definition.
var DotJ_KEY_SPACE = 32;
var DotJ_KEY_UP = 38;
var DotJ_KEY_DOWN = 40;
var DotJ_MOUSE_CLICK = 1000;

var DotJ_LOG = false;

//***********************************************************************

// Instantiations
var DotJ_today = new Date();
var DotJ_daysInMonth = new Array(31,29,31,30,31,30,31,31,30,31,30,31);
var tipDiv = DotJ_getObj('dotJ_tip');

//******************************   GRID   *******************************

DotJ_Grid.getCSField = function() {
	return eval('this.form.' + this.csFieldName);
}

DotJ_Grid.selectRow = function(firstPass) {
	this.rows.select(firstPass);
}

DotJ_Grid.selectCurrentRow = function(objRow, lastKey) {
	if (this.multiselect == false) return;
	this.rows.selectCurrentRow(objRow, lastKey);
}

DotJ_Grid.selectPreviousRow = function(objRow, lastKey) {
	this.rows.selectPreviousRow(objRow, lastKey);
}

DotJ_Grid.selectNextRow = function(objRow, lastKey) {
	this.rows.selectNextRow(objRow, lastKey);
}

DotJ_Grid.setClientState = function (command, param1, param2) {
	var csField = this.getCSField();
	var fixed = 'grid=' + this.name + DotJ_PAIR_DELIMITER +
				'cmd=' + command;

	var selParms = this.rows.getSelectedParms(param1, param2);
	csField.value = fixed + DotJ_PAIR_DELIMITER + selParms;
}

DotJ_Grid.setKeyField = function(row, keyField) {
	this.rows.setKeyField(row, keyField);
}

function DotJ_isRowToBeSelected(lastKey, multiselect) {
	if (multiselect == false || lastKey == DotJ_MOUSE_CLICK) {
		return true;
	} else if (multiselect == true && lastKey == DotJ_KEY_SPACE) {
		return true;
	}
	return false;
}

DotJ_Grid.showRowArrow = function(rowId, display) {
	if (this.showSelectorColumn == false) return;
	var sDiv = rowId.replace("_ROW_", "_SEL_");
	var oDiv = DotJ_getObj(sDiv);
	if (display) {
		if (DotJ_isRowToBeSelected(this.lastKey, this.multiselect)) {
			DotJ_setText(sDiv, this.selRowImg);
		}
	} else {
		DotJ_setText(sDiv, "&nbsp;");
	}
}

DotJ_Grid.style = function(styleName) {
	return this.stylePrefix + styleName;
}

DotJ_Grid.selectGridRowCommon = function(objRow, doPost, lastKey) {
	var parts = objRow.id.split("_");
	var row = parts[3];
	var absoluteRow = parts[4];
	var keyFields = parts[5];
	if (this.inEditMode && this.currentRowObj && this.currentRowObj.id == objRow.id) return;
	if (doPost) {
		this.submitFunc(this.name, 'select', absoluteRow, keyFields);
	} else {
		this.currentRowObj = objRow;
		this.currentRow = row;
		this.hiliteRow();
		this.selectRow(false);
		this.setKeyField(row, keyFields);
		this.setClientState('select', absoluteRow, keyFields);
		if (this.inEditMode) {
			this.submitFunc(this.name, 'select', absoluteRow, keyFields);
		}
	}
}

DotJ_Grid.changeRowStyle = function(objRow, style, selecting, hiliting) {
	var oldStyle = new Array();
	var iOld = (this.showSelectorColumn) ? 1 : 0;
	var iNew = 0;

	var newStyle = style;
	if (typeof(style) == 'string') {
		newStyle = new Array(objRow.cells.length);
		for (iNew = 0; iNew < newStyle.length; iNew++)
			newStyle[iNew] = style;
	} else if (typeof(style) == 'undefined') {
		return;
	}

	var rowIndex = this.rows.findRow(objRow.id);
	var start = (this.showSelectorColumn) ? 1 : 0;
	for (var i = start; i < objRow.cells.length; i++) {
		if (objRow.cells[i].childNodes && objRow.cells[i].childNodes.item(0)) {
			var oDiv = objRow.cells[i];
			// This could be smarter if there are multiple nested elements , but will do for now.
			if (oDiv.childNodes && oDiv.childNodes.length > 0 && oDiv.childNodes.item(0).nodeType == 1) {
				if (oDiv.childNodes.item(0).className != '' && (DotJ_isRowToBeSelected(this.lastKey, this.multiselect) || hiliting))
					oDiv.childNodes.item(0).className = newStyle[i];
			}
			if (DotJ_isRowToBeSelected(this.lastKey, this.multiselect) || hiliting) {
				oldStyle[iOld++] = oDiv.className;
				oDiv.className = newStyle[i];
			}
		}
	}

	var hstyle = this.rows.rows[rowIndex].hstyle;
	if (hstyle != null && typeof(hstyle) != 'undefined') {
		return hstyle;
	} else {
		return oldStyle;
	}
}

DotJ_Grid.hiliteRow = function() {
	this.restoreChanges();

	var objRow = this.currentRowObj;
	if (objRow == null) return;

	for (var i = 0; i < objRow.cells.length; i++) {
		if (objRow.cells[i].childNodes && objRow.cells[i].childNodes.item(0)) {
			var oDiv = objRow.cells[i];
			if (i == 0) {
				if (this.showSelectorColumn) {
					var sDiv = objRow.id.replace("_ROW_", "_SEL_");
					oDiv = DotJ_getObj(sDiv);
				}
				DotJ_borderTopBottomLeft(this.changes, oDiv, DotJ_GRID_CURRENTROW_BORDERCOLOR, DotJ_GRID_CURRENTROW_BORDERWIDTH, DotJ_GRID_CURRENTROW_BORDERSTYLE);
			} else if (i == objRow.cells.length-1) {
				DotJ_borderTopBottomRight(this.changes, oDiv, DotJ_GRID_CURRENTROW_BORDERCOLOR, DotJ_GRID_CURRENTROW_BORDERWIDTH, DotJ_GRID_CURRENTROW_BORDERSTYLE);
			} else {
				DotJ_borderTopBottom(this.changes, oDiv, DotJ_GRID_CURRENTROW_BORDERCOLOR, DotJ_GRID_CURRENTROW_BORDERWIDTH, DotJ_GRID_CURRENTROW_BORDERSTYLE);
			}
		}
	}
}

DotJ_Grid.restoreChanges = function() {
	if (this.changes == null) return;

	var change, i = this.changes.length - 1;

	while (i >= 0) {
		change = this.changes[i];
		if (change != null) {
			s = 'DotJ_getObj("' + change.id + '").' + change.property + ' = "' + change.value + '"';
			eval(s);
			this.changes[i] = null;
		}
		i--;
	}
	this.changes.length = 0;
}

DotJ_Grid.checkForForm = function() {
	if (this.form == null) this.form = DotJ_FindParentForm('DotJ_' + this.name + '_NAM');
	if (this.form == null) {
		var msg = "dotJ Javascript Error: Grid '" + this.name + "' is not contained within an HTML <form>.\n\nPlease put it under one before proceeding.";
		alert(msg);
		return false;
	}
	return true;
}

function DotJ_Grid(gridName, rowCount, page, pageSize, stamp, stylePrefix, selectedRowId, selectedKeyField, multiselect, requiresForm, showSelectorColumn, hottrack) {
	this.checkForForm = DotJ_Grid.checkForForm;

	this.changes = new Array();
	this.name = gridName;
	this.rowCount = rowCount;
	this.page = page;
	this.pageSize = pageSize;
	this.form = null;
	if (requiresForm) this.checkForForm();
	this.stamp = stamp;
	this.rows = new DotJ_RowsArray(this, rowCount);
	this.selectedRowId = selectedRowId;
	this.selectedKeyField = selectedKeyField;
	this.selectedRowOldStyle = "";
	this.multiselect = multiselect;
	this.stylePrefix = stylePrefix;
	this.requiresForm = requiresForm;
	this.showSelectorColumn = showSelectorColumn;
	this.hottrack = hottrack;

	this.getCSField = DotJ_Grid.getCSField;
	this.selectRow = DotJ_Grid.selectRow;
	this.selectGridRowCommon = DotJ_Grid.selectGridRowCommon;
	this.selectCurrentRow = DotJ_Grid.selectCurrentRow;
	this.selectPreviousRow = DotJ_Grid.selectPreviousRow;
	this.selectNextRow = DotJ_Grid.selectNextRow;
	this.setClientState = DotJ_Grid.setClientState;
	this.setKeyField = DotJ_Grid.setKeyField;
	this.showRowArrow = DotJ_Grid.showRowArrow;
	this.style = DotJ_Grid.style;
	this.changeRowStyle = DotJ_Grid.changeRowStyle;
	this.hiliteRow = DotJ_Grid.hiliteRow;
	this.restoreChanges = DotJ_Grid.restoreChanges;
	this.submitFunc = eval('DotJ_' + gridName + '_Submit');
}

//****************************   GRIDARRAY  *****************************

DotJ_GridArray.add = function (objGrid){
	this.grids.push(objGrid);
}

DotJ_GridArray.get = function(name) {
	for (var i = 0; i < this.grids.length; i++) {
		if (this.grids[i].name == name) {
			return this.grids[i];
		}
	}

	return null;
}

function DotJ_GridArray(){
	this.grids = new Array();

	this.add = DotJ_GridArray.add;
	this.get = DotJ_GridArray.get;
}

var DotJ_gridArray = null;
if (DotJ_gridArray == null){
	DotJ_gridArray = new DotJ_GridArray();
}

//****************************   ROWSARRAY  *****************************

DotJ_RowsArray.setRowId = function (row, rowId) {
	if (row >= 0 && row < this.rows.length) {
		var theRow = this.rows[row];
		if (theRow != null) {
			theRow.rowId = rowId;
		}
	}
}

DotJ_RowsArray.hasASelectedRow = function () {
	for (var i = 0; i < this.rows.length; i++) {
		if (this.rows[i].selected) return true;
	}
	return false;
}

DotJ_RowsArray.deselect = function () {
	if (this.grid.multiselect) {
		var objRow = this.grid.currentRowObj;
		var row = this.grid.currentRow;
//        alert('row=' + objRow.id + ', selected=' + this.rows[row-1].selected)
		temp = this.rows[row-1].selected;
		if (this.rows[row-1].selected) {
			this.grid.changeRowStyle(objRow, this.rows[row-1].style, (this.grid.lastKey != DotJ_MOUSE_CLICK), false);
			if (this.grid.lastKey == DotJ_MOUSE_CLICK || this.grid.lastKey == DotJ_KEY_SPACE) {
				this.rows[row-1].selected = false;
			}
			this.grid.showRowArrow(objRow.id, this.rows[row-1].selected);
		}
		//alert('desel: was ' + temp + ' and became ' + this.rows[row-1].selected)
	} else {
		for (var i = 0; i < this.rows.length; i++) {
			var objRow = this.rows[i].objRow;

			if (objRow != null) {
				this.grid.showRowArrow(objRow.id, false);
				this.grid.changeRowStyle(objRow, this.rows[i].style, false, false);
				this.rows[i].selected = false;
			}
		}
	}
}

DotJ_RowsArray.getSelectedParms = function(row, keyField) {
	var selRows = DotJ_EMPTY_STRING, selKeyFields = DotJ_EMPTY_STRING;
	var deselRows = DotJ_EMPTY_STRING, deselKeyFields = DotJ_EMPTY_STRING;
	var added = false;
	for (var i = 0; i < this.rows.length; i++) {
		if (this.rows[i].selected) {
			if (row == (i+1) && keyField == this.rows[i].keyField)
				added = true;
			if (selRows == DotJ_EMPTY_STRING) {
				selRows = '' + (i+1);
				selKeyFields = this.rows[i].keyField;
			} else {
				selRows = selRows + DotJ_ITEM_DELIMITER + (i+1);
				selKeyFields = selKeyFields + DotJ_ITEM_DELIMITER + this.rows[i].keyField;
			}
			//alert('row ' + (i+1) + ' is selected, selKeyFields=' + selKeyFields)
		} else {
			if (this.rows[i].initiallySelected) {
				if (deselRows == DotJ_EMPTY_STRING) {
					deselRows = '' + (i+1);
					deselKeyFields = this.rows[i].keyField;
				} else {
					deselRows = deselRows + DotJ_ITEM_DELIMITER + (i+1);
					deselKeyFields = deselKeyFields + DotJ_ITEM_DELIMITER + this.rows[i].keyField;
				}
			}
		}
	}
	if (!added) {
		if (selRows == DotJ_EMPTY_STRING) {
//            selRows = '' + row;
//            selKeyFields = keyField;
		} else {
//            selRows = selRows + DotJ_ITEM_DELIMITER + row;
//            selKeyFields = selKeyFields + DotJ_ITEM_DELIMITER + keyField;
		}
	}

//    alert(keyField + ': added=' + added + ', return=' + ('p1=' + selRows + DotJ_PAIR_DELIMITER + 'p2=' + selKeyFields))

	return  'p1=' + selRows + DotJ_PAIR_DELIMITER + 'p2=' + selKeyFields + DotJ_PAIR_DELIMITER +
			'p3=' + deselRows + DotJ_PAIR_DELIMITER + 'p4=' + deselKeyFields;
}

DotJ_RowsArray.saveOldStyle = function (row,style,hottrack) {
	if (hottrack) this.rows[row-1].hstyle = style;
	else this.rows[row-1].style = style;
}

DotJ_RowsArray.select = function (firstPass) {
	var objRow = this.grid.currentRowObj;
	var row = this.grid.currentRow;
	var wasSelected = this.rows[row-1].selected;
	this.rows[row-1].rowId = objRow.id;

	this.deselect();

	if (wasSelected == false) {
		this.rows[row-1].objRow = objRow;
		if (firstPass) this.rows[row-1].initiallySelected = true;
		if (DotJ_isRowToBeSelected(this.grid.lastKey, this.grid.multiselect)) {
			this.rows[row-1].selected = true;

			if (objRow.id != "") {
				this.grid.showRowArrow(objRow.id, true);
				var oldStyle = this.grid.changeRowStyle(objRow, this.grid.style('SelectedRow'), true, false);
				this.saveOldStyle(row,oldStyle,false);
			}
		}
	}

//    alert('sel: ' + this.rows[row-1].selected)
}

DotJ_RowsArray.findRow = function (rowId) {
	for (var i = 0; i < this.rows.length; i++) {
		if (this.rows[i].rowId == rowId) {
			return i;
		}
	}
	return -1;
}

DotJ_RowsArray.selectCurrentRow = function (objRow, lastKey) {
	if (typeof(this.grid.currentRowObj) == 'undefined') return;
	this.grid.selectGridRowCommon(this.grid.currentRowObj, false, lastKey);
}

DotJ_RowsArray.selectPreviousRow = function (objRow, lastKey) {
	if (typeof(this.grid.currentRowObj) == 'undefined') return;
	var i = this.findRow(this.grid.currentRowObj.id);
	if (i != -1) {
		i--;
		if (i >= 0) {
			var row = this.rows[i];
			if (row.objRow == null)
				row.objRow = DotJ_getObj(row.rowId);
			if (row.objRow != null) {
				this.grid.selectGridRowCommon(row.objRow, false, lastKey);
			}
		}
	}
}

DotJ_RowsArray.selectNextRow = function (objRow, lastKey) {
	if (typeof(this.grid.currentRowObj) == 'undefined') return;
	var i = this.findRow(this.grid.currentRowObj.id);
	if (i != -1) {
		i++;
		if (i < this.rows.length) {
			var row = this.rows[i];
			if (row.objRow == null)
				row.objRow = DotJ_getObj(row.rowId);
			if (row.objRow != null) {
				this.grid.selectGridRowCommon(row.objRow, false, lastKey);
			}
		}
	}
}

DotJ_RowsArray.setKeyField = function(row, keyField) {
	this.rows[row-1].keyField = keyField;
}

function DotJ_RowsArray(grid, rowCount) {
	this.grid = grid;
	this.rows = new Array(rowCount);
	for (var i = 0; i < this.rows.length; i++) {
		this.rows[i] = new DotJ_Row(false, '', (i+1), '');
	}

	this.hasASelectedRow = DotJ_RowsArray.hasASelectedRow;
	this.deselect = DotJ_RowsArray.deselect;
	this.getSelectedParms = DotJ_RowsArray.getSelectedParms;
	this.saveOldStyle = DotJ_RowsArray.saveOldStyle;
	this.select = DotJ_RowsArray.select;
	this.findRow = DotJ_RowsArray.findRow;
	this.selectCurrentRow = DotJ_RowsArray.selectCurrentRow;
	this.selectPreviousRow = DotJ_RowsArray.selectPreviousRow;
	this.selectNextRow = DotJ_RowsArray.selectNextRow;
	this.setKeyField = DotJ_RowsArray.setKeyField;
	this.setRowId = DotJ_RowsArray.setRowId;
}

//******************************    ROW   *******************************

function DotJ_Row(selected, rowId, row, keyField) {
	this.selected = selected;
	this.rowId = rowId;
	this.row = row;
	this.keyField = keyField;
	this.objRow = null;
	this.initiallySelected = false;
}

//****************************** SETTING  *******************************

function DotJ_Setting(id, property, value, obj) {
	this.id = id;
	this.property = property;
	this.value = value;
	this.obj = obj;
}

//**************************** GRID GLOBALS  ****************************

function DotJ_gridKeyDown(objRow, doPost) {
	if (doPost) return true;
	if (!DotJ_is_ie4up) return true;
	var parts = objRow.id.split("_");
	var objGrid = DotJ_gridArray.get(parts[1]);
	if (objGrid.inEditMode) return true;

	if (event && event.keyCode == DotJ_KEY_SPACE) {
		objGrid.lastKey = DotJ_KEY_SPACE;
		objGrid.selectCurrentRow(objRow, objGrid.lastKey);
		objGrid.lastKey = 0;
	} else if (event && event.keyCode == DotJ_KEY_UP) {
		objGrid.lastKey = DotJ_KEY_UP;
		objGrid.selectPreviousRow(objRow, objGrid.lastKey);
		objGrid.lastKey = 0;
		return false;
	} else if (event && event.keyCode == DotJ_KEY_DOWN) {
		objGrid.lastKey = DotJ_KEY_DOWN;
		objGrid.selectNextRow(objRow, objGrid.lastKey);
		objGrid.lastKey = 0;
		return false;
	}
	return true;
}

function DotJ_selectGridRow(objRow, doPost, lastKey) {
	var parts = objRow.id.split("_");
	var objGrid = DotJ_gridArray.get(parts[1]);
	var rowIndex = objGrid.rows.findRow(objRow.id);
	objGrid.lastKey = DotJ_MOUSE_CLICK;
	objGrid.selectGridRowCommon(objRow, doPost, lastKey);
	objGrid.lastKey = 0;
	objGrid.rows.rows[rowIndex].hstyle = null;
}

function DotJ_selectGridRow2(grid, absoluteRows, keyFields) {
	var objGrid = DotJ_gridArray.get(grid);
	var arrRows = absoluteRows.split(DotJ_ITEM_DELIMITER);
	var arrKeyFields = keyFields.split(DotJ_ITEM_DELIMITER);
	objGrid.lastKey = DotJ_MOUSE_CLICK;
	var lastId = null;
	for (var i = 0; i < arrRows.length; i++) {
		var row = (objGrid.pageSize == 0) ? arrRows[i]: (arrRows[i] - (objGrid.pageSize * (objGrid.page-1)));
		lastId = 'DotJ_' + objGrid.name + '_ROW_' + row + '_' + arrRows[i] + '_' + arrKeyFields[i];
		var objRow = DotJ_getObj(lastId);
		if (objRow != null) {
			objGrid.currentRowObj = objRow;
			objGrid.currentRow = row;
			objGrid.hiliteRow();
			objGrid.selectRow(true);
			objGrid.setKeyField(row, arrKeyFields[i]);
			objGrid.setClientState('select', arrRows[i], arrKeyFields[i]);
		}
	}
	objGrid.lastKey = 0;
	if (lastId != null) {
		var objField = DotJ_findFormField(lastId + '_focus');
		if (objField != null) {
			DotJ_toggleDisplay(objField);
			objField.focus();
			DotJ_toggleDisplay(objField);
		}
	}
}

function DotJ_hottrack(objRow, hilite) {
	var parts = objRow.id.split("_");
	var row = parts[3];
	var objGrid = DotJ_gridArray.get(parts[1]);
	if (objGrid.showSelectorColumn) {
		var objField = DotJ_findFormField(objRow.id + '_focus');
		if (objField != null) {
			DotJ_toggleDisplay(objField);
			objField.focus();
			DotJ_toggleDisplay(objField);
		}
	}

	if (hilite) {
		var oldStyle = objGrid.changeRowStyle(objRow, objGrid.style('RowHilite'), true, true);
		objGrid.rows.saveOldStyle(row,oldStyle,true);
	} else {
		var rowIndex = objGrid.rows.findRow(objRow.id);
		var style;
		if (objGrid.rows.rows[rowIndex].selected) {
			style = objGrid.style('SelectedRow');
		} else {
			style = objGrid.rows.rows[rowIndex].hstyle;
		}
		if (style != null) {
			var oldStyle = objGrid.changeRowStyle(objRow, style, false, true);
		}
		objGrid.rows.rows[rowIndex].hstyle = null;
	}
}

function DotJ_gridDoAction(radioField, grid, action, confirmText, dhtml) {
	var objGrid = DotJ_gridArray.get(grid);
	var csField = objGrid.getCSField();
	var selectedValue = '';
	if (dhtml) {
		if (csField.value != '') {
			var arr = csField.value.split(DotJ_PAIR_DELIMITER);
			if (arr.length >= 4) {
				var p1 = arr[2].split('=');
				var p2 = arr[3].split('=');
				if (p1[1] != DotJ_EMPTY_STRING) {
					selectedValue = p1[1] + DotJ_PAIR_DELIMITER + p2[1];
				}
			}
		}
	} else {
		if (objGrid.selectedRowId != '-1') {
			selectedValue = objGrid.selectedRowId + DotJ_PAIR_DELIMITER + objGrid.selectedKeyField;
			if (selectedValue == DotJ_PAIR_DELIMITER) selectedValue = '';
		}
	}

//    alert('selectedValue.length=' + selectedValue.length + ',hasASelectedRow=' + objGrid.rows.hasASelectedRow() +
//          ',dhtml=' + dhtml + ',action=' + action + ',selectedValue=' + selectedValue + '\n\nRESULT=' +
//          ((selectedValue.length == 0 || (objGrid.rows.hasASelectedRow() == false && dhtml)) && action != 'refresh'))

	if ((selectedValue.length == 0 || (objGrid.rows.hasASelectedRow() == false && dhtml)) && action != 'refresh') {
		alert(objGrid.MSG_NO_ROW_SELECTED);
	} else {
		var arr = selectedValue.split(DotJ_PAIR_DELIMITER);
		var param1 = arr[0];
		var param2 = arr[1];
		if (param1 != DotJ_EMPTY_STRING) {
			if (action == 'delete') {
				if (param1 != "") {
					if (confirm(confirmText) == true) {
						objGrid.submitFunc(grid,action,param1,param2);
					}
				}
			} else {
				objGrid.submitFunc(grid,action,param1,param2);
			}
		}
	}
}

function DotJ_gridChangePage(grid, selectField) {
	var objGrid = DotJ_gridArray.get(grid);
	var pageNum=1;
	for (var i = 0; i < selectField.options.length; i++) {
		if (selectField[i].selected) {
			pageNum = selectField[i].value;
		}
	}
	objGrid.submitFunc(grid, 'page', pageNum);
}

//***********************************************************************

function DotJ_borderBottomRight(changes, el, color, width, style) {
	DotJ_borderBottom(changes, el, color, width, style);
	DotJ_borderRight(changes, el, color, width, style);
}

function DotJ_borderTopBottomRight(changes, el, color, width, style) {
	DotJ_borderTop(changes, el, color, width, style);
	DotJ_borderBottom(changes, el, color, width, style);
	DotJ_borderRight(changes, el, color, width, style);
}

function DotJ_borderTopBottomLeft(changes, el, color, width, style) {
	DotJ_borderTop(changes, el, color, width, style);
	DotJ_borderBottom(changes, el, color, width, style);
	DotJ_borderLeft(changes, el, color, width, style);
}

function DotJ_borderTopLeft(changes, el, color, width, style) {
	DotJ_borderTop(changes, el, color, width, style);
	DotJ_borderLeft(changes, el, color, width, style);
}

function DotJ_borderTopBottom(changes, el, color, width, style) {
	DotJ_borderTop(changes, el, color, width, style);
	DotJ_borderBottom(changes, el, color, width, style);
}

function DotJ_borderAll(changes, el, color, width, style) {
	DotJ_borderTop(changes, el, color, width, style);
	DotJ_borderBottom(changes, el, color, width, style);
	DotJ_borderLeft(changes, el, color, width, style);
	DotJ_borderRight(changes, el, color, width, style);
}

function DotJ_borderTop(changes, el, color, width, style) {
	if (changes != null) {
		var change;
		change = new DotJ_Setting(el.id, 'style.borderTopWidth', el.style.borderTopWidth);
		changes[changes.length] = change;
		change = new DotJ_Setting(el.id, 'style.borderTopStyle', el.style.borderTopStyle);
		changes[changes.length] = change;
		change = new DotJ_Setting(el.id, 'style.borderTopColor', el.style.borderTopColor);
		changes[changes.length] = change;
	}

	el.style.borderTopWidth = width;
	el.style.borderTopStyle = style;
	el.style.borderTopColor = color;
}

function DotJ_borderBottom(changes, el, color, width, style) {
	if (changes != null) {
		var change;
		change = new DotJ_Setting(el.id, 'style.borderBottomWidth', el.style.borderBottomWidth);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderBottomStyle', el.style.borderBottomStyle);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderBottomColor', el.style.borderBottomColor);
		changes.push(change);
	}

	el.style.borderBottomWidth = width;
	el.style.borderBottomStyle = style;
	el.style.borderBottomColor = color;
}

function DotJ_borderRight(changes, el, color, width, style) {
	if (changes != null) {
		var change;
		change = new DotJ_Setting(el.id, 'style.borderRightWidth', el.style.borderRightWidth);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderRightStyle', el.style.borderRightStyle);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderRightColor', el.style.borderRightColor);
		changes.push(change);
	}

	el.style.borderRightWidth = width;
	el.style.borderRightStyle = style;
	el.style.borderRightColor = color;
}

function DotJ_borderLeft(changes, el, color, width, style) {
	if (changes != null) {
		var change;
		change = new DotJ_Setting(el.id, 'style.borderLeftWidth', el.style.borderLeftWidth);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderLeftStyle', el.style.borderLeftStyle);
		changes.push(change);
		change = new DotJ_Setting(el.id, 'style.borderLeftColor', el.style.borderLeftColor);
		changes.push(change);
	}

	el.style.borderLeftWidth = width;
	el.style.borderLeftStyle = style;
	el.style.borderLeftColor = color;
}

//***********************************************************************

function DotJ_setCursorToPointer(obj) {
	if (DotJ_is_ie4up) obj.style.cursor = 'hand';
	else obj.style.cursor = 'pointer';
}

function DotJ_setCursorToDefault(obj) {
	obj.style.cursor = 'default';
}

function DotJ_setCursorToMove(obj) {
	obj.style.cursor = 'move';
}

//***********************************************************************

function DotJ_taMaxlength(field, maxlength) {
	if (field.value.length > maxlength)
		field.value = field.value.substring(0, maxlength);
}

function DotJ_FindParentForm(elName) {
	var theForm = null;
	if (document.forms.length == 1) {
		theForm = document.forms[0];
	} else {
		var obj = DotJ_getObj(elName);
		while (obj != null && obj.nodeName != null && obj.nodeName.toLowerCase() != 'form')
			obj = obj.parentNode;
		if (obj != null && obj.nodeName != null && obj.nodeName.toLowerCase() == 'form')
			theForm = obj;
	}
	return theForm;
}

function DotJ_findFormField(fieldName) {
	var objField = null, form, iForm = 0, iElement = 0;
	var forms = document.forms;
	if (typeof(fieldName) == 'undefined' || fieldName == null || fieldName == '') return null;

	for (iForm = 0; iForm < forms.length; iForm++) {
		form = forms[iForm];

		for (iElement = 0; iElement < form.elements.length; iElement++) {
			var tempId = form.elements[iElement].name;
			if (typeof(tempId) == 'undefined' || tempId == '') tempId = form.elements[iElement].id;
			if (typeof(tempId) == 'undefined' || tempId == '') {
				;
			} else {
				if (tempId.toLowerCase() == fieldName.toLowerCase()) {
					objField = form.elements[iElement];
					break;
				}
			}
		}
	}

	if (objField == null) objField = DotJ_getObj(fieldName);

	return objField;
}

function DotJ_getObj(elName) {
	if (DotJ_is_nav4) return eval('document.' + elName);
	if (DotJ_is_ie4up) return document.all[elName];
	if (DotJ_MozillaFamily() || DotJ_is_opera7up) return document.getElementById(elName);
	return null;
}
function DotJ_DHTMLSupport() {
	if (DotJ_is_ie4up || DotJ_MozillaFamily()) return true;
	return false;
}
function DotJ_MozillaFamily() {
	if (DotJ_is_nav6up || DotJ_is_moz || DotJ_is_fx) return true;
	return false;
}
function DotJ_Onfocus(field,msg,tipalignment,tipStyle,dhtml) {
	if (field == undefined) return;
	if (dhtml) DotJ_ChangeBackground(field,DotJ_INPUT_BGCOLOR_ON);
	if (DotJ_DHTMLSupport()) {
		if (msg == null || msg == '')
			;
		else
			DotJ_ShowTip(field,msg,tipalignment,tipStyle,true)
	}
}
function DotJ_Onblur(field,dhtml) {
	if (field == undefined) return;
	if (dhtml) DotJ_ChangeBackground(field,DotJ_INPUT_BGCOLOR_OFF);
	if (DotJ_DHTMLSupport()) {
		DotJ_hideElement(tipDiv);
		if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(tipDiv, true);
	}
}
function DotJ_ChangeBackground(field,color) {
	if (field == undefined) return;
	if (DotJ_DHTMLSupport()) {
		if (field.type.toLowerCase() != 'radio' && field.type.toLowerCase() != 'checkbox')
			if (DotJ_is_nav4) field.bgColor=color;
			else field.style.background=color;
	}
}
function DotJ_GetBackground(el) {
	if (el == undefined) return;
	if (DotJ_DHTMLSupport()) {
		if (el.type.toLowerCase() != 'radio' && el.type.toLowerCase() != 'checkbox')
			if (DotJ_is_nav4) return el.bgColor;
			else return el.style.background;
	}
}
function DotJ_bindEvent(control, eventName, func) {
	eval("control." + eventName + " = func");
}
function DotJ_unbindEvent(control, eventName, func) {
	eval("control." + eventName + " = null");
}
function DotJ_stackJavaScriptEvent(control,eventName,func) {
	if (control == undefined) return;
	var evt = eval("control." + eventName);
	var sEvt = "";
	if (typeof(evt) == 'function' ) {
		sEvt = evt.toString();
		sEvt = sEvt.substring(sEvt.indexOf("{") + 1, sEvt.lastIndexOf("}"));
		sEvt = DotJ_Trim(sEvt);
	}
	var f;
	f = new Function(func + "; " + sEvt);
	var tagName = control.tagName;
	if (typeof(tagName) == 'undefined') tagName = control[0].tagName;
	if (DotJ_MozillaFamily() && tagName.toLowerCase() == 'body')
		eval("control." + eventName + " = f()");
	else
		eval("control." + eventName + " = f");
}

function DotJ_findAnchorItem(item) {
	var obj = DotJ_getObj(item);

	if (obj == null) {
		obj = DotJ_findFormField(item);
	}

	return obj;
}

function DotJ_setText(id, text) {
	DotJ_writeLayer(DotJ_getObj(id), text);
}

function DotJ_isHidden(el) {
	if (DotJ_getVisibility(el) == "hide" || DotJ_getVisibility(el) == "hidden") return true;
	else return false;
}

function DotJ_displayElement(element) {
	if (DotJ_is_nav4) element.visibility = "show";
	else if (DotJ_is_ie4up) element.style.visibility = "visible";
	else if (DotJ_MozillaFamily()) element.style.visibility = "visible";
}
function DotJ_getVisibility(element) {
	if (DotJ_is_nav4) return element.visibility;
	else if (DotJ_is_ie4up) return element.style.visibility;
	else if (DotJ_MozillaFamily()) return element.style.visibility;
}
function DotJ_hideElement(element) {
	if (DotJ_is_nav4) element.visibility = "hide";
	else if (DotJ_is_ie4up) element.style.visibility = "hidden";
	else if (DotJ_MozillaFamily()) element.style.visibility = "hidden";
}
function DotJ_toggleDisplay(element) {
	var collapsed = true;
	if (DotJ_DHTMLSupport()) {
		if (element.style.display == "") {
			element.style.display = "none";
			collapsed = true;
		} else {
			element.style.display= "";
			collapsed = false;
		}
	}
	return collapsed;
}

function DotJ_getWidth(el) {
	return el.offsetWidth;
}

function DotJ_getHeight(el) {
	return el.offsetHeight;
}

function DotJ_ShowTip(field,msg,tipalignment,tipStyle,isTip){
	if (null == field || null == msg)
		return;
	if (null == tipDiv)
		return;
	var cssStyle = 'tooltip';
	if (null != tipStyle && tipStyle.length > 0)
		cssStyle = tipStyle;
	if (isTip) {
		tipDiv.className = cssStyle;
	} else {
		tipDiv.backgroundColor = "red";
		tipDiv.color = "white";
	}
	DotJ_writeLayer(tipDiv,unescape(msg));
	DotJ_placeElement(tipDiv,field,tipalignment);
	DotJ_displayElement(tipDiv);
	if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(tipDiv, false);
}
function DotJ_writeLayer(lay, html) {
	if (DotJ_is_nav4) {
		var l = lay.document;
		l.write(html);
		l.close();
	} else if (DotJ_is_ie4up) {
		lay.innerHTML = html;
	} else if (DotJ_MozillaFamily()) {
		var r = document.createRange();
		r.setStartBefore(lay);
		var f = r.createContextualFragment(html);
		while (lay.hasChildNodes()) {
			lay.removeChild(lay.lastChild);
		}
		lay.appendChild(f);
	}
}
function DotJ_placeElement(el,inField,alignment) {
	var field = inField;
	if (typeof(field.id) == 'undefined') field = inField[0];
	var tempAlignment='bottom';
	if (null != alignment && alignment.toLowerCase() == 'right')
		tempAlignment = 'right';
	else if (null != alignment && alignment.toLowerCase() == 'top')
		tempAlignment = 'top';
	else if (null != alignment && alignment.toLowerCase() == 'left')
		tempAlignment = 'left';

	var c;

	if (field.type.toLowerCase() == 'radio') {
		c = DotJ_getAnchorPosition(field, field.id + "_tippos");
	} else {
		c = DotJ_getAnchorPosition(field, field.name + "_tippos");
	}

	var x = c.x;
	var y = c.y;
	if (DotJ_is_nav4) {
		DotJ_moveTo(el, x, y);
	} else {
		if (tempAlignment == 'top') {
			DotJ_moveTo(el, x, y-field.offsetHeight-el.offsetHeight);
		} else if (tempAlignment == 'right') {
			DotJ_moveTo(el, x+field.offsetWidth+2, y-field.offsetHeight);
		} else if (tempAlignment == 'left') {
			DotJ_moveTo(el, x-el.offsetWidth, y-field.offsetHeight);
		} else {
			DotJ_moveTo(el, x, y+2);
		}
	}
}
function DotJ_getAnchorPosition(anchor, anchorName) {
	var x = 0, y = 0;
	if (DotJ_DHTMLSupport()) {
		var obj = DotJ_getObj(anchorName);
		x = DotJ_getX(obj);
		y = DotJ_getY(obj);
	} else if (DotJ_is_nav4) {
		for (var i=0; i < document.anchorNames.length; i++) {
			if (document.anchorNames[i].name == anchorName) {
				x = document.anchorNames[i].x;
				y = document.anchorNames[i].y;
				break;
			}
		}
	}

	// Normalize a bit
	if (DotJ_MozillaFamily()) y = y + 3;
	if (DotJ_is_ie4up) y = y + anchor.offsetHeight;
	if (DotJ_is_nav4) y = y + 23;

	var pos = new Object();
	pos.x = x;
	pos.y = y;
	return pos;
}
function DotJ_getX(element) {
	var x = element.offsetLeft;
	var parent = element.offsetParent;
	while (null != parent) {
		if (parent.offsetLeft)
			x += parent.offsetLeft;
		parent = parent.offsetParent;
	}
	return x;
}
function DotJ_getY(element) {
	var y = element.offsetTop;
	var parent = element.offsetParent;
	while (null != parent) {
		if (parent.offsetTop)
			y += parent.offsetTop;
		parent = parent.offsetParent;
	}
	return y;
}
function DotJ_getX2(el) { return (el.x) ? el.x : DotJ_getPos(el,"Left"); }
function DotJ_getY2(el) { return (el.y) ? el.y : DotJ_getPos(el,"Top"); }
function DotJ_getPos(el,which) {
	iPos = 0;
	while (el != null) {
		iPos += el["offset" + which];
		el = el.offsetParent;
	}
	return iPos;
}
function DotJ_getSmartX(x, anchorWidth, objWidth, margin) {
	var winoffset = (DotJ_is_ie4up) ? document.body.scrollLeft : self.pageXOffset;
	var clientWidth = (DotJ_is_ie4up) ? document.body.clientWidth : self.innerWidth;

	if ( (x + objWidth) > (winoffset + clientWidth) ) {
		return x - margin - objWidth;    // left
	} else {
		return x + anchorWidth + margin; // right
	}
}

function DotJ_getSmartY(y, anchorHeight, objHeight, margin) {
	var scrolloffset = (DotJ_is_ie4up) ? document.body.scrollTop : self.pageYOffset;
	var clientHeight = (DotJ_is_ie4up) ? document.body.clientHeight : self.innerHeight;

	if ( (y + objHeight) > (scrolloffset + clientHeight) ) {
		return y - margin - objHeight;    // above
	} else {
		return y + anchorHeight + margin; // below
	}
}

function DotJ_moveTo(element,x,y) {
	if (DotJ_is_nav4) {
		element.left = x;
		element.top = y;
	} else if (DotJ_is_ie4up) {
		element.style.left = x;
		element.style.top = y;
	} else if (DotJ_MozillaFamily()) {
		element.style.left = x + "px";
		element.style.top = y + "px";
	}
}
function DotJ_setDate(theForm,yyField,mmField,ddField,targetField,fmt) {
	var dayField = eval('theForm.' + ddField);
	var yy = eval('theForm.' + yyField + '.value');
	var daysInFeb = DotJ_daysInFebruary(yy);
	var mm = eval('theForm.' + mmField + '.value');
	var dd = dayField.value;

	if (daysInFeb == 29) {
		if (mm == 2 && dd > 29)
			dayField.selectedIndex = 28;
		else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && (dd > 30))
			dayField.selectedIndex = 29;
	} else {
		if (mm == 2 && dd > 28)
			dayField.selectedIndex = 27;
		else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && (dd > 30))
			dayField.selectedIndex = 29;
	}

	dd = dayField.value;
	var date = DotJ_makeDate(yy, mm, dd, fmt);
	var targetField = eval('theForm.' + targetField);
	targetField.value = date;
}

function DotJ_AutoTab(theForm, keyChar, field, maxlen) {
	if (keyChar != 9 && keyChar != 16) {
		if (field.value.length + 1 <= maxlen) {
			field.focus();
		} else {
			var nextField;
			for (i=0; i < theForm.elements.length; i++) {
				if (field.name == theForm.elements[i].name) {
					if (i + 1 < theForm.elements.length) {
						nextField = i + 1;
						var fieldType = theForm.elements[nextField].type;
						if (fieldType == 'hidden')
							nextField = nextField + 1;
						theForm.elements[nextField].focus();
					}
				}
			}
		}
	}
}

function DotJ_makeSlots() {
	var arr = new Array(43);
	var i;
	for (i = 0; i < 43; i++)
		arr[i] = '';
	return arr;
}

function DotJ_safeJSString(s) {
	if (s == null || s == "null") return '';
	if (s.indexOf("'") == -1 && s.indexOf('"') != -1) return "'" + s + "'";
	if (s.indexOf("'") != -1 && s.indexOf('"') == -1) return '"' + s + '"';
	if (s.indexOf("'") != -1 && s.indexOf('"') != -1) return '"' + s.replace('"', '&quot;') + '"';

	return "'" + s + "'";
}

function DotJ_Trim(s) {
	while (''+s.charAt(0)==' ' || ''+s.charAt(0)=='\n')
		s = s.substring(1,s.length);
	while (''+s.charAt(s.length-1)==' ' || ''+s.charAt(s.length-1)=='\n')
		s=s.substring(0,s.length-1);
	return s;
}

function DotJ_getRadioButtonValue (radio) {
	for (var i = 0; i < radio.length; i++) {
		if (radio[i].checked) { break }
	}
	if (i == radio.length)
		return "";
	else
		return radio[i].value
}

function DotJ_isEmpty (s) {
	return ((s == null) || (s.length == 0))
}

function DotJ_isWhitespace (s) {
	var whitespace = " \t\n\r";
	var i;
	if (DotJ_isEmpty(s)) return true;
	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (whitespace.indexOf(c) == -1) return false;
	}
	return true;
}

function DotJ_bindControl(control,func) {
	if (control == undefined) return;
	var evt;
	if (control.tagName.toUpperCase() == 'FORM') evt = control.onsubmit;
	else if (control.type.toLowerCase() == 'radio') evt = control.onclick;
	else evt = control.onchange;
	var sEvt = "";
	if (typeof(evt) == 'function' ) {
		sEvt = evt.toString();
		sEvt = sEvt.substring(sEvt.indexOf("{") + 1, sEvt.lastIndexOf("}"));
	}
	var f, tmp;
	if (control.tagName.toUpperCase() == 'FORM') {
		tmp = DotJ_Trim(sEvt);
		if (tmp == '') tmp = 'true';
		else {
			tmp = tmp.replace(/^return /,'');
			tmp = tmp.replace('this','document.' + control.name);
		}
		f = new Function("var undefined;\nvar isValid = " + func + " \nvar urRc = " + tmp + "\nif (urRc == undefined)\n  return isValid;\nelse\n  return urRc && isValid;");
	} else {
		f = new Function(func + " " + sEvt);
	}
	if (control.tagName.toUpperCase() == 'FORM') control.onsubmit = f;
	else if (control.type.toLowerCase() == 'radio') control.onclick = f;
	else control.onchange = f;
}
function DotJ_ValidatorOnChange(fieldName) {
	var i, msg, rc = true;
	for (i = 0; i < validators.length; i++) {
		if (validators[i].fieldName == fieldName) {
    		validators[i].valid = true;
    	}
	}

	for (i = 0; i < validators.length; i++) {
		if (validators[i].fieldName == fieldName) {
			msg = DotJ_ValidatorValidate(validators[i], false);
			if (!validators[i].valid) {
				if (DotJ_useAlert() && msg != '') {
					alert(msg);
				}
				rc = false;
				break;
			}
		}
	}
	return rc;
}
function DotJ_useAlert() {
	if (DotJ_ALERT_BEHAVIOUR == 'alert') return true;
	else return false;
}

var DotJ_focusField = null;
function DotJ_timerFocus() {
	if (DotJ_focusField != null) {
		if (DotJ_isHidden(DotJ_focusField) == false) {
			DotJ_focusField.focus();
			var tag = DotJ_focusField.tagName.toLowerCase();
			if (tag == 'input' || tag == 'textarea')
				DotJ_focusField.select();
		}
		DotJ_focusField = null;
	}
	setTimeout("DotJ_timerFocus()", 250);
}
setTimeout("DotJ_timerFocus()", 250);
function DotJ_ValidatorValidate(val, onsubmit) {
	if (val.field == undefined) return true;
	val.valid = eval(val.func + '(val)');
	return DotJ_ValidatorUpdateDisplay(val, onsubmit);
}
function DotJ_ValidatorUpdateDisplay(val, onsubmit) {
	var resultMsg = '';
	var fieldElement = DotJ_getObj(val.name);
	var valid = true;
	var i, firstMsg;
	if (val.hmsg == '') firstMsg = val.msg;
	else firstMsg = new String(val.hmsg);
	for (i = 0; i < validators.length; i++) {
		if (validators[i].fieldName == val.fieldName) {
			if (valid && !validators[i].valid) {
				if (validators[i].hmsg == '') firstMsg = validators[i].msg;
				else firstMsg = new String(validators[i].hmsg);
				validators[i].hmsg = '';
			}
		    valid = valid && validators[i].valid;
		}
	}

	var type = val.field.type;
	if (typeof(type) == 'undefined') type = val.field[0].type;

	if (valid) {
		if (DotJ_useAlert() == false) {
			DotJ_hideElement(fieldElement);
			if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(fieldElement, true);
			if (DotJ_FIELDVALIDATOR_ERROR_CHANGEFIELDCLASSNAME) {
				if (type.toLowerCase() == 'radio' || type.toLowerCase() == 'checkbox') {
					for (var i = 0; i < val.field.length; i++) {
						var label = DotJ_getObj(val.field[i].id + '_label');
						if (label != null) {
							DotJ_stateMgr.restoreSettings(label.id);
						}
					}
				} else if (type.toLowerCase() == 'select-one' || type.toLowerCase() == 'select-multiple') {
					var tblSelect = DotJ_getObj('DotJ_tbl' + val.field.name);
					if (tblSelect != null) {
						DotJ_stateMgr.restoreSettings(tblSelect.id);
					}
				} else {
					DotJ_stateMgr.restoreSettings(val.field.name);
				}
			}
		}
	} else {
		if (DotJ_FIELDVALIDATOR_ERROR_CHANGEFIELDCLASSNAME && DotJ_useAlert() == false) {
			if (type.toLowerCase() == 'radio' || type.toLowerCase() == 'checkbox') {
				for (var i = 0; i < val.field.length; i++) {
					if (val.fieldName == val.field[i].id) {
						var label = DotJ_getObj(val.field[i].id + '_label');
						if (label != null) {
							DotJ_stateMgr.queueSetting(label.id, 'className', label.className, label);
							label.className = 'fieldError';
						}
					}
				}
			} else if (type.toLowerCase() == 'select-one' || type.toLowerCase() == 'select-multiple') {
				var tblSelect = DotJ_getObj('DotJ_tbl' + val.field.name);
				if (tblSelect != null) {
					DotJ_stateMgr.queueSetting(tblSelect.id, 'className', tblSelect.className, tblSelect);
					tblSelect.className = 'fieldError';
				}
			} else {
				DotJ_stateMgr.queueSetting(val.field.name, 'className', val.field.className, val.field);
				val.field.className = 'fieldError'
			}
		}
		if (type.toLowerCase() != 'radio' && type.toLowerCase() != 'checkbox') {
			DotJ_focusField = val.field;
		}
		if (DotJ_useAlert() == false)
			DotJ_writeLayer(fieldElement, firstMsg);
		resultMsg = firstMsg;

		if (DotJ_useAlert() == false) {
			if (!val.placed) {
				DotJ_placeElement(fieldElement,val.field,val.alignment);
				val.placed = true;
			}
			DotJ_displayElement(fieldElement);
			if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(fieldElement, false);
		}
	}
	return resultMsg;
}
function DotJ_GetFieldValue(val) {
	var result = '';
	var type = val.field.type;
	var undefined, count=0;
	if (type == undefined) type = val.field[0].type;
	if (type.toLowerCase() == "select-one" || type.toLowerCase() == "select-multiple") {
		for (var i = 0; i < val.field.options.length; i++) {
			if (val.field[i].selected) {
				count = count + 1;
				if (count == 1)
					result = val.field[i].value;
				else
					result = result + DotJ_ITEM_DELIMITER + val.field[i].value;
			}
		}
	} else if (type.toLowerCase() == "radio") {
		result = DotJ_getRadioButtonValue(val.field);
	} else {
		result = DotJ_Trim(val.field.value);
	}
	return result;
}
function DotJ_RequiredFieldValidator(val) {
	var value = DotJ_GetFieldValue(val);
	var type = val.field.type;
	var undefined;
	if (type == undefined) type = val.field[0].type;
	if (type.toLowerCase() == "select-one" || type.toLowerCase() == "select-multiple") {
		if (value == val.initValue || value == '') return false;
		else return true;
	} else if (type.toLowerCase() == "radio") {
		if (DotJ_isEmpty(value))
			return false;
		return true;
	} else {
		val.field.value = DotJ_Trim(value);
		if (DotJ_isEmpty(val.field.value) || DotJ_isWhitespace(val.field.value)) {
			return false;
		}
		if (val.field.value.length < val.minlength) {
			val.hmsg = DotJ_ERROR_MINLENGTH;
			val.hmsg = val.hmsg.replace('{minlength}',val.minlength);
			return false;
		}
	}
	return true;
}
function DotJ_AutoFieldValidator(val) {
	return DotJ_ValidateField(val.field, val.datatype, val.msg);
}

function DotJ_CustomFieldValidator(val) {
	var sValue = DotJ_GetFieldValue(val);
	var f = val.customFunc;
	var rc = DotJ_invoke(f, sValue); // Generated from tags
	if (rc == "true") {
		return true;
	} else if (rc == "false") {
		return false;
	} else {
		var msg = 'dotJ Javascript Error: client side function ' + f + ' does not exist.\n\nJavaScript Exception: ';
		msg = msg + rc;
		alert(msg);
		return false;
	}
}
function DotJ_RegularExpressionValidator(val) {
	var sValue = DotJ_GetFieldValue(val);
	if (sValue == '') return true;
	var re = new RegExp(val.regexp);
	var isMatch = re.exec(sValue);
	return (isMatch != null && sValue == isMatch[0]);
}
function DotJ_Validator(id, name, fieldName, field, datatype, msg, func, initValue, customFunc, minlength, regexp, alignment) {
	this.id = id;
	this.name = name;
	this.fieldName = fieldName;
	this.field = field;
	this.datatype = datatype;
	this.msg = msg;
	this.hmsg = '';
	this.func = func;
	this.initValue = initValue;
	this.valid = true;
	this.customFunc = customFunc;
	this.minlength = minlength;
	this.regexp = regexp;
	this.alignment = alignment;
	this.placed = false;
}
function DotJ_ValidateField(f, datatype, msg) {
	if (datatype == "" || datatype == "select" || datatype == "radiogroup")
		return true;
	f.value = DotJ_Trim(f.value);
	if (DotJ_isEmpty(f.value) || DotJ_isWhitespace(f.value))
		return true;
	if (datatype == "alphanumeric") {
		return DotJ_isAlphanumeric(f.value);
	} else if (datatype == "alphabetic") {
		return DotJ_isAlphabetic(f.value);
	} else if (datatype == "zip") {
		return DotJ_isZIPCode(f.value);
	} else if (datatype == "state") {
		f.value = f.value.toUpperCase();
		return DotJ_isStateCode(f.value);
	} else if (datatype == "usphone") {
		return DotJ_isUSPhoneNumber(f.value);
	} else if (datatype == "email") {
		return DotJ_isEmail(f.value);
	} else if (datatype == "ssn") {
		return DotJ_isSSN(f.value);
	} else if (datatype == "year") {
		return DotJ_isYear(f.value);
	} else if (datatype == "integer") {
		return DotJ_isInteger(f.value);
	} else if (datatype == "signedinteger") {
		return DotJ_isSignedInteger(f.value);
	} else if (datatype == "positiveinteger") {
		return DotJ_isPositiveInteger(f.value);
	} else if (datatype == "nonnegativeinteger") {
		return DotJ_isNonnegativeInteger(f.value);
	} else if (datatype == "negativeinteger") {
		return DotJ_isNegativeInteger(f.value);
	} else if (datatype == "nonpositiveinteger") {
		return DotJ_isNonpositiveInteger(f.value);
	} else if (datatype == "double") {
		return DotJ_isDouble(f.value);
	} else if (datatype == "signeddouble") {
		return DotJ_isSignedDouble(f.value);
	} else if (datatype == "positivedouble") {
		return DotJ_isPositiveDouble(f.value);
	} else if (datatype == "nonnegativedouble") {
		return DotJ_isNonnegativeDouble(f.value);
	} else if (datatype == "negativedouble") {
		return DotJ_isNegativeDouble(f.value);
	} else if (datatype == "nonpositivedouble") {
		return DotJ_isNonpositiveDouble(f.value);
	} else if (datatype == "date1" || datatype == "date2" || datatype == "date3" || datatype == "date4" || datatype == "date5" ||
			   datatype == "date6" || datatype == "date7" || datatype == "date8" || datatype == "date9") {
		return (DotJ_isDate(f.value, datatype) != null);
	} else if (datatype == "textarea") {
		return true;
	}
}

function DotJ_isInteger (s) {
	var re = /^(\+|\-)?\d+$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isSignedInteger (s) {
	var re = /^(\+|\-){1}\d+$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isPositiveInteger (s) {
	return (DotJ_isInteger(s) && parseInt(s,10) > 0);
}

function DotJ_isNegativeInteger (s) {
	return (DotJ_isInteger(s) && parseInt (s,10) < 0);
}

function DotJ_isNonnegativeInteger (s) {
	return (DotJ_isInteger(s) && parseInt (s,10) >= 0);
}

function DotJ_isNonpositiveInteger (s) {
	return (DotJ_isInteger(s) && parseInt (s,10) <= 0);
}

function DotJ_isDouble (s) {
	var i;
	var seenDecimalPoint = false;
	if (s == ".") return false;
	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if ((c == ".") && !seenDecimalPoint) seenDecimalPoint = true;
		else if (!DotJ_isDigit(c)) return false;
	}
	return true;
}

function DotJ_isSignedDouble (s) {
	var startPos = 0;
	if ((s.charAt(0) == "-") || (s.charAt(0) == "+"))
		return (DotJ_isDouble(s.substring(1, s.length)));
	else
		return false;
}

function DotJ_isPositiveDouble (s) {
	return (DotJ_isDouble(s) && parseFloat(s) > 0);
}

function DotJ_isNegativeDouble (s) {
	return (DotJ_isDouble(s) && parseFloat (s) < 0);
}

function DotJ_isNonnegativeDouble (s) {
	return (DotJ_isDouble(s) && parseFloat (s) >= 0);
}

function DotJ_isNonpositiveDouble (s) {
	return (DotJ_isDouble(s) && parseFloat (s) <= 0);
}

function DotJ_isDigit (c) {
	return ((c >= "0") && (c <= "9"))
}

function DotJ_isStateCode(s) {
	var re = /^AK|AL|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MN|NC|ND|NE|NH|NJ|NM|NV|NY|OH|OK|OR|PA|PR|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_getRadioButtonValue (radio) {
	for (var i = 0; i < radio.length; i++) {
		if (radio[i].checked) { break }
	}
	if (i == radio.length)
		return ""
	else
		return radio[i].value
}

function DotJ_isZIPCode (s) {
	var re = /(^\d{5}$)|(^\d{9}$)|(^\d{5}-\d{4}$)/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isUSPhoneNumber (s) {
	var re = /^(\([1-9][0-9]{2}\)\s?)?[1-9][0-9]{2}-[0-9]{4}$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isWhitespace (s) {
	var whitespace = " \t\n\r";
	var i;
	if (DotJ_isEmpty(s)) return true;
	for (i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (whitespace.indexOf(c) == -1) return false;
	}
	return true;
}

function DotJ_isShortYear (s) {
	var re = /^\d{2}$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isYear (s) {
	var re = /^\d{4}$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isEmail (s) {
	var re = /^([a-zA-Z0-9]+)([\-_.]([a-zA-Z0-9]+))*@[a-zA-Z0-9][\w\.\-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isSSN (s) {
	var re = /(^\d{3}-\d{2}-\d{4}$)|(^\d{9}$)/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isAlphabetic (s) {
	var re = /^[a-zA-Z]*$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_isAlphanumeric (s) {
	var re = /^[a-zA-Z0-9]*$/
	var isMatch = re.exec(s);
	return (isMatch != null && s == isMatch[0]);
}

function DotJ_getDateFormat (t) {
	if (t == "date1")
		return "MM/DD/YYYY";
	else if (t == "date2")
		return "MM-DD-YYYY";
	else if (t == "date3")
		return "YYYY/MM/DD";
	else if (t == "date4")
		return "YYYY-MM-DD";
	else if (t == "date5")
		return "MMDDYYYY";
	else if (t == "date6")
		return "YYYYMMDD";
	else if (t == "date7")
		return "MMDDYY";
	else if (t == "date8")
		return "MM/DD/YY";
	else if (t == "date9")
		return "MM-DD-YY";
	else
		return "";
}

function DotJ_makeDate (YYYY, mm, dd, fmt) {
	var MM = "" + mm;
	var DD = "" + dd;
	if (MM.length == 1) MM = "0" + MM;
	if (DD.length == 1) DD = "0" + DD;

	if (fmt == "date1") {
		return MM + "/" + DD + "/" + YYYY;
	} else if (fmt == "date2") {
		return MM + "-" + DD + "-" + YYYY;
	} else if (fmt == "date3") {
		return YYYY + "/" + MM + "/" + DD;
	} else if (fmt == "date4") {
		return YYYY + "-" + MM + "-" + DD;
	} else if (fmt == "date5") {
		return MM + "" + DD + "" + YYYY;
	} else if (fmt == "date6") {
		return YYYY + "" + MM + "" + DD;
	} else if (fmt == "date7") {
		var temp = "" + YYYY;
		return MM + "" + DD + "" + temp.substring(2);
	} else if (fmt == "date8") {
		var temp = "" + YYYY;
		return MM + "/" + DD + "/" + temp.substring(2);
	} else if (fmt == "date9") {
		var temp = "" + YYYY;
		return MM + "-" + DD + "-" + temp.substring(2);
	} else {
		return "";
	}
}

function DotJ_isMonth (s) {
	return DotJ_isIntegerInRange (s, 1, 12);
}

function DotJ_isDay (s) {
	return DotJ_isIntegerInRange (s, 1, 31);
}

function DotJ_isIntegerInRange (s, a, b) {
	if (!DotJ_isInteger(s)) return false;
	var num = s - 0;
	return ((num >= a) && (num <= b));
}

function DotJ_daysInFebruary (year) {
	return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DotJ_isDate (theDate, inFormat) {
	var format = inFormat.toLowerCase();
	var result = null, year, month, day, delim;
	var isYear = null;
	if (format == "date1" || format == "date3" || format == "date8")
		delim = '/'
	else if (format == "date2" || format == "date4" || format == "date9")
		delim = '-'
	if (format == "date1" || format == "date2" || format == "date8" || format == "date9") {
		var pos1 = theDate.indexOf(delim)
		if (pos1 == -1) return null;
		month = theDate.substring(0, pos1)
		var pos2 = theDate.lastIndexOf(delim)
		if (pos2 == pos1) return null;
		day = theDate.substring(pos1+1, pos2)
		year = theDate.substring(pos2+1, theDate.length)
		if (format == "date8" || format == "date9") {
			isYear = DotJ_isShortYear(year);
		}
	} else if (format == "date3" || format == "date4") {
		var pos1 = theDate.indexOf(delim)
		if (pos1 == -1) return null;
		year = theDate.substring(0, pos1)
		var pos2 = theDate.lastIndexOf(delim)
		if (pos2 == pos1) return null;
		month = theDate.substring(pos1+1, pos2)
		day = theDate.substring(pos2+1, theDate.length)
	} else if (format == "date5") {
		if (theDate.length != 8) return null;
		month = theDate.substring(0, 2)
		day = theDate.substring(2, 4)
		year = theDate.substring(4, 8)
	} else if (format == "date6") {
		if (theDate.length != 8) return null;
		year = theDate.substring(0, 4)
		month = theDate.substring(4, 6)
		day = theDate.substring(6, 8)
	} else if (format == "date7") {
		if (theDate.length != 6) return null;
		month = theDate.substring(0, 2)
		day = theDate.substring(2, 4)
		year = theDate.substring(4, 6)
		isYear = DotJ_isShortYear(year);
	}
	if (isYear == null) isYear = DotJ_isYear(year);
	if (!(isYear && DotJ_isMonth(month) && DotJ_isDay(day))) return null;
	var intYear = parseInt(year,10);
	if (intYear < 45) {
		intYear = 2000 + intYear;
	} else if (intYear < 100) {
		intYear = 1900 + intYear;
	}
	var intMonth = parseInt(month,10);
	var intDay = parseInt(day,10);
	if (intDay > DotJ_daysInMonth[intMonth-1]) return null;
	if ((intMonth == 2) && (intDay > DotJ_daysInFebruary(intYear))) return null;
	return new Date(intYear, intMonth-1, intDay);
}

function DotJ_countSelects() {
	var count = 0, form, iForm = 0, iElement = 0;
	var forms = document.forms;

	for (iForm = 0; iForm < forms.length; iForm++) {
		form = forms[iForm];

		for (iElement = 0; iElement < form.elements.length; iElement++) {
			if (form.elements[iElement].tagName.toLowerCase() == 'select') {
				count++;
			}
		}
	}

	return count;
}

function DotJ_makeNewURL(url, param, newValue, oldValue) {
	var baseURL = url;
	var queryString = null;

	if (url != null) {
		var pos = url.indexOf('?');
		if (pos != -1) {
			baseURL = url.substring(0, pos);
			queryString = url.substring(pos + 1);
		}

		return baseURL + "?" + DotJ_makeNewQueryString(queryString, param, newValue, oldValue);
	} else {
		return url;
	}
}

function DotJ_makeNewQueryString(queryString, param, newValue, oldValue) {
	var newQueryString = null;

	if (queryString == null || queryString.length == 0) {
		newQueryString = param + "=" + newValue;
	} else {
		var temp = param + "=";
		if (queryString.substring(temp.length) == temp) {
			newQueryString = queryString.replace(param + "=" + oldValue, param + "=" + newValue);
		} else if (queryString.indexOf("&" + param + "=") != -1) {
			newQueryString = queryString.replace("&" + param + "=" + oldValue,
												 "&" + param + "=" + newValue);
		} else {
			newQueryString = queryString + "&" + param + "=" + newValue;
		}
	}

	return newQueryString;
}

//*********  SELECT MOVER FUNCTIONS ***********

function DotJ_moveOptions(srcList, destList, sortBy, moveAll) {
	if ((srcList.selectedIndex == -1) && (moveAll == false)) {
		return;
	}

	var newDestList = new Array(destList.options.length);
	var len = 0;

	for (len = 0; len < destList.options.length; len++) {
		if (destList.options[len] != null) {
			newDestList[len] = new Option(destList.options[len].text, destList.options[len].value, destList.options[len].defaultSelected, destList.options[len].selected);
		}
	}

	for (var i = 0; i < srcList.options.length; i++) {
		if (srcList.options[i] != null && (srcList.options[i].selected == true || moveAll)) {
			newDestList[len] = new Option(srcList.options[i].text, srcList.options[i].value, srcList.options[i].defaultSelected, false);
			len++;
		}
	}

	if (sortBy == 'values')
		newDestList.sort(DotJ_compareOptionValues);
	else if (sortBy == 'text') {
		newDestList.sort(DotJ_compareOptionText);
	}

	for (var j = 0; j < newDestList.length; j++) {
		if (newDestList[j] != null) {
			destList.options[j] = newDestList[j];
		}
	}

	for (var i = srcList.options.length - 1; i >= 0; i--) {
		if (srcList.options[i] != null && (srcList.options[i].selected == true || moveAll)) {
			srcList.options[i] = null;
		}
	}
}

function DotJ_compareOptionValues(a, b) {
	var x = a.value;
	var y = b.value;
	return DotJ_compare(x, y);
}

function DotJ_compareOptionText(a, b) {
	var x = a.text;
	var y = b.text;
	return DotJ_compare(x, y);
}

function DotJ_compare(a, b) {
	var rc;
	var numA = parseFloat(a);
	var numB = parseFloat(b);
	if (isNaN(numA) || isNaN(numB)) {
		if (a > b) {
			rc = 1;
		} else if (a < b) {
			rc = -1;
		} else {
			rc = 0;
		}
	} else {
		rc = (numA - numB);
	}
	//alert('a=' + a + ',b=' + b + ',numA=' + numA + ',numB=' + numB + ',rc=' + rc);
	return rc;
}

function DotJ_moveItem(list, to) {
	var index = list.selectedIndex;
	var total = list.options.length-1;
	if (index == -1) return false;
	if (to == +1 && index == total) return false;
	if (to == -1 && index == 0) return false;
	var items = new Array;
	var values = new Array;
	for (i = total; i >= 0; i--) {
		items[i] = list.options[i].text;
		values[i] = list.options[i].value;
	}
	for (i = total; i >= 0; i--) {
		if (index == i) {
			list.options[i + to] = new Option(items[i],values[i + to], 0, 1);
			list.options[i] = new Option(items[i + to], values[i]);
			i--;
		} else {
			list.options[i] = new Option(items[i], values[i]);
		}
	}
	list.focus();
}

//*********  CALENDAR FUNCTIONS ***********

DotJ_Calendar.render = function() {
	var firstDay = new Date(this.year,this.month-1,1);
	this.computeDaySlots(firstDay);
	this.renderMonth();
	this.renderDays(firstDay);
}

DotJ_Calendar.computeDaySlots = function(firstDay) {
	var lastDay = this.computeLastDay() + firstDay.getDay();
	for (counter = 1; counter <= 42; counter++) {
		if (counter > firstDay.getDay() && counter <= lastDay) {
			this.daySlots[counter] = counter - firstDay.getDay();
		} else {
			this.daySlots[counter] = '';
		}
	}
}

DotJ_Calendar.computeLastDay = function() {
	var lastDay = DotJ_daysInMonth[this.month-1];
	if (this.month == 2) {
		lastDay = DotJ_daysInFebruary(this.year);
	}
	return lastDay;
}

DotJ_Calendar.searchForEvent = function(day) {
	var i = 0;
	if (this.events) {
		for (i = 0; i < this.events.length; i++) {
			if (this.year == this.events[i].date.getFullYear() &&
				this.month == (this.events[i].date.getMonth()+1) &&
				day == this.events[i].date.getDate()) {
				return i;
			}
		}
	}
	return -1;
}

DotJ_Calendar.renderDays = function(firstDay) {
	var clsName, theDay, eventId = -1, html;
	var tempToday = new Date(DotJ_today.getFullYear(), DotJ_today.getMonth(), DotJ_today.getDate());
	for (i = 1; i <= 42; i++) {
		clsName = this.style('Weekday');
		if (this.hiliteToday && this.year == DotJ_today.getFullYear() &&
			(this.month-1) == DotJ_today.getMonth() &&
			(i - firstDay.getDay()) == DotJ_today.getDate()) {
			clsName = this.style('CurrentDay');
		} else if (this.year == this.selectedYear &&
				   (this.month) == this.selectedMonth &&
				   (i - firstDay.getDay()) == this.selectedDay) {
			clsName = this.style('SelectedDay');
		} else {
			if (i == 1 || i == 8 || i == 15 || i == 22 || i == 29 || i == 36)
				clsName = this.style('Weekend');
			if (i == 7 || i == 14 || i == 21 || i == 28 || i == 35 || i == 42)
				clsName = this.style('Weekend');
		}

		html = "";
		eventId = this.searchForEvent((i - firstDay.getDay()));
		if (eventId != -1 && this.mode == 'fixed') {
			clsName = this.style('Event');
			html = html + "<a class='" + clsName + "'";
			if (this.events[eventId].target != null)
				html = html + " target='" + this.events[eventId].target + "'";

			if (this.events[eventId].url != null) {
				var oldValue = DotJ_param_date;
				var tempDate = this.events[eventId].date;
				var newURL = DotJ_makeNewURL(this.events[eventId].url, "date",
											 DotJ_makeDate(tempDate.getFullYear(), tempDate.getMonth()+1, tempDate.getDate(), this.format), oldValue);
				if (this.events[eventId].description != null) {
					oldValue = DotJ_param_description;
					newURL = DotJ_makeNewURL(newURL, "description", escape(this.events[eventId].description), oldValue);
				}
				if (this.events[eventId].key != null) {
					oldValue = DotJ_param_key;
					newURL = DotJ_makeNewURL(newURL, "key", escape(this.events[eventId].key), oldValue);
				}
				html = html + " href='" + newURL + "'";
			}

			if (this.events[eventId].description != null) {
				html = html + " title=" + DotJ_safeJSString(this.events[eventId].description);
			}
			html = html + ">";
		}

		var emptyCell = false;
		if (this.daySlots[i] == '') {
			html = html + "&nbsp;";
			emptyCell = true;
		} else {
			html = html + this.daySlots[i];
		}

		if (eventId != -1 && this.mode == 'fixed')
			html += "</a>";

		var cell = this.getCalTDId(i);
		var objCell = DotJ_getObj(cell);
		DotJ_setText(cell, html);
		objCell.className = clsName;
		if (this.mode == 'fixed') {
			DotJ_setCursorToDefault(objCell);
		} else {
			if (emptyCell)
				DotJ_setCursorToDefault(objCell);
			else
				DotJ_setCursorToPointer(objCell);
		}
	}
}

function DotJ_doPrev(cal,unit) {
	if (unit == 'm') cal.decMonth();
	else cal.decYear();
	cal.render();
}

function DotJ_gotoToday(cal) {
	cal.selectedYear = DotJ_today.getFullYear();
	cal.year = DotJ_today.getFullYear();
	cal.selectedMonth = DotJ_today.getMonth() + 1;
	cal.month = DotJ_today.getMonth() + 1;
	cal.selectedDay = DotJ_today.getDate();
	cal.day = DotJ_today.getDate();
	cal.render();
}

function DotJ_doNext(cal,unit) {
	if (unit == 'm') cal.incMonth();
	else cal.incYear();
	cal.render();
}

DotJ_Calendar.decMonth = function() {
	this.month -= 1;
	if (this.month <= 0) {
		this.month = 12;
		this.decYear();
	}
}

DotJ_Calendar.incMonth = function() {
	this.month += 1;
	if (this.month >= 13) {
		this.month = 1;
		this.incYear();
	}
}

DotJ_Calendar.decYear = function() {
	this.year -= 1;
}

DotJ_Calendar.incYear = function() {
	this.year += 1;
}

DotJ_Calendar.renderMonth = function() {
	DotJ_setText(this.getCalHdrId(), '&nbsp;' + this.months[this.month] + ' ' + this.year + '&nbsp;');
}

DotJ_Calendar.hide = function() {
	var el = this.div;
	DotJ_hideElement(el);
	this.visible = false;
	if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(el, true);
}

DotJ_Calendar.toggle = function() {
	var el = this.div;

	if (DotJ_getVisibility(el) == "show" || DotJ_getVisibility(el) == "visible") {
		this.hide();
	} else {
		//DotJ_calArray.hide();
		DotJ_displayElement(el);
		this.visible = true;
		if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(el, false);
	}
}

DotJ_Calendar.show = function(field,anchor) {
	var objField = DotJ_findFormField(field);
	if (objField == null && this.label == null) {
		var msg = "dotJ Javascript Error: Cannot locate form field '" + field + "'. \n\nThe item must be under a <form> tag.";
		alert(msg);
		return;
	}

	var inputDate;
	if (this.label == null) {
		inputDate = DotJ_isDate(objField.value, this.format);
	} else {
		var tempDate = DotJ_isDate(this.label.innerHTML, this.format);
		inputDate = (tempDate == null) ? DotJ_today : tempDate;
	}

	if (inputDate != null) {
		this.selectedYear = inputDate.getFullYear();
		this.year = inputDate.getFullYear();
		this.selectedMonth = inputDate.getMonth() + 1;
		this.month = inputDate.getMonth() + 1;
		this.selectedDay = inputDate.getDate();
		this.day = inputDate.getDate();
	}

	var calWidth = DotJ_getWidth(this.div);
	var calHeight = DotJ_getHeight(this.div);

	var objAnchor = DotJ_findAnchorItem(anchor);
	var x=0, y=0;
	if (objAnchor != null && objAnchor.tagName.toLowerCase() == 'a') {
		var c = DotJ_getAnchorPosition(objAnchor, objAnchor.id);
		var x1 = DotJ_getX(this.label);
		var y1 = DotJ_getY(this.label);
		x = (DotJ_is_ie4up) ? x1 : c.x;  // Bug in IE?
		y = (DotJ_is_ie4up) ? y1 : c.y;  // Bug in IE?
		var anchorHeight = DotJ_getHeight(objAnchor);
		var margin = (1 * anchorHeight / 3);
		y = DotJ_getSmartY(y, anchorHeight, calHeight, margin);
	} else {
		var anchorHeight = DotJ_getHeight(objAnchor);
		var margin = (1 * anchorHeight / 3);
//  x = DotJ_getSmartX(DotJ_getX(objAnchor), objAnchor.width, calWidth, margin);
		x = DotJ_getX(objAnchor)
		y = DotJ_getSmartY(DotJ_getY(objAnchor), anchorHeight, calHeight, margin);
	}

	DotJ_moveTo(this.div, x, y);
	this.render();
	this.toggle();
}

DotJ_Calendar.selectDay = function(cellId,field,fmt) {
	var cell = DotJ_getObj(cellId);
	var day = cell.innerHTML;
	if (DotJ_isPositiveInteger(day) == false) return;
	if (this.label == null) {
		var objField = DotJ_findFormField(field);
		objField.value = DotJ_makeDate(this.year, this.month, day, fmt);
		if (typeof(objField.onchange) == 'function') {
			objField.onchange();
		}
	} else {
		var selDate = DotJ_makeDate(this.year, this.month, day, fmt);
		this.label.innerHTML = selDate;
		if (this.labelId != '') {
			var objLbl = DotJ_findFormField(this.labelId);
			if (objLbl != null) objLbl.value = selDate;
		}
	}
	this.selectedYear = this.year;
	this.selectedMonth = this.month;
	this.selectedDay = day;
	this.toggle();
}

DotJ_Calendar.getCalId = function() {
	return "DotJ_" + this.id;
}

DotJ_Calendar.getCalHdrId = function() {
	return this.getCalId() + "_hdr";
}

DotJ_Calendar.getCalTDId = function(day) {
	return this.getCalId() + "_TD_" + day;
}

DotJ_Calendar.style = function(styleName) {
	return this.stylePrefix + styleName;
}

function DotJ_isACalImage(img) {
	var calFound = false;
	var parent = img.offsetParent;
	if (parent != null && DotJ_calArray.get(parent.id) != null) calFound = true;

	while (null != parent) {
		parent = parent.offsetParent;
		if (parent != null && DotJ_calArray.get(parent.id) != null) calFound = true;
	}
	return calFound;
}

DotJ_CalArray.hide = function() {
	for (var i = 0; i < this.cals.length; i++) {
		this.cals[i].hide();
	}
}

function DotJ_Calendar(id, format, mode, year, month, selectedDay, hiliteToday, stylePrefix, label, labelId) {
	this.id = id;
	this.div = DotJ_getObj(id);
	this.format = format;
	this.mode = mode;
	this.year = year;
	this.month = month;
	this.selectedYear = year;
	this.selectedMonth = month;
	this.selectedDay = selectedDay;
	this.hiliteToday = hiliteToday;
	this.events = null;
	this.months = null;
	this.daySlots = null;
	this.visible = false;
	this.stylePrefix = stylePrefix;
	this.label = label;
	this.labelId = labelId;

	this.style = DotJ_Calendar.style;
	this.render = DotJ_Calendar.render;
	this.renderMonth = DotJ_Calendar.renderMonth;
	this.renderDays = DotJ_Calendar.renderDays;
	this.computeDaySlots = DotJ_Calendar.computeDaySlots;
	this.computeLastDay = DotJ_Calendar.computeLastDay;
	this.searchForEvent = DotJ_Calendar.searchForEvent;
	this.decMonth = DotJ_Calendar.decMonth;
	this.incMonth = DotJ_Calendar.incMonth;
	this.decYear = DotJ_Calendar.decYear;
	this.incYear = DotJ_Calendar.incYear;
	this.hide = DotJ_Calendar.hide;
	this.show = DotJ_Calendar.show;
	this.toggle = DotJ_Calendar.toggle;
	this.selectDay = DotJ_Calendar.selectDay;
	this.getCalId = DotJ_Calendar.getCalId;
	this.getCalHdrId = DotJ_Calendar.getCalHdrId;
	this.getCalTDId = DotJ_Calendar.getCalTDId;
}

function DotJ_Event(date, target, url, description, key) {
	this.date = date;
	this.target = target;
	this.url = url;
	this.description = description;
	this.key = key;
}

DotJ_CalArray.add = function (objCal){
	this.cals.push(objCal);
}

DotJ_CalArray.get = function(name) {
	for (var i = 0; i < this.cals.length; i++) {
		if (this.cals[i].name == name) {
			return this.cals[i];
		}
	}

	return null;
}

DotJ_CalArray.clear = function() {
	while (this.cals.length > 0) {
		this.cals.pop();
	}
}

function DotJ_CalArray(){
	this.cals = new Array();

	this.add = DotJ_CalArray.add;
	this.get = DotJ_CalArray.get;
	this.clear = DotJ_CalArray.clear;
	this.hide = DotJ_CalArray.hide;
}

var DotJ_calArray = null;
if (DotJ_calArray == null){
	DotJ_calArray = new DotJ_CalArray();
}

//******************************   STATE MANAGER   *******************************

DotJ_StateMgr.queueSetting = function(id,property,value,obj) {
	var change,i=0,found=false;

	while (i < this.changes.length) {
		change = this.changes[i];
		if (change != null && change.id == id && change.property == property) {
			found = true;
			break;
		}
		i++;
	}

	if (!found) {
		change = new DotJ_Setting(id, property, value, obj);
		this.changes[this.changes.length] = change;
		//alert('Queued setting for id ' + id + ', ' + property + '=[' + value + ']');
	}
}

DotJ_StateMgr.restoreSettings = function(id) {
	if (this.changes == null) return;

	var change, i = this.changes.length - 1, changeCount = 0;

	while (i >= 0) {
		change = this.changes[i];
		if (change != null && change.id == id) {
			s = 'change.obj.' + change.property + ' = "' + change.value + '"';
			eval(s);
//			alert('Restored setting for id ' + id + ': ' + s);
			this.changes[i] = null;
			changeCount++;
		}
		i--;
	}
	//alert('old length=' + this.changes.length + ', new length=' + (this.changes.length - changeCount));
	//this.changes.length = this.changes.length - changeCount;
}

DotJ_StateMgr.restoreAllSettings = function() {
	if (this.changes == null) return;

	var change, i = this.changes.length - 1;

	while (i >= 0) {
		change = this.changes[i];
		if (change != null) {
			s = 'change.obj.' + change.property + ' = "' + change.value + '"';
			eval(s);
			this.changes[i] = null;
		}
		i--;
	}
	this.changes.length = 0;
}

DotJ_StateMgr.alert = function() {
	var change,i=0;
	var s = '';

	while (i < this.changes.length) {
		change = this.changes[i];
		if (change == null)
			s = s + 'null\n';
		else
			s = s + 'id=' + change.id + ', property=' + change.property + ', value=' + change.value + '\n';
		i++;
	}
	alert('Current Queued settings:\n-------------------------------------\n' + s)
}

function DotJ_StateMgr() {
	this.changes = new Array();

	this.queueSetting = DotJ_StateMgr.queueSetting;
	this.restoreSettings = DotJ_StateMgr.restoreSettings;
	this.restoreAllSettings = DotJ_StateMgr.restoreAllSettings;
	this.alert = DotJ_StateMgr.alert;
}

var DotJ_stateMgr = null;
if (DotJ_stateMgr == null){
	DotJ_stateMgr = new DotJ_StateMgr();
}

//******************************   DRAG N DROP   *******************************

DotJ_DragNDrop.saveCursor = function() {
	if (this.handleObj) this.cursor = this.handleObj.style.cursor;
}

DotJ_DragNDrop.restoreCursor = function() {
	if (this.handleObj) this.handleObj.style.cursor = this.cursor;
}

function DotJ_DragNDrop(obj, handleObj) {
	this.obj = obj;
	this.handleObj = handleObj;
	this.handleObj.obj = obj;
	this.zOrder = 1000;
	this.obj.root = obj.id;
	this.obj.dnd = this;

	this.saveCursor = DotJ_DragNDrop.saveCursor;
	this.restoreCursor = DotJ_DragNDrop.restoreCursor;

	DotJ_bindEvent(handleObj, "onmouseover", DotJ_showMoveCursor);
	DotJ_bindEvent(handleObj, "onmouseout", DotJ_hideMoveCursor);
	DotJ_bindEvent(handleObj, "onmousedown", DotJ_startDrag);
}

var DotJ_DND = null;

function DotJ_startDrag(e) {
	var obj = null;
	e = e ? e : window.event;
	e.el = e.srcElement ? e.srcElement : e.target;
	if (e.el.nodeType && e.el.nodeType == 3) e.el = e.el.parentNode;
	if (this.root) {
		obj = this;
	} else {
		while (!e.el.root)
			e.el = e.el.parentNode;
		obj = e.el;
	}

	DotJ_DND = obj.dnd;

	if (!e.preventDefault) e.preventDefault = function () { return false; }
	if (!e.stopPropogation) e.stopPropogation = function () { if (window.event) window.event.cancelBubble = true; }

	obj.style.zIndex = obj.dnd.zOrder++;
	obj.dnd.saveCursor();
	DotJ_setCursorToMove(obj.dnd.handleObj);
	obj.dnd.anchorX = e.clientX;
	obj.dnd.anchorY = e.clientY;
	obj.dnd.beginX = parseInt(obj.style.left,10);
	obj.dnd.beginY = parseInt(obj.style.top,10);

	DotJ_bindEvent(document, "onmousemove", DotJ_doDrag);
	DotJ_bindEvent(document, "onmouseup", DotJ_endDrag);

	e.preventDefault();
}
function DotJ_showMoveCursor(e) {
	e = e ? e : window.event;
	var obj = e.srcElement ? e.srcElement : e.target;
	DotJ_setCursorToMove(obj);
}
function DotJ_hideMoveCursor(e) {
	e = e ? e : window.event;
	var obj = e.srcElement ? e.srcElement : e.target;
	DotJ_setCursorToDefault(obj);
}
function DotJ_doDrag(e) {
	e = e ? e : window.event;
	if (DotJ_DND) {
		var obj = DotJ_DND.obj;

		var newX = obj.dnd.beginX + e.clientX - obj.dnd.anchorX;
		var newY = obj.dnd.beginY + e.clientY - obj.dnd.anchorY;
		if (newY > 0) {
			DotJ_moveTo(obj,newX,newY);
		}
		return false;
	} else {
		return true;
	}
}
function DotJ_endDrag(e) {
	e = e ? e : window.event;
	if (DotJ_DND) {
		var obj = DotJ_DND.obj;

		obj.dnd.restoreCursor();
		DotJ_DND = null;
		DotJ_unbindEvent(document, "onmousemove", DotJ_doDrag);
		DotJ_unbindEvent(document, "onmouseup", DotJ_endDrag);
		if (DotJ_is_ie4up) DotJ_hiddenSelects.checkOverlappingSelects(obj.dnd.obj, false);
		if (!obj) return;
	}
}

function DotJ_displayTab(tabArray, tabName) {
	for (i = 0; i < tabArray.length; i++) {
		DotJ_getObj(tabArray[i]).style.display = (tabArray[i] == tabName) ? '':'none';
	}

	return false;
}

//*********  HIDDEN_SELECTS FUNCTIONS ***********

DotJ_HiddenSelects.init = function() {
	this.selects = new Array();

	var form, iForm = 0, iElement = 0;
	var forms = document.forms;

	for (iForm = 0; iForm < forms.length; iForm++) {
		form = forms[iForm];

		for (iElement = 0; iElement < form.elements.length; iElement++) {
			if (form.elements[iElement].tagName.toLowerCase() == 'select') {
				var selectInfo = new DotJ_SelectInfo(form.elements[iElement]);
				this.selects[this.selects.length] = selectInfo;
			}
		}
	}
}

DotJ_HiddenSelects.trackElement = function(objSelect, el, hidingSelect) {
	for (i = 0; i < this.selects.length; i++) {
		if (objSelect == this.selects[i].objSelect) {
			this.selects[i].trackElement(el, hidingSelect);
			//alert('DECIDING NUMELEMENTS: select.name=' + objSelect.name + ',numElements=' + this.selects[i].size());
			if (this.selects[i].size() == 0) {
				DotJ_displayElement(objSelect);
			} else {
				DotJ_hideElement(objSelect);
			}
			return;
		}
	}
}

DotJ_HiddenSelects.checkOverlappingSelects = function (div, hidingElement) {
	if (this.selects == null) return;
	var oLeft = DotJ_getX(div) - 0;
	var oRight = oLeft + DotJ_getWidth(div) + 0;
	var oTop = DotJ_getY(div) - 0;
	var oBottom = oTop + DotJ_getHeight(div) + 0;
	var sLeft, sRight, sTop, sBottom;

	var iSelect = 0, objSelectInfo;

	for (iSelect = 0; iSelect < this.selects.length; iSelect++) {
		objSelectInfo = this.selects[iSelect];
		var select = objSelectInfo.objSelect;
		sLeft = DotJ_getX(select);
		sRight = sLeft + DotJ_getWidth(select);
		sTop = DotJ_getY(select);
		sBottom = sTop + DotJ_getHeight(select);

		if (sRight <= oLeft) {           // select is to the left
//alert('SELECT IS TO LEFT: div.name=' + div.id + ', select.name=' + select.name + '\n' + '   div.left=' + oLeft + '\n   div.top=' + oTop + '\n   div.right=' +
//       oRight + '\n   div.bottom=' + oBottom + '\n\n   select.left=' + sLeft + '\n   select.top=' + sTop + '\n   select.right=' + sRight +
//       '\n   select.bottom=' + sBottom);
			DotJ_hiddenSelects.trackElement(select, div, false);
		} else if (sLeft >= oRight) {    // select is to the right
//alert('SELECT IS TO RIGHT: div.name=' + div.id + ', select.name=' + select.name + '\n' + '   div.left=' + oLeft + '\n   div.top=' + oTop + '\n   div.right=' +
//       oRight + '\n   div.bottom=' + oBottom + '\n\n   select.left=' + sLeft + '\n   select.top=' + sTop + '\n   select.right=' + sRight +
//       '\n   select.bottom=' + sBottom);
			DotJ_hiddenSelects.trackElement(select, div, false);
		} else if (sBottom <= oTop) {    // select is above
//alert('SELECT IS ABOVE: div.name=' + div.id + ', select.name=' + select.name + '\n' + '   div.left=' + oLeft + '\n   div.top=' + oTop + '\n   div.right=' +
//       oRight + '\n   div.bottom=' + oBottom + '\n\n   select.left=' + sLeft + '\n   select.top=' + sTop + '\n   select.right=' + sRight +
//       '\n   select.bottom=' + sBottom);
			DotJ_hiddenSelects.trackElement(select, div, false);
		} else if (sTop >= oBottom) {    // select is under
//alert('SELECT IS UNDER: div.name=' + div.id + ', select.name=' + select.name + '\n' + '   div.left=' + oLeft + '\n   div.top=' + oTop + '\n   div.right=' +
//       oRight + '\n   div.bottom=' + oBottom + '\n\n   select.left=' + sLeft + '\n   select.top=' + sTop + '\n   select.right=' + sRight +
//       '\n   select.bottom=' + sBottom);
			DotJ_hiddenSelects.trackElement(select, div, false);
		} else {
//alert('ELSE: div.name=' + div.id + ', select.name=' + select.name + '\n' + '   div.left=' + oLeft + '\n   div.top=' + oTop + '\n   div.right=' +
//       oRight + '\n   div.bottom=' + oBottom + '\n\n   select.left=' + sLeft + '\n   select.top=' + sTop + '\n   select.right=' + sRight +
//       '\n   select.bottom=' + sBottom);
			DotJ_hiddenSelects.trackElement(select, div, !hidingElement);
		}
	}
}

function DotJ_HiddenSelects() {
	this.selects = null;

	this.init = DotJ_HiddenSelects.init;
	this.checkOverlappingSelects = DotJ_HiddenSelects.checkOverlappingSelects;
	this.trackElement = DotJ_HiddenSelects.trackElement;
}

var DotJ_hiddenSelects = null;
if (DotJ_hiddenSelects == null){
	DotJ_hiddenSelects = new DotJ_HiddenSelects();
}
func = "DotJ_hiddenSelects.init()";
DotJ_stackJavaScriptEvent(document.body, 'onload', func);

DotJ_SelectInfo.trackElement = function (el, hidingSelect) {
	var i, found = false;

	for (i = 0; i < this.overlayedElements.length; i++) {
		if (this.overlayedElements[i] == el) {
			found = true;
			if (hidingSelect == false) {
				this.overlayedElements[i] = null;
			}
		}
	}

	if (!found && hidingSelect) {
		this.overlayedElements[this.overlayedElements.length] = el;
	}
//	alert('NUMELEMENTS: select.name=' + this.objSelect.name + ', numElements=' + this.size());
}

DotJ_SelectInfo.size = function () {
	var i, count = 0;

	for (i = 0; i < this.overlayedElements.length; i++) {
		if (this.overlayedElements[i] != null) count++;
	}

	return count;
}

function DotJ_SelectInfo(objSelect) {
	this.objSelect = objSelect;
	this.overlayedElements = new Array();

	this.trackElement = DotJ_SelectInfo.trackElement;
	this.size = DotJ_SelectInfo.size;
}

function DotJ_logDebug(msg) {
    if (DotJ_LOG) {
        var log = DotJ_getObj('dotJ_log');
        if (log != null) {
            DotJ_setText('dotJ_log', log.innerHTML + "<br>" + msg);
        }
    }
}

function DotJ_clearLog() {
    if (DotJ_LOG) {
        var log = DotJ_getObj('dotJ_log');
        if (log != null) {
            DotJ_setText('dotJ_log', "<b><a href='javascript:DotJ_clearLog()'>Clear</a></b><br>");
        }
    }
}