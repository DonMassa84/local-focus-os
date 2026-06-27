const storageKey = "localFocusOsTasks.v1";
const kaizenKey = "localFocusOsKaizen.v1";

const views = document.querySelectorAll(".view");
const tabs = document.querySelectorAll(".tab");

const moduleCards = document.getElementById("moduleCards");
const moduleSearchInput = document.getElementById("moduleSearchInput");
const moduleStatusFilter = document.getElementById("moduleStatusFilter");

const taskCards = document.getElementById("taskCards");
const taskSearchInput = document.getElementById("taskSearchInput");
const taskPriorityFilter = document.getElementById("taskPriorityFilter");
const taskStatusFilter = document.getElementById("taskStatusFilter");

const publishedCount = document.getElementById("publishedCount");
const openTaskCount = document.getElementById("openTaskCount");
const doneTaskCount = document.getElementById("doneTaskCount");

const dailyHighlight = document.getElementById("dailyHighlight");
const activeSprint = document.getElementById("activeSprint");

const newTaskTitle = document.getElementById("newTaskTitle");
const newTaskNextAction = document.getElementById("newTaskNextAction");
const newTaskPriority = document.getElementById("newTaskPriority");
const newTaskMinutes = document.getElementById("newTaskMinutes");

const addTaskBtn = document.getElementById("addTaskBtn");
const clearKaizenBtn = document.getElementById("clearKaizenBtn");
const exportTodayBtn = document.getElementById("exportTodayBtn");
const generateExportBtn = document.getElementById("generateExportBtn");
const copyExportBtn = document.getElementById("copyExportBtn");
const exportBox = document.getElementById("exportBox");

const modules = window.LOCAL_FOCUS_OS_MODULES || [];
const baseTasks = window.LOCAL_FOCUS_OS_TASKS || [];

let tasks = loadTasks();
let kaizen = loadKaizen();

function normalize(value) {
  return String(value || "").toLowerCase();
}

function loadTasks() {
  const stored = localStorage.getItem(storageKey);
  if (stored) {
    try {
      return JSON.parse(stored);
    } catch {
      return baseTasks;
    }
  }
  return baseTasks;
}

function saveTasks() {
  localStorage.setItem(storageKey, JSON.stringify(tasks, null, 2));
}

function loadKaizen() {
  const stored = localStorage.getItem(kaizenKey);
  if (stored) {
    try {
      return JSON.parse(stored);
    } catch {
      return {};
    }
  }
  return {};
}

function saveKaizen() {
  localStorage.setItem(kaizenKey, JSON.stringify(kaizen, null, 2));
}

function setView(name) {
  views.forEach(view => view.classList.toggle("active", view.id === `view-${name}`));
  tabs.forEach(tab => tab.classList.toggle("active", tab.dataset.view === name));
}

function statusLabel(status) {
  return {
    "published": "published",
    "local-pending": "pending",
    "external": "external",
    "missing": "missing",
    "open": "open",
    "doing": "doing",
    "done": "done"
  }[status] || status;
}

function renderMetrics() {
  publishedCount.textContent = modules.filter(item => item.status === "published").length;
  openTaskCount.textContent = tasks.filter(item => item.status !== "done").length;
  doneTaskCount.textContent = tasks.filter(item => item.status === "done").length;
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

  return (!query || haystack.includes(query)) && (status === "all" || item.status === status);
}

function taskMatches(item, query, priority, status) {
  const haystack = [
    item.title,
    item.priority,
    item.status,
    item.area,
    item.kaizenStep,
    item.nextAction,
    item.output
  ].map(normalize).join(" ");

  return (!query || haystack.includes(query))
    && (priority === "all" || item.priority === priority)
    && (status === "all" || item.status === status);
}

