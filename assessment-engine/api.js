// ─── ANTHROPIC API CONFIGURATION ───────────────────────────────────────────
const ANTHROPIC_API_KEY = "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"; // Replace with real key
const YOUTUBE_API_KEY = "AIzaSyCq_7BBx1m7BZ_WRI3xTFMjVYS3sVYhhF4"; // Already set

const MODELS = {
  HAIKU:  "claude-haiku-4-5-20251001",
  SONNET: "claude-sonnet-4-6"
};

const PRICING = {
  haiku:  { input: 0.80,  output: 4.00,  cacheWrite: 1.00,  cacheRead: 0.08 },
  sonnet: { input: 3.00,  output: 15.00, cacheWrite: 3.75,  cacheRead: 0.30 }
};

// ─── GLOBAL STATE ──────────────────────────────────────────────────────────
window.costLog = {
  calls: [],
  total: 0
};

// ─── TOPIC MAPPING BY SUBJECT ──────────────────────────────────────────────
const TOPICS_BY_SUBJECT = {
  Physics: [
    "Forces & Motion", "Energy Stores & Transfers", "Waves", "Electricity", 
    "Magnetism", "Particle Model", "Atomic Structure", "Radioactivity", 
    "Space Physics", "Circuit Calculations"
  ],
  Chemistry: [
    "Atomic Structure", "Periodic Table", "Bonding", "Quantitative Chemistry",
    "Chemical Changes", "Electrolysis", "Energy Changes", "Rates of Reaction",
    "Organic Chemistry", "Chemical Analysis", "Atmosphere"
  ],
  Biology: [
    "Cell Biology", "Transport in Cells", "Organization", "Infection & Response",
    "Bioenergetics", "Homeostasis", "Inheritance & Variation", "Ecology",
    "Photosynthesis", "Respiration", "Nervous System", "Hormones"
  ],
  Mathematics: [
    "Algebra", "Quadratic Equations", "Trigonometry", "Geometry",
    "Probability", "Statistics", "Vectors", "Sequences", "Calculus",
    "Simultaneous Equations", "Algebraic Fractions"
  ]
};

// ─── YOUTUBE VIDEO SEARCH ──────────────────────────────────────────────────
async function searchYouTubeVideo(taskLabel, subject, level) {
  if (!YOUTUBE_API_KEY || YOUTUBE_API_KEY === "YOUR_YOUTUBE_API_KEY_HERE") {
    console.warn("YouTube API key not set — using fallback");
    return getFallbackVideo(taskLabel);
  }

  const query = encodeURIComponent(`${level} ${subject} ${taskLabel} GCSE tutorial`);
  const url = `https://www.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&videoEmbeddable=true&safeSearch=strict&maxResults=3&key=${YOUTUBE_API_KEY}`;

  try {
    const res = await fetch(url);
    if (!res.ok) throw new Error(`YouTube API error: ${res.status}`);
    
    const data = await res.json();
    if (!data.items || data.items.length === 0) return getFallbackVideo(taskLabel);

    const video = data.items[0];
    return {
      id: video.id.videoId,
      title: video.snippet.title,
      channel: video.snippet.channelTitle,
      live: true
    };
  } catch (err) {
    console.warn("Video search failed:", err);
    return getFallbackVideo(taskLabel);
  }
}

function getFallbackVideo(taskLabel) {
  const videos = {
    "force": { id: "pk4sEhgB_hc", channel: "Khan Academy", title: "Forces & Motion" },
    "energy": { id: "w4QFJb9a8vo", channel: "Khan Academy", title: "Energy" },
    "wave": { id: "nBPy8n0dFvY", channel: "Khan Academy", title: "Waves" },
    "electric": { id: "TfiMSzB7qOk", channel: "Khan Academy", title: "Electricity" },
    "quadratic": { id: "mbc3_e7lm-0", channel: "Khan Academy", title: "Quadratic Equations" },
    "cell": { id: "URUJD5NEXC8", channel: "Khan Academy", title: "Cell Biology" },
    "photosynthes": { id: "sQK3Yr4Sc_k", channel: "Khan Academy", title: "Photosynthesis" },
  };

  const lower = taskLabel.toLowerCase();
  for (const [key, vid] of Object.entries(videos)) {
    if (lower.includes(key)) return { ...vid, live: false };
  }
  return { id: "NybHckSEQBI", channel: "Khan Academy", title: "Concept Overview", live: false };
}

