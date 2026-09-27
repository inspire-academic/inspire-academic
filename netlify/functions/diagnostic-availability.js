// GET /api/v1/diagnostic/availability
//
// Which tier choices each subject can offer yet, for the start page:
// { boards: { AQA: { Physics: { Higher, Foundation, route }, ... }, Edexcel: {...} },
//   subjects: <the AQA entry, for pages written before boards> }
//   Higher      a Higher-tier test (offered whenever there are questions)
//   Foundation  a Foundation-tier test (needs a full test's worth of reviewed
//               Foundation or both-tier questions)
//   route       "Not sure: find my tier" (needs a routing block and both tiers)
// Counted from the same reviewed pool the start endpoint draws on; never
// returns a question. Cached briefly: it changes only as questions are
// approved.

const { fail, db, QUESTION_BOARDS } = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');

const SUBJECTS = ['Physics', 'Chemistry', 'Biology', 'Combined Science', 'Mathematics', engine.MATHS_PAPER2];
const COLUMNS = 'id,subject,topic,difficulty,tier,exam_board,specification_ref,combined_eligible,combined_eligible_edexcel';

exports.handler = async (event) => {
  if (event.httpMethod !== 'GET') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');
  try {
    const rows = await client.get(
      'diagnostic_questions?level=eq.GCSE&review_status=in.(approved,legacy)&question_type=in.(mcq,numeric)' +
      `&active=is.true&exam_board=in.(${QUESTION_BOARDS.join(',')},Universal)&tier=in.(Higher,Foundation,Both)&select=${COLUMNS}`
    );
    const boards = {};
    QUESTION_BOARDS.forEach(board => {
      const onBoard = rows.filter(q => q.exam_board === board || q.exam_board === 'Universal');
      boards[board] = {};
      SUBJECTS.forEach(subject => {
        const sources = engine.sourceSubjects(subject);
        boards[board][subject] = engine.tierAvailability(subject, onBoard.filter(q => sources.includes(q.subject)), board);
      });
    });
    const subjects = boards.AQA;
    return {
      statusCode: 200,
      headers: { 'Content-Type': 'application/json', 'Cache-Control': 'public, max-age=300' },
      body: JSON.stringify({ success: true, boards, subjects })
    };
  } catch (e) {
    console.error('diagnostic-availability error:', e.message);
    return fail(502, 'db_error', 'Could not check which tests are available.');
  }
};
