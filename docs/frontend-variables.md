# Frontend Variables
The frontend files contains variables in the format `$$name$$` that get replaced by actual content by the backend.

Variables in the format `$$if_...$$` can be used for conditional blocks:  
`$$if_fork$$...$$/if_fork$$` only includes a specific section (`...`) on `/<document>/fork` pages.
`$$!if_fork$$...$$/if_fork$$` only includes a specific section (`...`) on the index page (i.e.: not on fork pages).

The following variables exist in the various files:

## Global
| Variable   | Description                                                                |
| ---------- | -------------------------------------------------------------------------- |
| `$$root$$` | Public entry point without trailing slash, e.g. `https://example.org/qbin` |
| `$$path$$` | Domain-relative public entry point without trailing slash, e.g. `/qbin`    |

## index.html
| Variable                      | Description                                                              |
| ----------------------------- | ------------------------------------------------------------------------ |
| `$$if_fork$$`                 | Only show on `/<document>/fork` pages                                    |
| ...                           | Supports all variables from output.html when forking                     |
| `$$content$$`                 | As opposed to output.html, this is the plain-text source of the document without syntax highlighting. Example use: `<textarea>$$if_fork$$$$content$$$$/if_fork$$</textarea>` |

## output.html
| Variable                   | Description                                                                   |
| -------------------------- | ----------------------------------------------------------------------------- |
| `$$if_volatile$$`          | Only show if the document is volatile (only viewable once)                    |
| `$$if_syntax$$`            | Only show when not using the generic/no syntax                                |
| `$$id$$`                   | The ID of the document, like it is in the URL                                 |
| `$$syntax$$`               | The syntax language of the document, e.g. `javascript`                        |
| `$$creation$$`             | The creation date in the format `YYYY-MM-DD hh:mm (UTC)`                      |
| `$$expiration$$`           | The expiration date in the format `YYYY-MM-DD hh:mm (UTC)`                    |
| `$$expiration-remaining$$` | The time left until the expiration date in a humane format like `2 days left` |
| `$$views$$`                | The number of times this document has already been viewed                     |
| `$$content$$`              | The document contents, dependent on the content type either wrapped in a `<div class="markdown">`, or in a `<pre class="no-linenumber-padding"><code class="language-... line-numbers">` |

## report.html
| Variable                   | Description                                             |
| -------------------------- | --------------------------------------------------------|
| `$$id$$`                   | The ID of the document to report, like it is in the URL |
