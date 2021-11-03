import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('geo');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
