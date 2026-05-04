// ─── GLOBAL STATE ──────────────────────────────────────────────────────────
window.engine = {
  config: null,
  questions: [],
  answers: [],
  currentQuestion: 0,
  diagnosis: null,
  plan: null
};

// ─── SETUP STAGE ───────────────────────────────────────────────────────────
function selectSubject(subject) {
  document.querySelectorAll(".subject-btn").forEach(btn => {
    btn.classList.toggle("active", btn.dataset.subject === subject);
  });
  updateStartButton();
}

function updateStartButton() {
  const name = document.getElementById("name-input").value.trim();
  const subject = document.querySelector(".subject-btn.active");
  const btn = document.getElementById("start-btn");
  btn.disabled = !name || !subject;
}

async function startAssessment() {
  const name = document.getElementById("name-input").value.trim();
  const subjectBtn = document.querySelector(".subject-btn.active");
  const level = document.getElementById("level-select").value;
  const board = document.getElementById("board-select").value;

  if (!name || !subjectBtn) {
    showToast("Please fill in all fields", "error");
    return;
  }

  window.engine.config = {
    name,
    subject: subjectBtn.dataset.subject,
    level,
    board
  };

  showToast("Generating diagnostic questions...");
  try {
    window.engine.questions = await generateQuestions(window.engine.config);
    window.engine.answers = new Array(window.engine.questions.length).fill("");
    window.engine.currentQuestion = 0;
    goToStage("assess");
    loadQuestion();
    showToast("Assessment ready!");
  } catch (err) {
    showToast("Failed to generate questions: " + err.message, "error");
    console.error(err);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  document.getElementById("name-input").addEventListener("input", updateStartButton);
});

// ─── ASSESS STAGE ──────────────────────────────────────────────────────────
function loadQuestion() {
  const q = window.engine.questions[window.engine.currentQuestion];
  const answerInput = document.getElementById("answer-input");
  const qCounter = document.getElementById("q-counter");
  const qText = document.getElementById("question-text");
  const nextBtn = document.getElementById("next-btn");

  qCounter.textContent = window.engine.currentQuestion + 1;
  qText.textContent = q.question;
  answerInput.value = window.engine.answers[window.engine.currentQuestion] || "";

  const isLast = window.engine.currentQuestion === window.engine.questions.length - 1;
  nextBtn.textContent = isLast ? "Complete Assessment →" : "Next Question →";

  updateProgressBar();
}

function updateProgressBar() {
  const progress = ((window.engine.currentQuestion + 1) / window.engine.questions.length) * 100;
  document.getElementById("progress-bar").style.width = progress + "%";
}

async function nextQuestion() {
  const answerInput = document.getElementById("answer-input");
  window.engine.answers[window.engine.currentQuestion] = answerInput.value;

  if (window.engine.currentQuestion < window.engine.questions.length - 1) {
    window.engine.currentQuestion++;
    loadQuestion();
  } else {
    // All answers collected — diagnose
    goToStage("diagnose");
    await diagnosePhase();
  }
}

// ─── DIAGNOSE STAGE ───────────────────────────────────────────────────────
async function diagnosePhase() {
  showToast("Analyzing your answers...");
  try {
    window.engine.diagnosis = await diagnoseAnswers(
      window.engine.config,
      window.engine.questions,
      window.engine.answers
    );
    renderDiagnosis();
    showToast("Diagnosis complete!");
  } catch (err) {
    showToast("Failed to analyze answers: " + err.message, "error");
    console.error(err);
  }
}

function renderDiagnosis() {
  const container = document.getElementById("section-diagnose");
  if (!container) {
    // Create section dynamically
    const section = document.createElement("div");
    section.className = "section active";
    section.id = "section-diagnose";
    document.querySelector(".engine-container").appendChild(section);
  }

  const d = window.engine.diagnosis;
  const score = d.overallScore || 0;
  const scoreColor = score >= 70 ? "var(--green)" : score >= 50 ? "var(--gold)" : "var(--red)";

  let html = `
    <div style="text-align:center;margin-bottom:2rem;">
      <h2 class="serif" style="font-size:1.8rem;margin-bottom:1rem;">Your Diagnosis</h2>
      <div style="font-size:3rem;font-weight:900;color:${scoreColor};margin:1rem 0;">
        ${score}%
      </div>
      <p class="muted" style="font-size:1.1rem;">
        Current grade: <strong style="color:var(--white);">${d.currentGrade}</strong> 
        → Target: <strong style="color:var(--teal);">${d.targetGrade}</strong>
      </p>
    </div>

    <div class="card" style="margin-bottom:2rem;">
      <h3 style="font-size:1.2rem;margin-bottom:1.5rem;">Knowledge Gaps</h3>
  `;

  (d.gaps || []).forEach(gap => {
    const priorityColor = gap.priority === "critical" ? "var(--red)" : 
                          gap.priority === "high" ? "var(--orange)" :
                          gap.priority === "medium" ? "var(--gold)" : "var(--green)";
    
    html += `
      <div style="margin-bottom:1.5rem;padding:1rem;background:var(--navy);border-radius:var(--r);border-left:3px solid ${priorityColor};">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:.5rem;">
          <strong style="font-size:1.05rem;">${gap.topic}</strong>
          <span style="color:${priorityColor};font-weight:700;text-transform:uppercase;font-size:.75rem;">${gap.priority}</span>
        </div>
        <p style="color:var(--muted);font-size:.9rem;margin-bottom:.5rem;">${gap.reason}</p>
        <div style="display:flex;gap:1rem;font-size:.85rem;color:var(--muted);">
          <span>Score: <strong>${gap.score}%</strong></span>
          <span>Marks at stake: <strong>${gap.marksAtStake}</strong></span>
        </div>
      </div>
    `;
  });

  html += `
      <button class="btn btn-gold" style="width:100%;margin-top:1.5rem;font-size:1rem;padding:1rem;" onclick="goToPlanPhase()">
        Generate Study Plan →
      </button>
    </div>
  `;

  document.getElementById("section-diagnose").innerHTML = html;
}