function createModuleCard(item) {
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

function createTaskCard(task) {
  const article = document.createElement("article");
  article.className = "card task-card";

  article.innerHTML = `
    <div class="card-top">
      <span class="area">${task.priority} · ${task.area}</span>
      <span class="badge ${task.status}">${task.status}</span>
    </div>

    <h2>${task.title}</h2>

    <div class="block">
      <strong>Kaizen Step</strong>
      <p>${task.kaizenStep}</p>
    </div>

    <div class="block">
      <strong>Next Action</strong>
      <p>${task.nextAction}</p>
    </div>

    <div class="block">
      <strong>Output</strong>
      <p>${task.output || "sichtbarer Fortschritt"}</p>
    </div>

    <div class="tags">
      <span class="tag">${task.estimatedMinutes || 25} min</span>
      <span class="tag">${task.id}</span>
    </div>

    <div class="card-actions">
      <button data-action="highlight" data-id="${task.id}">Highlight</button>
      <button data-action="sprint" data-id="${task.id}">Sprint</button>
      <button data-action="doing" data-id="${task.id}" class="secondary">Doing</button>
      <button data-action="done" data-id="${task.id}" class="secondary">Done</button>
    </div>
  `;

  return article;
}

function renderModules() {
  const query = normalize(moduleSearchInput.value.trim());
  const status = moduleStatusFilter.value;
  const filtered = modules.filter(item => moduleMatches(item, query, status));

  moduleCards.innerHTML = "";

  if (!filtered.length) {
    moduleCards.innerHTML = `<article class="card"><h2>Keine Module gefunden</h2></article>`;
    return;
  }

  filtered.forEach(item => moduleCards.appendChild(createModuleCard(item)));
}

function renderTasks() {
  const query = normalize(taskSearchInput.value.trim());
  const priority = taskPriorityFilter.value;
  const status = taskStatusFilter.value;
  const filtered = tasks.filter(item => taskMatches(item, query, priority, status));

  taskCards.innerHTML = "";

  if (!filtered.length) {
    taskCards.innerHTML = `<article class="card"><h2>Keine Aufgaben gefunden</h2></article>`;
    return;
  }

  filtered.forEach(task => taskCards.appendChild(createTaskCard(task)));
}

function renderKaizen() {
  if (kaizen.highlight) {
    dailyHighlight.textContent = `Daily Highlight: ${kaizen.highlight.title} → ${kaizen.highlight.nextAction}`;
  } else {
    dailyHighlight.textContent = "Noch kein Daily Highlight gesetzt.";
  }

  if (kaizen.sprint) {
    const end = new Date(kaizen.sprint.endsAt);
    const now = new Date();
    const remainingMs = end - now;
    const remainingMin = Math.max(0, Math.ceil(remainingMs / 60000));

    activeSprint.textContent = remainingMs > 0
      ? `Aktiver Sprint: ${kaizen.sprint.title} · ${remainingMin} min übrig`
      : `Sprint beendet: ${kaizen.sprint.title} · Ergebnis dokumentieren.`;
  } else {
    activeSprint.textContent = "Kein aktiver Sprint.";
  }
}

function setHighlight(id) {
  const task = tasks.find(item => item.id === id);
  if (!task) return;

  kaizen.highlight = {
    id: task.id,
    title: task.title,
    nextAction: task.nextAction,
    setAt: new Date().toISOString()
  };

  saveKaizen();
  renderKaizen();
}

function startSprint(id) {
  const task = tasks.find(item => item.id === id);
  if (!task) return;

  task.status = "doing";

  const minutes = Number(task.estimatedMinutes || 25);
  const now = new Date();
  const endsAt = new Date(now.getTime() + minutes * 60000);

  kaizen.sprint = {
    id: task.id,
    title: task.title,
    nextAction: task.nextAction,
    minutes,
    startedAt: now.toISOString(),
    endsAt: endsAt.toISOString()
  };

  saveTasks();
  saveKaizen();
  renderAll();
}

function setTaskStatus(id, status) {
  const task = tasks.find(item => item.id === id);
  if (!task) return;

  task.status = status;
  task.updatedAt = new Date().toISOString();

  saveTasks();
  renderAll();
}

function addTask() {
  const title = newTaskTitle.value.trim();
  const nextAction = newTaskNextAction.value.trim();

  if (!title || !nextAction) {
    alert("Aufgabe und nächste Aktion ausfüllen.");
    return;
  }

  const id = `task_${Date.now()}`;

  tasks.unshift({
    id,
    title,
    priority: newTaskPriority.value,
    status: "open",
    area: "Custom",
    kaizenStep: "Micro-Commitment",
    nextAction,
    estimatedMinutes: Number(newTaskMinutes.value || 25),
    output: "sichtbarer Fortschritt"
  });

  newTaskTitle.value = "";
  newTaskNextAction.value = "";

  saveTasks();
  renderAll();
}

function generateMarkdownExport() {
  const today = new Date().toISOString().slice(0, 10);

  const lines = [
    `# Local Focus OS — Kaizen Task Export`,
    ``,
    `Stand: ${today}`,
    ``,
    `## Daily Highlight`,
    ``,
    kaizen.highlight ? `- ${kaizen.highlight.title}: ${kaizen.highlight.nextAction}` : `- nicht gesetzt`,
    ``,
    `## Aktiver Sprint`,
    ``,
    kaizen.sprint ? `- ${kaizen.sprint.title}: ${kaizen.sprint.nextAction}` : `- kein aktiver Sprint`,
    ``,
    `## Aufgaben`,
    ``
  ];

  for (const task of tasks) {
    lines.push(`- [${task.status === "done" ? "x" : " "}] ${task.priority} · ${task.title}`);
    lines.push(`  - Status: ${task.status}`);
    lines.push(`  - Bereich: ${task.area}`);
    lines.push(`  - Kaizen: ${task.kaizenStep}`);
    lines.push(`  - Nächste Aktion: ${task.nextAction}`);
    lines.push(`  - Output: ${task.output || "sichtbarer Fortschritt"}`);
    lines.push(``);
  }

  exportBox.value = lines.join("\n");
  setView("export");
}

function clearKaizen() {
  kaizen = {};
  saveKaizen();
  renderKaizen();
}

function renderAll() {
  renderMetrics();
  renderModules();
  renderTasks();
  renderKaizen();
}

tabs.forEach(tab => {
  tab.addEventListener("click", () => setView(tab.dataset.view));
});

moduleSearchInput.addEventListener("input", renderModules);
moduleStatusFilter.addEventListener("change", renderModules);
taskSearchInput.addEventListener("input", renderTasks);
taskPriorityFilter.addEventListener("change", renderTasks);
taskStatusFilter.addEventListener("change", renderTasks);

addTaskBtn.addEventListener("click", addTask);
clearKaizenBtn.addEventListener("click", clearKaizen);
exportTodayBtn.addEventListener("click", generateMarkdownExport);
generateExportBtn.addEventListener("click", generateMarkdownExport);

copyExportBtn.addEventListener("click", async () => {
  if (!exportBox.value) generateMarkdownExport();
  await navigator.clipboard.writeText(exportBox.value);
  copyExportBtn.textContent = "Kopiert";
  setTimeout(() => copyExportBtn.textContent = "In Zwischenablage kopieren", 1200);
});

taskCards.addEventListener("click", event => {
  const button = event.target.closest("button[data-action]");
  if (!button) return;

  const { action, id } = button.dataset;

  if (action === "highlight") setHighlight(id);
  if (action === "sprint") startSprint(id);
  if (action === "doing") setTaskStatus(id, "doing");
  if (action === "done") setTaskStatus(id, "done");
});

setInterval(renderKaizen, 30000);
renderAll();
