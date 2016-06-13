<script type="text/javascript">
   function show_stripe_button() {
      console.log( "#stripe_button show" );
      $("#stripe_button").show();   
 }
    setTimeout(function() {
      $('.stripe-button-el:first').click(function() {
      console.log( "month_plan" );
      $('#user_plan_id').val("month-plan");
      });
      $('.stripe-button-el:last').click(function() {
      console.log( "year_plan" );
      $('#user_plan_id').val("day-plan");
      });
    }, 3000);
    $('#new_user').css({
    'width': '70%',
    'display': 'block',
    'float': 'left',
});
</script>
