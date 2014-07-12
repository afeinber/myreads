$(function () {
  $('#myTab a:last').tab('show')
})

// Example 1: From an element in DOM
$('.open-popup-link').magnificPopup({
  type:'inline',
  midClick: true // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
});

// // Example: 2 Dynamically created
// $('.user_book').magnificPopup({
//   items: {
//       src: '<div class="white-popup">Dynamically created popup</div>',
//       type: 'inline'
//   },
//   closeBtnInside: true
//   midClick: true
// });
