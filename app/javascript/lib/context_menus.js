import tippy from "tippy.js"

function format_selection_menu() {
  return (`<div style="pointer-events: auto; position: relative; z-index: 0">
    <div style="pointer-events: none; display: flex; width: 100%; opacity: 1;">
      <div style="pointer-events: none; padding: 12px;">
        <div style="display: inline-flex;
        align-items: stretch;
        height: 32px;
        background: white;
        overflow: hidden;
        font-size: 14px;
        line-height: 1.2;
        border-radius: 5px;
        box-shadow: rgb(15 15 15 / 5%) 0px 0px 0px 1px, rgb(15 15 15 / 10%) 0px 3px 6px, rgb(15 15 15 / 20%) 0px 9px 24px;
        pointer-events: auto;">
          <div style="user-select: none; transition: background 20ms ease-in 0s; cursor: pointer; display: flex; align-items: center; padding: 0px 10px; white-space: nowrap; box-shadow: rgb(55 53 47 / 9%) 1px 0px 0px; margin-right: 1px;" data-action="mousedown->change-fragment#h2">
            h2
          </div>
          <div style="user-select: none; transition: background 20ms ease-in 0s; cursor: pointer; display: flex; align-items: center; padding: 0px 10px; white-space: nowrap; box-shadow: rgb(55 53 47 / 9%) 1px 0px 0px; margin-right: 1px;" data-action="mousedown->change-fragment#paragraph">
            本文
          </div>
        </div>
      </div>
    </div>
  </div>`)
}

{/* <div style="user-select: none; transition: background 20ms ease-in 0s; cursor: pointer; display: flex; align-items: center; padding: 0px 10px; white-space: nowrap; box-shadow: rgb(55 53 47 / 9%) 1px 0px 0px; margin-right: 1px;" data-action="mousedown->change-fragment#h1">
h1
</div> */}

// `<div style="pointer-events: auto; position: relative; z-index: 0">
//     <div style="pointer-events: none;
//     position: absolute;
//     top: 365px;
//     left: 0px;
//     display: flex;
//     width: 100%;
//     opacity: 1;">
//       test
//     </div>
//   </div>`

// `
//   <div class="p-1 bg-white" data-controller="format" style="cursor: pointer;">
//     <a class="has-text-white" data-action="mousedown->format#bold">
//       Bold
//     </a>
//     <span class="ml-1 mr-1 has-text-grey">|</span>
//     <a class="has-text-white" data-action="mousedown->format#italic">
//       Italic
//     </a>
//     <span class="ml-1 mr-1 has-text-grey">|</span>
//     <a class="has-text-white" data-action="mousedown->format#strikethrough">
//       Strike
//     </a>
//     <span class="ml-1 mr-1 has-text-grey">|</span>
//     <a class="has-text-white" data-action="mousedown->format#code">
//       Code
//     </a>
//   </div>
//   `

export function show_format_selection_menu(element) {
  console.log(format_selection_menu())
  let box = window.getSelection().getRangeAt(0).getBoundingClientRect()
  return tippy(element, {
    allowHTML: true,
    content: format_selection_menu(),
    interactive: true,
    interactiveBorder: 100,
    inlinePositioning: true,
    // maxWidth: 250,
    getReferenceClientRect: () => box,
    onHidden: (instance) => { instance.destroy() }
  }).show()
}
