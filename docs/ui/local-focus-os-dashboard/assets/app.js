const cardsRoot = document.getElementById("cards");
const searchInput = document.getElementById("searchInput");
const statusFilter = document.getElementById("statusFilter");

const publishedCount = document.getElementById("publishedCount");
const pendingCount = document.getElementById("pendingCount");
const moduleCount = document.getElementById("moduleCount");

let modules = [];

function normalize(value) {
  return String(value || "").toLowerCase();
}

function statusLabel(status) {
  return {
    "published": "published",
    "local-pending": "pending",
    "external": "external",
    "missing": "missing"
  }[status] || status;
}

function renderMetrics(items) {
  publishedCount.textContent = items.filter(item => item.status === "published").length;
  pendingCount.textContent = items.filter(item => item.status === "local-pending").length;
  moduleCount.textContent = items.length;
}

function moduleMatches(item, query, status) {
  const haystack = [
    item.title,
    item.area,
    item.status,
    item.what,
    item.proof,
    item.action,
    ...(item.tags || [])
  ].map(normalize).join(" ");

  const queryMatch = !query || haystack.includes(query);
  const statusMatch = status === "all" || item.status === status;

  return queryMatch && statusMatch;
}

function createCard(item) {
  const article = document.createElement("article");
  article.className = "card";

  const tags = (item.tags || [])
    .map(tag => `<span class="tag">${tag}</span>`)
    .join("");

  const link = item.link
    ? `<a href="${item.link}" target="${item.link.startsWith("http") ? "_blank" : "_self"}" rel="noreferrer">Open</a>`
    : `<span class="disabled-link">Pending integration</span>`;

  article.innerHTML = `
    <div class="card-top">
      <span class="area">${item.area}</span>
      <span class="badge ${item.status}">${statusLabel(item.status)}</span>
    </div>
    <h2>${item.title}</h2>

    <div class="block">
      <strong>What</strong>
      <p>${item.what}</p>
    </div>

    <div class="block">
      <strong>Proof</strong>
      <p>${item.proof}</p>
    </div>

    <div class="block">
      <strong>Action</strong>
      <p>${item.action}</p>
    </div>

    <div class="tags">${tags}</div>
    ${link}
  `;

  return article;
}

function render() {
  const query = normalize(searchInput.value.trim());
  const status = statusFilter.value;

  const filtered = modules.filter(item => moduleMatches(item, query, status));

  cardsRoot.innerHTML = "";

  if (!filtered.length) {
    cardsRoot.innerHTML = `
      <article class="card">
        <h2>Keine Treffer</h2>
        <p class="subtitle">Suchfilter reduzieren oder Statusfilter auf „Alle Status“ setzen.</p>
      </article>
    `;
    return;
  }

  filtered.forEach(item => cardsRoot.appendChild(createCard(item)));
}

async function init() {
  const response = await fetch("assets/modules.json");
  modules = await response.json();

  renderMetrics(modules);
  render();

  searchInput.addEventListener("input", render);
  statusFilter.addEventListener("change", render);
}

init().catch(error => {
  cardsRoot.innerHTML = `
    <article class="card">
      <h2>Dashboard konnte nicht geladen werden</h2>
      <p class="subtitle">${error.message}</p>
    </article>
  `;
});
