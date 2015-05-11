$(document).ready(function() {

    $('input[data-checkall-control]').each(function(){
    var $checkAll = $(this);
    var $children = $('input[data-checkall-group="' + $checkAll.data('checkall-control') + '"]');

    $checkAll.on('click', function() {
        if ($checkAll.is(':checked')) {
            $children.prop('checked', true);
        }
        else {
            $children.prop('checked', false);
        }
    });

    $children.on('click', function() {
        if ($children.filter(':checked').length == $children.length) {
            $checkAll.prop('checked', true);
        }
        else {
            $checkAll.prop('checked', false);
        }
    });
});

});