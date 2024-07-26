// app/javascript/packs/stripe.js
document.addEventListener("DOMContentLoaded", function() {
    var stripe = Stripe(document.querySelector('input[name="stripe_publishable_key"]').value);
    var elements = stripe.elements();
    var card = elements.create('card');
    card.mount('#card-element');
  
    card.addEventListener('change', function(event) {
      var displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });
  
    var form = document.querySelector('#new_order');
    form.addEventListener('submit', function(event) {
      event.preventDefault();
  
      stripe.createToken(card).then(function(result) {
        if (result.error) {
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          stripeTokenHandler(result.token);
        }
      });
    });
  
    function stripeTokenHandler(token) {
      var form = document.querySelector('#new_order');
      var hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'stripeToken');
      hiddenInput.setAttribute('value', token.id);
      form.appendChild(hiddenInput);
  
      form.submit();
    }
  });
  