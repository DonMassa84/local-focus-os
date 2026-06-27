(function () {
  const stageStorageKey = "localFocusOsLinkedinCampaignStages.v1";
  const publicCampaigns = window.LOCAL_FOCUS_OS_LINKEDIN_CAMPAIGNS || [];
  const privateCampaigns = window.LOCAL_FOCUS_OS_PRIVATE_LINKEDIN_CAMPAIGNS || [];
  const campaigns = [...privateCampaigns, ...publicCampaigns];

  let stageOverrides = loadStageOverrides();

  function loadStageOverrides() {
    try {
      return JSON.parse(localStorage.getItem(stageStorageKey)) || {};
    } catch {
      return {};
    }
  }

  function saveStageOverrides() {
    localStorage.setItem(stageStorageKey, JSON.stringify(stageOverrides, null, 2));
  }

  function allPosts() {
    return campaigns.flatMap(campaign =>
      (campaign.posts || []).map(post => ({
        ...post,
        campaignId: campaign.id,
        campaignName: campaign.name,
        campaignGoal: campaign.goal,
        stage: stageOverrides[post.id]?.stage || post.stage || "to_post",
        postedDate: stageOverrides[post.id]?.postedDate || post.postedDate || "",
        url: stageOverrides[post.id]?.url || post.url || ""
      }))
    );
  }

  function countByStage(stage) {
    return allPosts().filter(post => post.stage === stage).length;
  }

  function injectCampaignView() {
    const tabs = document.querySelector(".tabs");
    const exportView = document.getElementById("view-export");

    if (!tabs || !exportView) return;

    if (!document.querySelector('[data-view="campaigns"]')) {
      const btn = document.createElement("button");
      btn.className = "tab";
      btn.dataset.view = "campaigns";
      btn.textContent = "Campaigns";
      btn.addEventListener("click", () => setCampaignView());
      tabs.appendChild(btn);
    }

    if (!document.getElementById("view-campaigns")) {
      const section = document.createElement("section");
      section.id = "view-campaigns";
      section.className = "view";
      section.innerHTML = `
        <section class="kaizen-cockpit">
          <div>
            <p class="eyebrow">LinkedIn Campaign Tracker</p>
            <h2>Gepostet vs. noch posten</h2>
            <p class="cockpit-line">Steuere deine LinkedIn-Beiträge nach Kampagne, Status und nächster Aktion.</p>
          </div>
          <div class="cockpit-actions">
            <button id="campaignExportBtn">Campaign Export</button>
          </div>
        </section>

        <section class="campaign-summary">
          <div class="campaign-stat"><strong id="campaignPostedCount">0</strong><span>posted</span></div>
          <div class="campaign-stat"><strong id="campaignReviewCount">0</strong><span>review</span></div>
          <div class="campaign-stat"><strong id="campaignScheduledCount">0</strong><span>scheduled</span></div>
          <div class="campaign-stat"><strong id="campaignToPostCount">0</strong><span>to post</span></div>
        </section>

        <section class="control-bar">
          <input id="campaignSearchInput" type="search" placeholder="Kampagne oder Post suchen …">
          <select id="campaignFilter"></select>
          <select id="campaignStageFilter">
            <option value="all">Alle Stages</option>
            <option value="posted">Posted</option>
            <option value="review">Review</option>
            <option value="scheduled">Scheduled</option>
            <option value="to_post">To post</option>
            <option value="parked">Parked</option>
          </select>
        </section>

        <section id="campaignRoot"></section>

        <section class="strategy">
          <h2>Campaign Markdown Export</h2>
          <textarea id="campaignExportBox" rows="16" spellcheck="false"></textarea>
        </section>
      `;
      exportView.insertAdjacentElement("beforebegin", section);
    }
  }

  function setCampaignView() {
    document.querySelectorAll(".view").forEach(view => view.classList.toggle("active", view.id === "view-campaigns"));
    document.querySelectorAll(".tab").forEach(tab => tab.classList.toggle("active", tab.dataset.view === "campaigns"));
    renderCampaigns();
  }

  function normalize(value) {
    return String(value || "").toLowerCase();
  }

  function stageLabel(stage) {
    return {
      "posted": "posted",
      "review": "review",
      "scheduled": "scheduled",
      "to_post": "to post",
      "parked": "parked"
    }[stage] || stage;
  }

  function renderCampaignFilters() {
    const select = document.getElementById("campaignFilter");
    if (!select) return;

    const current = select.value || "all";
    select.innerHTML = `<option value="all">Alle Kampagnen</option>` + campaigns
      .map(c => `<option value="${c.id}">${c.name}</option>`)
      .join("");

    select.value = [...select.options].some(option => option.value === current) ? current : "all";
  }

  function renderCampaignSummary() {
    document.getElementById("campaignPostedCount").textContent = countByStage("posted");
    document.getElementById("campaignReviewCount").textContent = countByStage("review");
    document.getElementById("campaignScheduledCount").textContent = countByStage("scheduled");
    document.getElementById("campaignToPostCount").textContent = countByStage("to_post");
  }

  function campaignMatchesPost(post, query, stage) {
    const haystack = [
      post.title,
      post.campaignName,
      post.campaignGoal,
      post.stage,
      post.proof,
      post.nextAction,
      post.channel
    ].map(normalize).join(" ");

    return (!query || haystack.includes(query)) && (stage === "all" || post.stage === stage);
  }

  function renderCampaigns() {
    if (!document.getElementById("view-campaigns")) return;

    renderCampaignFilters();
    renderCampaignSummary();

    const root = document.getElementById("campaignRoot");
    const query = normalize(document.getElementById("campaignSearchInput")?.value || "");
    const campaignFilter = document.getElementById("campaignFilter")?.value || "all";
    const stageFilter = document.getElementById("campaignStageFilter")?.value || "all";

    root.innerHTML = "";

    const selectedCampaigns = campaigns.filter(campaign => campaignFilter === "all" || campaign.id === campaignFilter);

    for (const campaign of selectedCampaigns) {
      const posts = allPosts()
        .filter(post => post.campaignId === campaign.id)
        .filter(post => campaignMatchesPost(post, query, stageFilter));

      if (!posts.length) continue;

      const group = document.createElement("section");
      group.className = "campaign-group";
      group.innerHTML = `
        <div class="campaign-header">
          <div>
            <p class="eyebrow">Campaign</p>
            <h2>${campaign.name}</h2>
            <p>${campaign.goal || ""}</p>
          </div>
          <span class="badge ${campaign.status || "published"}">${campaign.status || "active"}</span>
        </div>
        <div class="grid">
          ${posts.map(post => `
            <article class="card campaign-post-card">
              <div class="card-top">
                <span class="area">${post.channel || "LinkedIn"}</span>
                <span class="badge stage-${post.stage}">${stageLabel(post.stage)}</span>
              </div>

              <h2>${post.title}</h2>

              <div class="block">
                <strong>Proof</strong>
                <p>${post.proof || "Proof ergänzen"}</p>
              </div>

              <div class="block">
                <strong>Next Action</strong>
                <p>${post.nextAction || "Nächste Aktion ergänzen"}</p>
              </div>

              <div class="block">
                <strong>Posted</strong>
                <p>${post.postedDate || "noch nicht gepostet"} ${post.url ? "· " + post.url : ""}</p>
              </div>

              <div class="campaign-actions">
                <button data-campaign-action="posted" data-post-id="${post.id}">Posted</button>
                <button data-campaign-action="review" data-post-id="${post.id}" class="secondary">Review</button>
                <button data-campaign-action="scheduled" data-post-id="${post.id}" class="secondary">Scheduled</button>
                <button data-campaign-action="to_post" data-post-id="${post.id}" class="secondary">To post</button>
              </div>
            </article>
          `).join("")}
        </div>
      `;
      root.appendChild(group);
    }

    if (!root.innerHTML.trim()) {
      root.innerHTML = `<article class="card"><h2>Keine Kampagnenposts gefunden</h2></article>`;
    }
  }

  function setPostStage(postId, stage) {
    stageOverrides[postId] = {
      ...(stageOverrides[postId] || {}),
      stage,
      postedDate: stage === "posted"
        ? new Date().toISOString().slice(0, 10)
        : (stageOverrides[postId]?.postedDate || "")
    };

    saveStageOverrides();
    renderCampaigns();
  }

  function generateCampaignExport() {
    const box = document.getElementById("campaignExportBox");
    if (!box) return;

    const today = new Date().toISOString().slice(0, 10);
    const lines = [
      "# LinkedIn Campaign Status",
      "",
      `Stand: ${today}`,
      "",
      "## Summary",
      "",
      `- Posted: ${countByStage("posted")}`,
      `- Review: ${countByStage("review")}`,
      `- Scheduled: ${countByStage("scheduled")}`,
      `- To post: ${countByStage("to_post")}`,
      "",
      "## Campaigns",
      ""
    ];

    for (const campaign of campaigns) {
      lines.push(`### ${campaign.name}`);
      lines.push("");
      lines.push(`Ziel: ${campaign.goal || "-"}`);
      lines.push("");

      for (const post of allPosts().filter(p => p.campaignId === campaign.id)) {
        lines.push(`- [${post.stage === "posted" ? "x" : " "}] ${stageLabel(post.stage)} · ${post.title}`);
        lines.push(`  - Proof: ${post.proof || "-"}`);
        lines.push(`  - Next Action: ${post.nextAction || "-"}`);
        lines.push(`  - Posted Date: ${post.postedDate || "-"}`);
        lines.push(`  - URL: ${post.url || "-"}`);
        lines.push("");
      }
    }

    box.value = lines.join("\n");
    setCampaignView();
  }

  function bindCampaignEvents() {
    document.addEventListener("input", event => {
      if (event.target.id === "campaignSearchInput") renderCampaigns();
    });

    document.addEventListener("change", event => {
      if (event.target.id === "campaignFilter" || event.target.id === "campaignStageFilter") renderCampaigns();
    });

    document.addEventListener("click", event => {
      const actionButton = event.target.closest("[data-campaign-action]");
      if (actionButton) {
        setPostStage(actionButton.dataset.postId, actionButton.dataset.campaignAction);
      }

      if (event.target.id === "campaignExportBtn") {
        generateCampaignExport();
      }
    });
  }

  function boot() {
    injectCampaignView();
    bindCampaignEvents();
    renderCampaigns();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }
})();
