// app/javascript/components/banner.js
import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Choose your construction trash!","aa"],
    typeSpeed: 70,
    loop: true
  });
}

export { loadDynamicBannerText };
