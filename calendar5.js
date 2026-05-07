// Title: Tigra Calendar
// Description: See the demo at url
// URL: https://www.softcomplex.com/products/tigra_calendar/
// Version: 2.0 (Date only with year scrolling)
// Date: 06-04-2002 (mm-dd-yyyy)
// Author: Denis Gritcyuk <denis@softcomplex.com>
// Notes: Permission given to use this script in ANY kind of applications if
//    header lines are left unchanged.
// About us: Our company provides offshore IT consulting services.
//    Contact us at sales@softcomplex.com if you have any programming task you
//    want to be handled by professionals. Our typical hourly rate is $20.

// d.getMonth()
// d.getDate()
// d.getFullYear()


// months as they appear in the calendar's title
var ARR_MONTHS = ["January", "February", "March", "April", "May", "June",
		"July", "August", "September", "October", "November", "December"];
// week day titles as they appear on the calendar
var ARR_WEEKDAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
// day week starts from (normally 0-Mo or 1-Su)
var NUM_WEEKSTART = 1;
// path to the directory where calendar images are stored. trailing slash req.
/*
var STR_ICONPATH = 'img/';
*/

var STR_ICONPATH = '';


/*
var STR_ICONPATH = 'https://lawdept1-dev.usps.gov/WebStaffDir/Admin/';
*/

// if two digit year input dates after this year considered 20 century.
var NUM_CENTYEAR = 30;

var calendars = [];

function calendar5(obj_target) {

	//alert("Calendar 5 Method");

	// assigning methods
	this.gen_date = cal_gen_date5;
	this.prs_date = cal_prs_date5;
	this.popup    = cal_popup5;

	// validate input parameters
	if (!obj_target)
    return alert("Error calling the calendar: no target control specified");
	if (obj_target.value == null)
		return alert("Error calling the calendar: parameter specified is not valid target control");
	this.target = obj_target;

	// register in global collections
	this.id = calendars.length;
	calendars[this.id] = this;
}