// ─── PLAN STAGE ───────────────────────────────────────────────────────────
async function goToPlanPhase() {
  goToStage("plan");
  showToast("Creating your personalized study plan...");
  try {
    window.engine.plan = await generatePlan(window.engine.config, window.engine.diagnosis);
    renderPlan();
    showToast("Study plan ready!");
  } catch (err) {
    showToast("Failed to generate plan: " + err.message, "error");
    console.error(err);
  }
}

function renderPlan() {
  const container = document.getElementById("section-plan");
  if (!container) {
    const section = document.createElement("div");
    section.className = "section active";
    section.id = "section-plan";
    document.querySelector(".engine-container").appendChild(section);
  }

  let html = `
    <div style="text-align:center;margin-bottom:2rem;">
      <h2 class="serif" style="font-size:1.8rem;margin-bottom:1rem;">Your Study Plan</h2>
      <p class="muted">3-week personalized roadmap based on your diagnosis</p>
    </div>

    <div style="margin-bottom:2rem;">
      <h3 style="font-size:1.1rem;margin-bottom:1rem;">Grade Journey</h3>
      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:1rem;">
  `;

  (window.engine.plan.gradeJourney || []).forEach(step => {
    html += `
      <div class="card" style="text-align:center;">
        <div style="font-size:2.5rem;font-weight:900;color:var(--teal);margin-bottom:.5rem;">${step.grade}</div>
        <div style="color:var(--muted);font-size:.85rem;">Week ${step.week}</div>
        <div style="color:var(--white);font-size:.9rem;margin-top:.5rem;">${step.description}</div>
      </div>
    `;
  });

  html += `
      </div>
    </div>
  `;

  (window.engine.plan.weeks || []).forEach(week => {
    html += `
      <div class="card" style="margin-bottom:1.5rem;">
        <h4 style="font-size:1.1rem;margin-bottom:.5rem;">Week ${week.number}: ${week.title}</h4>
        <p class="muted" style="font-size:.9rem;margin-bottom:1rem;">${week.why}</p>
        <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:1rem;">
    `;

    (week.tasks || []).forEach(task => {
      const icon = task.type === "video" ? "▶" : task.type === "drill" ? "◎" : "✓";
      const badge = task.type === "video" ? "badge-teal" : task.type === "drill" ? "badge-gold" : "badge-green";
      html += `
        <div style="padding:1rem;background:var(--navy);border-radius:var(--r);border:1px solid var(--border);">
          <div style="font-size:1.5rem;margin-bottom:.5rem;">${icon}</div>
          <div style="font-size:.9rem;font-weight:600;margin-bottom:.5rem;">${task.label}</div>
          <div class="badge ${badge}">${task.mins}m</div>
        </div>
      `;
    });

    html += `
        </div>
      </div>
    `;
  });

  html += `
    <button class="btn btn-gold" style="width:100%;font-size:1rem;padding:1rem;margin-top:2rem;" onclick="goToExecutePhase()">
      Start Week 1 →
    </button>
  `;

  document.getElementById("section-plan").innerHTML = html;
}

// ─── EXECUTE & TRACK STAGES ───────────────────────────────────────────────
function goToExecutePhase() {
  goToStage("execute");
  showToast("Execute stage coming soon — for now, your plan is ready above!");
}

function goToTrackPhase() {
  goToStage("track");
  showToast("Track stage coming soon!");
}

// ─── NAVIGATION ────────────────────────────────────────────────────────────
function goToStage(stage) {
  const stageMap = {
    "setup": "setup",
    "assess": "assess",
    "diagnose": "diagnose",
    "plan": "plan",
    "execute": "execute",
    "track": "track"
  };

  document.querySelectorAll(".section").forEach(s => s.classList.remove("active"));
  
  const sectionId = `section-${stageMap[stage]}`;
  const section = document.getElementById(sectionId);
  if (section) {
    section.classList.add("active");
  }

  // Update pipeline
  const stages = ["setup", "assess", "diagnose", "plan", "execute", "track"];
  const stageIndex = stages.indexOf(stage);
  
  document.querySelectorAll(".pipeline-dot").forEach((dot, idx) => {
    const stageIdx = Math.floor(idx / 2); // Skip lines
    dot.classList.remove("active", "done");
    if (stageIdx < stageIndex) {
      dot.classList.add("done");
    } else if (stageIdx === stageIndex) {
      dot.classList.add("active");
    }
  });

  window.scrollTo({ top: 0, behavior: "smooth" });
}

// ─── INIT ──────────────────────────────────────────────────────────────────
document.addEventListener("DOMContentLoaded", () => {
  goToStage("setup");
});
