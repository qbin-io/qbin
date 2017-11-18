# Frontend Variables
The frontend files contains variables in the format `$$name$$` that get replaced by actual content by the backend.

The following variables exist in the various files:

## Global
| Variable   | Description                                                                |
| ---------- | -------------------------------------------------------------------------- |
| `$$root$$` | Public entry point without trailing slash, e.g. `https://example.org/qbin` |
| `$$path$$` | Domain-relative public entry point without trailing slash, e.g. `/qbin`    |

## index.html
| Variable                      | Description                                                              |
| ----------------------------- | ------------------------------------------------------------------------ |
| `$$if_fork$$...$$/if_fork$$`  | Only include a specific section on `/<document>/fork` pages              |
| `$$!if_fork$$...$$/if_fork$$` | Only include a specific section on the index page, and not on fork pages |
| `$$id$$`                      | See output.html; only exists when forking                                |
| `$$syntax$$`                  | See output.html; only exists when forking                                |
| `$$creation$$`                | See output.html; only exists when forking                                |
| `$$expiration$$`              | See output.html; only exists when forking                                |
| `$$expiration-remaining$$`    | See output.html; only exists when forking                                |
| `$$content$$`                 | See output.html; only exists when forking. Example use: `<textarea>$$if_fork$$$$content$$$$/if_fork$$</textarea>` |

## output.html
| Variable                   | Description                                                                   |
| -------------------------- | ----------------------------------------------------------------------------- |
| `$$id$$`                   | The ID of the document, like it is in the URL                                 |
| `$$syntax$$`               | The syntax language of the document, e.g. `javascript`                        |
| `$$creation$$`             | The creation date in the format `YYYY-MM-DD hh:mm (UTC)`                      |
| `$$expiration$$`           | The expiration date in the format `YYYY-MM-DD hh:mm (UTC)`                    |
| `$$expiration-remaining$$` | The time left until the expiration date in a humane format like `2 days left` |
| `$$content$$`              | The document contents, dependent on the content type either wrapped in a `<div class="markdown">`, or in a `<pre class="no-linenumber-padding"><code class="language-... line-numbers">` |

## report.html
| Variable                   | Description                                             |
| -------------------------- | --------------------------------------------------------|
| `$$id$$`                   | The ID of the document to report, like it is in the URL |