function cal_popup5 (str_datetime) {

	//alert("Cal Popup 5 Method");
	this.dt_current = this.prs_date(str_datetime ? str_datetime : this.target.value);
	if (!this.dt_current) return alert("Unknown datetime format: '" + str_datetime + "'.");

	var dCurrentDate = this.dt_current;

	var dToday=new Date;

  	//alert(dToday);
	//alert(new Date(2003, 9, 8, 12, 0, 0, 0));

  // get same date in the previous year
	var dt_prev_year = new Date(this.dt_current);
	dt_prev_year.setFullYear(dt_prev_year.getFullYear() - 1);
	if (dt_prev_year.getDate() != this.dt_current.getDate())
		dt_prev_year.setDate(0);

	// get same date in the next year
	var dt_next_year = new Date(this.dt_current);
	dt_next_year.setFullYear(dt_next_year.getFullYear() + 1);
	if (dt_next_year.getDate() != this.dt_current.getDate())
		dt_next_year.setDate(0);

	// get same date in the previous month
	var dt_prev_month = new Date(this.dt_current);
	dt_prev_month.setMonth(dt_prev_month.getMonth() - 1);
	if (dt_prev_month.getDate() != this.dt_current.getDate())
		dt_prev_month.setDate(0);

	// get same date in the next month
	var dt_next_month = new Date(this.dt_current);
	dt_next_month.setMonth(dt_next_month.getMonth() + 1);
	if (dt_next_month.getDate() != this.dt_current.getDate())
		dt_next_month.setDate(0);

	// get first day to display in the grid for current month
	var dt_firstday = new Date(this.dt_current);
	dt_firstday.setDate(1);
	dt_firstday.setDate(1 - (7 + dt_firstday.getDay() - NUM_WEEKSTART) % 7);

	// html generation (feel free to tune it for your particular application)
	// print calendar header
	//var obj_calwindow = window.open("", "Calendar",
	//	"width=210,height=200,status=no,resizable=no,top=200,left=200");
	var obj_calwindow = window.open("", "Calendar",
    "width=235,height=235,status=no,resizable=no");
	obj_calwindow.opener = window;

  var str_buffer2 = new String (
	'<html>'+
	'<head>'+
		'<title>Select Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>'+
		'<script language="JavaScript">'+
		'function set_datetime(n_datetime, b_close) {'+
			'var obj_calendar = window.opener.calendars['+this.id+'];'+
			'obj_calendar.target.value = obj_calendar.gen_date(new Date(n_datetime));'+
			'if (b_close) window.close();'+
			'else obj_calendar.popup(n_datetime);'+
		'}'+
    'function set_newMonth(nYear, nMonth, nDay, b_close) {'+
			'var nAdjMonth = eval(nMonth)+1;'+
			'var obj_calendar = window.opener.calendars['+this.id+'];'+
      		'obj_calendar.target.value = obj_calendar.gen_date(new Date(nYear,nMonth,nDay,0,0,0,0));'+
			'if (b_close) window.close();'+
			'else obj_calendar.popup(nAdjMonth+"/"+nDay+"/"+nYear);'+
		 '}'+
		'</script>'+
	'</head>'+
	'<body bgcolor="White">'+
	'<table class="clsOTable" cellspacing="0" border="0" width="100%">'+
	'<tr><td bgcolor="#4682B4">'+
	'<table cellspacing="1" cellpadding="3" border="0" width="100%">'+
	'<tr>'+
    '<td bgcolor="#4682B4" colspan="4">'+
    '<select name="months" onChange="javascript:set_newMonth('+dCurrentDate.getFullYear()+',this.options[this.selectedIndex].value,'+dCurrentDate.getDate()+')">')

  obj_calwindow.document.write(str_buffer2);

   if (dCurrentDate.getMonth() == 0)
      obj_calwindow.document.write('<option value="0" selected >January</option>');
  else
      obj_calwindow.document.write('<option value="0">January</option>');
   if (dCurrentDate.getMonth() == 1)
      obj_calwindow.document.write('<option value="1" selected >February</option>');
  else
      obj_calwindow.document.write('<option value="1">February</option>');
   if (dCurrentDate.getMonth() == 2)
      obj_calwindow.document.write('<option value="2" selected >March</option>');
  else
      obj_calwindow.document.write('<option value="2">March</option>');

   if (dCurrentDate.getMonth() == 3)
      obj_calwindow.document.write('<option value="3" selected >April</option>');
  else
      obj_calwindow.document.write('<option value="3">April</option>');

   if (dCurrentDate.getMonth() == 4)
      obj_calwindow.document.write('<option value="4" selected >May</option>');
  else
      obj_calwindow.document.write('<option value="4">May</option>');

   if (dCurrentDate.getMonth() == 5)
      obj_calwindow.document.write('<option value="5" selected >June</option>');
  else
      obj_calwindow.document.write('<option value="5">June</option>');

   if (dCurrentDate.getMonth() == 6)
      obj_calwindow.document.write('<option value="6" selected >July</option>');
  else
      obj_calwindow.document.write('<option value="6">July</option>');
   if (dCurrentDate.getMonth() == 7)
      obj_calwindow.document.write('<option value="7" selected >August</option>');
  else
      obj_calwindow.document.write('<option value="7">August</option>');
   if (dCurrentDate.getMonth() == 8)
      obj_calwindow.document.write('<option value="8" selected >September</option>');
  else
      obj_calwindow.document.write('<option value="8">September</option>');
   if (dCurrentDate.getMonth() == 9)
      obj_calwindow.document.write('<option value="9" selected >October</option>');
  else
      obj_calwindow.document.write('<option value="9">October</option>');
   if (dCurrentDate.getMonth() == 10)
      obj_calwindow.document.write('<option value="10" selected >November</option>');
  else
      obj_calwindow.document.write('<option value="10">November</option>');
   if (dCurrentDate.getMonth() == 11)
      obj_calwindow.document.write('<option value="11" selected >December</option>');
  else
      obj_calwindow.document.write('<option value="11">December</option>');

var str_buffer3= new String (
    '</select>'+
    '</td>'+
    '<td bgcolor="#4682B4" align="right" colspan="1"><a href="javascript:set_datetime('+dToday.valueOf()+')"><img src="'+STR_ICONPATH+'today.gif" width="16" height="16" border="0" alt="todays date"></a></td>'+
    '<td bgcolor="#4682B4" align="right" colspan="2">'+
    '<select name="years" onChange="javascript:set_newMonth(this.options[this.selectedIndex].value,'+dCurrentDate.getMonth()+','+dCurrentDate.getDate()+')">')
  obj_calwindow.document.write(str_buffer3);

  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()-4)+'>'+eval(dCurrentDate.getFullYear()-4)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()-3)+'>'+eval(dCurrentDate.getFullYear()-3)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()-2)+'>'+eval(dCurrentDate.getFullYear()-2)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()-1)+'>'+eval(dCurrentDate.getFullYear()-1)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear())+' selected >'+eval(dCurrentDate.getFullYear())+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()+1)+'>'+eval(dCurrentDate.getFullYear()+1)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()+2)+'>'+eval(dCurrentDate.getFullYear()+2)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()+3)+'>'+eval(dCurrentDate.getFullYear()+3)+'</option>');
  obj_calwindow.document.write('<option value='+eval(dCurrentDate.getFullYear()+4)+'>'+eval(dCurrentDate.getFullYear()+4)+'</option>');

