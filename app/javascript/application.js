// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "flatpickr/dist/l10n/ja.js"
import { initSortable } from "./initSortable"
import "trix"
import "@rails/actiontext"

if (!window.__appClientLoaded) {
  window.__appClientLoaded = true;
  require("@hotwired/turbo-rails");
}

document.addEventListener("DOMContentLoaded", function () {
  // window.addEventListener('scroll', function () {
  //   if (window.scrollY > 10) {
  //     document.getElementById('navbar_top').classList.add('fixed-top');
  //     // add padding top to show content behind navbar
  //     navbar_height = document.querySelector('.navbar').offsetHeight;
  //     document.body.style.paddingTop = navbar_height + 'px';
  //   } else {
  //     document.getElementById('navbar_top').classList.remove('fixed-top');
  //     // remove padding top from body
  //     document.body.style.paddingTop = '0';
  //   }
  // });
});

document.addEventListener("turbo:load", function () {
  tooltip();

  const seriesElement = document.getElementById("series");
  if (seriesElement) {
    initSortable(seriesElement);
  }

  var wid = window.innerWidth;

  $('.slider').slick({
    centerMode: false,
    slidesToShow: 1,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 3000,
    speed: 700,
  });

  if (wid >= 1010) {
    $('.top-banner-slider').slick({
      centerMode: true,
      slidesToShow: 2,
      arrows: false,
      autoplay: false,
      autoplaySpeed: 3000,
      adaptiveHeight: true,
      speed: 700,
    });
  } else {
    $('.top-banner-slider').slick({
      centerMode: true,
      slidesToShow: 1,
      arrows: false,
      autoplay: true,
      autoplaySpeed: 3000,
      adaptiveHeight: true,
      speed: 700,
    });
  }


  if (wid >= 679) {
    $('.top-series-slider').slick({
      centerMode: false,
      slidesToShow: 2,
      arrows: false,
      autoplay: true,
      autoplaySpeed: 3000,
      adaptiveHeight: true,
      speed: 700,
    });
  } else {
    $('.top-series-slider').slick({
      centerMode: false,
      slidesToShow: 1,
      arrows: false,
      autoplay: false,
      autoplaySpeed: 1500,
      adaptiveHeight: true,
      speed: 700,
    });
  }

});

function tooltip() {
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
  const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
}

Trix.config.blockAttributes.heading2 = {
  tagName: 'h2',
  terminal: true,
  breakOnReturn: true,
  group: false
}

Trix.config.toolbar.getDefaultHTML = function() {
  return `
    <div class="trix-button-row">
      <span class="trix-button-group trix-button-group--text-tools" data-trix-button-group="text-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-bold" data-trix-attribute="bold" data-trix-key="b" title="#{lang.bold}" tabindex="-1">#{lang.bold}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-italic" data-trix-attribute="italic" data-trix-key="i" title="#{lang.italic}" tabindex="-1">#{lang.italic}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-strike" data-trix-attribute="strike" title="#{lang.strike}" tabindex="-1">#{lang.strike}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="#{lang.link}" tabindex="-1">#{lang.link}</button>
      </span>
      <span class="trix-button-group trix-button-group--block-tools" data-trix-button-group="block-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-heading-1" data-trix-attribute="heading2" title="#{lang.heading2}" tabindex="-1">#{lang.heading2}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-quote" data-trix-attribute="quote" title="#{lang.quote}" tabindex="-1">#{lang.quote}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-code" data-trix-attribute="code" title="#{lang.code}" tabindex="-1">#{lang.code}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-bullet-list" data-trix-attribute="bullet" title="#{lang.bullets}" tabindex="-1">#{lang.bullets}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-number-list" data-trix-attribute="number" title="#{lang.numbers}" tabindex="-1">#{lang.numbers}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-decrease-nesting-level" data-trix-action="decreaseNestingLevel" title="#{lang.outdent}" tabindex="-1">#{lang.outdent}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-increase-nesting-level" data-trix-action="increaseNestingLevel" title="#{lang.indent}" tabindex="-1">#{lang.indent}</button>
      </span>
      <span class="trix-button-group trix-button-group--file-tools" data-trix-button-group="file-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-attach" data-trix-action="attachFiles" title="#{lang.attachFiles}" tabindex="-1">#{lang.attachFiles}</button>
      </span>
      <span class="trix-button-group-spacer"></span>
      <span class="trix-button-group trix-button-group--history-tools" data-trix-button-group="history-tools">
        <button type="button" class="trix-button trix-button--icon trix-button--icon-undo" data-trix-action="undo" data-trix-key="z" title="#{lang.undo}" tabindex="-1">#{lang.undo}</button>
        <button type="button" class="trix-button trix-button--icon trix-button--icon-redo" data-trix-action="redo" data-trix-key="shift+z" title="#{lang.redo}" tabindex="-1">#{lang.redo}</button>
      </span>
    </div>
    <div class="trix-dialogs" data-trix-dialogs>
      <div class="trix-dialog trix-dialog--link" data-trix-dialog="href" data-trix-dialog-attribute="href">
        <div class="trix-dialog__link-fields">
          <input type="url" name="href" class="trix-input trix-input--dialog" placeholder="#{lang.urlPlaceholder}" aria-label="#{lang.url}" required data-trix-input>
          <div class="trix-button-group">
            <input type="button" class="trix-button trix-button--dialog" value="#{lang.link}" data-trix-method="setAttribute">
            <input type="button" class="trix-button trix-button--dialog" value="#{lang.unlink}" data-trix-method="removeAttribute">
          </div>
        </div>
      </div>
    </div>
  `
}