// ─── CLAUDE API CALLS ──────────────────────────────────────────────────────
async function callClaude(systemPrompt, userMessage, model = "sonnet") {
  if (!ANTHROPIC_API_KEY || ANTHROPIC_API_KEY === "YOUR_ANTHROPIC_API_KEY_HERE") {
    throw new Error("⚠️ Anthropic API key not configured. Set ANTHROPIC_API_KEY in assessment-engine.html");
  }

  const modelKey = model === "sonnet" ? MODELS.SONNET : MODELS.HAIKU;
  const pricingKey = model === "sonnet" ? "sonnet" : "haiku";

  try {
    const response = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "anthropic-beta": "prompt-caching-2024-07-31",
        "x-api-key": ANTHROPIC_API_KEY
      },
      body: JSON.stringify({
        model: modelKey,
        max_tokens: 1000,
        system: [
          {
            type: "text",
            text: systemPrompt,
            cache_control: { type: "ephemeral" }
          }
        ],
        messages: [
          { role: "user", content: userMessage }
        ]
      })
    });

    const data = await response.json();

    if (data.error) {
      console.error("Claude API error:", data.error);
      throw new Error(`API Error: ${data.error.message}`);
    }

    // Track cost
    const usage = data.usage || {};
    const p = PRICING[pricingKey];
    const cost = (
      (usage.input_tokens || 0) * p.input +
      (usage.cache_creation_input_tokens || 0) * p.cacheWrite +
      (usage.cache_read_input_tokens || 0) * p.cacheRead +
      (usage.output_tokens || 0) * p.output
    ) / 1_000_000;

    window.costLog.calls.push({
      model: modelKey,
      inputTokens: usage.input_tokens || 0,
      cacheWriteTokens: usage.cache_creation_input_tokens || 0,
      cacheReadTokens: usage.cache_read_input_tokens || 0,
      outputTokens: usage.output_tokens || 0,
      cached: (usage.cache_read_input_tokens || 0) > 0,
      cost
    });
    window.costLog.total += cost;

    updateCostBadge();

    return data.content?.[0]?.text || "";
  } catch (err) {
    console.error("Claude API call failed:", err);
    throw err;
  }
}

// ─── GENERATE DIAGNOSTIC QUESTIONS ────────────────────────────────────────
async function generateQuestions(config) {
  const systemPrompt = `You are an expert ${config.level} ${config.subject} examiner (${config.board}).
Generate exactly 5 diagnostic questions for ${config.level} ${config.subject}.
Return ONLY a valid JSON array with no markdown, preamble, or extra text.
Each object: { "id": number, "topic": string, "marks": number, "difficulty": "easy"|"medium"|"hard", "question": string }
Focus on core topics from the ${config.subject} specification.
Make questions authentic to ${config.board} exam style.`;

  const userMessage = `Generate 5 GCSE ${config.subject} diagnostic questions for ${config.name}.`;

  const response = await callClaude(systemPrompt, userMessage, "haiku");
  
  try {
    return JSON.parse(response);
  } catch (err) {
    console.error("Failed to parse questions:", err);
    return generateFallbackQuestions(config);
  }
}

function generateFallbackQuestions(config) {
  return [
    { id: 1, topic: "Core Concept 1", marks: 4, difficulty: "easy", question: "Define the main concept in this topic." },
    { id: 2, topic: "Core Concept 2", marks: 6, difficulty: "medium", question: "Explain how this concept relates to real-world applications." },
    { id: 3, topic: "Core Concept 3", marks: 5, difficulty: "medium", question: "Calculate the value and explain your method." },
    { id: 4, topic: "Advanced Topic 1", marks: 6, difficulty: "hard", question: "Analyze the relationship between these factors." },
    { id: 5, topic: "Advanced Topic 2", marks: 5, difficulty: "hard", question: "Evaluate the implications of this scenario." }
  ];
}

