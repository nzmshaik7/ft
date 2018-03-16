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

  // Connect the popover to its content in a non-visible div.
  //
  $('#vr1id').popover({ 
    html : true, content: function() { return $('#vr1id_div').html(); }
  });
  $('#vr2id').popover({ 
    html : true, content: function() { return $('#vr2id_div').html(); }
  });
  $('#vr3id').popover({ 
    html : true, content: function() { return $('#vr3id_div').html(); }
  });
  $('#vr4id').popover({ 
    html : true, content: function() { return $('#vr4id_div').html(); }
  });
  $('#vr5id').popover({ 
    html : true, content: function() { return $('#vr5id_div').html(); }
  });
  $('#vr6id').popover({ 
    html : true, content: function() { return $('#vr6id_div').html(); }
  });
  $('#cust1id').popover({ 
    html : true, content: function() { return $('#cust1id_div').html(); }
  });
  $('#cust2id').popover({ 
    html : true, content: function() { return $('#cust2id_div').html(); }
  });
  $('#cust3id').popover({ 
    html : true, content: function() { return $('#cust3id_div').html(); }
  });
  $('#cust4id').popover({ 
    html : true, content: function() { return $('#cust4id_div').html(); }
  });
  $('#cust5id').popover({ 
    html : true, content: function() { return $('#cust5id_div').html(); }
  });
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
