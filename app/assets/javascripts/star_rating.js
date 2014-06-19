window.StarRating = {
  initialize: function (my_restaurant) {

    $(".star").each(function () {
      $(this).raty({
        readOnly: true,
        score: function () {
          return $(this).attr('data-rating');
        },
        path: '/assets'
      });
    });
  }

};