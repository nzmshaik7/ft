$('document').ready(function() {
  if ($('#expander1').length) {
    $("#expander1").click(function() {
      $("#expander1").css("display", "none");
      $("#expdiv1").css("display", "block");
      $("#collapser1").css("display", "block");
    });
    $("#collapser1").click(function() {
      $("#expander1").css("display", "block");
      $("#expdiv1").css("display", "none");
      $("#collapser1").css("display", "none");
    });
  }
})