var str_buffer= new String (
    '</select>'+
  '</td>'+
	'</tr><tr>'+
		'<td bgcolor="#4682B4"><a href="javascript:set_datetime('+dt_prev_year.valueOf()+')"><img src="'+STR_ICONPATH+'prev_year.gif" width="16" height="16" border="0" alt="previous year"></a></td>'+
		'<td bgcolor="#4682B4"><a href="javascript:set_datetime('+dt_prev_month.valueOf()+')"><img src="'+STR_ICONPATH+'prev.gif" width="16" height="16" border="0" alt="previous month"></a></td>'+
		'<td bgcolor="#4682B4" colspan="3" align="center"><font color="white" face="tahoma, verdana" style="font-size: 10px">'+ARR_MONTHS[this.dt_current.getMonth()]+' '+this.dt_current.getFullYear()+'</font></td>'+
		'<td bgcolor="#4682B4" align="right"><a href="javascript:set_datetime('+dt_next_month.valueOf()+')"><img src="'+STR_ICONPATH+'next.gif" width="16" height="16" border="0" alt="next month"></a></td>'+
		'<td bgcolor="#4682B4" align="right"><a href="javascript:set_datetime('+dt_next_year.valueOf()+')"><img src="'+STR_ICONPATH+'next_year.gif" width="16" height="16" border="0" alt="next year"></a></td>'+
  '</tr><tr>');
	var dt_current_day = new Date(dt_firstday);

	// print weekdays titles
	for (var n=0; n<7; n++)
		str_buffer += '<td bgcolor="#87CEFA" align="center"><font color="white" face="tahoma, verdana" size="2">'+ARR_WEEKDAYS[(NUM_WEEKSTART+n)%7]+'</font></td>';
	str_buffer += '</tr>';

	// print calendar table
	var dt_current_day = new Date(dt_firstday);
	while (dt_current_day.getMonth() == this.dt_current.getMonth() ||
		dt_current_day.getMonth() == dt_firstday.getMonth()) {
		// print row heder
		str_buffer += '<tr>';
		for (var n_current_wday=0; n_current_wday<7; n_current_wday++) {
				if (dt_current_day.getDate() == this.dt_current.getDate() &&
					dt_current_day.getMonth() == this.dt_current.getMonth())
					// print current date
					str_buffer += '<td bgcolor="#FFB6C1" align="center">';
				else if (dt_current_day.getDay() == 0 || dt_current_day.getDay() == 6)
					// weekend days
					str_buffer += '<td bgcolor="#DBEAF5" align="center">';
				else
					// print working days of current month
					str_buffer += '<td bgcolor="white" align="center">';

				if (dt_current_day.getMonth() == this.dt_current.getMonth())
					// print days of current month
					str_buffer += '<a href="javascript:set_datetime('+dt_current_day.valueOf()+', true)" style="color: black; font-size: 12px; font-family: tahoma, verdana;">';
				else
					// print days of other months
					str_buffer += '<a href="javascript:set_datetime('+dt_current_day.valueOf()+', true)"style="color: gray; font-size: 12px; font-family: tahoma, verdana;">';

				str_buffer += dt_current_day.getDate()+'</a></td>';
				dt_current_day.setDate(dt_current_day.getDate()+1);
		}
		// print row footer
		str_buffer += '</tr>';
	}
	// print calendar footer
	str_buffer +=
		'</table></tr></td></table></body></html>';

  obj_calwindow.document.write(str_buffer);
	obj_calwindow.document.close();
	obj_calwindow.focus();
}

// datetime generating function
function cal_gen_date5 (dt_datetime) {
  //alert("In Gen Date ["+dt_datetime+"]");
	return (
		new String (
			(dt_datetime.getMonth() < 9 ? '0' : '') + (dt_datetime.getMonth() + 1) + "/"
			+ (dt_datetime.getDate() < 10 ? '0' : '') + dt_datetime.getDate() + "/"
			+ dt_datetime.getFullYear()
		)
	);
}

// datetime parsing function
function cal_prs_date5 (str_datetime) {

	//alert("Calendar Parsing 5 Method");
  //alert("PRS Date ["+str_datetime+"]");
	// if no parameter specified return current timestamp
	if (!str_datetime)
		return (new Date());

	// if positive integer treat as milliseconds from epoch
	var re_num = /^\d+$/;
	if (re_num.exec(str_datetime))
		return (new Date(str_datetime));

	// else treat as date in string format
	var re_date = /^(\d+)\/(\d+)\/(\d+)/;
	if (re_date.exec(str_datetime)) {
	var n_year = Number(RegExp.$3);
	if (n_year < 100)
		n_year += (n_year < NUM_CENTYEAR ? 2000 : 1900);
		return (new Date (n_year, RegExp.$1-1, RegExp.$2));
	}
}


