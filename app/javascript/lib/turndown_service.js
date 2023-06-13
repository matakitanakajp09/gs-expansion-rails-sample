import TurnDown from "turndown"

export function turndownService() {
  // Create a new instance of TurnDown to convert HTML to Markdown
  let service = new TurnDown({
    headingStyle: "atx",
    bulletListMarker: "-",

  })

  // Strip '#' from headings
  service.addRule("headings", {
    filter: ['h1', 'h2', 'h3'],
    replacement: function (content, node, options) {
      return content
    }
  })

  // Ignore <form></form> elements
  service.remove(['form'])

  return service
}
