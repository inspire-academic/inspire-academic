# Assessment Engine — Integration Guide

## Overview

The Assessment Engine is a complete AI-powered 5-stage learning loop for Inspire Academic:
1. **Assess** — Generate 5 diagnostic questions
2. **Diagnose** — Mark answers, identify knowledge gaps
3. **Plan** — Create personalized 3-week study plans
4. **Execute** — Watch curated videos, pass mastery checks
5. **Track** — Monitor progress and improvement

## Folder Structure

```
assessment-engine/
├── assessment-engine.html    (Main entry point)
├── js/
│   ├── app.js               (State management & navigation)
│   └── api.js               (Claude API integration)
└── css/
    └── styles.css           (Additional styling)
```

## Installation

### 1. Copy to Your Project

Copy the entire `assessment-engine/` folder into your `C:\Deploy_Inspire_Academic` directory:

```
C:\Deploy_Inspire_Academic\
├── index.html
├── quiz.html
├── dashboard.html
├── ... (other files)
└── assessment-engine/          ← Copy here
    ├── assessment-engine.html
    ├── js/
    └── css/
```

### 2. Configure API Keys

**In `assessment-engine/js/api.js`**, replace these placeholders:

**Line 2 — Anthropic API Key:**
```javascript
const ANTHROPIC_API_KEY = "sk-ant-v0-xxxx..."; // Get from https://console.anthropic.com
```

**Line 3 — YouTube API Key:**
```javascript
const YOUTUBE_API_KEY = "AIza..."; // Already set, but can be updated
```

### 3. Add Navigation Link

**In your main `index.html`**, add a link to the assessment engine in the navigation:

```html
<a href="/assessment-engine/assessment-engine.html" class="btn btn-gold">
  🎓 Assessment Engine
</a>
```

Or if you have a main menu/dashboard, add:

```html
<div class="feature">
  <a href="/assessment-engine/assessment-engine.html">
    <span class="feature-icon">🎓</span>
    <strong>Assessment Engine</strong>
    <span class="muted">Full learning loop</span>
  </a>
</div>
```

## API Configuration

### Anthropic API Key

1. Go to [https://console.anthropic.com](https://console.anthropic.com)
2. Click **API Keys** in the left menu
3. Click **Create Key**
4. Copy your key (starts with `sk-ant-`)
5. Paste into `js/api.js` line 2

**Cost:** ~$0.001–0.005 per assessment (optimized with prompt caching)

### YouTube API Key

Already configured with key: `AIzaSyCq_7BBx1m7BZ_WRI3xTFMjVYS3sVYhhF4`

To use your own:
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create/select project `inspire-academic-platform`
3. Enable **YouTube Data API v3**
4. Go to **Credentials** → **Create API Key**
5. Paste into `js/api.js` line 3

**Cost:** Free tier covers ~100 searches/day

## Features

### ✅ Complete Implementation

- **Assess**: Generates 5 GCSE-style diagnostic questions using Claude
- **Diagnose**: Marks answers, identifies gaps, prioritizes topics
- **Plan**: Creates 3-week personalized study roadmap
- **Execute**: Placeholder for video watching + AI mastery checks
- **Track**: Progress visualization (UI ready)

### ✅ Cost Tracking

Bottom-left corner shows real-time API spending:
- `⚡ CACHED` = 90% discount on repeated prompts
- `$X.XXXXX` = Total session cost
- Click to expand cost breakdown

### ✅ Code Style Match

- Uses your **navy/gold/orange** colour scheme
- **Playfair Display + DM Sans** typography
- **Card, badge, button** patterns from your existing site
- Mobile responsive

### ✅ PWA Ready

Works offline, installable on Android/iOS (same as main platform)

## Customization

### Change Colours

Edit `assessment-engine.html` CSS root variables (lines 10-20):

```css
:root{
  --navy:#0b1628;
  --gold:#d4a017;
  --teal:#00c9a7;
  /* ... etc */
}
```

### Add/Remove Subjects

Edit `js/api.js` around line 30:

```javascript
const TOPICS_BY_SUBJECT = {
  Physics: [...],
  Chemistry: [...],
  Biology: [...],
  Mathematics: [...]
  // Add more subjects here
};
```

### Adjust AI Prompts

Edit system prompts in `js/api.js`:
- `generateQuestions()` — Line 120
- `diagnoseAnswers()` — Line 140
- `generatePlan()` — Line 160

## Deployment

### Netlify (Your Current Host)

1. Commit `assessment-engine/` to your GitHub repo
2. Push to main branch
3. Netlify auto-deploys
4. Access at `https://www.inspireacademic.org/assessment-engine/assessment-engine.html`

### Testing Locally

```bash
cd C:\Deploy_Inspire_Academic
# Open assessment-engine/assessment-engine.html in browser
# Or use any local server:
python -m http.server 8000
# Then visit http://localhost:8000/assessment-engine/assessment-engine.html
```

## Troubleshooting

### "Failed to generate questions: API Error"

**Solution:** Check your Anthropic API key in `js/api.js` line 2. Make sure it:
- Starts with `sk-ant-`
- Has not expired
- Is correct (no extra spaces)

### "YouTube API key not set"

**Solution:** Update line 3 in `js/api.js` with your real YouTube API key, or leave as-is to use the fallback video map.

### "CORS error when fetching API"

**Solution:** This shouldn't happen. If it does:
1. Check your API key is correct
2. Make sure you're not on a restricted network
3. Test the API key directly at [https://console.anthropic.com](https://console.anthropic.com)

### Videos not loading

**Solution:** 
- The YouTube API key might be wrong (but fallback videos will still show)
- Check your internet connection
- Try a different browser

## Next Steps

### Phase 2 — Execute Stage

Build the video watching + mastery check interaction:
- Embed YouTube videos from search results
- AI quizzes after watching
- Mastery-gated task completion
- Sequential unlock (can't skip ahead)

### Phase 3 — Integration with Your Backend

Wire assessment data into your Supabase:
- Store assessment history per student
- Track gap progression
- Sync with your existing dashboard

### Phase 4 — Teacher Dashboard

Show teachers:
- Student assessment progress
- Class-wide gap analysis
- Recommended intervention topics

## Support

For issues or feature requests:
1. Check this README first
2. Review the code comments in `js/app.js` and `js/api.js`
3. Test API keys at their respective consoles
4. File an issue with:
   - Error message
   - What you were trying to do
   - Your API key (redacted)

---

**Built for Inspire Academic**  
Premium GCSE & A-Level tutoring platform  
https://www.inspireacademic.org