// ─── MARK ANSWERS & DIAGNOSE ──────────────────────────────────────────────
async function diagnoseAnswers(config, questions, answers) {
  const systemPrompt = `You are an expert ${config.level} ${config.subject} examiner.
${config.name} answered 5 diagnostic questions.
Mark each answer and identify knowledge gaps.
Return ONLY valid JSON (no markdown):
{
  "overallScore": number (0-100),
  "currentGrade": string,
  "targetGrade": string,
  "gaps": [
    { "topic": string, "score": number, "marksAtStake": number, "priority": "critical"|"high"|"medium"|"low", "reason": string }
  ]
}`;

  const answerSummary = questions.map((q, i) => 
    `Q${i+1} (${q.topic}, ${q.marks}m): "${answers[i] || 'No answer'}"`
  ).join('\n');

  const userMessage = `Mark these answers:\n\n${answerSummary}\n\nIdentify gaps and prioritize them.`;

  const response = await callClaude(systemPrompt, userMessage, "sonnet");
  
  try {
    return JSON.parse(response);
  } catch (err) {
    console.error("Failed to parse diagnosis:", err);
    return {
      overallScore: 45,
      currentGrade: "5",
      targetGrade: "8",
      gaps: [
        { topic: "Core Concepts", score: 35, marksAtStake: 12, priority: "critical", reason: "Fundamental understanding gaps" },
        { topic: "Application", score: 50, marksAtStake: 8, priority: "high", reason: "Difficulty applying concepts to new scenarios" }
      ]
    };
  }
}

// ─── GENERATE PERSONALIZED PLAN ────────────────────────────────────────────
async function generatePlan(config, diagnosis) {
  const systemPrompt = `You are a ${config.level} ${config.subject} tutor creating a 3-week personalized study plan.
${config.name} has specific gaps: ${diagnosis.gaps.map(g => `${g.topic} (${g.priority})`).join(', ')}
Return ONLY valid JSON (no markdown):
{
  "gradeJourney": [{ "week": number, "grade": string, "description": string }],
  "weeks": [
    {
      "number": number,
      "title": string,
      "why": string,
      "tasks": [
        { "id": string, "type": "video"|"drill"|"test", "label": string, "mins": number }
      ]
    }
  ]
}`;

  const gapsSummary = diagnosis.gaps.map(g => `${g.topic}: ${g.reason}`).join('\n');
  const userMessage = `Create a 3-week study plan to address these gaps:\n${gapsSummary}`;

  const response = await callClaude(systemPrompt, userMessage, "sonnet");
  
  try {
    return JSON.parse(response);
  } catch (err) {
    console.error("Failed to parse plan:", err);
    return generateFallbackPlan();
  }
}

function generateFallbackPlan() {
  return {
    gradeJourney: [
      { week: 1, grade: "5", description: "Foundation building" },
      { week: 2, grade: "6", description: "Skill development" },
      { week: 3, grade: "7", description: "Mastery consolidation" }
    ],
    weeks: [
      {
        number: 1,
        title: "Foundation",
        why: "Build core understanding",
        tasks: [
          { id: "t1", type: "video", label: "Watch: Core Concepts", mins: 15 },
          { id: "t2", type: "drill", label: "Practice: Basic Problems", mins: 20 },
          { id: "t3", type: "test", label: "Test: Week 1 Quiz", mins: 15 }
        ]
      }
    ]
  };
}

// ─── COST TRACKING UI ──────────────────────────────────────────────────────
function updateCostBadge() {
  const badge = document.getElementById("cost-badge");
  const total = window.costLog.total.toFixed(6);
  badge.textContent = `💰 $${total}`;

  const list = document.getElementById("cost-list");
  if (window.costLog.calls.length === 0) {
    list.innerHTML = "No API calls yet";
    return;
  }

  let html = `<div style="margin-bottom:0.5rem;"><strong>Total: $${total}</strong></div>`;
  window.costLog.calls.forEach((call, i) => {
    const cached = call.cached ? " ⚡ CACHED" : "";
    html += `<div style="margin:0.3rem 0;font-size:.75rem;color:var(--muted);">
      Call ${i+1}: ${call.model} ${cached} — $${call.cost.toFixed(6)}
    </div>`;
  });
  list.innerHTML = html;
}

function toggleCostDetails() {
  const details = document.getElementById("cost-details");
  details.classList.toggle("show");
}

// ─── UTILITY FUNCTIONS ────────────────────────────────────────────────────
function showToast(message, type = "info") {
  const toast = document.getElementById("toast");
  toast.textContent = message;
  toast.className = `show ${type}`;
  setTimeout(() => toast.classList.remove("show"), 3000);
}
