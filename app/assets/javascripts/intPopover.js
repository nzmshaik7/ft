$(function () { 
    // enable all popovers on page.
    $("[data-toggle='popover']").popover();

    // Toggle view/hide button.  This allows the popover to be dismissed
    // either by clicking Hide or clicking anywhere.
    //
    $('.show_hide_popover').on('shown.bs.popover', function () {
      // If the popover is show, remove the View button and enable Hide.
      var myId = jQuery(this).attr("id");
      var hideId = '#x' + myId;
      jQuery(this).css("display", "none");
      $(hideId).css("display", "block");
      // alert('shown');
    });
    $('.show_hide_popover').on('hidden.bs.popover', function () {
      // Opposite of the above.
      // var myId = jQuery(this).attr("id");
      // var showId = '#' + myId.substring(1);
      // jQuery(this).css("display", "none");
      // $(showId).css("display", "block");
      var myId = jQuery(this).attr("id");
      var hideId = '#x' + myId;
      jQuery(this).css("display", "block");
      $(hideId).css("display", "none");
    });

});

$(document).ready(function(){

  var jsVisitCount = parseInt($('#jsVisitCount').attr('value'));
  for (var vnum = 1; vnum <= jsVisitCount; vnum++) {
      var vrid = "#vr" + vnum.toString() + "id";
      var vrdiv = "#vr" + vnum.toString() + "id_div";
      // Connect the popover to its content in a non-visible div.
      //DBG alert("attach " + vrid);
      $(vrid).popover({ 
	html : true, content: function() { return $(vrdiv).html(); }
      });
  }

  // The cust1id and cust2id are real.
  $('#cust1id').popover({ 
    html : true, content: function() { return $('#cust1id_div').html(); }
  });
  $('#cust2id').popover({ 
    html : true, content: function() { return $('#cust2id_div').html(); }
  });

  // Mockup placeholders until we get images working.
  $('#vehphot').popover({ 
    html : true, content: function() { return $('#vehphot_div').html(); }
  });
  $('#doorphot').popover({ 
    html : true, content: function() { return $('#doorphot_div').html(); }
  });
  $('#titlphot').popover({ 
    html : true, content: function() { return $('#titlphot_div').html(); }
  });

});
