(function () {
  const themeKey = "localFocusOsLearningMode.v1";
  const modes = [
    {
      id: "focus",
      label: "Fokus",
      hint: "Blau · Deep Work",
      className: "learning-focus"
    },
    {
      id: "sprint",
      label: "Sprint",
      hint: "Orange · Startdruck",
      className: "learning-sprint"
    },
    {
      id: "review",
      label: "Review",
      hint: "Violett · Strategie",
      className: "learning-review"
    },
    {
      id: "calm",
      label: "Calm",
      hint: "Türkis · Reizreduktion",
      className: "learning-calm"
    }
  ];

  function removeModeClasses() {
    modes.forEach(mode => document.body.classList.remove(mode.className));
  }

  function applyMode(id) {
    const mode = modes.find(item => item.id === id) || modes[0];
    removeModeClasses();
    document.body.classList.add(mode.className);
    localStorage.setItem(themeKey, mode.id);

    document.querySelectorAll(".mode-btn").forEach(button => {
      button.classList.toggle("active", button.dataset.mode === mode.id);
    });
  }

  function injectLearningPanel() {
    const hero = document.querySelector(".hero");
    if (!hero || document.querySelector(".learning-panel")) return;

    const panel = document.createElement("section");
    panel.className = "learning-panel";
    panel.innerHTML = `
      <div>
        <p class="eyebrow">Shadowmaker Learning Mode</p>
        <h2>Trigger-Farben für Umsetzung</h2>
        <p>
          Farben steuern deine Handlung: Rot für sofortige Kontrolle, Orange für Start,
          Blau für Fokus, Violett für Review, Grün für erledigt.
        </p>
        <div class="trigger-legend">
          <span class="trigger-chip" style="--chip-color:#ff3b3b">P0 Kontrolle</span>
          <span class="trigger-chip" style="--chip-color:#ff9f1c">Start</span>
          <span class="trigger-chip" style="--chip-color:#3b82f6">Fokus</span>
          <span class="trigger-chip" style="--chip-color:#a78bfa">Review</span>
          <span class="trigger-chip" style="--chip-color:#22c55e">Done</span>
        </div>
      </div>
      <div class="mode-grid">
        ${modes.map(mode => `
          <button class="mode-btn" data-mode="${mode.id}">
            ${mode.label}
            <small>${mode.hint}</small>
          </button>
        `).join("")}
      </div>
    `;

    hero.insertAdjacentElement("afterend", panel);

    panel.querySelectorAll(".mode-btn").forEach(button => {
      button.addEventListener("click", () => applyMode(button.dataset.mode));
    });
  }

  function enhanceTaskCards() {
    document.querySelectorAll(".task-card").forEach(card => {
      const areaText = card.querySelector(".area")?.textContent || "";
      const statusText = card.querySelector(".badge")?.textContent || "";

      const priorityMatch = areaText.match(/P[0-3]/i);
      if (priorityMatch) {
        card.classList.add(`priority-${priorityMatch[0].toLowerCase()}`);
      }

      if (statusText) {
        card.classList.add(`status-${statusText.trim().toLowerCase()}`);
      }
    });
  }

  function observeCards() {
    const root = document.getElementById("taskCards");
    if (!root) return;

    const observer = new MutationObserver(() => enhanceTaskCards());
    observer.observe(root, { childList: true, subtree: true });
  }

  function boot() {
    injectLearningPanel();
    applyMode(localStorage.getItem(themeKey) || "focus");
    enhanceTaskCards();
    observeCards();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }
})();
