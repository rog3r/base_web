var default_picker_options = {

}

var default_datepicker_options = {
      format: 'DD/MM/YYYY',
    showTodayButton: true,
      keepOpen: false
//    format: 'YYYY-MM-DD',
//    pickTime: false
}

$(document).on('ready page:change', function() {
  $('.datetimepicker').datetimepicker(default_picker_options);

  $('.timepicker').datetimepicker(default_picker_options);

  $('.datepicker').datetimepicker(default_datepicker_options);

  $('.datetimerange').each(function(){
    var $this = $(this)
    var range1 = $($this.find('.input-group')[0])
    var range2 = $($this.find('.input-group')[1])

    if(range1.data("DateTimePicker").date() != null)
      range2.data("DateTimePicker").minDate(range1.data("DateTimePicker").date());

    if(range2.data("DateTimePicker").date() != null)
      range1.data("DateTimePicker").maxDate(range2.data("DateTimePicker").date());

    range1.on("dp.change",function (e) {
      if(e.date)
        range2.data("DateTimePicker").minDate(e.date);
      else
        range2.data("DateTimePicker").minDate(false);
    });

    range2.on("dp.change",function (e) {
      if(e.date)
        range1.data("DateTimePicker").maxDate(e.date);
      else
        range1.data("DateTimePicker").maxDate(false);
    });
  })
});
