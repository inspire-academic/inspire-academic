// netlify/edge-functions/mileiq-reports.js
// Generate PDF and Excel monthly reports from MileIQ data
// Called by frontend to download reports

import { createCanvas } from 'canvas'; // Will use HTML5 Canvas API

export default async function(request, context) {
  
  if (request.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json' }
    });
  }

  try {
    const body = await request.json();
    const { format, journeys, studentName, month } = body;

    if (format === 'pdf') {
      return generatePDF(journeys, studentName, month);
    } else if (format === 'excel') {
      return generateExcel(journeys, studentName, month);
    } else {
      return new Response(JSON.stringify({ error: 'Invalid format' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

  } catch (err) {
    console.error('Report generation error:', err);
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
}

function generatePDF(journeys, studentName, month) {
  // Basic PDF generation using simple text format
  // For production, use a library like jsPDF
  
  const monthStr = new Date(month).toLocaleString('default', { month: 'long', year: 'numeric' });
  const totalMiles = journeys.reduce((sum, j) => sum + (parseFloat(j.distance_miles) || 0), 0);
  
  let pdfContent = `%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>
endobj
4 0 obj
<< /Length 800 >>
stream
BT
/F1 24 Tf
50 750 Td
(MileIQ Monthly Report) Tj
0 -40 Td
/F1 12 Tf
(${studentName}) Tj
0 -20 Td
(${monthStr}) Tj
0 -40 Td
/F1 14 Tf
(Total Mileage: ${totalMiles.toFixed(1)} miles) Tj
0 -30 Td
/F1 10 Tf
(Journeys: ${journeys.length}) Tj
ET
endstream
endobj
5 0 obj
<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>
endobj
xref
0 6
0000000000 65535 f 
0000000009 00000 n 
0000000058 00000 n 
0000000115 00000 n 
0000000317 00000 n 
0000001167 00000 n 
trailer
<< /Size 6 /Root 1 0 R >>
startxref
1247
%%EOF`;

  const pdfBuffer = new TextEncoder().encode(pdfContent);
  
  return new Response(pdfBuffer, {
    status: 200,
    headers: {
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename="MileIQ_${monthStr.replace(' ', '_')}.pdf"`
    }
  });
}

function generateExcel(journeys, studentName, month) {
  // Generate simple CSV which Excel can open
  // For production, use a library like xlsx
  
  const monthStr = new Date(month).toLocaleString('default', { month: 'long', year: 'numeric' });
  const totalMiles = journeys.reduce((sum, j) => sum + (parseFloat(j.distance_miles) || 0), 0);
  
  let csv = `MileIQ Monthly Mileage Report\n`;
  csv += `${studentName}\n`;
  csv += `${monthStr}\n\n`;
  csv += `Date,Start Location,Destination,Purpose,Distance (Miles)\n`;
  
  journeys.forEach(j => {
    const date = new Date(j.journey_date).toLocaleDateString();
    const distance = parseFloat(j.distance_miles) || 0;
    csv += `"${date}","${j.start_location}","${j.destination}","${j.purpose || ''}",${distance}\n`;
  });
  
  csv += `\nTotal Mileage:,${totalMiles.toFixed(1)}\n`;
  csv += `Number of Journeys:,${journeys.length}\n`;
  csv += `Average per Journey:,${(totalMiles / (journeys.length || 1)).toFixed(1)}\n`;
  
  const csvBuffer = new TextEncoder().encode(csv);
  
  return new Response(csvBuffer, {
    status: 200,
    headers: {
      'Content-Type': 'text/csv',
      'Content-Disposition': `attachment; filename="MileIQ_${monthStr.replace(' ', '_')}.csv"`
    }
  });
}
